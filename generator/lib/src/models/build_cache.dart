import 'package:freezed_annotation/freezed_annotation.dart';

part 'build_cache.freezed.dart';
part 'build_cache.g.dart';

/// Represents the build cache for incremental builds.
///
/// Tracks file modification times and content hashes to determine
/// which files need to be regenerated.
@freezed
sealed class BuildCache with _$BuildCache {
  const factory BuildCache({
    /// Cache format version for future compatibility
    @Default('1.0.0') String version,

    /// Last build timestamp (milliseconds since epoch)
    required int lastBuildTime,

    /// Map of file paths to their cache entries
    @Default({}) Map<String, CacheEntry> entries,
  }) = _BuildCache;

  factory BuildCache.fromJson(Map<String, dynamic> json) =>
      _$BuildCacheFromJson(json);

  /// Creates an empty cache
  factory BuildCache.empty() => BuildCache(
        lastBuildTime: DateTime.now().millisecondsSinceEpoch,
      );
}

/// Represents a cached entry for a single file.
@freezed
sealed class CacheEntry with _$CacheEntry {
  const factory CacheEntry({
    /// File path relative to project root
    required String filePath,

    /// Last modification time (milliseconds since epoch)
    required int lastModified,

    /// Content hash (SHA-256) for change detection
    required String contentHash,

    /// Generated output files for this source file
    @Default([]) List<String> outputs,
  }) = _CacheEntry;

  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);
}
