import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/utils/string_utils.dart';
import 'package:syntaxify/src/visitors/visitors.dart';

/// Generates a full Screen widget from a [ScreenDefinition].
class ScreenGenerator {
  ScreenGenerator({
    LayoutEmitter? layoutEmitter,
  }) : layoutEmitter = layoutEmitter ?? LayoutEmitter();

  final LayoutEmitter layoutEmitter;

  /// Generates Dart code for a screen.
  ///
  /// [screen] The screen definition to generate code for.
  /// [packageName] Optional package name for import resolution.
  String generate(ScreenDefinition screen, {String? packageName}) {
    // Collect callbacks, controllers, and bindings using visitors
    final callbackInfos = CallbackCollector().visit(screen.layout);
    final callbacks = {for (final c in callbackInfos) c.name: c.reference};
    final controllers = ControllerCollector().visit(screen.layout);
    final bindings = BindingCollector().visit(screen.layout);
    final needsStateful = controllers.isNotEmpty || bindings.isNotEmpty;

    final library = Library((b) => b
      ..comments.addAll([
        'GENERATED CODE',
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
    final className = '${StringUtils.toPascalCase(screen.id)}Screen';

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
    final className = '${StringUtils.toPascalCase(screen.id)}Screen';
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
}
