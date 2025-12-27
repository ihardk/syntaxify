import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:syntaxify/src/core/interfaces/file_system.dart';

/// Repository for project-level file operations.
///
/// Centralizes all file I/O for project structure, configuration,
/// and meta file discovery.
class ProjectRepository {
  final FileSystem _fileSystem;
  final String _projectRoot;
  final p.Context _pathContext;

  ProjectRepository({
    required FileSystem fileSystem,
    required String projectRoot,
    p.Context? pathContext,
  })  : _fileSystem = fileSystem,
        _projectRoot = projectRoot,
        _pathContext = pathContext ?? p.posix;

  /// Get the underlying file system (for use by services)
  FileSystem get fileSystem => _fileSystem;

  /// Read and parse package name from pubspec.yaml
  Future<String?> getPackageName() async {
    try {
      final pubspecPath = _pathContext.join(_projectRoot, 'pubspec.yaml');
      if (!await _fileSystem.exists(pubspecPath)) {
        return null;
      }

      final content = await _fileSystem.readFile(pubspecPath);
      final nameMatch =
          RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(content);

      return nameMatch?.group(1)?.trim();
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to read package name from pubspec.yaml: $e',
      );
    }
  }

  /// Get all meta files in the meta directory
  Future<List<String>> getMetaFiles(String metaDirectoryPath) async {
    try {
      final metaDir = Directory(metaDirectoryPath);
      if (!await metaDir.exists()) {
        return [];
      }

      final files = <String>[];
      await for (final entity in metaDir.list()) {
        if (entity is File && entity.path.endsWith('.meta.dart')) {
          files.add(entity.path);
        }
      }

      return files;
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to list meta files in $metaDirectoryPath: $e',
      );
    }
  }

  /// Get all screen files in the meta directory
  Future<List<String>> getScreenFiles(String metaDirectoryPath) async {
    try {
      final metaDir = Directory(metaDirectoryPath);
      if (!await metaDir.exists()) {
        return [];
      }

      final files = <String>[];
      await for (final entity in metaDir.list()) {
        if (entity is File && entity.path.endsWith('.screen.dart')) {
          files.add(entity.path);
        }
      }

      return files;
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to list screen files in $metaDirectoryPath: $e',
      );
    }
  }

  /// Check if a screen file already exists (to avoid overwriting user edits)
  Future<bool> screenExists({
    required String screenName,
    required String outputDir,
  }) async {
    final screenPath = _pathContext.join(
      outputDir,
      'screens',
      '${screenName}_screen.dart',
    );
    return await _fileSystem.exists(screenPath);
  }

  /// Write generated component file
  Future<void> saveGeneratedComponent({
    required String fileName,
    required String code,
    required String outputDir,
  }) async {
    try {
      final dirPath = _pathContext.join(outputDir, 'generated', 'components');
      await _fileSystem.createDirectory(dirPath);

      final filePath = _pathContext.join(dirPath, fileName);
      await _fileSystem.writeFile(filePath, code);
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to save component $fileName: $e',
      );
    }
  }

  /// Write generated screen file
  Future<String?> saveGeneratedScreen({
    required String screenName,
    required String code,
    required String outputDir,
  }) async {
    try {
      final dirPath = _pathContext.join(outputDir, 'screens');
      await _fileSystem.createDirectory(dirPath);

      final fileName = '${screenName}_screen.dart';
      final filePath = _pathContext.join(dirPath, fileName);

      // Don't overwrite existing screen files (they're user-editable)
      if (await _fileSystem.exists(filePath)) {
        return null;
      }

      await _fileSystem.writeFile(filePath, code);
      return 'screens/$fileName';
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to save screen $screenName: $e',
      );
    }
  }

  /// Write generated enum variant file
  Future<void> saveEnumVariant({
    required String fileName,
    required String code,
    required String outputDir,
  }) async {
    try {
      final dirPath = _pathContext.join(outputDir, 'generated', 'variants');
      await _fileSystem.createDirectory(dirPath);

      final filePath = _pathContext.join(dirPath, fileName);
      await _fileSystem.writeFile(filePath, code);
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to save enum variant $fileName: $e',
      );
    }
  }

  /// Ensure output directories exist
  Future<void> ensureOutputDirectories(String outputDir) async {
    try {
      await _fileSystem.createDirectory(
        _pathContext.join(outputDir, 'generated', 'components'),
      );
      await _fileSystem.createDirectory(
        _pathContext.join(outputDir, 'generated', 'variants'),
      );
      await _fileSystem.createDirectory(
        _pathContext.join(outputDir, 'screens'),
      );
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to create output directories: $e',
      );
    }
  }

  /// Write barrel export file (index.dart)
  Future<void> saveBarrelFile({
    required String outputDir,
    required List<String> files,
  }) async {
    try {
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
// GENERATED BY SYNTAXIFY v0.2.0-beta
// DO NOT MODIFY - Regenerated on build
// Barrel file exporting all generated code
// ============================================

$exports
''';

      final filePath = _pathContext.join(outputDir, 'index.dart');
      await _fileSystem.writeFile(filePath, content);
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to save barrel file: $e',
      );
    }
  }

  /// Check if file or directory exists
  Future<bool> exists(String path) async {
    return await _fileSystem.exists(path);
  }

  /// Read file contents
  Future<String> readFile(String path) async {
    try {
      return await _fileSystem.readFile(path);
    } catch (e) {
      throw ProjectRepositoryException('Failed to read file $path: $e');
    }
  }

  /// Write file contents
  Future<void> writeFile(String path, String content) async {
    try {
      await _fileSystem.writeFile(path, content);
    } catch (e) {
      throw ProjectRepositoryException('Failed to write file $path: $e');
    }
  }

  /// Copy file from source to destination
  Future<void> copyFile(String source, String destination) async {
    try {
      await _fileSystem.copyFile(source, destination);
    } catch (e) {
      throw ProjectRepositoryException(
        'Failed to copy file from $source to $destination: $e',
      );
    }
  }

  /// Create directory
  Future<void> createDirectory(String path) async {
    try {
      await _fileSystem.createDirectory(path);
    } catch (e) {
      throw ProjectRepositoryException('Failed to create directory $path: $e');
    }
  }
}

/// Exception thrown by ProjectRepository operations
class ProjectRepositoryException implements Exception {
  final String message;

  ProjectRepositoryException(this.message);

  @override
  String toString() => 'ProjectRepositoryException: $message';
}
