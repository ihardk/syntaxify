import 'package:path/path.dart' as path;
import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/generators/screen_generator.dart';

/// Use case for generating a Flutter screen from a ScreenDefinition.
///
/// Generates screens to `lib/screens/` which are user-editable.
/// Screens are only generated if they don't already exist (preserves user edits).
class GenerateScreenUseCase {
  GenerateScreenUseCase({
    required this.fileSystem,
    this.screenGenerator = const ScreenGenerator(),
  });

  final FileSystem fileSystem;
  final ScreenGenerator screenGenerator;

  Future<String?> execute({
    required ScreenDefinition screen,
    required String outputDir,
    String? packageName,
  }) async {
    final fileName = '${screen.id}_screen.dart';

    // Screens go to lib/screens/ (editable by user)
    // Not under outputDir - they're separate from generated code
    final screensDir = path.join('lib', 'screens');
    await fileSystem.createDirectory(screensDir);

    final filePath = path.join(screensDir, fileName);

    // Only generate if file doesn't exist (preserve user edits)
    if (await fileSystem.exists(filePath)) {
      return null; // Skip - file already exists
    }

    final code = screenGenerator.generate(screen, packageName: packageName);
    await fileSystem.writeFile(filePath, code);

    return 'screens/$fileName';
  }
}
