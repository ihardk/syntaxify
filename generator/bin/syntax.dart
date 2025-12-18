import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:syntax/src/cli/build_command.dart';
import 'package:syntax/src/cli/clean_command.dart';
import 'package:syntax/src/cli/init_command.dart';

/// Syntax CLI entry point
Future<void> main(List<String> arguments) async {
  final logger = Logger();

  final runner = CommandRunner<int>(
    'syntax',
    'Syntax UI code generator - produces production-ready Flutter widgets from design tokens.',
  )
    ..addCommand(InitCommand(logger: logger))
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
