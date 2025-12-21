import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;
import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/models/build_cache.dart';

/// Manages the build cache for incremental builds.
///
/// Tracks file modification times and content hashes to determine
/// which files need to be regenerated during builds.
class BuildCacheManager {
  BuildCacheManager({
    required this.fileSystem,
    required this.cacheFilePath,
  });

  final FileSystem fileSystem;
  final String cacheFilePath;

  static const String defaultCacheFileName = '.syntaxify_cache.json';

  /// Load the cache from disk.
  ///
  /// Returns an empty cache if the file doesn't exist or is invalid.
  Future<BuildCache> loadCache() async {
    try {
      if (!await fileSystem.exists(cacheFilePath)) {
        return BuildCache.empty();
      }

      final content = await fileSystem.readFile(cacheFilePath);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return BuildCache.fromJson(json);
    } catch (e) {
      // If cache is corrupted or invalid, start fresh
      return BuildCache.empty();
    }
  }

  /// Save the cache to disk.
  Future<void> saveCache(BuildCache cache) async {
    try {
      final json = jsonEncode(cache.toJson());
      await fileSystem.writeFile(cacheFilePath, json);
    } catch (e) {
      // Ignore save errors - worst case we rebuild next time
      // Could add logging here if needed
    }
  }

  /// Compute SHA-256 hash of file content.
  Future<String> computeHash(String filePath) async {
    try {
      final content = await fileSystem.readFile(filePath);
      final bytes = utf8.encode(content);
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      // If we can't read the file, return empty hash
      return '';
    }
  }

  /// Get file modification time in milliseconds since epoch.
  Future<int> getModificationTime(String filePath) async {
    try {
      final stats = await fileSystem.getStats(filePath);
      return stats.modified.millisecondsSinceEpoch;
    } catch (e) {
      // If we can't get stats, return 0
      return 0;
    }
  }

  /// Check if a file should be regenerated.
  ///
  /// Returns true if:
  /// - File is not in cache
  /// - File modification time changed
  /// - File content hash changed
  Future<bool> shouldRegenerate(
    String filePath,
    BuildCache cache,
  ) async {
    // Check if file exists in cache
    final cacheEntry = cache.entries[filePath];
    if (cacheEntry == null) {
      return true; // Not in cache, must regenerate
    }

    // Check if file still exists
    if (!await fileSystem.exists(filePath)) {
      return true; // File deleted, need to regenerate (or remove from cache)
    }

    // Check modification time
    final currentModTime = await getModificationTime(filePath);
    if (currentModTime != cacheEntry.lastModified) {
      // Modification time changed, check content hash
      final currentHash = await computeHash(filePath);
      if (currentHash != cacheEntry.contentHash) {
        return true; // Content actually changed
      }
      // Modification time changed but content is the same
      // Could update cache entry here, but for now we'll regenerate
      return true;
    }

    // File hasn't changed
    return false;
  }

  /// Update cache entry for a file.
  ///
  /// Should be called after successfully generating output for a file.
  Future<CacheEntry> createCacheEntry(
    String filePath,
    List<String> outputs,
  ) async {
    final modTime = await getModificationTime(filePath);
    final hash = await computeHash(filePath);

    return CacheEntry(
      filePath: filePath,
      lastModified: modTime,
      contentHash: hash,
      outputs: outputs,
    );
  }

  /// Update the cache with new entries.
  Future<BuildCache> updateCache(
    BuildCache currentCache,
    Map<String, CacheEntry> newEntries,
  ) async {
    final updatedEntries = Map<String, CacheEntry>.from(currentCache.entries);
    updatedEntries.addAll(newEntries);

    return BuildCache(
      version: currentCache.version,
      lastBuildTime: DateTime.now().millisecondsSinceEpoch,
      entries: updatedEntries,
    );
  }

  /// Remove cache entries for files that no longer exist.
  Future<BuildCache> cleanupCache(BuildCache cache) async {
    final cleanedEntries = <String, CacheEntry>{};

    for (final entry in cache.entries.entries) {
      if (await fileSystem.exists(entry.key)) {
        cleanedEntries[entry.key] = entry.value;
      }
    }

    return BuildCache(
      version: cache.version,
      lastBuildTime: cache.lastBuildTime,
      entries: cleanedEntries,
    );
  }

  /// Check if any of the output files are missing.
  ///
  /// If generated outputs are deleted, we need to regenerate.
  Future<bool> outputsMissing(CacheEntry entry) async {
    for (final output in entry.outputs) {
      if (!await fileSystem.exists(output)) {
        return true;
      }
    }
    return false;
  }

  /// Get list of files that need regeneration.
  Future<List<String>> getFilesToRegenerate(
    List<String> allFiles,
    BuildCache cache,
  ) async {
    final filesToRegenerate = <String>[];

    for (final filePath in allFiles) {
      final needsRegen = await shouldRegenerate(filePath, cache);
      if (needsRegen) {
        filesToRegenerate.add(filePath);
        continue;
      }

      // Also check if outputs are missing
      final cacheEntry = cache.entries[filePath];
      if (cacheEntry != null && await outputsMissing(cacheEntry)) {
        filesToRegenerate.add(filePath);
      }
    }

    return filesToRegenerate;
  }

  /// Clear the cache completely.
  Future<void> clearCache() async {
    try {
      await fileSystem.deleteFile(cacheFilePath);
    } catch (e) {
      // Ignore errors - file might not exist
    }
  }
}
