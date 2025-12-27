import 'package:syntaxify/src/infrastructure/build_cache_manager.dart';
import 'package:syntaxify/src/models/build_cache.dart';
import 'package:syntaxify/src/core/interfaces/file_system.dart';

/// Repository for build cache operations.
///
/// Provides a simplified interface for cache management,
/// abstracting BuildCacheManager complexity.
class CacheRepository {
  final BuildCacheManager _cacheManager;
  BuildCache _cache;

  CacheRepository._(this._cacheManager, this._cache);

  /// Create a cache repository instance
  ///
  /// [fileSystem] The file system to use for cache storage
  /// [cacheFilePath] Path to the cache file
  /// [enableCache] Whether caching is enabled
  static Future<CacheRepository> create({
    required FileSystem fileSystem,
    required String cacheFilePath,
    required bool enableCache,
  }) async {
    final cacheManager = BuildCacheManager(
      fileSystem: fileSystem,
      cacheFilePath: cacheFilePath,
    );

    final cache =
        enableCache ? await cacheManager.loadCache() : BuildCache.empty();

    return CacheRepository._(cacheManager, cache);
  }

  /// Check if a component has changed since last build
  ///
  /// Returns true if:
  /// - Cache is empty
  /// - Component not in cache
  /// - Component's hash doesn't match
  bool hasComponentChanged(String componentName, String newHash) {
    final cached = _cache.entries[componentName];
    if (cached == null) return true;
    return cached.contentHash != newHash;
  }

  /// Check if a screen has changed since last build
  bool hasScreenChanged(String screenName, String newHash) {
    final cached = _cache.entries[screenName];
    if (cached == null) return true;
    return cached.contentHash != newHash;
  }

  /// Update cache entry for a component
  void updateComponent(String componentName, String hash) {
    final entry = CacheEntry(
      filePath: 'components/$componentName',
      contentHash: hash,
      lastModified: DateTime.now().millisecondsSinceEpoch,
    );

    _cache = BuildCache(
      lastBuildTime: DateTime.now().millisecondsSinceEpoch,
      entries: {..._cache.entries, componentName: entry},
    );
  }

  /// Update cache entry for a screen
  void updateScreen(String screenName, String hash) {
    final entry = CacheEntry(
      filePath: 'screens/$screenName',
      contentHash: hash,
      lastModified: DateTime.now().millisecondsSinceEpoch,
    );

    _cache = BuildCache(
      lastBuildTime: DateTime.now().millisecondsSinceEpoch,
      entries: {..._cache.entries, screenName: entry},
    );
  }

  /// Save the current cache to disk
  Future<void> save() async {
    try {
      await _cacheManager.saveCache(_cache);
    } catch (e) {
      throw CacheRepositoryException('Failed to save cache: $e');
    }
  }

  /// Get current cache
  BuildCache get cache => _cache;

  /// Get number of cached entries
  int get entryCount => _cache.entries.length;

  /// Clear all cache entries
  void clear() {
    _cache = BuildCache.empty();
  }
}

/// Exception thrown by CacheRepository operations
class CacheRepositoryException implements Exception {
  final String message;

  CacheRepositoryException(this.message);

  @override
  String toString() => 'CacheRepositoryException: $message';
}
