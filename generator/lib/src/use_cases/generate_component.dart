import 'package:path/path.dart' as path;

import 'package:syntax/src/core/interfaces/file_system.dart';
import 'package:syntax/src/generators/generator_registry.dart';
import 'package:syntax/src/models/component_definition.dart';
import 'package:syntax/src/models/token_definition.dart';

/// Use case for generating a single component.
///
/// Follows Single Responsibility: Only generates one component.
/// Uses Dependency Inversion: Depends on abstractions (FileSystem, GeneratorRegistry).
class GenerateComponentUseCase {
  GenerateComponentUseCase({
    required this.fileSystem,
    required this.registry,
  });

  final FileSystem fileSystem;
  final GeneratorRegistry registry;

  /// Execute the use case.
  ///
  /// Returns the path to the generated file.
  Future<String> execute({
    required ComponentDefinition component,
    required String outputDir,
    TokenDefinition? tokens,
  }) async {
    // Find appropriate generator
    final generator = registry.forComponent(component);

    // Generate code
    final code = generator.generate(
      component: component,
      tokens: tokens,
    );

    // Ensure output directory exists
    final componentsDir = path.join(outputDir, 'components');
    await fileSystem.createDirectory(componentsDir);

    // Write file
    final componentName =
        component.className.replaceAll('Meta', '').toLowerCase();
    final fileName = 'app_$componentName.dart';
    final filePath = path.join(componentsDir, fileName);

    await fileSystem.writeFile(filePath, code);

    return 'components/$fileName';
  }
}
