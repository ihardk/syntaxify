import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/cli/build_command.dart';
import 'package:forge/src/cli/clean_command.dart';

/// Forge CLI entry point
Future<void> main(List<String> arguments) async {
  final logger = Logger();

  final runner = CommandRunner<int>(
    'forge',
    'Forge UI code generator - produces production-ready Flutter widgets from design tokens.',
  )
    ..addCommand(BuildCommand(logger: logger))
    ..addCommand(CleanCommand(logger: logger));

  try {
    final exitCode = await runner.run(arguments) ?? ExitCode.success.code;
    exit(exitCode);
  } on UsageException catch (e) {
    logger.err(e.message);
    logger.info(e.usage);
    exit(ExitCode.usage.code);
  } catch (e, stackTrace) {
    logger.err('An unexpected error occurred: $e');
    logger.detail(stackTrace.toString());
    exit(ExitCode.software.code);
  }
}
