import 'package:test/test.dart';
import 'package:syntaxify/src/generators/token_generator.dart';
import 'package:syntaxify/src/models/component_definition.dart';

void main() {
  group('TokenGenerator', () {
    late TokenGenerator generator;

    setUp(() {
      generator = TokenGenerator();
    });

    group('generate()', () {
      test('generates token class with foundation import', () {
        final component = ComponentDefinition(
          name: 'TestCard',
          className: 'TestCardMeta',
          properties: [
            ComponentProp(
              name: 'backgroundColor',
              type: 'Color',
              isRequired: false,
            ),
            ComponentProp(
              name: 'borderRadius',
              type: 'double',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, isNotNull);
        expect(
            result, contains('import \'foundation/foundation_tokens.dart\''));
        expect(result, contains('class TestCardTokens'));
        expect(result, contains('final Color backgroundColor'));
        expect(result, contains('final double borderRadius'));
      });

      test('generates .fromFoundation() factory', () {
        final component = ComponentDefinition(
          name: 'TestCard',
          className: 'TestCardMeta',
          properties: [
            ComponentProp(
              name: 'backgroundColor',
              type: 'Color',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('factory TestCardTokens.fromFoundation'));
        expect(result, contains('FoundationTokens foundation'));
        expect(result, contains('return TestCardTokens('));
      });

      test('handles variant-aware components', () {
        final component = ComponentDefinition(
          name: 'TestButton',
          className: 'TestButtonMeta',
          properties: [
            ComponentProp(
              name: 'bgColor',
              type: 'Color',
              isRequired: true,
            ),
          ],
          typeParameters: [],
          variants: ['primary', 'secondary'],
        );

        final result = generator.generate(component);

        expect(result, contains('required TestButtonVariant variant'));
        expect(result, contains('.fromFoundation('));
      });

      test('returns empty for components with no token properties', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'label',
              type: 'String',
              isRequired: true,
            ),
            ComponentProp(
              name: 'onPressed',
              type: 'VoidCallback?',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        // No token-worthy properties, should return null
        expect(result, contains('TestTokens()'));
      });

      test('filters out callback properties', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'bgColor',
              type: 'Color',
              isRequired: true,
            ),
            ComponentProp(
              name: 'onPressed',
              type: 'VoidCallback?',
              isRequired: false,
            ),
            ComponentProp(
              name: 'onChanged',
              type: 'ValueChanged<String>?',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, isNotNull);
        expect(result, contains('final Color bgColor'));
        expect(result, isNot(contains('final VoidCallback')));
        expect(result, isNot(contains('final ValueChanged')));
      });

      test('filters out state properties', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'bgColor',
              type: 'Color',
              isRequired: true,
            ),
            ComponentProp(
              name: 'value',
              type: 'bool',
              isRequired: true,
            ),
            ComponentProp(
              name: 'enabled',
              type: 'bool',
              isRequired: false,
            ),
            ComponentProp(
              name: 'label',
              type: 'String',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, isNotNull);
        expect(result, contains('final Color bgColor'));
        expect(result, isNot(contains('final bool value')));
        expect(result, isNot(contains('final bool enabled')));
        expect(result, isNot(contains('final String label')));
      });
    });

    group('Smart Property Mapping', () {
      test('maps activeColor to colorPrimary', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'activeColor',
              type: 'Color',
              isRequired: true,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorPrimary'));
      });

      test('maps inactiveColor to colorSurfaceVariant', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'inactiveColor',
              type: 'Color',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorSurfaceVariant'));
      });

      test('maps backgroundColor to colorSurface', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'backgroundColor',
              type: 'Color',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorSurface'));
      });

      test('maps borderColor to colorOutline', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'borderColor',
              type: 'Color',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorOutline'));
      });

      test('maps errorColor to colorError', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'errorColor',
              type: 'Color',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorError'));
      });

      test('maps borderWidth to borderWidthMedium', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'borderWidth',
              type: 'double',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.borderWidthMedium'));
      });

      test('maps borderRadius to radiusSm', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'borderRadius',
              type: 'double',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.radiusSm'));
      });

      test('maps radius to radiusSm', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'radius',
              type: 'double',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.radiusSm'));
      });

      test('maps padding to EdgeInsets with foundation spacing', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'padding',
              type: 'EdgeInsets',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('EdgeInsets.symmetric'));
        expect(result, contains('foundation.spacingMd'));
        expect(result, contains('foundation.spacingSm'));
      });

      test('maps textStyle to bodyMedium', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'textStyle',
              type: 'TextStyle',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.bodyMedium'));
        expect(result, contains('copyWith'));
      });

      test('maps hintStyle to bodyMedium with colorOnSurfaceVariant', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'hintStyle',
              type: 'TextStyle',
              isRequired: false,
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.bodyMedium'));
        expect(result, contains('colorOnSurfaceVariant'));
      });

      test('handles multiple properties with correct mappings', () {
        final component = ComponentDefinition(
          name: 'CustomCard',
          className: 'CustomCardMeta',
          properties: [
            ComponentProp(
                name: 'backgroundColor', type: 'Color', isRequired: false),
            ComponentProp(
                name: 'borderColor', type: 'Color', isRequired: false),
            ComponentProp(
                name: 'borderWidth', type: 'double', isRequired: false),
            ComponentProp(
                name: 'borderRadius', type: 'double', isRequired: false),
            ComponentProp(
                name: 'padding', type: 'EdgeInsets', isRequired: false),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('foundation.colorSurface'));
        expect(result, contains('foundation.colorOutline'));
        expect(result, contains('foundation.borderWidthMedium'));
        expect(result, contains('foundation.radiusSm'));
        expect(result, contains('EdgeInsets.symmetric'));
      });
    });

    group('Generated Code Structure', () {
      test('includes proper imports', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('import \'package:flutter/material.dart\''));
        expect(
            result, contains('import \'foundation/foundation_tokens.dart\''));
      });

      test('generates const constructor', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('const TestTokens({'));
        expect(result, contains('required this.bgColor'));
      });

      test('generates proper field declarations', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
            ComponentProp(
                name: 'borderRadius', type: 'double?', isRequired: false),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('final Color bgColor'));
        expect(result, contains('final double? borderRadius'));
      });

      test('formats code with dart_style', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        // Check for proper indentation (2 spaces)
        expect(result, contains('\n  final Color bgColor'));
        expect(result, contains('\n  const TestTokens({'));
      });
    });

    group('Edge Cases', () {
      test('handles component with App prefix', () {
        final component = ComponentDefinition(
          name: 'AppCard',
          className: 'AppCardMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        // Should generate CardTokens, not AppCardTokens
        expect(result, contains('class CardTokens'));
      });

      test('handles explicit name', () {
        final component = ComponentDefinition(
          name: 'MyCustomComponent',
          className: 'MyCustomComponentMeta',
          explicitName: 'SuperCard',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('class SuperCardTokens'));
      });

      test('handles optional properties', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color?', isRequired: false),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('final Color? bgColor'));
        expect(result, contains('this.bgColor'));
        expect(result, isNot(contains('required this.bgColor')));
      });

      test('handles required properties', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(name: 'bgColor', type: 'Color', isRequired: true),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        expect(result, contains('required this.bgColor'));
      });

      test('handles default values', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: [
            ComponentProp(
              name: 'borderWidth',
              type: 'double',
              isRequired: false,
              defaultValue: '2.0',
            ),
          ],
          typeParameters: [],
          variants: [],
        );

        final result = generator.generate(component);

        // Factory should still use foundation, constructor can have default
        expect(result, contains('foundation.borderWidthMedium'));
      });
    });
  });
}
