import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/generators/enum_generator.dart';
import 'package:syntaxify/src/generators/design_system_generator.dart';

import 'package:syntaxify/src/models/build_result.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/parser/registry_parser.dart';
import 'package:syntaxify/src/generators/registry/icon_registry_generator.dart';
import 'package:syntaxify/src/generators/registry/image_registry_generator.dart';
import 'package:syntaxify/src/use_cases/generate_screen.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/validation/layout_validator.dart';
import 'package:syntaxify/src/models/validation_error.dart';
import 'package:syntaxify/src/infrastructure/build_cache_manager.dart';
import 'package:syntaxify/src/models/build_cache.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

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
    registry: registry,
  );
  final _validator = const LayoutValidator();

  /// Execute the full build process.
  ///
  /// This orchestrates the entire build pipeline:
  /// 1. Validates all screen definitions.
  /// 2. Checks build cache to skip unchanged files (incremental build).
  /// 3. Generates component code.
  /// 4. Generates screen code.
  /// 5. Updates the registry and build cache.
  ///
  /// [components] List of parsed component definitions.
  /// [screens] List of parsed screen definitions.
  /// [tokens] List of design tokens.
  /// [outputDir] Directory to write generated files to.
  /// [metaDirectoryPath] Source directory for meta definitions.
  /// [designSystemDir] Directory containing design system implementations.
  /// [enableCache] Whether to use incremental build caching (default: true).
  /// [forceRebuild] Whether to ignore cache and force rebuild (default: false).
  Future<BuildResult> execute({
    required List<ComponentDefinition> components,
    required List<ScreenDefinition> screens,
    required List<TokenDefinition> tokens,
    required String outputDir,
    required String metaDirectoryPath,
    String? designSystemDir,
    bool enableCache = true,
    bool forceRebuild = false,
  }) async {
    final metaDirectory = Directory(metaDirectoryPath);
    final stopwatch = Stopwatch()..start();
    final generatedFiles = <String>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Initialize build cache
    BuildCacheManager? cacheManager;
    BuildCache cache = BuildCache.empty();
    final cacheUpdates = <String, CacheEntry>{};

    // Use posix style for consistent internal paths (forward slashes)
    // especially for imports and memory file system tests
    final context = p.posix;

    if (enableCache && !forceRebuild) {
      cacheManager = BuildCacheManager(
        fileSystem: fileSystem,
        cacheFilePath:
            context.join(outputDir, BuildCacheManager.defaultCacheFileName),
      );
      cache = await cacheManager.loadCache();
      logger.detail('Loaded build cache with ${cache.entries.length} entries');
    } else if (forceRebuild) {
      logger.detail('Force rebuild enabled, skipping cache');
    }

    // Create output directories
    await fileSystem
        .createDirectory(context.join(outputDir, 'generated', 'components'));

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
          final message =
              '${screen.id}: ${error.message} (${error.nodePath ?? "unknown"})';

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
        final hasErrors =
            validationErrors.any((e) => e.severity == ErrorSeverity.error);
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
          outputDir: context.join(outputDir, 'generated'),
          tokens: matchingTokens,
        );

        generatedFiles.add('generated/$filePath');
        logger.success('Generated: generated/$filePath');
      } catch (e) {
        logger.err('Failed to generate ${component.className}: $e');
        errors.add('Failed to generate ${component.className}: $e');
      }
    }

    // Generate variant enums for components with variants
    final enumGenerator = EnumGenerator();
    await fileSystem
        .createDirectory(context.join(outputDir, 'generated', 'variants'));

    for (final component in components) {
      if (component.variants.isNotEmpty) {
        try {
          final componentName = component.explicitName ??
              component.className.replaceAll('Meta', '');
          final enumCode =
              enumGenerator.generate(componentName, component.variants);
          final fileName =
              '${StringUtils.toSnakeCase(componentName)}_variant.dart';
          final filePath =
              context.join(outputDir, 'generated', 'variants', fileName);

          await fileSystem.writeFile(filePath, enumCode);
          generatedFiles.add('generated/variants/$fileName');
          logger.success('Generated enum: generated/variants/$fileName');
        } catch (e) {
          warnings
              .add('Could not generate enum for ${component.className}: $e');
        }
      }
    }

    // Copy design system files (modular structure)
    if (designSystemDir != null) {
      // 1. Create design_system directory
      await fileSystem
          .createDirectory(context.join(outputDir, 'design_system'));
      await fileSystem
          .createDirectory(context.join(outputDir, 'design_system', 'styles'));

      // Core design system files (Source: design_system/ -> Dest: design_system/)
      final designSystemFiles = [
        'design_system.dart',
        'app_theme.dart',
        'design_style.dart',
        'variants.dart',
      ];

      for (final file in designSystemFiles) {
        try {
          final srcPath = context.join(designSystemDir, file);
          if (await fileSystem.exists(srcPath)) {
            final destPath = context.join(outputDir, 'design_system', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/$file');
            logger.success('Copied: design_system/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }

      // Style implementation files (Source: design_system/styles/ -> Dest: design_system/styles/)
      // Style implementation files
      final styleFiles = [
        'material_style.dart',
        'cupertino_style.dart',
        'neo_style.dart',
      ];

      for (final file in styleFiles) {
        try {
          final srcPath = context.join(designSystemDir, 'styles', file);
          if (await fileSystem.exists(srcPath)) {
            final destPath =
                context.join(outputDir, 'design_system', 'styles', file);
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/styles/$file');
            logger.success('Copied: design_system/styles/$file');
          }
        } catch (e) {
          warnings.add('Could not copy $file: $e');
        }
      }

      // Copy components recursively (Source: design_system/components/ -> Dest: design_system/components/)
      // Uses dart:io Directory for recursion as FileSystem abstraction doesn't support it easily
      try {
        final componentsDir =
            Directory(context.join(designSystemDir, 'components'));
        if (await componentsDir.exists()) {
          final destComponentsDir =
              context.join(outputDir, 'design_system', 'components');
          await fileSystem.createDirectory(destComponentsDir);

          await for (final entity
              in componentsDir.list(recursive: true, followLinks: false)) {
            if (entity is File) {
              // Normalize path to posix
              final relPath = p
                  .relative(entity.path, from: componentsDir.path)
                  .replaceAll(p.separator, '/');
              final destPath = context.join(destComponentsDir, relPath);

              // Create parent directory if needed
              final parentDir = context.dirname(destPath);
              await fileSystem.createDirectory(parentDir);

              await fileSystem.copyFile(entity.path, destPath);
              generatedFiles.add('design_system/components/$relPath');
              logger.success('Copied: design_system/components/$relPath');
            }
          }
        }
      } catch (e) {
        warnings.add('Failed to copy components directory: $e');
      }

      // HANDLE APP ICONS (Generate or Copy)
      try {
        final registryParser = RegistryParser(logger: logger);
        final registryDefs = await registryParser.parseDirectory(metaDirectory);

        // Separate icon and image registries
        final iconRegistries =
            registryDefs.where((r) => r.type == RegistryType.icon).toList();
        final imageRegistries =
            registryDefs.where((r) => r.type == RegistryType.image).toList();

        // Generate AppIcons if icon registry exists
        if (iconRegistries.isNotEmpty) {
          final iconGen = IconRegistryGenerator();
          final lib = iconGen.build(iconRegistries.first);
          final emitter = DartEmitter(
              allocator: Allocator.simplePrefixing(), orderDirectives: true);
          final content = lib.accept(emitter).toString();

          await fileSystem.writeFile(
            context.join(outputDir, 'design_system', 'app_icons.dart'),
            DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
                .format(content),
          );
          generatedFiles.add('design_system/app_icons.dart');
          logger.success('Generated: design_system/app_icons.dart');
        } else {
          // Fallback: Copy if exists in source
          final srcPath = context.join(designSystemDir, 'app_icons.dart');
          if (await fileSystem.exists(srcPath)) {
            final destPath =
                context.join(outputDir, 'design_system', 'app_icons.dart');
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/app_icons.dart');
            logger.success('Copied: design_system/app_icons.dart (Fallback)');
          }
        }

        // Generate AppImages if image registry exists
        if (imageRegistries.isNotEmpty) {
          final imageGen = ImageRegistryGenerator();
          final lib = imageGen.build(imageRegistries.first);
          final emitter = DartEmitter(
              allocator: Allocator.simplePrefixing(), orderDirectives: true);
          final content = lib.accept(emitter).toString();

          await fileSystem.writeFile(
            context.join(outputDir, 'design_system', 'app_images.dart'),
            DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
                .format(content),
          );
          generatedFiles.add('design_system/app_images.dart');
          logger.success('Generated: design_system/app_images.dart');
        } else {
          // Fallback: Copy if exists in source
          final srcPath = context.join(designSystemDir, 'app_images.dart');
          if (await fileSystem.exists(srcPath)) {
            final destPath =
                context.join(outputDir, 'design_system', 'app_images.dart');
            await fileSystem.copyFile(srcPath, destPath);
            generatedFiles.add('design_system/app_images.dart');
            logger.success('Copied: design_system/app_images.dart (Fallback)');
          }
        }
      } catch (e) {
        warnings.add('Failed to handle AppIcons: $e');
      }

      // Copy token files (Source: design_system/tokens/ -> Dest: design_system/tokens/)
      await fileSystem
          .createDirectory(context.join(outputDir, 'design_system', 'tokens'));

      // Copy foundation token directory (Critical for centralized token system)
      try {
        final foundationTokenDir =
            Directory(context.join(designSystemDir, 'tokens', 'foundation'));
        if (await foundationTokenDir.exists()) {
          final destFoundationDir = context.join(
              outputDir, 'design_system', 'tokens', 'foundation');
          await fileSystem.createDirectory(destFoundationDir);

          // Copy all foundation token files
          await for (final entity in foundationTokenDir.list(
              recursive: false, followLinks: false)) {
            if (entity is File && entity.path.endsWith('.dart')) {
              final fileName = context.basename(entity.path);
              final destPath = context.join(destFoundationDir, fileName);

              await fileSystem.copyFile(entity.path, destPath);
              generatedFiles
                  .add('design_system/tokens/foundation/$fileName');
              logger.success(
                  'Copied: design_system/tokens/foundation/$fileName');
            }
          }
        } else {
          warnings.add(
              'Foundation token directory not found at ${foundationTokenDir.path}');
        }
      } catch (e) {
        warnings.add('Failed to copy foundation tokens: $e');
      }

      // Explicitly copy shared tokens
      try {
        final iconTokenPath =
            context.join(designSystemDir, 'tokens', 'icon_token.dart');
        if (await fileSystem.exists(iconTokenPath)) {
          final destPath = context.join(
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
          final srcPath = context.join(
              designSystemDir, 'tokens', '${componentName}_tokens.dart');
          final destPath = context.join(
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

    // Generate dynamic design system files (DesignStyle, Styles, Renderer Stubs)
    // This runs AFTER copying so we can overwrite/augment the static files
    if (designSystemDir != null) {
      final designGen = DesignSystemGenerator();
      final standardComponents = {
        'Button',
        'Input',
        'Text',
        'Checkbox',
        'Toggle',
        'Slider',
        'Radio'
      };

      try {
        // 1. Generate Main Library (design_system.dart)
        final mainLibCode = designGen.generateMainLibrary(components);
        await fileSystem.writeFile(
            context.join(outputDir, 'design_system', 'design_system.dart'),
            mainLibCode);
        generatedFiles.add('design_system/design_system.dart');
        logger.success('Generated: design_system/design_system.dart');

        // 2. Generate Abstract DesignStyle
        final designStyleCode = designGen.generateDesignStyle(components);
        await fileSystem.writeFile(
            context.join(outputDir, 'design_system', 'design_style.dart'),
            designStyleCode);
        generatedFiles.add('design_system/design_style.dart');
        logger.success('Generated: design_system/design_style.dart');

        // 3. Generate Concrete Styles (Material, Cupertino, Neo)
        final styles = ['Material', 'Cupertino', 'Neo'];
        for (final style in styles) {
          final styleCode = designGen.generateStyleClass(style, components);
          final fileName = '${style.toLowerCase()}_style.dart';
          await fileSystem.writeFile(
              context.join(outputDir, 'design_system', 'styles', fileName),
              styleCode);
          generatedFiles.add('design_system/styles/$fileName');
          logger.success('Generated: design_system/styles/$fileName');
        }

        // 4. Generate Renderer Stubs for Custom Components
        for (final component in components) {
          final baseName = component.explicitName ??
              component.className.replaceAll('Meta', '');
          final cleanName =
              baseName.startsWith('App') ? baseName.substring(3) : baseName;

          if (standardComponents.contains(cleanName)) continue;

          final folderName = StringUtils.toSnakeCase(cleanName);
          final componentDir = context.join(
              outputDir, 'design_system', 'components', folderName);
          await fileSystem.createDirectory(componentDir);

          for (final style in styles) {
            final stubCode = designGen.generateRendererStub(component, style);
            final fileName = '${style.toLowerCase()}_renderer.dart';
            await fileSystem.writeFile(
                context.join(componentDir, fileName), stubCode);
            generatedFiles
                .add('design_system/components/$folderName/$fileName');
            logger.success(
                'Generated Stub: design_system/components/$folderName/$fileName');
          }
        }
      } catch (e) {
        logger.err('Failed to generate design system files: $e');
        errors.add('Failed to generate design system files: $e');
      }
    }

    // Generate barrel file
    await _generateBarrelFile(outputDir, generatedFiles);
    generatedFiles.add('index.dart');

    // Save build cache
    if (cacheManager != null && cacheUpdates.isNotEmpty) {
      cache = await cacheManager.updateCache(cache, cacheUpdates);
      await cacheManager.saveCache(cache);
      logger.detail('Saved build cache with ${cache.entries.length} entries');
    }

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
// GENERATED BY SYNTAXIFY v0.1.0-alpha.10
// DO NOT MODIFY - Regenerated on build
// Barrel file exporting all generated code
// ============================================

$exports
''';

    await fileSystem.writeFile(
      p.posix.join(outputDir, 'index.dart'),
      content,
    );
  }
}
