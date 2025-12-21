import 'dart:io';

import 'package:test/test.dart';

import 'package:syntaxify/src/parser/meta_parser.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:mason_logger/mason_logger.dart';

void main() {
  group('MetaParser', skip: 'TODO: Fix fixture file paths for test runner', () {
    late MetaParser parser;
    late Logger logger;

    setUp(() {
      logger = Logger(level: Level.quiet);
      parser = MetaParser(logger: logger);
    });

    test('parses @SyntaxComponent annotation', () async {
      final file = File('meta/button.meta.dart');
      final result = await parser.parseFile(file);

      expect(result, isNotNull);
      expect(result!.className, equals('ButtonMeta'));
    });

    test('extracts required fields', () async {
      final file = File('meta/button.meta.dart');
      final result = await parser.parseFile(file);

      expect(result, isNotNull);

      final labelField = result!.properties.firstWhere(
        (f) => f.name == 'label', // Access properties instead of fields
        orElse: () => throw StateError('label field not found'),
      );

      expect(labelField.isRequired, isTrue);
      expect(labelField.type, equals('String'));
    });

    test('extracts optional fields', () async {
      final file = File('meta/button.meta.dart');
      final result = await parser.parseFile(file);

      expect(result, isNotNull);

      final onPressedField = result!.properties.firstWhere(
        (f) => f.name == 'onPressed',
        orElse: () => throw StateError('onPressed field not found'),
      );

      expect(onPressedField.isRequired, isFalse);
    });

    test('extracts all fields from ButtonMeta', () async {
      final file = File('meta/button.meta.dart');
      final result = await parser.parseFile(file);

      expect(result, isNotNull);
      expect(result!.properties.length, greaterThanOrEqualTo(4));

      final fieldNames = result.properties.map((f) => f.name).toList();
      expect(fieldNames, contains('label'));
      expect(fieldNames, contains('onPressed'));
      expect(fieldNames, contains('isLoading'));
      expect(fieldNames, contains('isDisabled'));
    });

    test('returns null for files without @SyntaxComponent', () async {
      // Create a temp file without annotation
      final tempFile = File('test/fixtures/no_meta.dart');
      await tempFile.create(recursive: true);
      await tempFile.writeAsString('class NotAMeta {}');

      final result = await parser.parseFile(tempFile);
      expect(result, isNull);

      await tempFile.delete();
    });

    test('parses directory returning all components', () async {
      final dir = Directory('meta');
      final result = await parser.parseDirectory(dir);

      expect(
          result.components, isNotEmpty); // Access components instead of nodes
      expect(result.errors, isEmpty);
    });
  });
}
