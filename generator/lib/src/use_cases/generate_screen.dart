import 'package:path/path.dart' as path;
import 'package:syntax/src/core/interfaces/file_system.dart';
import 'package:syntax/src/models/ast/screen_definition.dart';
import 'package:syntax/src/generators/screen_generator.dart';

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
    String? packageName,
  }) async {
    final code = screenGenerator.generate(screen, packageName: packageName);
    final fileName = '${screen.id}_screen.dart';

    // Screens go to lib/screens/ (editable by user)
    // Not under outputDir - they're separate from generated code
    final screensDir = path.join('lib', 'screens');
    await fileSystem.createDirectory(screensDir);

    final filePath = path.join(screensDir, fileName);
    await fileSystem.writeFile(filePath, code);

    return 'screens/$fileName';
  }
}
