import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';

import 'package:syntaxify/src/models/build_result.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/parser/registry_parser.dart';
import 'package:syntaxify/src/generators/registry/icon_registry_generator.dart';
import 'package:syntaxify/src/use_cases/generate_screen.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/validation/layout_validator.dart';
import 'package:syntaxify/src/models/validation_error.dart';

/// Use case for building all components.
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
  late final _generateScreen = GenerateScreenUseCase(
    fileSystem: fileSystem,
  );
  final _validator = const LayoutValidator();

  /// Execute the full build.
  Future<BuildResult> execute({
    required List<ComponentDefinition> components,
    required List<ScreenDefinition> screens,
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

    // Read package name from pubspec.yaml for screen imports
    String? packageName;
    try {
      final pubspecPath = 'pubspec.yaml';
      if (await fileSystem.exists(pubspecPath)) {
        final content = await fileSystem.readFile(pubspecPath);
        final nameMatch =
            RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(content);
        if (nameMatch != null) {
          packageName = nameMatch.group(1)?.trim();
        }
      }
    } catch (e) {
      logger.warn('Could not read package name from pubspec.yaml: $e');
    }

    // Generate screens to lib/screens/ (editable)
    for (final screen in screens) {
      try {
        logger.info('Validating Screen: ${screen.id}');

        // Validate screen layout
        final validationErrors = _validator.validate(
          screen.layout,
          'screens/${screen.id}',
        );

        // Also validate appBar if present
        if (screen.appBar != null) {
          validationErrors.addAll(_validator.validate(
            screen.appBar!,
            'screens/${screen.id}.appBar',
          ));
        }

        // Collect validation errors and warnings
        for (final error in validationErrors) {
          final message = '${screen.id}: ${error.message} (${error.nodePath ?? "unknown"})';

          if (error.severity == ErrorSeverity.error) {
            logger.err('  ✗ $message');
            if (error.suggestion != null) {
              logger.detail('    💡 ${error.suggestion}');
            }
            errors.add(message);
          } else if (error.severity == ErrorSeverity.warning) {
            logger.warn('  ⚠ $message');
            if (error.suggestion != null) {
              logger.detail('    💡 ${error.suggestion}');
            }
            warnings.add(message);
          } else {
            logger.info('  ℹ $message');
            if (error.suggestion != null) {
              logger.detail('    💡 ${error.suggestion}');
            }
          }
        }

        // Only generate if no critical errors
        final hasErrors = validationErrors.any((e) => e.severity == ErrorSeverity.error);
        if (hasErrors) {
          logger.err('Skipping screen ${screen.id} due to validation errors');
          continue;
        }

        logger.info('Generating Screen: ${screen.id}');
        final filePath = await _generateScreen.execute(
          screen: screen,
          outputDir: outputDir,
          packageName: packageName,
        );
        if (filePath != null) {
          generatedFiles.add(filePath);
          logger.success('Generated: $filePath');
        } else {
          logger.detail(
              'Skipped: screens/${screen.id}_screen.dart (already exists)');
        }
      } catch (e) {
        logger.err('Failed to generate screen ${screen.id}: $e');
        errors.add('Failed to generate screen ${screen.id}: $e');
      }
    }

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
        'enums.dart',
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
        'material/text_renderer.dart',
        'cupertino/text_renderer.dart',
        'neo/text_renderer.dart',
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
            DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
                .format(content),
          );
          generatedFiles.add('design_system/app_icons.dart');
          logger.success('Generated: design_system/app_icons.dart');
        } else {
          // Fallback: Copy if exists in source
          final srcPath = path.join(designSystemDir, 'app_icons.dart');
          if (await fileSystem.exists(srcPath)) {
            final destPath =
                path.join(outputDir, 'design_system', 'app_icons.dart');
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/app_icons.dart');
            logger.success('Copied: design_system/app_icons.dart (Fallback)');
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
    // Also exclude screens since they're navigated to, not imported
    final exports = files
        .where((f) => f.endsWith('.dart') && !f.endsWith('index.dart'))
        .where((f) {
          // Only export design_system.dart from the design_system directory
          if (f.startsWith('design_system/')) {
            return f == 'design_system/design_system.dart';
          }
          // Don't export screens - they're navigated to, not imported
          if (f.startsWith('screens/')) {
            return false;
          }
          return true;
        })
        .map((f) => "export '$f';")
        .join('\n');

    final content = '''
// ============================================
// GENERATED BY SYNTAX v0.1.0
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
