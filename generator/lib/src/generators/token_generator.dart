import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

/// Generates design token classes for components.
///
/// Automatically creates token files like:
/// - checkbox_tokens.dart with CheckboxTokens class
/// - slider_tokens.dart with SliderTokens class
///
/// Token properties are inferred from component properties based on naming conventions:
/// - *Color -> Color type
/// - *Width, *Height, *Radius, *Spacing -> double type
/// - shadow, elevation -> Optional types
class TokenGenerator {
  TokenGenerator({this.version = '0.2.0-beta'});

  final String version;

  final _formatter =
      DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
  final _emitter = DartEmitter(useNullSafetySyntax: true);

  /// Generate a token class file for a component.
  ///
  /// Returns the generated Dart code as a string, or null if no tokens needed.
  String? generate(ComponentDefinition component) {
    final tokenProperties = _inferTokenProperties(component);

    // Only generate token file if there are token-worthy properties
    if (tokenProperties.isEmpty) {
      return null;
    }

    final baseName = _getBaseName(component);
    final tokenClassName = '${baseName}Tokens';

    final library = Library(
      (b) => b
        ..comments.addAll(_generateHeader(tokenClassName))
        ..directives.add(Directive.import('package:flutter/material.dart'))
        ..body.add(_generateTokenClass(
          tokenClassName,
          baseName,
          tokenProperties,
        )),
    );

    final code = library.accept(_emitter).toString();
    return _formatter.format(code);
  }

  /// Infer which component properties should become token properties.
  ///
  /// Analyzes property names and types to determine if they represent
  /// visual styling (colors, sizes, spacing, shadows).
  List<TokenProperty> _inferTokenProperties(ComponentDefinition component) {
    final tokenProps = <TokenProperty>[];

    for (final prop in component.properties) {
      final propName = prop.name;
      final propType = prop.type;

      // Explicitly skip callback and state properties
      if (_isCallbackProperty(propType) || _isStateProperty(propName)) {
        continue;
      }

      // Infer token properties based on naming and type patterns
      if (_isTokenProperty(propName, propType)) {
        tokenProps.add(TokenProperty(
          name: propName,
          type: _inferTokenType(propName, propType),
          defaultValue: prop.defaultValue,
          description: prop.description,
        ));
      }
    }

    return tokenProps;
  }

  /// Check if a property is a callback (VoidCallback, ValueChanged, etc.)
  bool _isCallbackProperty(String type) {
    final callbackPatterns = [
      'VoidCallback',
      'ValueChanged',
      'GestureTapCallback',
      'Function',
      '()',
      '=>',
    ];
    return callbackPatterns.any((pattern) => type.contains(pattern));
  }

  /// Check if a property represents component state (not styling)
  bool _isStateProperty(String name) {
    final statePatterns = [
      'value',
      'groupValue',
      'enabled',
      'disabled',
      'loading',
      'controller',
      'focusNode',
      'label',
      'hint',
      'text',
      'icon',
      'error',
      'min',
      'max',
      'divisions',
      'obscureText',
      'keyboardType',
    ];
    return statePatterns.contains(name);
  }

  /// Check if a property should become a token based on naming/type
  bool _isTokenProperty(String name, String type) {
    // Color properties
    if (name.contains('Color') || name.contains('color') || type.contains('Color')) {
      return true;
    }

    // Size/dimension properties
    final sizePatterns = [
      'width',
      'height',
      'radius',
      'spacing',
      'padding',
      'margin',
      'size',
      'thickness',
      'stroke',
      'elevation',
    ];
    if (sizePatterns.any((pattern) => name.toLowerCase().contains(pattern))) {
      return true;
    }

    // Visual effect properties
    final effectPatterns = ['shadow', 'blur', 'opacity', 'border'];
    if (effectPatterns.any((pattern) => name.toLowerCase().contains(pattern))) {
      return true;
    }

    // Explicit type checks
    if (type.contains('BoxShadow') ||
        type.contains('EdgeInsets') ||
        type.contains('Border')) {
      return true;
    }

    return false;
  }

  /// Infer the appropriate token type from property name/type
  String _inferTokenType(String name, String type) {
    // If type is already specific, use it
    if (type.contains('Color') ||
        type.contains('BoxShadow') ||
        type.contains('EdgeInsets') ||
        type.contains('Border')) {
      return type;
    }

    // Infer from name patterns
    if (name.contains('Color') || name.contains('color')) {
      return 'Color';
    }

    if (name.toLowerCase().contains('shadow')) {
      return 'BoxShadow?';
    }

    if (name.toLowerCase().contains('padding') ||
        name.toLowerCase().contains('margin')) {
      return 'EdgeInsets?';
    }

    if (name.toLowerCase().contains('border')) {
      return 'Border?';
    }

    // Default to double for numeric styling properties
    return 'double';
  }

  String _getBaseName(ComponentDefinition component) {
    final name =
        component.explicitName ?? component.className.replaceAll('Meta', '');
    final base = name.startsWith('App') ? name.substring(3) : name;
    if (base.isEmpty) {
      throw Exception('Component name cannot be empty');
    }
    return base;
  }

  List<String> _generateHeader(String className) {
    return [
      '$className definition',
      '',
      'Pure data class defining styling properties for the ${className.replaceAll('Tokens', '')} component.',
      'Used by DesignStyle implementations to provide style-specific tokens.',
    ];
  }

  Class _generateTokenClass(
    String className,
    String componentName,
    List<TokenProperty> properties,
  ) {
    return Class(
      (b) => b
        ..name = className
        ..docs.add('/// Design tokens for the $componentName component')
        ..fields.addAll(properties.map(_generateField))
        ..constructors.add(_generateConstructor(properties)),
    );
  }

  Field _generateField(TokenProperty prop) {
    return Field(
      (b) => b
        ..name = prop.name
        ..modifier = FieldModifier.final$
        ..type = refer(prop.type)
        ..docs.addAll(
            prop.description != null ? ['/// ${prop.description}'] : []),
    );
  }

  Constructor _generateConstructor(List<TokenProperty> properties) {
    return Constructor(
      (b) => b
        ..constant = true
        ..optionalParameters.addAll(
          properties.map(
            (prop) => Parameter(
              (p) => p
                ..name = prop.name
                ..named = true
                ..required = !prop.type.endsWith('?')
                ..toThis = true
                ..defaultTo = prop.defaultValue != null
                    ? Code(prop.defaultValue!)
                    : null,
            ),
          ),
        ),
    );
  }
}
