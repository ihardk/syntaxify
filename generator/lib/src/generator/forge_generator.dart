import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/core/interfaces/file_system.dart';
import 'package:forge/src/generators/generator_registry.dart';
import 'package:forge/src/infrastructure/local_file_system.dart';
import 'package:forge/src/models/build_result.dart';
import 'package:forge/src/parser/meta_parser.dart';
import 'package:forge/src/parser/token_parser.dart';
import 'package:forge/src/use_cases/build_all.dart';

/// Main Forge generator - orchestrates the build process.
///
/// Uses dependency injection for testability:
/// - FileSystem abstraction (LocalFileSystem or MemoryFileSystem)
/// - GeneratorRegistry for component generators
///
/// Following Clean Architecture:
/// - This is the PRESENTATION layer (CLI integration)
/// - Delegates to USE CASES (BuildAllUseCase)
class ForgeGenerator {
  ForgeGenerator({
    required this.metaDirectory,
    required this.tokensDirectory,
    required this.outputDirectory,
    required this.designSystemDirectory,
    required this.logger,
    FileSystem? fileSystem,
    GeneratorRegistry? registry,
  })  : fileSystem = fileSystem ?? LocalFileSystem(),
        registry = registry ?? GeneratorRegistry();

  final String metaDirectory;
  final String tokensDirectory;
  final String outputDirectory;
  final String designSystemDirectory;
  final Logger logger;
  final FileSystem fileSystem;
  final GeneratorRegistry registry;

  late final MetaParser _metaParser = MetaParser(logger: logger);
  late final TokenParser _tokenParser = TokenParser(logger: logger);

  /// Build components from meta definitions.
  Future<BuildResult> build({
    String? component,
    String? theme,
  }) async {
    final stopwatch = Stopwatch()..start();
    final errors = <String>[];

    try {
      // Parse meta files
      logger.info('Scanning meta directory: $metaDirectory');
      final metaDir = Directory(metaDirectory);
      final parseResult = await _metaParser.parseDirectory(metaDir);

      if (parseResult.errors.isNotEmpty) {
        errors.addAll(parseResult.errors);
      }

      var components = parseResult.components;
      logger.info('Found ${components.length} component(s)');

      // Filter by component name if specified
      if (component != null) {
        components = components
            .where((c) => c.name == component || c.className == component)
            .toList();

        if (components.isEmpty) {
          return BuildResult(
            filesGenerated: 0,
            generatedFiles: [],
            duration: stopwatch.elapsed,
            errors: ['Component not found: $component'],
          );
        }
      }

      // Parse token files
      logger.info('Scanning tokens directory: $tokensDirectory');
      final tokensDir = Directory(tokensDirectory);
      final tokens = await _tokenParser.parseDirectory(tokensDir);
      logger.info('Found ${tokens.length} token definition(s)');

      // Use BuildAllUseCase for the actual work
      final buildUseCase = BuildAllUseCase(
        fileSystem: fileSystem,
        registry: registry,
        logger: logger,
      );

      return buildUseCase.execute(
        components: components,
        screens: parseResult.screens,
        tokens: tokens,
        outputDir: outputDirectory,
        designSystemDir: designSystemDirectory,
        metaDirectoryPath: metaDirectory,
      );
    } catch (e) {
      stopwatch.stop();
      errors.add('Build failed: $e');

      return BuildResult(
        filesGenerated: 0,
        generatedFiles: [],
        duration: stopwatch.elapsed,
        errors: errors,
      );
    }
  }
}
