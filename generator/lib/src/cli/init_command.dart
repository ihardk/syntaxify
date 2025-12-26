import 'dart:io';
import 'dart:isolate';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// Default syntaxify.yaml content for new projects.
const String _defaultConfigYaml = '''
# Syntaxify Configuration
# Customize paths for your project structure

# Source meta files (.meta.dart, .screen.dart)
meta: meta

# Output directory for generated code
output: lib/syntaxify

# Design system directory
design_system: lib/syntaxify/design_system

# Tokens directory (typically same as design_system)
tokens: lib/syntaxify/design_system

# Generation options
generate:
  screens: true
  components: true
''';

/// Init command - scaffolds a new Syntaxify project
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
      'Initialize a new Syntaxify project with default structure';

  @override
  Future<int> run() async {
    final force = argResults?['force'] == true;
    final progress = logger.progress('Initializing Syntaxify project');

    try {
      final cwd = Directory.current.path;
      var generatorRoot = await _findGeneratorRoot();

      if (generatorRoot == null) {
        progress.fail(
            'Could not locate generator templates. Are you running from the repo?');
        return ExitCode.config.code;
      }

      // Try reading package name from pubspec.yaml
      String? packageName;
      final pubspecFile = File(path.join(cwd, 'pubspec.yaml'));
      if (pubspecFile.existsSync()) {
        try {
          final pubspecContent = pubspecFile.readAsStringSync();
          final yaml = loadYaml(pubspecContent);
          packageName = yaml['name']?.toString();
        } catch (_) {
          // ignore
        }
      }

      if (packageName == null) {
        logger.warn('Could not determine package name from pubspec.yaml.');
        packageName = 'example'; // Fallback
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
        packageName: packageName,
      );

      // 2. Scaffold lib/syntaxify/design_system/
      await _copyDirectory(
        source: Directory(path.join(generatorRoot, 'design_system')),
        destination:
            Directory(path.join(cwd, 'lib', 'syntaxify', 'design_system')),
        force: force,
        logger: logger,
        packageName: packageName,
      );

      // 3. Create syntaxify.yaml config file
      final configFile = File(path.join(cwd, 'syntaxify.yaml'));
      if (!configFile.existsSync() || force) {
        configFile.writeAsStringSync(_defaultConfigYaml);
        logger.detail('Created syntaxify.yaml');
      }

      progress.complete('Project initialized successfully! 🚀');
      logger.info('');
      logger.info('Next steps:');
      logger.info('  1. Edit component definitions in meta/');
      logger
          .info('  2. Customize design system in lib/syntaxify/design_system/');
      logger.info('  3. (Optional) Edit syntaxify.yaml to customize paths');
      logger.info('  4. Run: syntaxify build');

      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Init failed: $e');
      return ExitCode.software.code;
    }
  }

  Future<String?> _findGeneratorRoot() async {
    try {
      // 1. Try to find package:syntaxify/ location
      final packageUri =
          Uri.parse('package:syntaxify/src/cli/init_command.dart');
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
    required String packageName,
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

        // Perform substitution for known text files
        if (entity.path.endsWith('.dart') ||
            entity.path.endsWith('.yaml') ||
            entity.path.endsWith('.md')) {
          try {
            final content = entity.readAsStringSync();
            final updatedContent =
                content.replaceAll('\$packageName', packageName);
            destFile.writeAsStringSync(updatedContent);
          } catch (e) {
            // Fallback to direct copy if read fails
            entity.copySync(destFile.path);
          }
        } else {
          entity.copySync(destFile.path);
        }
      }
    }
  }
}
