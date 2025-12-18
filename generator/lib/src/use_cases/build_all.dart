import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:forge/src/core/interfaces/file_system.dart';
import 'package:forge/src/generators/generator_registry.dart';
import 'package:forge/src/generator/theme_generator.dart';
import 'package:forge/src/models/build_result.dart';
import 'package:forge/src/models/ast_node.dart';
import 'package:forge/src/models/token_definition.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:forge/src/use_cases/generate_component.dart';
import 'package:forge/src/parser/registry_parser.dart';
import 'package:forge/src/generators/registry/icon_registry_generator.dart';

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
    required List<AstNode> components,
    required List<TokenDefinition> tokens,
    required String outputDir,
    required String metaDirectoryPath,
    String? designSystemDir,
  }) async {
    final metaDirectory = Directory(metaDirectoryPath);
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
          node: component,
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

      // Mixin Renderers (Source: design_system/styles/<style>/ -> Dest: design_system/styles/<style>/)
      // TODO: Implement recursive copy or glob finding to avoid hardcoding
      final rendererFiles = [
        'material/button_renderer.dart',
        'cupertino/button_renderer.dart',
        'neo/button_renderer.dart',
        'material/input_renderer.dart',
        'cupertino/input_renderer.dart',
        'neo/input_renderer.dart',
      ];

      for (final file in rendererFiles) {
        try {
          final srcPath = path.join(designSystemDir, 'styles', file);
          if (await fileSystem.exists(srcPath)) {
            // Create sub-directory (e.g., styles/material/)
            final subDir = path.dirname(file);
            await fileSystem.createDirectory(
                path.join(outputDir, 'design_system', 'styles', subDir));

            final destPath =
                path.join(outputDir, 'design_system', 'styles', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/styles/$file');
            logger.success('Copied: design_system/styles/$file');
          }
        } catch (e) {
          warnings.add('Could not copy renderer $file: $e');
        }
      }

      // HANDLE APP ICONS (Generate or Copy)
      try {
        final registryParser = RegistryParser(logger: logger);
        final registryDefs = await registryParser.parseDirectory(metaDirectory);

        if (registryDefs.isNotEmpty) {
          final iconGen = IconRegistryGenerator();
          final lib = iconGen.build(registryDefs.first);
          // Use DartEmitter with orderDirectives? Or manual.
          final emitter = DartEmitter(
              allocator: Allocator.simplePrefixing(), orderDirectives: true);
          final content = lib.accept(emitter).toString();

          await fileSystem.writeFile(
            path.join(outputDir, 'design_system', 'app_icons.dart'),
            DartFormatter().format(content),
          );
          generatedFiles.add('design_system/app_icons.dart');
          logger.success('Generated: design_system/app_icons.dart');
        } else {
          // Fallback: Copy if exists in source
          if (designSystemDir != null) {
            final srcPath = path.join(designSystemDir, 'app_icons.dart');
            if (await fileSystem.exists(srcPath)) {
              final destPath =
                  path.join(outputDir, 'design_system', 'app_icons.dart');
              await fileSystem.copyFile(srcPath, destPath);
              generatedFiles.add('design_system/app_icons.dart');
              logger.success('Copied: design_system/app_icons.dart (Fallback)');
            }
          }
        }
      } catch (e) {
        warnings.add('Failed to handle AppIcons: $e');
      }

      // Copy token files (Source: design_system/tokens/ -> Dest: design_system/tokens/)
      await fileSystem
          .createDirectory(path.join(outputDir, 'design_system', 'tokens'));

      // Explicitly copy shared tokens
      try {
        final iconTokenPath =
            path.join(designSystemDir, 'tokens', 'icon_token.dart');
        if (await fileSystem.exists(iconTokenPath)) {
          final destPath = path.join(
              outputDir, 'design_system', 'tokens', 'icon_token.dart');
          await fileSystem.copyFile(iconTokenPath, destPath);
          generatedFiles.add('design_system/tokens/icon_token.dart');
          logger.success('Copied: design_system/tokens/icon_token.dart');
        }
      } catch (e) {
        warnings.add('Could not copy icon_token.dart: $e');
      }

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
