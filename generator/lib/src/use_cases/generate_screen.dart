import 'package:path/path.dart' as p;
import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/generators/screen_generator.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';

/// Use case for generating a Flutter screen from a ScreenDefinition.
///
/// Generates screens to `lib/screens/` which are user-editable.
/// Screens are only generated if they don't already exist (preserves user edits).
class GenerateScreenUseCase {
  GenerateScreenUseCase({
    required this.fileSystem,
    required this.registry,
    ScreenGenerator? screenGenerator,
  }) : screenGenerator = screenGenerator ??
            ScreenGenerator(layoutEmitter: LayoutEmitter(registry: registry));

  final FileSystem fileSystem;
  final GeneratorRegistry registry;
  final ScreenGenerator screenGenerator;

  Future<String?> execute({
    required ScreenDefinition screen,
    required String outputDir,
    String? packageName,
  }) async {
    final fileName = '${screen.id}_screen.dart';
    final context = p.posix;

    // Screens go to lib/screens/ (editable by user)
    // outputDir is typically 'lib', so this becomes lib/screens
    final screensDir = context.join(outputDir, 'screens');
    await fileSystem.createDirectory(screensDir);

    final filePath = context.join(screensDir, fileName);

    // Only generate if file doesn't exist (preserve user edits)
    if (await fileSystem.exists(filePath)) {
      return null; // Skip - file already exists
    }

    final code = screenGenerator.generate(screen, packageName: packageName);
    await fileSystem.writeFile(filePath, code);

    return 'screens/$fileName';
  }
}
