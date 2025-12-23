import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/plugins/syntaxify_plugin.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';
import 'package:test/test.dart';
import 'package:mason_logger/mason_logger.dart';

// --- Test Plugin Definition ---

class TestPlugin extends SyntaxifyPlugin {
  @override
  String get namespace => 'test_kit';

  @override
  Map<String, ComponentGenerator> get componentGenerators => {
        'carousel': StubGenerator('Carousel'),
      };

  @override
  Map<String, CustomEmitterHandler> get layoutEmitters => {
        'Carousel': CarouselEmitter(),
      };
}

class StubGenerator extends ComponentGenerator {
  StubGenerator(this.type);
  final String type;

  @override
  String get componentType => type.toLowerCase();

  @override
  bool canHandle(ComponentDefinition component) =>
      component.name.toLowerCase().contains(type.toLowerCase());

  @override
  String generate({
    required ComponentDefinition component,
    TokenDefinition? tokens,
  }) {
    return 'class ${component.className} extends StatelessWidget {}';
  }
}

class CarouselEmitter extends CustomEmitterHandler {
  @override
  Expression emit(CustomNode node) {
    return refer('TestCarousel').newInstance([], {
      'items': literalList(node.props['items'] as List),
      'autoPlay': literalBool(node.props['autoPlay'] as bool? ?? false),
    });
  }
}

// --- End Test Plugin Definition ---

void main() {
  group('Plugin End-to-End Integration', () {
    late BuildAllUseCase buildUseCase;
    late MemoryFileSystem fileSystem;
    late GeneratorRegistry registry;
    late Logger logger;

    setUp(() {
      fileSystem = MemoryFileSystem();
      registry = GeneratorRegistry();
      logger = Logger(level: Level.quiet);

      // 1. Register the external plugin
      registry.registerPlugin(TestPlugin());

      buildUseCase = BuildAllUseCase(
        fileSystem: fileSystem,
        registry: registry,
        logger: logger,
      );
    });

    test('plugin can emit custom layout nodes in screens', () async {
      // 2. Define a screen using the custom node
      final screen = ScreenDefinition(
        id: 'dashboard',
        layout: App.column(
          children: [
            App.text(text: 'Featured Items'),
            App.custom(
              node: CustomNode(
                type: 'Carousel',
                props: {
                  'items': ['Item 1', 'Item 2'],
                  'autoPlay': true,
                },
              ),
            ),
          ],
        ),
      );

      // 3. Run the build
      final result = await buildUseCase.execute(
        components: const [], // No component file generation for this test
        screens: [screen],
        tokens: const [],
        outputDir: '/lib',
        metaDirectoryPath: '/meta',
      );

      // 4. Verify the output
      expect(result.hasErrors, isFalse);

      final code = fileSystem.getFile('/lib/screens/dashboard_screen.dart');
      expect(code, isNotNull);

      // Check for the custom emitter output
      expect(code, contains('TestCarousel'));
      expect(code, contains("['Item 1', 'Item 2']"));
      expect(code, contains('autoPlay: true'));
    });
  });
}
