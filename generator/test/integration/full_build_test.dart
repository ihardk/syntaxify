import 'dart:io';
import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';
import 'package:syntaxify/src/use_cases/build_all.dart';
import 'package:syntaxify/src/infrastructure/memory_file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:mason_logger/mason_logger.dart';

void main() {
  group('Full Build Integration Tests',
      skip: 'BuildAllUseCase implementation pending', () {
    late BuildAllUseCase buildUseCase;
    late MemoryFileSystem fileSystem;
    late GeneratorRegistry registry;
    late Logger logger;

    setUp(() {
      fileSystem = MemoryFileSystem();
      registry = GeneratorRegistry();
      logger = Logger(level: Level.quiet);
      buildUseCase = BuildAllUseCase(
        fileSystem: fileSystem,
        registry: registry,
        logger: logger,
      );

      // Create pubspec.yaml for package name
      fileSystem.writeFile(
        'pubspec.yaml',
        'name: test_app\nversion: 1.0.0',
      );
    });

    tearDown(() {
      fileSystem.clear();
    });

    test('builds project with single component', () async {
      // Arrange
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
      ];

      // Act
      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      // Assert
      expect(result.hasErrors, isFalse);
      expect(result.filesGenerated, greaterThan(0));
      expect(
        fileSystem.hasFile('/lib/generated/components/app_button.dart'),
        isTrue,
      );
    });

    test('builds project with multiple components', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
        ComponentDefinition(
          name: 'AppText',
          className: 'TextMeta',
          properties: const [
            ComponentProp(name: 'text', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
        ComponentDefinition(
          name: 'AppInput',
          className: 'InputMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
      ];

      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(result.filesGenerated, greaterThanOrEqualTo(3));
      expect(fileSystem.hasFile('/lib/generated/components/app_button.dart'),
          isTrue);
      expect(fileSystem.hasFile('/lib/generated/components/app_text.dart'),
          isTrue);
      expect(fileSystem.hasFile('/lib/generated/components/app_input.dart'),
          isTrue);
    });

    test('builds project with single screen', () async {
      final screens = [
        ScreenDefinition(
          id: 'login',
          layout: LayoutNode.column(
            children: [
              LayoutNode.text(text: 'Welcome'),
              LayoutNode.button(label: 'Login', onPressed: 'handleLogin'),
            ],
          ),
        ),
      ];

      final result = await buildUseCase.execute(
        components: const [],
        screens: screens,
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(fileSystem.hasFile('/lib/screens/login_screen.dart'), isTrue);
    });

    test('builds project with components and screens', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
      ];

      final screens = [
        ScreenDefinition(
          id: 'home',
          layout: LayoutNode.column(
            children: [
              LayoutNode.text(text: 'Home'),
            ],
          ),
        ),
      ];

      final result = await buildUseCase.execute(
        components: components,
        screens: screens,
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(fileSystem.hasFile('/lib/generated/components/app_button.dart'),
          isTrue);
      expect(fileSystem.hasFile('/lib/screens/home_screen.dart'), isTrue);
    });

    test('handles build with empty components and screens', () async {
      final result = await buildUseCase.execute(
        components: const [],
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(result.filesGenerated, equals(0));
    });

    test('creates output directories if they don\'t exist', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        ),
      ];

      await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/new/output/path',
        metaDirectoryPath: '/meta',
      );

      final files = await fileSystem.listFiles('/new/output/path');
      expect(files, isNotEmpty);
    });

    test('build result contains generated file paths', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        ),
      ];

      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.generatedFiles, isNotEmpty);
      expect(
          result.generatedFiles.any((f) => f.contains('app_button')), isTrue);
    });

    test('handles screen generation failures gracefully', () async {
      // Create a screen with invalid data that might cause issues
      final screens = [
        ScreenDefinition(
          id: '', // Empty ID
          layout: LayoutNode.column(children: []),
        ),
      ];

      final result = await buildUseCase.execute(
        components: const [],
        screens: screens,
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      // Should handle error without crashing
      expect(result, isNotNull);
    });

    test('handles component generation failures gracefully', () async {
      final components = [
        ComponentDefinition(
          name: '', // Empty name
          className: '',
          properties: const [],
          variants: const [],
        ),
      ];

      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      // Should handle error without crashing
      expect(result, isNotNull);
    });

    test('reports build duration', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        ),
      ];

      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.duration, greaterThan(Duration.zero));
    });

    test('builds complex project with many components', () async {
      final components = List.generate(
        10,
        (i) => ComponentDefinition(
          name: 'Component$i',
          className: 'Component${i}Meta',
          properties: [
            ComponentProp(name: 'prop$i', type: 'String', isRequired: true),
          ],
          variants: const [],
        ),
      );

      final result = await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(result.filesGenerated, greaterThanOrEqualTo(10));
    });

    test('builds complex project with many screens', () async {
      final screens = List.generate(
        5,
        (i) => ScreenDefinition(
          id: 'screen$i',
          layout: LayoutNode.column(
            children: [
              LayoutNode.text(text: 'Screen $i'),
            ],
          ),
        ),
      );

      final result = await buildUseCase.execute(
        components: const [],
        screens: screens,
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      expect(result.filesGenerated, greaterThanOrEqualTo(5));
    });

    test('subsequent builds overwrite existing component files', () async {
      final component = ComponentDefinition(
        name: 'AppButton',
        className: 'ButtonMeta',
        properties: const [
          ComponentProp(name: 'label', type: 'String', isRequired: true),
        ],
        variants: const [],
      );

      // First build
      await buildUseCase.execute(
        components: [component],
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      final firstCode =
          fileSystem.getFile('/lib/generated/components/app_button.dart');

      // Second build with same component
      await buildUseCase.execute(
        components: [component],
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      final secondCode =
          fileSystem.getFile('/lib/generated/components/app_button.dart');

      // Code should be the same (file was overwritten)
      expect(firstCode, equals(secondCode));
    });

    test('subsequent builds preserve existing screen files', () async {
      final screen = ScreenDefinition(
        id: 'existing',
        layout: LayoutNode.column(children: []),
      );

      // Pre-create the screen file with custom content
      await fileSystem.createDirectory('/lib/screens');
      await fileSystem.writeFile(
        '/lib/screens/existing_screen.dart',
        '// Custom user edits',
      );

      // Build (should not overwrite)
      await buildUseCase.execute(
        components: const [],
        screens: [screen],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      final content = fileSystem.getFile('/lib/screens/existing_screen.dart');
      expect(content, equals('// Custom user edits'));
    });

    test('generates valid importable code', () async {
      final components = [
        ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(
                name: 'onPressed', type: 'VoidCallback?', isRequired: false),
          ],
          variants: const [],
        ),
      ];

      await buildUseCase.execute(
        components: components,
        screens: const [],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      final code =
          fileSystem.getFile('/lib/generated/components/app_button.dart');

      // Check for proper imports
      expect(code, contains('import \'package:flutter/material.dart\''));

      // Check for proper class structure
      expect(code, contains('class AppButton extends StatelessWidget'));

      // Check for proper build method
      expect(code, contains('Widget build(BuildContext context)'));
    });

    test('handles screens with complex nested layouts', () async {
      final screens = [
        ScreenDefinition(
          id: 'complex',
          layout: LayoutNode.column(
            children: [
              LayoutNode.row(
                children: [
                  LayoutNode.column(
                    children: [
                      LayoutNode.text(text: 'Deep 1'),
                      LayoutNode.text(text: 'Deep 2'),
                    ],
                  ),
                  LayoutNode.column(
                    children: [
                      LayoutNode.button(
                          label: 'Action 1', onPressed: 'onAction1'),
                      LayoutNode.button(
                          label: 'Action 2', onPressed: 'onAction2'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ];

      final result = await buildUseCase.execute(
        components: const [],
        screens: screens,
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      expect(result.hasErrors, isFalse);
      final code = fileSystem.getFile('/lib/screens/complex_screen.dart');
      expect(code, contains('Column'));
      expect(code, contains('Row'));
      expect(code, contains('onAction1'));
      expect(code, contains('onAction2'));
    });
  });
}
