import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:syntaxify/src/parser/extractors/extractors.dart';
import 'package:test/test.dart';

void main() {
  late EnumExtractor extractor;

  setUp(() {
    extractor = EnumExtractor();
  });

  EnumDeclaration parseEnum(String code) {
    final result = parseString(content: code);
    return result.unit.declarations.first as EnumDeclaration;
  }

  group('EnumExtractor', () {
    test('extracts enum name', () {
      final code = '''
        enum ButtonVariant { primary, secondary }
      ''';
      final enumDecl = parseEnum(code);
      final def = extractor.extract(enumDecl);

      expect(def.name, 'ButtonVariant');
    });

    test('extracts enum values', () {
      final code = '''
        enum ButtonSize { sm, md, lg }
      ''';
      final enumDecl = parseEnum(code);
      final def = extractor.extract(enumDecl);

      expect(def.values, ['sm', 'md', 'lg']);
    });

    test('handles empty enum', () {
      final code = '''
        enum EmptyEnum {}
      ''';
      final enumDecl = parseEnum(code);
      final def = extractor.extract(enumDecl);

      expect(def.values, isEmpty);
    });

    test('extracts single value enum', () {
      final code = '''
        enum SingleValue { only }
      ''';
      final enumDecl = parseEnum(code);
      final def = extractor.extract(enumDecl);

      expect(def.values, ['only']);
    });
  });
}
