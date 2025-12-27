import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/models/build_result.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/infrastructure/repositories/project_repository.dart';
import 'package:syntaxify/src/infrastructure/repositories/cache_repository.dart';
import 'package:syntaxify/src/services/component_generation_service.dart';
import 'package:syntaxify/src/services/screen_generation_service.dart';
import 'package:syntaxify/src/services/design_system_service.dart';

/// Use case for building all components.
///
/// This is the main orchestrator for the build pipeline. It delegates
/// to specialized services for different aspects of code generation:
/// - ComponentGenerationService: Handles component code generation
/// - ScreenGenerationService: Handles screen code generation
/// - DesignSystemService: Handles design system file operations
class BuildAllUseCase {
  BuildAllUseCase({
    required this.fileSystem,
    required this.registry,
    required this.logger,
  });

  final FileSystem fileSystem;
  final GeneratorRegistry registry;
  final Logger logger;

  /// Execute the full build process.
  ///
  /// This orchestrates the entire build pipeline using a service-layer architecture:
  /// 1. Initialize repositories (ProjectRepository, CacheRepository)
  /// 2. Create services (ComponentGenerationService, ScreenGenerationService, DesignSystemService)
  /// 3. Generate components, screens, and design system files
  /// 4. Collect results and update build cache
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
    final stopwatch = Stopwatch()..start();
    final generatedFiles = <String>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Use posix style for consistent internal paths (forward slashes)
    final context = p.posix;

    // Initialize repositories
    final projectRepo = ProjectRepository(
      fileSystem: fileSystem,
      projectRoot: Directory.current.path,
      pathContext: context,
    );

    final cacheRepo = await CacheRepository.create(
      fileSystem: fileSystem,
      cacheFilePath: context.join(outputDir, '.build_cache.json'),
      enableCache: enableCache && !forceRebuild,
    );

    if (forceRebuild) {
      logger.detail('Force rebuild enabled, skipping cache');
    } else if (enableCache) {
      logger.detail('Loaded build cache with ${cacheRepo.entryCount} entries');
    }

    // Create services
    final componentService = ComponentGenerationService(
      projectRepo: projectRepo,
      cacheRepo: cacheRepo,
      generatorRegistry: registry,
      logger: logger,
    );

    final screenService = ScreenGenerationService(
      projectRepo: projectRepo,
      cacheRepo: cacheRepo,
      generatorRegistry: registry,
      logger: logger,
    );

    final designSystemService = DesignSystemService(
      projectRepo: projectRepo,
      fileSystem: fileSystem,
      logger: logger,
    );

    // Ensure output directories exist
    await projectRepo.ensureOutputDirectories(outputDir);

    // Read package name for screen imports
    final packageName = await projectRepo.getPackageName();

    // Generate screens
    final screenResults = await screenService.generateAllScreens(
      screens: screens,
      outputDir: outputDir,
      packageName: packageName,
      enableCache: enableCache && !forceRebuild,
    );

    // Collect screen results
    for (final result in screenResults) {
      if (result.isValidationFailed) {
        errors.addAll(result.errors);
        warnings.addAll(result.warnings);
      } else if (result.isSuccess && !result.isSkipped) {
        if (result.filePath != null) {
          generatedFiles.add(result.filePath!);
        }
        warnings.addAll(result.warnings);
      }
    }

    // Generate components
    final componentResults = await componentService.generateAllComponents(
      components: components,
      tokens: tokens,
      outputDir: outputDir,
      enableCache: enableCache && !forceRebuild,
    );

    // Collect component results
    for (final result in componentResults) {
      if (result.isSuccess && !result.isSkipped) {
        generatedFiles.addAll(result.filesGenerated);
      } else if (!result.isSuccess) {
        errors.add(
            result.error ?? 'Unknown error generating ${result.componentName}');
      }
    }

    // Generate enum variants
    final enumResults = await componentService.generateEnumVariants(
      components: components,
      outputDir: outputDir,
    );

    // Collect enum results
    for (final result in enumResults) {
      if (result.isSuccess && result.filePath != null) {
        generatedFiles.add(result.filePath!);
      } else if (!result.isSuccess) {
        warnings.add(result.error ??
            'Failed to generate enum for ${result.componentName}');
      }
    }

    // Generate design system files
    if (designSystemDir != null) {
      try {
        // Copy design system files
        final copiedFiles = await designSystemService.copyDesignSystemFiles(
          sourceDir: designSystemDir,
          outputDir: outputDir,
        );
        generatedFiles.addAll(copiedFiles);

        // Generate design system code
        final designSystemFiles =
            await designSystemService.generateDesignSystemCode(
          components: components,
          outputDir: outputDir,
        );
        generatedFiles.addAll(designSystemFiles);

        // Handle tokens
        final tokenFiles = await designSystemService.handleTokens(
          components: components,
          designSystemDir: designSystemDir,
          outputDir: outputDir,
        );
        generatedFiles.addAll(tokenFiles);

        // Generate registries
        final registryFiles = await designSystemService.generateRegistries(
          metaDirectoryPath: metaDirectoryPath,
          outputDir: outputDir,
          designSystemDir: designSystemDir,
        );
        generatedFiles.addAll(registryFiles);
      } catch (e, stackTrace) {
        logger.err('Failed to generate design system files: $e');
        logger.detail('Stack trace: $stackTrace');
        errors.add('Failed to generate design system files: $e');
      }
    }

    // Generate barrel file
    await projectRepo.saveBarrelFile(
      outputDir: outputDir,
      files: generatedFiles,
    );
    generatedFiles.add('index.dart');

    // Save build cache
    if (enableCache && !forceRebuild) {
      await cacheRepo.save();
      logger.detail('Saved build cache with ${cacheRepo.entryCount} entries');
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
}
