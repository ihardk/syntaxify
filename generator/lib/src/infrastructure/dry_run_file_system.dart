import 'package:syntaxify/src/core/interfaces/file_system.dart';

/// A file system decorator that logs file operations without writing.
///
/// Used for `--dry-run` mode to preview what files would be generated.
class DryRunFileSystem implements FileSystem {
  DryRunFileSystem({
    required this.delegate,
  });

  /// The underlying file system (used for reads only).
  final FileSystem delegate;

  /// List of planned operations.
  final List<DryRunOperation> _operations = [];

  /// Get all planned operations.
  List<DryRunOperation> get operations => List.unmodifiable(_operations);

  @override
  Future<void> writeFile(String path, String content) async {
    _operations.add(DryRunOperation(
      type: DryRunOperationType.write,
      path: path,
      contentLength: content.length,
    ));
    // Don't actually write
  }

  @override
  Future<void> createDirectory(String path) async {
    _operations.add(DryRunOperation(
      type: DryRunOperationType.createDir,
      path: path,
    ));
    // Don't actually create
  }

  @override
  Future<String> readFile(String path) => delegate.readFile(path);

  @override
  Future<bool> exists(String path) => delegate.exists(path);

  @override
  Future<List<String>> listFiles(String directory, {String? pattern}) =>
      delegate.listFiles(directory, pattern: pattern);

  @override
  Future<void> copyFile(String source, String destination) async {
    _operations.add(DryRunOperation(
      type: DryRunOperationType.copy,
      path: '$source -> $destination',
    ));
  }

  @override
  Future<void> deleteFile(String path) async {
    _operations.add(DryRunOperation(
      type: DryRunOperationType.delete,
      path: path,
    ));
  }

  @override
  Future<FileStats> getStats(String path) => delegate.getStats(path);

  /// Print a summary of what would be done.
  String getSummary() {
    if (_operations.isEmpty) {
      return 'No changes would be made.';
    }

    final buffer = StringBuffer();
    buffer.writeln('Dry run - the following changes would be made:\n');

    final writes =
        _operations.where((o) => o.type == DryRunOperationType.write);
    final dirs =
        _operations.where((o) => o.type == DryRunOperationType.createDir);
    final deletes =
        _operations.where((o) => o.type == DryRunOperationType.delete);
    final copies = _operations.where((o) => o.type == DryRunOperationType.copy);

    if (dirs.isNotEmpty) {
      buffer.writeln('📁 Directories to create:');
      for (final op in dirs) {
        buffer.writeln('   + ${op.path}');
      }
      buffer.writeln();
    }

    if (writes.isNotEmpty) {
      buffer.writeln('📝 Files to write:');
      for (final op in writes) {
        final size =
            op.contentLength != null ? ' (${op.contentLength} bytes)' : '';
        buffer.writeln('   + ${op.path}$size');
      }
      buffer.writeln();
    }

    if (copies.isNotEmpty) {
      buffer.writeln('📋 Files to copy:');
      for (final op in copies) {
        buffer.writeln('   ${op.path}');
      }
      buffer.writeln();
    }

    if (deletes.isNotEmpty) {
      buffer.writeln('🗑️ Files to delete:');
      for (final op in deletes) {
        buffer.writeln('   - ${op.path}');
      }
      buffer.writeln();
    }

    buffer.writeln('Total: ${writes.length} files, ${dirs.length} directories');
    return buffer.toString();
  }
}

/// Types of operations tracked in dry run mode.
enum DryRunOperationType { write, createDir, delete, copy }

/// A single dry run operation.
class DryRunOperation {
  const DryRunOperation({
    required this.type,
    required this.path,
    this.contentLength,
  });

  final DryRunOperationType type;
  final String path;
  final int? contentLength;
}
