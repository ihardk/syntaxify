import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// Clean command - removes generated files
class CleanCommand extends Command<int> {
  CleanCommand({required this.logger}) {
    argParser.addOption(
      'output',
      abbr: 'o',
      help: 'Output directory to clean',
      defaultsTo: 'lib/generated',
    );
  }

  final Logger logger;

  @override
  String get name => 'clean';

  @override
  String get description => 'Remove all generated files';

  @override
  Future<int> run() async {
    final outputDir = argResults?['output'] as String? ?? 'lib/generated';
    final progress = logger.progress('Cleaning generated files');

    try {
      final directory = Directory(outputDir);

      if (await directory.exists()) {
        final files = await directory
            .list(recursive: true)
            .where((entity) => entity is File && entity.path.endsWith('.dart'))
            .toList();

        var count = 0;
        for (final file in files) {
          await file.delete();
          count++;
        }

        progress.complete('Removed $count generated files');
      } else {
        progress.complete('No generated files to clean');
      }

      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Clean failed: $e');
      return ExitCode.software.code;
    }
  }
}
