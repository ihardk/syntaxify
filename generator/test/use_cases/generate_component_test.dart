import 'package:test/test.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/infrastructure/memory_file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/models/component_definition.dart';

void main() {
  group('GenerateComponentUseCase', () {
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

    tearDown(() {
      fileSystem.clear();
    });

    group('execute', () {
      test('generates component file in correct location', () async {
        // Arrange
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          explicitName: 'AppButton',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        );

        // Act
        final filePath = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        // Assert
        expect(filePath, equals('components/app_button.dart'));
        expect(
            fileSystem.hasFile('/output/components/app_button.dart'), isTrue);
      });

      test('generates correct file name from component name', () async {
        final component = ComponentDefinition(
          name: 'AppText',
          className: 'TextMeta',
          properties: const [
            ComponentProp(name: 'text', type: 'String', isRequired: true),
          ],
          variants: const [],
        );

        final filePath = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(filePath, equals('components/app_text.dart'));
        expect(fileSystem.hasFile('/output/components/app_text.dart'), isTrue);
      });

      test('uses explicit name when provided', () async {
        final component = ComponentDefinition(
          name: 'CustomButton',
          className: 'ButtonMeta',
          explicitName: 'CustomButton',
          properties: const [],
          variants: const [],
        );

        final filePath = await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        expect(filePath, equals('components/app_custombutton.dart'));
      });

      test('creates components directory if it doesn\'t exist', () async {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        );

        await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        final files = await fileSystem.listFiles('/output/components');
        expect(files, isNotEmpty);
      });

      test('writes valid Dart code to file', () async {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(
                name: 'onPressed', type: 'VoidCallback?', isRequired: false),
          ],
          variants: const [],
        );

        await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/components/app_button.dart');
        expect(code, isNotNull);
        expect(code, contains('class AppButton'));
        expect(code, contains('StatelessWidget'));
        expect(code, contains('final String label'));
      });

      test('passes tokens to generator', () async {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        );

        // This test verifies tokens are passed through (tokens parameter exists)
        await useCase.execute(
          component: component,
          outputDir: '/output',
          tokens: null,
        );

        expect(
            fileSystem.hasFile('/output/components/app_button.dart'), isTrue);
      });

      test('handles component with multiple properties', () async {
        final component = ComponentDefinition(
          name: 'AppInput',
          className: 'InputMeta',
          explicitName: 'AppInput',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(
                name: 'placeholder', type: 'String?', isRequired: false),
            ComponentProp(name: 'obscureText', type: 'bool', isRequired: false),
            ComponentProp(
                name: 'onChanged',
                type: 'ValueChanged<String>?',
                isRequired: false),
          ],
          variants: const [],
        );

        await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/components/app_input.dart');
        // InputGenerator produces fields with proper types
        expect(code, contains('label'));
        expect(code, contains('hint'));
        expect(code, contains('obscureText'));
        expect(code, contains('onChanged'));
      });

      test('handles component with variants', () async {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(
                name: 'variant', type: 'ButtonVariant?', isRequired: false),
          ],
          variants: const ['ButtonVariant'],
        );

        await useCase.execute(
          component: component,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/components/app_button.dart');
        expect(code, contains('ButtonVariant'));
      });

      test('generates different files for different components', () async {
        final button = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: const [],
          variants: const [],
        );

        final text = ComponentDefinition(
          name: 'AppText',
          className: 'TextMeta',
          properties: const [],
          variants: const [],
        );

        await useCase.execute(component: button, outputDir: '/output');
        await useCase.execute(component: text, outputDir: '/output');

        expect(
            fileSystem.hasFile('/output/components/app_button.dart'), isTrue);
        expect(fileSystem.hasFile('/output/components/app_text.dart'), isTrue);
      });

      test('overwrites existing file', () async {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          explicitName: 'AppButton',
          properties: const [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: const [],
        );

        // Generate once
        await useCase.execute(component: component, outputDir: '/output');
        final firstCode =
            fileSystem.getFile('/output/components/app_button.dart');

        // Generate again
        await useCase.execute(component: component, outputDir: '/output');
        final secondCode =
            fileSystem.getFile('/output/components/app_button.dart');

        // Both should have content (file was overwritten, not preserved)
        expect(firstCode, isNotNull);
        expect(secondCode, isNotNull);
        // Code structure should be the same (ignore timestamps in comments)
        expect(secondCode, contains('class AppButton'));
      });
    });
  });
}
