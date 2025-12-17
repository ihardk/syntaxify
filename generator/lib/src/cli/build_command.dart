import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/generator/forge_generator.dart';

/// Build command - generates Flutter widgets from meta definitions
class BuildCommand extends Command<int> {
  BuildCommand({required this.logger}) {
    argParser
      ..addOption(
        'component',
        abbr: 'c',
        help: 'Generate a specific component only',
      )
      ..addOption(
        'theme',
        abbr: 't',
        help: 'Generate for a specific theme only',
      )
      ..addOption(
        'meta',
        abbr: 'm',
        help: 'Directory containing meta files',
        defaultsTo: 'meta',
      )
      ..addOption(
        'tokens',
        help: 'Directory containing token files',
        defaultsTo: 'design_system',
      )
      ..addOption(
        'design-system',
        help: 'Directory containing design system templates',
        defaultsTo: 'design_system',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output directory for generated files',
        defaultsTo: 'lib/forge',
      );
  }

  final Logger logger;

  @override
  String get name => 'build';

  @override
  String get description => 'Generate Flutter widgets from meta definitions';

  @override
  Future<int> run() async {
    final component = argResults?['component'] as String?;
    final theme = argResults?['theme'] as String?;
    final metaDir = argResults?['meta'] as String? ?? 'meta';
    final tokensDir = argResults?['tokens'] as String? ?? 'design_system';
    final designSystemDir =
        argResults?['design-system'] as String? ?? 'design_system';
    final outputDir = argResults?['output'] as String? ?? 'lib/generated';

    logger.info('');
    logger.info('🔨 Forge Build');
    logger.info('   Meta:          $metaDir/');
    logger.info('   Tokens:        $tokensDir/');
    logger.info('   Design System: $designSystemDir/');
    logger.info('   Output:        $outputDir/');
    logger.info('');

    final progress = logger.progress('Building components');

    try {
      final generator = ForgeGenerator(
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
}
