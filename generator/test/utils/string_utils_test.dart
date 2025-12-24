import 'package:syntaxify/src/utils/string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('StringUtils', () {
    group('toPascalCase', () {
      test('converts snake_case to PascalCase', () {
        expect(StringUtils.toPascalCase('my_class_name'), 'MyClassName');
      });

      test('converts single word', () {
        expect(StringUtils.toPascalCase('button'), 'Button');
      });

      test('handles empty string', () {
        expect(StringUtils.toPascalCase(''), '');
      });

      test('handles single character', () {
        expect(StringUtils.toPascalCase('a'), 'A');
      });
    });

    group('toCamelCase', () {
      test('converts space-separated to camelCase', () {
        expect(StringUtils.toCamelCase('my variable'), 'myVariable');
      });

      test('handles single word', () {
        expect(StringUtils.toCamelCase('button'), 'button');
      });

      test('handles empty string', () {
        expect(StringUtils.toCamelCase(''), '');
      });
    });

    group('toSnakeCase', () {
      test('converts PascalCase to snake_case', () {
        expect(StringUtils.toSnakeCase('MyClassName'), 'my_class_name');
      });

      test('handles single word', () {
        expect(StringUtils.toSnakeCase('Button'), 'button');
      });

      test('handles empty string', () {
        expect(StringUtils.toSnakeCase(''), '');
      });

      test('handles lowercase', () {
        expect(StringUtils.toSnakeCase('button'), 'button');
      });
    });

    group('toKebabCase', () {
      test('converts PascalCase to kebab-case', () {
        expect(StringUtils.toKebabCase('MyClassName'), 'my-class-name');
      });

      test('handles single word', () {
        expect(StringUtils.toKebabCase('Button'), 'button');
      });

      test('handles empty string', () {
        expect(StringUtils.toKebabCase(''), '');
      });
    });
  });
}
