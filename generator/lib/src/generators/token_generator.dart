import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';

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
  /// Returns the generated Dart code as a string.
  /// Always generates a token file (even if empty) to provide a scaffold
  /// for custom components that users can fill in.
  String generate(ComponentDefinition component) {
    final tokenProperties = _inferTokenProperties(component);

    // Always generate token file - provides scaffold for custom components
    // even if no properties are inferred from naming patterns

    final baseName = _getBaseName(component);
    final tokenClassName = '${baseName}Tokens';

    final library = Library(
      (b) => b
        ..comments.addAll(_generateHeader(tokenClassName))
        ..directives.addAll([
          Directive.import('package:flutter/material.dart'),
          Directive.import('foundation/foundation_tokens.dart'),
        ])
        ..body.add(_generateTokenClass(
          tokenClassName,
          baseName,
          tokenProperties,
          component,
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
    if (name.contains('Color') ||
        name.contains('color') ||
        type.contains('Color')) {
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
        type.contains('Border') ||
        type.contains('TextStyle')) {
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

    // borderRadius should be double, not Border
    if (name.toLowerCase().contains('radius')) {
      return type.endsWith('?') ? 'double?' : 'double';
    }

    // border (without radius) should be Border type
    if (name.toLowerCase().contains('border') &&
        !name.toLowerCase().contains('radius')) {
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
    ComponentDefinition component,
  ) {
    return Class(
      (b) => b
        ..name = className
        ..docs.add('/// Design tokens for the $componentName component')
        ..fields.addAll(properties.map(_generateField))
        ..constructors.addAll([
          _generateConstructor(properties),
          _generateFromFoundationFactory(
              className, componentName, properties, component),
        ]),
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
                ..defaultTo =
                    prop.defaultValue != null ? Code(prop.defaultValue!) : null,
            ),
          ),
        ),
    );
  }

  /// Generate .fromFoundation() factory constructor.
  ///
  /// Creates tokens from foundation primitives with smart property mapping.
  /// Handles both simple (no variants) and variant-aware components.
  Constructor _generateFromFoundationFactory(
    String className,
    String componentName,
    List<TokenProperty> properties,
    ComponentDefinition component,
  ) {
    final hasVariants = component.variants.isNotEmpty;

    // Generate smart property mapping from foundation tokens
    final propertyMappings = properties.map((prop) {
      return '${prop.name}: ${_mapToFoundation(prop.name, componentName)}';
    }).join(',\n        ');

    // Only include property mappings if there are any
    final bodyContent = properties.isEmpty
        ? 'return $className();'
        : '''return $className(
        $propertyMappings,
      );''';

    return Constructor(
      (b) => b
        ..factory = true
        ..name = 'fromFoundation'
        ..docs.add('/// Create ${className} from foundation design tokens')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'foundation'
              ..type = refer('FoundationTokens'),
          ),
        )
        ..optionalParameters.addAll(
          hasVariants
              ? [
                  Parameter(
                    (p) => p
                      ..name = 'variant'
                      ..named = true
                      ..required = true
                      ..type = refer('${componentName}Variant'),
                  ),
                ]
              : [],
        )
        ..body = Code(bodyContent),
    );
  }

  /// Map a token property name to the appropriate foundation token.
  ///
  /// Uses naming patterns to intelligently select foundation primitives:
  /// - activeColor -> colorPrimary
  /// - borderWidth -> borderWidthMedium
  /// - borderRadius -> radiusMd
  String _mapToFoundation(String propName, String componentName) {
    final lowerName = propName.toLowerCase();

    // Color mappings
    // Check inactive BEFORE active since "inactive" contains "active"
    if (lowerName.contains('inactive') && lowerName.contains('color')) {
      return 'foundation.colorSurfaceVariant';
    }
    if (lowerName.contains('active') && lowerName.contains('color')) {
      return 'foundation.colorPrimary';
    }
    if (lowerName.contains('check') && lowerName.contains('color')) {
      return 'foundation.colorOnPrimary';
    }
    if (lowerName.contains('thumb') && lowerName.contains('color')) {
      return 'foundation.colorOnPrimary';
    }
    if (lowerName.contains('border') && lowerName.contains('color')) {
      return 'foundation.colorOutline';
    }
    if (lowerName.contains('track') && lowerName.contains('color')) {
      if (lowerName.contains('inactive')) {
        return 'foundation.colorSurfaceVariant';
      }
      return 'foundation.colorPrimary';
    }
    if (lowerName.contains('overlay') && lowerName.contains('color')) {
      return 'foundation.colorPrimary.withOpacity(0.12)';
    }
    if (lowerName.contains('text') && lowerName.contains('color')) {
      return 'foundation.colorOnSurface';
    }
    if (lowerName.contains('background') && lowerName.contains('color')) {
      return 'foundation.colorSurface';
    }
    if (lowerName.contains('error') && lowerName.contains('color')) {
      return 'foundation.colorError';
    }
    if (lowerName.contains('focus') && lowerName.contains('color')) {
      return 'foundation.colorPrimary';
    }
    if (lowerName.endsWith('color')) {
      return 'foundation.colorPrimary';
    }

    // Size/dimension mappings
    if (lowerName.contains('borderwidth')) {
      return 'foundation.borderWidthMedium';
    }
    if (lowerName.contains('borderradius') || lowerName == 'radius') {
      return 'foundation.radiusSm';
    }
    if (lowerName.contains('trackheight')) {
      return 'foundation.borderWidthMedium * 2';
    }
    if (lowerName.contains('thumbradius')) {
      return 'foundation.spacingSm + 2';
    }
    if (lowerName.contains('padding')) {
      return 'EdgeInsets.symmetric(horizontal: foundation.spacingMd, vertical: foundation.spacingSm)';
    }
    if (lowerName.contains('margin')) {
      return 'EdgeInsets.all(foundation.spacingSm)';
    }

    // TextStyle mappings
    if (lowerName.contains('textstyle')) {
      return 'foundation.bodyMedium.copyWith(color: foundation.colorOnSurface)';
    }
    if (lowerName.contains('hintstyle')) {
      return 'foundation.bodyMedium.copyWith(color: foundation.colorOnSurfaceVariant)';
    }

    // Default fallback based on type
    if (lowerName.contains('width') ||
        lowerName.contains('height') ||
        lowerName.contains('size')) {
      return 'foundation.spacingMd';
    }

    // Generic fallback
    return 'foundation.colorPrimary';
  }
}
