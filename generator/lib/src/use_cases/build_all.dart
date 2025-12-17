import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

import 'package:forge/src/core/interfaces/file_system.dart';
import 'package:forge/src/generators/generator_registry.dart';
import 'package:forge/src/generator/theme_generator.dart';
import 'package:forge/src/models/build_result.dart';
import 'package:forge/src/models/meta_component.dart';
import 'package:forge/src/models/token_definition.dart';
import 'package:forge/src/use_cases/generate_component.dart';

/// Use case for building all components.
///
/// Orchestrates the full build process:
/// 1. Generates each component using appropriate generator
/// 2. Generates theme provider
/// 3. Copies token files
/// 4. Creates barrel file
class BuildAllUseCase {
  BuildAllUseCase({
    required this.fileSystem,
    required this.registry,
    required this.logger,
  });

  final FileSystem fileSystem;
  final GeneratorRegistry registry;
  final Logger logger;

  late final _generateComponent = GenerateComponentUseCase(
    fileSystem: fileSystem,
    registry: registry,
  );
  late final _themeGenerator = ThemeGenerator();

  /// Execute the full build.
  Future<BuildResult> execute({
    required List<MetaComponent> components,
    required List<TokenDefinition> tokens,
    required String outputDir,
    String? tokensDir,
  }) async {
    final stopwatch = Stopwatch()..start();
    final generatedFiles = <String>[];
    final warnings = <String>[];
    final errors = <String>[];

    // Create output directories
    await fileSystem.createDirectory(path.join(outputDir, 'components'));
    await fileSystem.createDirectory(path.join(outputDir, 'theme'));
    await fileSystem.createDirectory(path.join(outputDir, 'tokens'));

    // Generate each component
    for (final component in components) {
      try {
        logger.info('Generating: ${component.className}');

        final matchingTokens = tokens
            .where(
              (t) =>
                  t.componentName.toLowerCase() ==
                  component.className.replaceAll('Meta', '').toLowerCase(),
            )
            .firstOrNull;

        final filePath = await _generateComponent.execute(
          component: component,
          outputDir: outputDir,
          tokens: matchingTokens,
        );

        generatedFiles.add(filePath);
        logger.success('Generated: $filePath');
      } catch (e) {
        logger.err('Failed to generate ${component.className}: $e');
        errors.add('Failed to generate ${component.className}: $e');
      }
    }

    // Copy design system files (modular structure)
    if (tokensDir != null) {
      // Core design system files
      final designSystemFiles = [
        'design_system.dart', // Barrel file
        'app_theme.dart',
        'design_style.dart',
        'button_variant.dart',
      ];

      for (final file in designSystemFiles) {
        try {
          final srcPath = path.join(tokensDir, file);
          if (await fileSystem.exists(srcPath)) {
            final destPath = path.join(outputDir, 'tokens', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('tokens/$file');
            logger.success('Copied: tokens/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }

      // Create styles subdirectory
      await fileSystem
          .createDirectory(path.join(outputDir, 'tokens', 'styles'));

      // Style implementation files
      final styleFiles = [
        'styles/material_style.dart',
        'styles/cupertino_style.dart',
        'styles/neo_style.dart',
      ];

      for (final file in styleFiles) {
        try {
          final srcPath = path.join(tokensDir, file);
          if (await fileSystem.exists(srcPath)) {
            final destPath = path.join(outputDir, 'tokens', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('tokens/$file');
            logger.success('Copied: tokens/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }
    }

    // Copy token files
    if (tokensDir != null) {
      for (final token in tokens) {
        try {
          final componentName = token.componentName.toLowerCase();
          final srcPath = path.join(tokensDir, '${componentName}_tokens.dart');
          final destPath = path.join(
            outputDir,
            'tokens',
            '${componentName}_tokens.dart',
          );

          if (await fileSystem.exists(srcPath)) {
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('tokens/${componentName}_tokens.dart');
            logger.success('Copied: tokens/${componentName}_tokens.dart');
          }
        } catch (e) {
          warnings.add('Could not copy token file for ${token.componentName}');
        }
      }
    }

    // Generate barrel file
    await _generateBarrelFile(outputDir, generatedFiles);
    generatedFiles.add('index.dart');

    stopwatch.stop();

    return BuildResult(
      filesGenerated: generatedFiles.length,
      generatedFiles: generatedFiles,
      duration: stopwatch.elapsed,
      warnings: warnings,
      errors: errors,
    );
  }

  Future<void> _generateBarrelFile(
    String outputDir,
    List<String> files,
  ) async {
    final exports = files
        .where((f) => f.endsWith('.dart') && !f.endsWith('index.dart'))
        .map((f) => "export '$f';")
        .join('\n');

    final content = '''
// ============================================
// GENERATED BY FORGE v0.1.0
// DO NOT MODIFY - Regenerated on build
// Barrel file exporting all generated code
// ============================================

$exports
''';

    await fileSystem.writeFile(
      path.join(outputDir, 'index.dart'),
      content,
    );
  }
}
