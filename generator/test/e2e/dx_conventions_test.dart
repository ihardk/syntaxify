// E2E test for new DX conventions
import 'dart:io';
import 'package:test/test.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:syntaxify/syntaxify.dart';

void main() {
  group('E2E: New DX Conventions', () {
    late MetaParser parser;

    setUp(() {
      parser = MetaParser(logger: Logger());
    });

    test('parses component with @SyntaxComponent(variants: [...])', () async {
      final file = File('e2e_test/test_button.meta.dart');
      final result = await parser.parseFile(file);

      expect(result, isNotNull);
      expect(result!.className, 'TestButtonMeta');
      expect(result.explicitName, 'AppTestButton');

      // Check variants are parsed from annotation
      expect(result.variants,
          containsAll(['primary', 'secondary', 'danger', 'ghost']));

      // Check convention-based parsing
      final labelProp = result.properties.firstWhere((p) => p.name == 'label');
      expect(labelProp.isRequired, isTrue,
          reason: 'Non-nullable String should be required');

      final variantProp =
          result.properties.firstWhere((p) => p.name == 'variant');
      expect(variantProp.isRequired, isFalse,
          reason: 'Nullable String? should be optional');

      final onPressedProp =
          result.properties.firstWhere((p) => p.name == 'onPressed');
      expect(onPressedProp.isRequired, isFalse,
          reason: 'Nullable callback should be optional');
    });

    test('parses screen with App.xxx() syntax', () async {
      final dir = Directory('e2e_test');
      final result = await parser.parseDirectory(dir);

      expect(result.screens, hasLength(1));

      final screen = result.screens.first;
      expect(screen.id, 'testScreen'); // Inferred from variable name
    });
  });

  group('E2E: EnumGenerator', () {
    test('generates enum from variants', () {
      final generator = EnumGenerator();
      final code =
          generator.generate('TestButton', ['primary', 'secondary', 'danger']);

      expect(code, contains('enum TestButtonVariant'));
      expect(code, contains('primary'));
      expect(code, contains('secondary'));
      expect(code, contains('danger'));
    });
  });
}
