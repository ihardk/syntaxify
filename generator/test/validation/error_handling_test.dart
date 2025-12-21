import 'dart:io';
import 'package:test/test.dart';
import 'package:syntaxify/src/parser/meta_parser.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/infrastructure/memory_file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:mason_logger/mason_logger.dart';

void main() {
  group('Error Handling', () {
    group('Parser Error Handling', () {
      late MetaParser parser;
      late Logger logger;

      setUp(() {
        logger = Logger(level: Level.quiet);
        parser = MetaParser(logger: logger);
      });

      test('returns null for non-existent file', () async {
        final file = File('nonexistent/path/file.meta.dart');

        final result = await parser.parseFile(file);

        expect(result, isNull);
      });

      test('handles file without @SyntaxComponent annotation gracefully',
          () async {
        final tempFile = File('test/fixtures/temp_no_annotation.dart');
        await tempFile.create(recursive: true);
        await tempFile.writeAsString('''
class NotAnnotated {
  final String field;
}
''');

        final result = await parser.parseFile(tempFile);

        expect(result, isNull);

        await tempFile.delete();
      });

      test('handles malformed Dart file gracefully', () async {
        final tempFile = File('test/fixtures/temp_malformed.dart');
        await tempFile.create(recursive: true);
        await tempFile.writeAsString('this is not valid dart {{{');

        final result = await parser.parseFile(tempFile);

        expect(result, isNull);

        await tempFile.delete();
      });

      test('handles empty file gracefully', () async {
        final tempFile = File('test/fixtures/temp_empty.dart');
        await tempFile.create(recursive: true);
        await tempFile.writeAsString('');

        final result = await parser.parseFile(tempFile);

        expect(result, isNull);

        await tempFile.delete();
      });

      test('handles file with syntax errors gracefully', () async {
        final tempFile = File('test/fixtures/temp_syntax_error.dart');
        await tempFile.create(recursive: true);
        await tempFile.writeAsString('''
@SyntaxComponent()
class ButtonMeta {
  final String label
  // Missing semicolon
}
''');

        final result = await parser.parseFile(tempFile);

        // Should handle syntax error gracefully
        expect(result, isNull);

        await tempFile.delete();
      });
    });

    group('File System Error Handling', () {
      late MemoryFileSystem fileSystem;

      setUp(() {
        fileSystem = MemoryFileSystem();
      });

      test('readFile throws on non-existent file', () async {
        expect(
          () => fileSystem.readFile('/nonexistent.dart'),
          throwsA(isA<Exception>()),
        );
      });

      test('copyFile throws on non-existent source', () async {
        expect(
          () => fileSystem.copyFile('/nonexistent.dart', '/destination.dart'),
          throwsA(isA<Exception>()),
        );
      });

      test('handles multiple writes to same file', () async {
        await fileSystem.writeFile('/test.dart', 'content1');
        await fileSystem.writeFile('/test.dart', 'content2');

        final content = await fileSystem.readFile('/test.dart');
        expect(content, equals('content2'));
      });

      test('deleteFile on non-existent file succeeds silently', () async {
        // Should not throw
        await fileSystem.deleteFile('/nonexistent.dart');
        expect(fileSystem.hasFile('/nonexistent.dart'), isFalse);
      });
    });

    group('Generation Error Handling', () {
      late GenerateComponentUseCase useCase;
      late MemoryFileSystem fileSystem;
      late GeneratorRegistry registry;

      setUp(() {
        fileSystem = MemoryFileSystem();
        registry = GeneratorRegistry();
        useCase = GenerateComponentUseCase(
          fileSystem: fileSystem,
          registry: registry,
        );
      });

      test('handles empty component name', () async {
        final component = ComponentDefinition(
          name: '',
          className: 'Meta',
          properties: const [],
          variants: const [],
        );

        // Should handle empty name gracefully
        // Should throw due to formatting error on invalid code
        expect(
          () => useCase.execute(
            component: component,
            outputDir: '/output',
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('handles component with no properties', () async {
        final component = ComponentDefinition(
          name: 'Empty',
          className: 'EmptyMeta',
          properties: const [],
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(result, isNotEmpty);
        expect(fileSystem.hasFile('/output/components/app_empty.dart'), isTrue);
      });

      test('handles component with many properties', () async {
        final properties = List.generate(
          50,
          (i) => ComponentProp(
            name: 'prop$i',
            type: 'String',
            isRequired: i % 2 == 0,
          ),
        );

        final component = ComponentDefinition(
          name: 'ManyProps',
          className: 'ManyPropsMeta',
          properties: properties,
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(result, isNotEmpty);
      });
    });

    group('Boundary Conditions', () {
      test('handles component name with special characters', () {
        final component = ComponentDefinition(
          name: 'App_Button-Test',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        );

        expect(component.name, equals('App_Button-Test'));
      });

      test('handles extremely long component names', () {
        final longName = 'A' * 200;
        final component = ComponentDefinition(
          name: longName,
          className: 'Meta',
          properties: const [],
          variants: const [],
        );

        expect(component.name.length, equals(200));
      });

      test('handles component with circular references in types', () {
        final component = ComponentDefinition(
          name: 'Node',
          className: 'NodeMeta',
          properties: const [
            ComponentProp(
                name: 'children', type: 'List<Node>?', isRequired: false),
          ],
          variants: const [],
        );

        expect(component.properties.length, equals(1));
      });

      test('handles property with complex generic type', () {
        final component = ComponentDefinition(
          name: 'Complex',
          className: 'ComplexMeta',
          properties: const [
            ComponentProp(
              name: 'handler',
              type: 'Map<String, Function(int, String)?>?',
              isRequired: false,
            ),
          ],
          variants: const [],
        );

        expect(component.properties.first.type, contains('Map'));
        expect(component.properties.first.type, contains('Function'));
      });

      test('handles properties with Unicode characters in names', () {
        final component = ComponentDefinition(
          name: 'Unicode',
          className: 'UnicodeMeta',
          properties: const [
            ComponentProp(name: 'текст', type: 'String', isRequired: true),
            ComponentProp(name: '文本', type: 'String', isRequired: true),
          ],
          variants: const [],
        );

        expect(component.properties.length, equals(2));
      });
    });

    group('Validation Error Cases', () {
      test('handles empty property type', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: const [
            ComponentProp(name: 'field', type: '', isRequired: true),
          ],
          variants: const [],
        );

        expect(component.properties.first.type, isEmpty);
      });

      test('handles null safety violations in types', () {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: const [
            ComponentProp(name: 'required', type: 'String?', isRequired: true),
          ],
          variants: const [],
        );

        // Nullable type marked as required (user error)
        expect(component.properties.first.isRequired, isTrue);
        expect(component.properties.first.type, contains('?'));
      });

      test('handles duplicate property names', () {
        final component = ComponentDefinition(
          name: 'Duplicate',
          className: 'DuplicateMeta',
          properties: const [
            ComponentProp(name: 'name', type: 'String', isRequired: true),
            ComponentProp(name: 'name', type: 'int', isRequired: false),
          ],
          variants: const [],
        );

        expect(component.properties.length, equals(2));
        expect(
          component.properties.where((p) => p.name == 'name').length,
          equals(2),
        );
      });
    });

    group('Boundary Conditions', () {
      late GenerateComponentUseCase useCase;
      late MemoryFileSystem fileSystem;
      late GeneratorRegistry registry;

      setUp(() {
        fileSystem = MemoryFileSystem();
        registry = GeneratorRegistry();
        useCase = GenerateComponentUseCase(
          fileSystem: fileSystem,
          registry: registry,
        );
      });

      test('handles generation to root directory', () async {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: const [],
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/',
        );

        expect(result, equals('components/app_test.dart'));
      });

      test('handles output directory with trailing slash', () async {
        final component = ComponentDefinition(
          name: 'Test',
          className: 'TestMeta',
          properties: const [],
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/output/',
        );

        expect(result, isNotEmpty);
      });

      test('handles very deep output directory path', () async {
        final component = ComponentDefinition(
          name: 'Deep',
          className: 'DeepMeta',
          properties: const [],
          variants: const [],
        );

        final deepPath = List.generate(20, (i) => 'level$i').join('/');

        final result = await useCase.execute(
          component: component,
          outputDir: '/$deepPath',
        );

        expect(result, isNotEmpty);
      });

      test('handles component with only optional properties', () async {
        final component = ComponentDefinition(
          name: 'AllOptional',
          className: 'AllOptionalMeta',
          properties: const [
            ComponentProp(name: 'opt1', type: 'String?', isRequired: false),
            ComponentProp(name: 'opt2', type: 'int?', isRequired: false),
            ComponentProp(name: 'opt3', type: 'bool?', isRequired: false),
          ],
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(result, isNotEmpty);
        final code =
            fileSystem.getFile('/output/components/app_alloptional.dart');
        expect(code, isNotNull);
      });

      test('handles component with only required properties', () async {
        final component = ComponentDefinition(
          name: 'AllRequired',
          className: 'AllRequiredMeta',
          properties: const [
            ComponentProp(name: 'req1', type: 'String', isRequired: true),
            ComponentProp(name: 'req2', type: 'int', isRequired: true),
            ComponentProp(name: 'req3', type: 'bool', isRequired: true),
          ],
          variants: const [],
        );

        final result = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(result, isNotEmpty);
        final code =
            fileSystem.getFile('/output/components/app_allrequired.dart');
        expect(code, contains('required'));
      });
    });

    group('Concurrency and State', () {
      late GenerateComponentUseCase useCase;
      late MemoryFileSystem fileSystem;
      late GeneratorRegistry registry;

      setUp(() {
        fileSystem = MemoryFileSystem();
        registry = GeneratorRegistry();
        useCase = GenerateComponentUseCase(
          fileSystem: fileSystem,
          registry: registry,
        );
      });

      test('handles generating same component multiple times', () async {
        final component = ComponentDefinition(
          name: 'Repeated',
          className: 'RepeatedMeta',
          properties: const [],
          variants: const [],
        );

        // Generate 3 times
        await useCase.execute(component: component, outputDir: '/output');
        await useCase.execute(component: component, outputDir: '/output');
        await useCase.execute(component: component, outputDir: '/output');

        // Should overwrite, only one file exists
        expect(
            fileSystem.hasFile('/output/components/app_repeated.dart'), isTrue);
      });

      test('handles generating different components concurrently', () async {
        final comp1 = ComponentDefinition(
          name: 'First',
          className: 'FirstMeta',
          properties: const [],
          variants: const [],
        );

        final comp2 = ComponentDefinition(
          name: 'Second',
          className: 'SecondMeta',
          properties: const [],
          variants: const [],
        );

        // Generate concurrently
        await Future.wait([
          useCase.execute(component: comp1, outputDir: '/output'),
          useCase.execute(component: comp2, outputDir: '/output'),
        ]);

        expect(fileSystem.hasFile('/output/components/app_first.dart'), isTrue);
        expect(
            fileSystem.hasFile('/output/components/app_second.dart'), isTrue);
      });
    });
  });
}
