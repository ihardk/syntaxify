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
    String? designSystemDir,
  }) async {
    final stopwatch = Stopwatch()..start();
    final generatedFiles = <String>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Create output directories
    await fileSystem
        .createDirectory(path.join(outputDir, 'generated', 'components'));

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
          outputDir: path.join(outputDir, 'generated'),
          tokens: matchingTokens,
        );

        generatedFiles.add('generated/$filePath');
        logger.success('Generated: generated/$filePath');
      } catch (e) {
        logger.err('Failed to generate ${component.className}: $e');
        errors.add('Failed to generate ${component.className}: $e');
      }
    }

    // Copy design system files (modular structure)
    if (designSystemDir != null) {
      // 1. Create design_system directory
      await fileSystem.createDirectory(path.join(outputDir, 'design_system'));
      await fileSystem
          .createDirectory(path.join(outputDir, 'design_system', 'styles'));

      // Core design system files (Source: design_system/ -> Dest: design_system/)
      final designSystemFiles = [
        'design_system.dart',
        'app_theme.dart',
        'design_style.dart',
        'button_variant.dart',
      ];

      for (final file in designSystemFiles) {
        try {
          final srcPath = path.join(designSystemDir, file);
          if (await fileSystem.exists(srcPath)) {
            final destPath = path.join(outputDir, 'design_system', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/$file');
            logger.success('Copied: design_system/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }

      // Style implementation files (Source: design_system/styles/ -> Dest: design_system/styles/)
      final styleFiles = [
        'material_style.dart',
        'cupertino_style.dart',
        'neo_style.dart',
      ];

      for (final file in styleFiles) {
        try {
          final srcPath = path.join(designSystemDir, 'styles', file);
          if (await fileSystem.exists(srcPath)) {
            final destPath =
                path.join(outputDir, 'design_system', 'styles', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/styles/$file');
            logger.success('Copied: design_system/styles/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }

      // Copy token files (Source: design_system/tokens/ -> Dest: design_system/tokens/)
      await fileSystem
          .createDirectory(path.join(outputDir, 'design_system', 'tokens'));

      for (final token in tokens) {
        try {
          final componentName = token.componentName.toLowerCase();
          final srcPath = path.join(
              designSystemDir, 'tokens', '${componentName}_tokens.dart');
          final destPath = path.join(
            outputDir,
            'design_system',
            'tokens',
            '${componentName}_tokens.dart',
          );

          if (await fileSystem.exists(srcPath)) {
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles
                .add('design_system/tokens/${componentName}_tokens.dart');
            logger.success(
                'Copied: design_system/tokens/${componentName}_tokens.dart');
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
    // Exclude part files that are already exported by design_system.dart
    final exports = files
        .where((f) => f.endsWith('.dart') && !f.endsWith('index.dart'))
        .where((f) {
          // Only export design_system.dart from the design_system directory
          if (f.startsWith('design_system/')) {
            return f == 'design_system/design_system.dart';
          }
          return true;
        })
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
