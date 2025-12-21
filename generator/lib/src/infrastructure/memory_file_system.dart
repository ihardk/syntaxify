import 'package:syntaxify/src/core/interfaces/file_system.dart';

/// In-memory file system for testing.
///
/// No actual file I/O - useful for unit tests.
class MemoryFileSystem implements FileSystem {
  final Map<String, String> _files = {};
  final Map<String, DateTime> _modificationTimes = {};
  final Set<String> _directories = {};

  @override
  Future<String> readFile(String path) async {
    if (!_files.containsKey(path)) {
      throw Exception('File not found: $path');
    }
    return _files[path]!;
  }

  @override
  Future<void> writeFile(String path, String content) async {
    _files[path] = content;
    _modificationTimes[path] = DateTime.now();
  }

  @override
  Future<bool> exists(String path) async {
    return _files.containsKey(path) || _directories.contains(path);
  }

  @override
  Future<void> createDirectory(String path) async {
    _directories.add(path);
  }

  @override
  Future<List<String>> listFiles(String directory, {String? pattern}) async {
    return _files.keys
        .where((p) => p.startsWith(directory))
        .where((p) => pattern == null || p.contains(pattern))
        .toList();
  }

  @override
  Future<void> copyFile(String source, String destination) async {
    if (!_files.containsKey(source)) {
      throw Exception('Source file not found: $source');
    }
    _files[destination] = _files[source]!;
    _modificationTimes[destination] = DateTime.now();
  }

  @override
  Future<void> deleteFile(String path) async {
    _files.remove(path);
    _modificationTimes.remove(path);
  }

  @override
  Future<FileStats> getStats(String path) async {
    if (!_files.containsKey(path)) {
      throw Exception('File not found: $path');
    }
    final modified = _modificationTimes[path] ?? DateTime.now();
    final size = _files[path]!.length;
    return FileStats(modified: modified, size: size);
  }

  /// Clear all files (for test cleanup)
  void clear() {
    _files.clear();
    _modificationTimes.clear();
    _directories.clear();
  }

  /// Get file contents (for test assertions)
  String? getFile(String path) => _files[path];

  /// Check if file was written (for test assertions)
  bool hasFile(String path) => _files.containsKey(path);
}
