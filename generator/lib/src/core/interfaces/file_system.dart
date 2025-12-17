/// Abstract interface for file system operations.
///
/// Following Dependency Inversion principle:
/// - Production code uses LocalFileSystem
/// - Tests use MemoryFileSystem (mockable)
abstract class FileSystem {
  /// Read file contents as string.
  Future<String> readFile(String path);

  /// Write string contents to file.
  Future<void> writeFile(String path, String content);

  /// Check if file or directory exists.
  Future<bool> exists(String path);

  /// Create directory (recursively if needed).
  Future<void> createDirectory(String path);

  /// List files in directory matching pattern.
  Future<List<String>> listFiles(String directory, {String? pattern});

  /// Copy file from source to destination.
  Future<void> copyFile(String source, String destination);

  /// Delete file.
  Future<void> deleteFile(String path);
}
