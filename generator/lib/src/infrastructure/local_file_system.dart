import 'dart:io' as io;

import 'package:path/path.dart' as path;

import 'package:syntaxify/src/core/interfaces/file_system.dart';

/// Local file system implementation.
///
/// Uses dart:io for actual file operations.
/// In tests, use MemoryFileSystem instead.
class LocalFileSystem implements FileSystem {
  @override
  Future<String> readFile(String filePath) async {
    final file = io.File(filePath);
    return file.readAsString();
  }

  @override
  Future<void> writeFile(String filePath, String content) async {
    final file = io.File(filePath);
    await file.writeAsString(content);
  }

  @override
  Future<bool> exists(String filePath) async {
    final file = io.File(filePath);
    final dir = io.Directory(filePath);
    return await file.exists() || await dir.exists();
  }

  @override
  Future<void> createDirectory(String dirPath) async {
    final dir = io.Directory(dirPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  @override
  Future<List<String>> listFiles(String directory, {String? pattern}) async {
    final dir = io.Directory(directory);
    if (!await dir.exists()) {
      return [];
    }

    final files = <String>[];
    await for (final entity in dir.list()) {
      if (entity is io.File) {
        final fileName = path.basename(entity.path);
        if (pattern == null || fileName.contains(pattern)) {
          files.add(entity.path);
        }
      }
    }
    return files;
  }

  @override
  Future<void> copyFile(String source, String destination) async {
    final srcFile = io.File(source);
    await srcFile.copy(destination);
  }

  @override
  Future<void> deleteFile(String filePath) async {
    final file = io.File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
