import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/ast/custom/custom_node.dart';
import 'package:syntaxify/src/visitors/binding_collector.dart';
import 'package:syntaxify/src/visitors/controller_collector.dart';

/// Generates a full Screen widget from a [ScreenDefinition].
class ScreenGenerator {
  ScreenGenerator({
    this.layoutEmitter = const LayoutEmitter(),
  });

  final LayoutEmitter layoutEmitter;

  /// Generates Dart code for a screen.
  ///
  /// [screen] The screen definition to generate code for.
  /// [packageName] Optional package name for import resolution.
  String generate(ScreenDefinition screen, {String? packageName}) {
    // Collect callbacks, controllers, and bindings using visitors
    final callbacks = _collectCallbacks(screen.layout);
    final controllers = ControllerCollector().visit(screen.layout);
    final bindings = BindingCollector().visit(screen.layout);
    final needsStateful = controllers.isNotEmpty || bindings.isNotEmpty;

    final library = Library((b) => b
      ..comments.addAll([
        'GENERATED CODE - DO NOT MODIFY BY HAND',
        'Analyzed by Syntaxify',
      ])
      ..directives.addAll([
        Directive.import('package:flutter/material.dart'),
        if (packageName != null) ...[
          Directive.import('package:$packageName/syntaxify/index.dart'),
          Directive.import(
              'package:$packageName/syntaxify/design_system/design_system.dart'),
        ] else ...[
          // Fallback to relative imports if package name not provided
          Directive.import('../index.dart'), // For generated components
          Directive.import(
              '../design_system/design_system.dart'), // For design system
        ],
      ])
      ..body.addAll(needsStateful
          ? _buildStatefulScreen(screen, callbacks, controllers, bindings)
          : [_buildStatelessScreen(screen, callbacks)]));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
        .format('${library.accept(emitter)}');
  }

  /// Build StatelessWidget screen (no controllers needed)
  Class _buildStatelessScreen(
      ScreenDefinition screen, Map<String, Reference> callbacks) {
    final className = '${_toPascalCase(screen.id)}Screen';

    return Class((c) => c
      ..name = className
      ..extend = refer('StatelessWidget')
      ..fields.addAll(callbacks.entries.map((e) => Field((f) => f
        ..name = e.key
        ..type = e.value
        ..modifier = FieldModifier.final$)))
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..optionalParameters.add(Parameter((p) => p
          ..name = 'super.key'
          ..named = true))
        ..optionalParameters
            .addAll(callbacks.keys.map((name) => Parameter((p) => p
              ..name = name
              ..named = true
              ..toThis = true)))))
      ..methods.add(Method((m) => m
        ..annotations.add(refer('override'))
        ..name = 'build'
        ..requiredParameters.add(Parameter((p) => p
          ..name = 'context'
          ..type = refer('BuildContext')))
        ..returns = refer('Widget')
        ..body = _buildBuildMethodBody(screen))));
  }

  /// Build StatefulWidget screen (controllers and/or bindings needed)
  List<Spec> _buildStatefulScreen(
    ScreenDefinition screen,
    Map<String, Reference> callbacks,
    List<ControllerInfo> controllers,
    List<BindingInfo> bindings,
  ) {
    final className = '${_toPascalCase(screen.id)}Screen';
    final stateClassName = '_${className}State';

    // The StatefulWidget class
    final widgetClass = Class((c) => c
      ..name = className
      ..extend = refer('StatefulWidget')
      ..fields.addAll(callbacks.entries.map((e) => Field((f) => f
        ..name = e.key
        ..type = e.value
        ..modifier = FieldModifier.final$)))
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..optionalParameters.add(Parameter((p) => p
          ..name = 'super.key'
          ..named = true))
        ..optionalParameters
            .addAll(callbacks.keys.map((name) => Parameter((p) => p
              ..name = name
              ..named = true
              ..toThis = true)))))
      ..methods.add(Method((m) => m
        ..annotations.add(refer('override'))
        ..name = 'createState'
        ..returns = refer('State<$className>')
        ..lambda = true
        ..body = Code('$stateClassName()'))));

    // The State class
    final stateClass = Class((c) => c
      ..name = stateClassName
      ..extend = refer('State<$className>')
      // Controller fields
      ..fields.addAll(controllers.map((ctrl) => Field((f) => f
        ..name = ctrl.fieldName
        ..late = true
        ..modifier = FieldModifier.final$
        ..type = refer('TextEditingController'))))
      // Binding state fields
      ..fields.addAll(bindings.map((b) => Field((f) => f
        ..name = b.fieldName
        ..type = refer(b.type)
        ..assignment = Code(b.defaultValue))))
      // initState
      ..methods.add(Method((m) => m
        ..annotations.add(refer('override'))
        ..name = 'initState'
        ..returns = refer('void')
        ..body = Block.of([
          refer('super').property('initState').call([]).statement,
          ...controllers.map((ctrl) => refer(ctrl.fieldName)
              .assign(refer('TextEditingController').call([]))
              .statement),
        ])))
      // dispose
      ..methods.add(Method((m) => m
        ..annotations.add(refer('override'))
        ..name = 'dispose'
        ..returns = refer('void')
        ..body = Block.of([
          ...controllers.map((ctrl) =>
              refer(ctrl.fieldName).property('dispose').call([]).statement),
          refer('super').property('dispose').call([]).statement,
        ])))
      // build
      ..methods.add(Method((m) => m
        ..annotations.add(refer('override'))
        ..name = 'build'
        ..requiredParameters.add(Parameter((p) => p
          ..name = 'context'
          ..type = refer('BuildContext')))
        ..returns = refer('Widget')
        ..body =
            _buildStatefulBuildMethodBody(screen, controllers, callbacks))));

    return [widgetClass, stateClass];
  }

  Code _buildBuildMethodBody(ScreenDefinition screen) {
    final scaffold = refer('Scaffold').newInstance([], {
      if (screen.appBar != null) 'appBar': layoutEmitter.emit(screen.appBar!),
      'body': layoutEmitter.emit(screen.layout),
    });

    return scaffold.returned.statement;
  }

  Code _buildStatefulBuildMethodBody(
    ScreenDefinition screen,
    List<ControllerInfo> controllers,
    Map<String, Reference> callbacks,
  ) {
    // Map callbacks to widget properties (e.g. 'onSubmit' -> 'widget.onSubmit')
    final variableMap = {
      for (final cb in callbacks.keys) cb: 'widget.$cb',
    };

    // Create a modified layout emitter that injects controller references
    final emitterWithControllers = LayoutEmitter(
      controllerMap: _buildControllerMap(controllers),
      variableMap: variableMap,
    );

    final scaffold = refer('Scaffold').newInstance([], {
      if (screen.appBar != null)
        'appBar': emitterWithControllers.emit(screen.appBar!),
      'body': emitterWithControllers.emit(screen.layout),
    });

    return scaffold.returned.statement;
  }

  Map<String, String> _buildControllerMap(List<ControllerInfo> controllers) {
    return {
      for (final ctrl in controllers) ctrl.inputLabel: ctrl.fieldName,
    };
  }

  // Collect controllers from input nodes
  List<ControllerInfo> _collectControllers(App node) {
    final controllers = <ControllerInfo>[];
    _traverseForControllers(node, controllers);
    return controllers;
  }

  void _traverseForControllers(App node, List<ControllerInfo> controllers) {
    node.map(
      structural: (n) => _traverseStructuralForControllers(n.node, controllers),
      primitive: (n) => _traversePrimitiveForControllers(n.node, controllers),
      interactive: (n) =>
          _traverseInteractiveForControllers(n.node, controllers),
      custom: (_) {},
      appBar: (_) {},
    );
  }

  void _traverseStructuralForControllers(
      StructuralNode node, List<ControllerInfo> controllers) {
    node.map(
      column: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      row: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      container: (n) {
        if (n.child != null) {
          _traverseForControllers(n.child!, controllers);
        }
      },
      card: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      listView: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      stack: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      gridView: (n) {
        for (final child in n.children) {
          _traverseForControllers(child, controllers);
        }
      },
      padding: (n) {
        _traverseForControllers(n.child, controllers);
      },
      center: (n) {
        _traverseForControllers(n.child, controllers);
      },
    );
  }

  void _traversePrimitiveForControllers(
      PrimitiveNode node, List<ControllerInfo> controllers) {
    node.map(
      text: (_) {},
      icon: (_) {},
      spacer: (_) {},
      image: (_) {},
      divider: (_) {},
      circularProgressIndicator: (_) {},
      sizedBox: (n) {
        if (n.child != null) {
          _traverseForControllers(n.child!, controllers);
        }
      },
      expanded: (n) {
        _traverseForControllers(n.child, controllers);
      },
    );
  }

  void _traverseInteractiveForControllers(
      InteractiveNode node, List<ControllerInfo> controllers) {
    node.map(
      button: (_) {},
      textField: (n) {
        // Generate controller field name from label
        final label = n.label ?? 'input${controllers.length}';
        final fieldName = '_${_toCamelCase(label)}Controller';
        controllers.add(ControllerInfo(
          inputLabel: label,
          fieldName: fieldName,
        ));
      },
      checkbox: (_) {},
      switchNode: (_) {},
      iconButton: (_) {},
      dropdown: (_) {},
      radio: (_) {},
      slider: (_) {},
    );
  }

  // Rewrite using AST Visitor pattern
  Map<String, Reference> _collectCallbacks(App node) {
    final callbacks = <String, Reference>{};

    node.map(
      structural: (n) => _collectStructuralCallbacks(n.node, callbacks),
      primitive: (n) => _collectPrimitiveCallbacks(n.node, callbacks),
      interactive: (n) => _collectInteractiveCallbacks(n.node, callbacks),
      custom: (n) => _collectCustomCallbacks(n.node, callbacks),
      appBar: (n) => _collectAppBarCallbacks(n, callbacks),
    );

    return callbacks;
  }

  void _collectStructuralCallbacks(
      StructuralNode node, Map<String, Reference> callbacks) {
    node.map(
      column: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      row: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      container: (n) {
        if (n.child != null) {
          callbacks.addAll(_collectCallbacks(n.child!));
        }
      },
      card: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      listView: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      stack: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      gridView: (n) {
        for (final child in n.children) {
          callbacks.addAll(_collectCallbacks(child));
        }
      },
      padding: (n) {
        callbacks.addAll(_collectCallbacks(n.child));
      },
      center: (n) {
        callbacks.addAll(_collectCallbacks(n.child));
      },
    );
  }

  void _collectPrimitiveCallbacks(
      PrimitiveNode node, Map<String, Reference> callbacks) {
    node.map(
      text: (_) {},
      icon: (_) {},
      spacer: (_) {},
      image: (_) {},
      divider: (_) {},
      circularProgressIndicator: (_) {},
      sizedBox: (n) {
        if (n.child != null) {
          callbacks.addAll(_collectCallbacks(n.child!));
        }
      },
      expanded: (n) {
        callbacks.addAll(_collectCallbacks(n.child));
      },
    );
  }

  void _collectInteractiveCallbacks(
      InteractiveNode node, Map<String, Reference> callbacks) {
    node.map(
      button: (n) {
        if (n.onPressed != null) {
          callbacks[n.onPressed!] = refer('VoidCallback?');
        }
      },
      textField: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<String>?');
        }
        if (n.onSubmitted != null) {
          callbacks[n.onSubmitted!] = refer('ValueChanged<String>?');
        }
      },
      checkbox: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<bool?>?');
        }
      },
      switchNode: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<bool>?');
        }
      },
      iconButton: (n) {
        if (n.onPressed != null) {
          callbacks[n.onPressed!] = refer('VoidCallback?');
        }
      },
      dropdown: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<String?>?');
        }
      },
      radio: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<String?>?');
        }
      },
      slider: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<double>?');
        }
      },
    );
  }

  void _collectAppBarCallbacks(
      AppBarNode node, Map<String, Reference> callbacks) {
    if (node.onLeadingPressed != null) {
      callbacks[node.onLeadingPressed!] = refer('VoidCallback?');
    }
  }

  void _collectCustomCallbacks(
      CustomNode node, Map<String, Reference> callbacks) {
    // TODO: Implement callback collection for custom nodes
    // Plugins should probably provide this meta-info
  }

  String _toPascalCase(String input) {
    if (input.isEmpty) return '';
    return input
        .split('_')
        .map((s) => s.isNotEmpty
            ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
            : '')
        .join('');
  }

  String _toCamelCase(String input) {
    if (input.isEmpty) return '';
    // Remove non-alphanumeric and convert to camelCase
    final parts = input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ').split(' ');
    if (parts.isEmpty) return 'input';
    return parts.first.toLowerCase() +
        parts
            .skip(1)
            .map((s) => s.isNotEmpty
                ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
                : '')
            .join('');
  }
}
