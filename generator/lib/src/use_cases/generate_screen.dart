import 'package:path/path.dart' as path;
import 'package:forge/src/core/interfaces/file_system.dart';
import 'package:forge/src/models/ast/screen_definition.dart';
import 'package:forge/src/generators/screen_generator.dart';

class GenerateScreenUseCase {
  GenerateScreenUseCase({
    required this.fileSystem,
    this.screenGenerator = const ScreenGenerator(),
  });

  final FileSystem fileSystem;
  final ScreenGenerator screenGenerator;

  Future<String> execute({
    required ScreenDefinition screen,
    required String outputDir,
  }) async {
    final code = screenGenerator.generate(screen);
    final fileName = '${screen.id}_screen.dart';

    // Screens go into lib/screens for now
    final screensDir = path.join(outputDir, 'screens');
    await fileSystem.createDirectory(screensDir);

    final filePath = path.join(screensDir, fileName);
    await fileSystem.writeFile(filePath, code);

    return 'screens/$fileName';
  }
}
