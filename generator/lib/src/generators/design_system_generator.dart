import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

/// Generates the dynamic parts of the Design System.
///
/// Responsible for:
/// 1. `design_style.dart`: Abstract base class with render methods for ALL components.
/// 2. `styles/*.dart`: Concrete style classes (Material, Cupertino, Neo) mixing in all renderers.
/// 3. Renderer Stubs: Default implementations for new custom components.
class DesignSystemGenerator {
  final _formatter =
      DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
  final _emitter = DartEmitter(useNullSafetySyntax: true);

  /// Standard components are handled by pre-existing renderers.
  /// Custom components (not in this list) get stub renderers generated.
  static const standardComponents = {
    'Button',
    'Input',
    'Text',
    'Checkbox',
    'Toggle',
    'Slider',
    'Radio',
  };

  /// Generates the main `design_system.dart` library file with all part directives.
  String generateMainLibrary(List<ComponentDefinition> components) {
    final buffer = StringBuffer();

    buffer.writeln('/// Syntaxify Design System - Generated');
    buffer.writeln('///');
    buffer
        .writeln('/// Base classes and types for the Syntaxify Design System.');
    buffer.writeln('/// Uses `part` files so sealed class can be extended.');
    buffer.writeln('library design_system;');
    buffer.writeln();

    // Imports
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:flutter/cupertino.dart';");
    buffer.writeln("import 'package:syntaxify/syntaxify.dart';");
    buffer.writeln();

    // Token imports (Standard)
    buffer.writeln("import 'tokens/button_tokens.dart';");
    buffer.writeln("import 'tokens/input_tokens.dart';");
    buffer.writeln("import 'tokens/text_tokens.dart';");
    buffer.writeln("import 'app_icons.dart';");
    buffer.writeln();

    // Exports
    buffer.writeln("export 'tokens/button_tokens.dart';");
    buffer.writeln("export 'tokens/input_tokens.dart';");
    buffer.writeln("export 'tokens/text_tokens.dart';");
    buffer.writeln("export 'app_icons.dart';");
    buffer
        .writeln("export 'package:syntaxify/syntaxify.dart' show TextVariant;");
    buffer.writeln();

    // Core Parts
    buffer.writeln("part 'app_theme.dart';");
    buffer.writeln("part 'design_style.dart';");
    buffer.writeln("part 'variants.dart';");
    buffer.writeln("part 'styles/material_style.dart';");
    buffer.writeln("part 'styles/cupertino_style.dart';");
    buffer.writeln("part 'styles/neo_style.dart';");
    buffer.writeln();

    // Renderer Parts
    for (final comp in components) {
      final baseName = _getBaseName(component: comp);
      final folderName = StringUtils.toSnakeCase(baseName);

      // Check if standard component (hardcoded paths for now to match strict directory structure)
      // Standard components use matching names: Button -> button, Input -> input
      // Custom components use matching names: SuperCard -> super_card

      buffer.writeln("part 'components/$folderName/material_renderer.dart';");
      buffer.writeln("part 'components/$folderName/cupertino_renderer.dart';");
      buffer.writeln("part 'components/$folderName/neo_renderer.dart';");

      buffer.writeln();
    }

    return _formatter.format(buffer.toString());
  }

  /// Generates the `DesignStyle` abstract base class.
  String generateDesignStyle(List<ComponentDefinition> components) {
    // A simplified approach: define the class and print it.
    final cls = Class((c) {
      c
        ..name = 'DesignStyle'
        ..sealed = true
        ..docs.add('/// Base sealed class for all design styles.')
        ..constructors.add(Constructor((ctor) => ctor..constant = true));

      c.methods.add(Method((m) => m
        ..name = 'name'
        ..type = MethodType.getter
        ..returns = refer('String')
        ..lambda = true
        ..body = Code(
            "runtimeType.toString().replaceAll('Style', '').toLowerCase()")));

      for (final comp in components) {
        c.methods.add(_generateRenderSignature(comp));
      }
    });

    final code = cls.accept(_emitter).toString();
    return _formatter.format('''
/// DesignStyle Sealed Class
part of 'design_system.dart';

$code
''');
  }

  Method _generateRenderSignature(ComponentDefinition component) {
    final name = _getBaseName(component: component);
    return Method((m) {
      m
        ..name = 'render$name'
        ..returns = refer('Widget')
        ..docs.add('/// Render a $name widget')
        ..optionalParameters.addAll(component.properties.map((prop) {
          // Determine if type should be nullable:
          // Nullable if NOT required AND NO default value AND not already nullable
          final isNullable = !prop.isRequired &&
              prop.defaultValue == null &&
              !prop.type.endsWith('?');
          return Parameter((p) => p
            ..name = prop.name
            ..named = true
            ..required = prop.isRequired
            ..type = refer(prop.type + (isNullable ? '?' : '')));
        }));

      // Add type parameters if generic
      if (component.typeParameters.isNotEmpty) {
        m.types.addAll(component.typeParameters.map((t) => refer(t)));
      }
    });
  }

  /// Generates a stub renderer mixin for a custom component and specific style.
  String generateRendererStub(ComponentDefinition component, String style) {
    final name = _getBaseName(component: component);
    final rendererName = '$style${name}Renderer';

    final cls = Mixin((c) {
      c
        ..name = rendererName
        ..on = refer('DesignStyle')
        ..methods.add(Method((m) {
          m
            ..name = 'render$name'
            ..annotations.add(refer('override'))
            ..returns = refer('Widget')
            ..optionalParameters.addAll(component.properties.map((prop) {
              final isNullable = !prop.isRequired &&
                  prop.defaultValue == null &&
                  !prop.type.endsWith('?');
              return Parameter((p) => p
                ..name = prop.name
                ..named = true
                ..required = prop.isRequired
                ..type = refer(prop.type + (isNullable ? '?' : '')));
            }))
            ..body = Code('''
    // STUB: Implement me!
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$name ($style)', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(height: 8),
          ${component.properties.map((p) => "Text('${p.name}: \$${p.name}')").join(',\n          ')},
        ],
      ),
    );
''');
        }));
    });

    final code = cls.accept(_emitter).toString();
    return _formatter.format('''
part of '../../design_system.dart';

$code
''');
  }

  /// Generates a concrete Style class (e.g., MaterialStyle) mixing in all renderers.
  String generateStyleClass(
      String styleName, List<ComponentDefinition> components) {
    final className = '${styleName}Style';

    final cls = Class((c) {
      c
        ..name = className
        ..extend = refer('DesignStyle')
        ..constructors.add(Constructor((ctor) => ctor..constant = true));

      for (final comp in components) {
        final baseName = _getBaseName(component: comp);
        // Use standard renderer if it's a standard component, otherwise assume generated stub naming
        final rendererName = '${styleName}${baseName}Renderer';
        c.mixins.add(refer(rendererName));
      }
    });

    final code = cls.accept(_emitter).toString();
    return _formatter.format('''
/// $styleName Style
part of '../design_system.dart';

$code
''');
  }

  String _getBaseName({required ComponentDefinition component}) {
    final name =
        component.explicitName ?? component.className.replaceAll('Meta', '');
    return name.startsWith('App') ? name.substring(3) : name;
  }
}
