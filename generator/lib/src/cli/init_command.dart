import 'dart:io';
import 'dart:isolate';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

/// Init command - scaffolds a new Forge project
class InitCommand extends Command<int> {
  InitCommand({required this.logger}) {
    argParser.addFlag(
      'force',
      abbr: 'f',
      help: 'Overwrite existing files',
      negatable: false,
    );
  }

  final Logger logger;

  @override
  String get name => 'init';

  @override
  List<String> get aliases => ['setup'];

  @override
  String get description =>
      'Initialize a new Forge project with default structure';

  @override
  Future<int> run() async {
    final force = argResults?['force'] == true;
    final progress = logger.progress('Initializing Forge project');

    try {
      final cwd = Directory.current.path;
      var generatorRoot = await _findGeneratorRoot();

      if (generatorRoot == null) {
        progress.fail(
            'Could not locate generator templates. Are you running from the repo?');
        return ExitCode.config.code;
      }

      // 1. Scaffold meta/
      var metaSource = Directory(path.join(generatorRoot, 'meta'));
      if (!metaSource.existsSync()) {
        // Try probing 'generator/meta' (if root was repo root)
        final altSource =
            Directory(path.join(generatorRoot, 'generator', 'meta'));
        if (altSource.existsSync()) {
          generatorRoot = path.join(generatorRoot, 'generator');
          metaSource = altSource;
        }
      }

      await _copyDirectory(
        source: metaSource,
        destination: Directory(path.join(cwd, 'meta')),
        force: force,
        logger: logger,
      );

      // 2. Scaffold design_system/
      // Re-use corrected generatorRoot
      await _copyDirectory(
        source: Directory(path.join(generatorRoot, 'design_system')),
        destination: Directory(path.join(cwd, 'design_system')),
        force: force,
        logger: logger,
      );

      progress.complete('Project initialized successfully! 🚀');
      logger.info('');
      logger.info('Next steps:');
      logger.info('  1. Edit definitions in meta/');
      logger.info('  2. Customize styles in design_system/');
      logger.info('  3. Run: dart run generator/bin/forge.dart build');

      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Init failed: $e');
      return ExitCode.software.code;
    }
  }

  Future<String?> _findGeneratorRoot() async {
    try {
      // 1. Try to find package:forge/ location
      final packageUri = Uri.parse('package:forge/src/cli/init_command.dart');
      final resolvedUri = await Isolate.resolvePackageUri(packageUri);

      if (resolvedUri != null) {
        final file = File.fromUri(resolvedUri);

        // Traverse up to find pubspec.yaml
        var directory = file.parent;
        while (directory.path != directory.parent.path) {
          final pubspecPath = path.join(directory.path, 'pubspec.yaml');
          if (await File(pubspecPath).exists()) {
            return directory.path;
          }
          directory = directory.parent;
        }
      }
    } catch (_) {
      // Ignore errors and fall through to fallbacks
    }

    // 2. Dev environment fallback (Repo Root)
    if (Directory('generator').existsSync()) {
      return 'generator';
    }

    // 3. Dev environment fallback (Inside generator)
    if (File('pubspec.yaml').existsSync() && Directory('bin').existsSync()) {
      return '.';
    }

    return null;
  }

  Future<void> _copyDirectory({
    required Directory source,
    required Directory destination,
    required bool force,
    required Logger logger,
  }) async {
    if (!source.existsSync()) {
      logger.warn('Source directory missing: ${source.path}');
      return;
    }

    if (!destination.existsSync()) {
      destination.createSync(recursive: true);
    }

    await for (final entity in source.list(recursive: true)) {
      if (entity is File) {
        final relativePath = path.relative(entity.path, from: source.path);
        final destStr = path.join(destination.path, relativePath);
        final destFile = File(destStr);

        if (destFile.existsSync() && !force) {
          // Skip
          continue;
        }

        if (!destFile.parent.existsSync()) {
          destFile.parent.createSync(recursive: true);
        }

        entity.copySync(destFile.path);
      }
    }
  }
}
