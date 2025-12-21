import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';

/// Generates a full Screen widget from a [ScreenDefinition].
class ScreenGenerator {
  const ScreenGenerator({
    this.layoutEmitter = const LayoutEmitter(),
  });

  final LayoutEmitter layoutEmitter;

  String generate(ScreenDefinition screen, {String? packageName}) {
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
      ..body.add(_buildScreenClass(screen)));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
        .format('${library.accept(emitter)}');
  }

  Class _buildScreenClass(ScreenDefinition screen) {
    final className = '${_toPascalCase(screen.id)}Screen';
    final callbacks = _collectCallbacks(screen.layout);

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

  Code _buildBuildMethodBody(ScreenDefinition screen) {
    final scaffold = refer('Scaffold').newInstance([], {
      if (screen.appBar != null) 'appBar': layoutEmitter.emit(screen.appBar!),
      'body': layoutEmitter.emit(screen.layout),
    });

    return scaffold.returned.statement;
  }

  Map<String, Reference> _collectCallbacks(LayoutNode node) {
    final callbacks = <String, Reference>{};

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
      button: (n) {
        if (n.onPressed != null) {
          callbacks[n.onPressed!] = refer('VoidCallback?');
        }
      },
      text: (_) {},
      textField: (n) {
        if (n.onChanged != null) {
          callbacks[n.onChanged!] = refer('ValueChanged<String>?');
        }
      },
      icon: (_) {},
      spacer: (_) {},
      appBar: (_) {},
    );

    return callbacks;
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
}
