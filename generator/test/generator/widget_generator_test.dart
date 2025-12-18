import 'package:test/test.dart';

import 'package:forge/src/generator/widget_generator.dart';
import 'package:forge/src/models/component_definition.dart';

void main() {
  group('WidgetGenerator', () {
    late WidgetGenerator generator;

    setUp(() {
      generator = WidgetGenerator();
    });

    test('generates valid Dart code', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [
          const ComponentProp(
            name: 'label',
            type: 'String',
            isRequired: true,
          ),
        ],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('class AppButton'));
      expect(output, contains('final String label'));
      expect(output, isValidDartCode);
    });

    test('includes required imports', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains("import 'package:flutter/material.dart'"));
      expect(output, contains("import '../theme/app_theme.dart'"));
    });

    test('uses AppTheme.of(context) pattern', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [
          const ComponentProp(name: 'label', type: 'String', isRequired: true),
        ],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('AppTheme.of(context).button'));
    });

    test('strips Meta suffix from class name', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('class AppButton'));
      expect(output, isNot(contains('class AppButtonMeta')));
    });

    test('generates constructor with required params', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [
          const ComponentProp(name: 'label', type: 'String', isRequired: true),
          const ComponentProp(
              name: 'onPressed', type: 'VoidCallback?', isRequired: false),
        ],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('required this.label'));
      expect(output, contains('this.onPressed'));
    });

    test('handles disabled state in generated code', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [
          const ComponentProp(name: 'label', type: 'String', isRequired: true),
          const ComponentProp(
              name: 'isDisabled', type: 'bool', isRequired: false),
        ],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('isDisabled'));
      expect(output, contains('isDisabled ? null : onPressed'));
    });

    test('handles loading state in generated code', () {
      final component = ComponentDefinition(
        name: 'button_meta',
        className: 'ButtonMeta',
        properties: [
          const ComponentProp(name: 'label', type: 'String', isRequired: true),
          const ComponentProp(
              name: 'isLoading', type: 'bool', isRequired: false),
        ],
        variants: [],
      );

      final output = generator.generate(component: component);

      expect(output, contains('isLoading'));
      expect(output, contains('CircularProgressIndicator'));
    });
  });
}

/// Custom matcher for valid Dart code
const Matcher isValidDartCode = _IsValidDartCode();

class _IsValidDartCode extends Matcher {
  const _IsValidDartCode();

  @override
  bool matches(Object? item, Map<dynamic, dynamic> matchState) {
    if (item is! String) return false;

    // Basic syntax checks
    final hasClass = item.contains('class ');
    final hasImport = item.contains('import ');
    final balancedBraces = _balancedBraces(item);

    return hasClass && hasImport && balancedBraces;
  }

  bool _balancedBraces(String code) {
    var count = 0;
    for (final char in code.codeUnits) {
      if (char == '{'.codeUnitAt(0)) count++;
      if (char == '}'.codeUnitAt(0)) count--;
      if (count < 0) return false;
    }
    return count == 0;
  }

  @override
  Description describe(Description description) {
    return description.add('valid Dart code');
  }
}
