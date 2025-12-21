import 'dart:io';
import 'dart:async';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:watcher/watcher.dart';

import 'package:syntaxify/src/config/package_config.dart' as config;
import 'package:syntaxify/src/generator/syntax_generator.dart';
import 'init_command.dart';

/// Build command - generates Flutter widgets from meta definitions
class BuildCommand extends Command<int> {
  BuildCommand({required this.logger}) {
    argParser
      ..addFlag(
        'watch',
        abbr: 'w',
        help: 'Watch for file changes and rebuild automatically',
        negatable: false,
        defaultsTo: false,
      )
      ..addOption(
        'component',
        abbr: 'c',
        help: 'Build a specific component only (e.g., AppButton)',
      )
      ..addOption(
        'theme',
        abbr: 't',
        help: 'Build for a specific theme only (e.g., material)',
      )
      ..addOption(
        'meta',
        abbr: 'm',
        help: 'Path to meta directory containing component definitions',
        defaultsTo: 'meta',
      )
      ..addOption(
        'tokens',
        help:
            'Path to tokens directory (auto-detects lib/syntaxify/design_system)',
      )
      ..addOption(
        'design-system',
        help:
            'Path to design system directory (auto-detects lib/syntaxify/design_system)',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output directory for generated files',
        defaultsTo: config.defaultOutputDir,
      );
  }

  final Logger logger;

  @override
  String get name => 'build';

  @override
  String get description => '''
Generate Flutter widgets from meta definitions.

Usage:
  syntaxify build                    # Auto-detect project structure
  syntaxify build -m meta -o lib     # Custom paths
  syntaxify build -c AppButton       # Build specific component

Options:
  -m, --meta              Meta directory (default: "meta")
  -o, --output            Output directory (default: "lib/syntaxify")
  --design-system         Design system directory (auto-detected)
  --tokens                Tokens directory (auto-detected)
  -c, --component         Build specific component only
  -t, --theme             Build for specific theme only

Examples:
  syntaxify build                                    # Build everything
  syntaxify build --component=AppButton              # Build one component
  syntaxify build --meta=specs --output=lib/gen     # Custom paths
''';

  @override
  Future<int> run() async {
    final watch = argResults?['watch'] as bool? ?? false;
    final component = argResults?['component'] as String?;
    final theme = argResults?['theme'] as String?;
    final metaDir = argResults?['meta'] as String? ?? 'meta';

    // Smart defaults - prefer design_system in output dir if it exists
    // Note: Check from current working directory (where user runs command)
    final cwd = Directory.current.path;
    final designSystemPath = path.join(cwd, config.defaultDesignSystemDir);
    final designSystemExists = Directory(designSystemPath).existsSync();

    final tokensDir = argResults?['tokens'] as String? ??
        (designSystemExists ? config.defaultDesignSystemDir : 'design_system');
    final designSystemDir = argResults?['design-system'] as String? ??
        (designSystemExists ? config.defaultDesignSystemDir : 'design_system');
    final outputDir =
        argResults?['output'] as String? ?? config.defaultOutputDir;

    // Check availability
    final metaExists = Directory(metaDir).existsSync();
    final dsExists = Directory(designSystemDir).existsSync();

    if (!metaExists || !dsExists) {
      if (!metaExists) logger.warn('Directory not found: $metaDir');
      if (!dsExists) logger.warn('Directory not found: $designSystemDir');

      logger.info('Project seems uninitialized.');
      if (logger.confirm('Would you like to run "syntaxify init" now?')) {
        final initCmd = InitCommand(logger: logger);
        final result = await initCmd.run();
        if (result != ExitCode.success.code) {
          return result;
        }
        // Proceed to build...
      } else {
        logger.err('Build aborted. Run "syntaxify init" first.');
        return ExitCode.config.code;
      }
    }

    if (watch) {
      return await _runWatch(
        metaDir: metaDir,
        tokensDir: tokensDir,
        designSystemDir: designSystemDir,
        outputDir: outputDir,
        component: component,
        theme: theme,
      );
    } else {
      return await _runBuild(
        metaDir: metaDir,
        tokensDir: tokensDir,
        designSystemDir: designSystemDir,
        outputDir: outputDir,
        component: component,
        theme: theme,
      );
    }
  }

  /// Run a single build
  Future<int> _runBuild({
    required String metaDir,
    required String tokensDir,
    required String designSystemDir,
    required String outputDir,
    String? component,
    String? theme,
  }) async {
    logger.info('');
    logger.info('🔨 Syntaxify Build');
    logger.info('   Meta:          $metaDir/');
    logger.info('   Tokens:        $tokensDir/');
    logger.info('   Design System: $designSystemDir/');
    logger.info('   Output:        $outputDir/');
    logger.info('');

    final progress = logger.progress('Building components');

    try {
      final generator = SyntaxGenerator(
        metaDirectory: metaDir,
        tokensDirectory: tokensDir,
        designSystemDirectory: designSystemDir,
        outputDirectory: outputDir,
        logger: logger,
      );

      final result = await generator.build(
        component: component,
        theme: theme,
      );

      if (result.hasErrors) {
        progress.fail('Build failed with ${result.errors.length} error(s)');
        for (final error in result.errors) {
          logger.err('  ✗ $error');
        }
        return 1;
      }

      progress.complete(
        'Generated ${result.filesGenerated} files in ${result.duration.inMilliseconds}ms',
      );

      if (result.hasWarnings) {
        for (final warning in result.warnings) {
          logger.warn('  ⚠ $warning');
        }
      }

      logger.info('');
      logger.info('Generated files:');
      for (final file in result.generatedFiles) {
        logger.success('  ✓ $file');
      }

      return 0;
    } catch (e) {
      progress.fail('Build failed: $e');
      return 1;
    }
  }

  /// Run in watch mode - continuously watch for file changes
  Future<int> _runWatch({
    required String metaDir,
    required String tokensDir,
    required String designSystemDir,
    required String outputDir,
    String? component,
    String? theme,
  }) async {
    logger.info('');
    logger.info('👀 Syntaxify Watch Mode');
    logger.info('   Meta:          $metaDir/');
    logger.info('   Output:        $outputDir/');
    logger.info('');
    logger.info('Press Ctrl+C to stop');
    logger.info('');

    // Initial build
    await _runBuild(
      metaDir: metaDir,
      tokensDir: tokensDir,
      designSystemDir: designSystemDir,
      outputDir: outputDir,
      component: component,
      theme: theme,
    );

    final timestamp = DateTime.now().toString().substring(11, 19);
    logger.info('');
    logger.info('[$timestamp] Watching for changes...');

    // Watch for changes with debouncing
    final watcher = DirectoryWatcher(metaDir);
    Timer? debounceTimer;

    await for (final event in watcher.events) {
      if (event.type == ChangeType.MODIFY || event.type == ChangeType.ADD) {
        final fileName = event.path.split(path.separator).last;

        if (fileName.endsWith('.meta.dart') ||
            fileName.endsWith('.screen.dart')) {
          // Debounce: wait 300ms for more changes before rebuilding
          debounceTimer?.cancel();
          debounceTimer = Timer(Duration(milliseconds: 300), () async {
            final ts = DateTime.now().toString().substring(11, 19);
            logger.info('');
            logger.info('📝 [$ts] ${event.path} changed');

            try {
              await _runBuild(
                metaDir: metaDir,
                tokensDir: tokensDir,
                designSystemDir: designSystemDir,
                outputDir: outputDir,
                component: component,
                theme: theme,
              );
            } catch (e) {
              logger.err('Build failed: $e');
            }

            final ts2 = DateTime.now().toString().substring(11, 19);
            logger.info('[$ts2] Watching for changes...');
          });
        }
      }
    }

    return 0;
  }
}
