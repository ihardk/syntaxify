import 'dart:io';
import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/plugins/default_plugin.dart';
import 'package:test/test.dart';
import 'package:mason_logger/mason_logger.dart';

void main() {
  group('Phase 1 End-to-End Integration (AST Refactor)', () {
    late BuildAllUseCase buildUseCase;
    late MemoryFileSystem fileSystem;
    late GeneratorRegistry registry;
    late Logger logger;

    setUp(() {
      fileSystem = MemoryFileSystem();
      registry = GeneratorRegistry()..registerPlugin(DefaultPlugin());
      logger = Logger(level: Level.quiet);

      buildUseCase = BuildAllUseCase(
        fileSystem: fileSystem,
        registry: registry,
        logger: logger,
      );
    });

    test('generates complex screen using ALL core AST node types', () async {
      // "Kitchen Sink" Screen Definition
      final screen = ScreenDefinition(
        id: 'kitchen_sink',
        appBar: AppBarNode(
          title: 'Phase 1 verification',
          leadingIcon: 'menu',
          actions: [
            AppBarAction(icon: 'search', onPressed: 'onSearch'),
          ],
        ),
        layout: App.column(
          mainAxisAlignment: MainAlignment.center,
          crossAxisAlignment: CrossAlignment.stretch,
          spacing: '16',
          children: [
            // Primitive: Text
            App.text(
              text: 'Hello World',
              variant: TextVariant.headlineMedium,
              align: SyntaxTextAlign.center,
            ),

            // Structural: Row
            App.row(
              mainAxisAlignment: MainAlignment.spaceBetween,
              children: [
                // Primitive: Icon
                App.icon(name: 'star', size: IconSize.sm),
                App.text(text: 'Rating: 5.0'),
              ],
            ),

            // Primitive: Spacer
            App.spacer(flex: 1),

            // Interactive: Button
            App.button(
              label: 'Submit',
              onPressed: 'onSubmit',
              variant: 'filled',
              icon: 'send',
              isLoading: true,
            ),

            // Interactive: TextField
            App.textField(
              label: 'Email',
              hint: 'Enter email',
              keyboardType: KeyboardType.email,
              onChanged: 'onEmailChanged',
            ),
          ],
        ),
      );

      // Execute Build
      final result = await buildUseCase.execute(
        components: const [],
        screens: [screen],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      // Verify Build Success
      expect(result.hasErrors, isFalse, reason: 'Build should succeed');
      expect(result.filesGenerated, greaterThan(0));

      final code = fileSystem.getFile('/lib/screens/kitchen_sink_screen.dart');
      print('Writing generated code to test_debug_output.txt');
      if (code != null) {
        File('test_debug_output.txt').writeAsStringSync(code);
      }
      print('GENERATED CODE:\n$code');
      expect(code, isNotNull);

      try {
        // Verify Core Widgets (Structural)
        expect(code, contains('Column'), reason: 'Should generate Column');
        expect(code, contains('Row'), reason: 'Should generate Row');
        expect(code, contains('mainAxisAlignment: MainAxisAlignment.center'));

        // Verify Primitives
        expect(code, contains('Text'), reason: 'Should generate Text');
        expect(code, contains("'Hello World'"));
        expect(code, contains('Icon'), reason: 'Should generate Icon');
        expect(
            code,
            contains(
                'Icons.star')); // Assuming icon mapping uses material icons
        expect(code, contains('Spacer'), reason: 'Should generate Spacer');

        // Verify Interactives
        expect(code, contains('AppButton'),
            reason: 'Should generate AppButton usage');
        expect(code, contains('label: \'Submit\''));
        expect(code, contains('isLoading: true'));

        expect(code, contains('AppInput'),
            reason:
                'Should generate AppInput usage'); // Assuming generic generator or default plugin uses AppInput
        expect(code, contains('label: \'Email\''));
        expect(code, contains('hint: \'Enter email\''));

        // Verify AppBar
        expect(code, contains('AppBar'), reason: 'Should generate AppBar');
        expect(
            code, contains('title: AppText(text: \'Phase 1 verification\')'));
      } catch (e) {
        print('ASSERTION FAILED: $e');
        rethrow;
      }
    });
  });
}
