import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:syntaxify/src/parser/extractors/extractors.dart';
import 'package:test/test.dart';

void main() {
  late PropertyExtractor extractor;

  setUp(() {
    extractor = PropertyExtractor();
  });

  (FieldDeclaration, VariableDeclaration) parseField(String code) {
    final result = parseString(content: '''
      class TestClass {
        $code
      }
    ''');
    final classDecl = result.unit.declarations.first as ClassDeclaration;
    final fieldDecl = classDecl.members.first as FieldDeclaration;
    return (fieldDecl, fieldDecl.fields.variables.first);
  }

  group('PropertyExtractor', () {
    test('extracts simple property name', () {
      final (field, variable) = parseField('final String? label;');
      final prop = extractor.extract(variable, field);

      expect(prop?.name, 'label');
    });

    test('extracts property type', () {
      final (field, variable) = parseField('final String? hint;');
      final prop = extractor.extract(variable, field);

      expect(prop?.type, 'String?');
    });

    test('extracts int type', () {
      final (field, variable) = parseField('final int? count;');
      final prop = extractor.extract(variable, field);

      expect(prop?.type, 'int?');
    });

    test('extracts bool type', () {
      final (field, variable) = parseField('final bool? active;');
      final prop = extractor.extract(variable, field);

      expect(prop?.type, 'bool?');
    });
  });
}
