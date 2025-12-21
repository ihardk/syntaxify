// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuildCache _$BuildCacheFromJson(Map<String, dynamic> json) => _BuildCache(
      version: json['version'] as String? ?? '1.0.0',
      lastBuildTime: (json['lastBuildTime'] as num).toInt(),
      entries: (json['entries'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, CacheEntry.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$BuildCacheToJson(_BuildCache instance) =>
    <String, dynamic>{
      'version': instance.version,
      'lastBuildTime': instance.lastBuildTime,
      'entries': instance.entries.map((k, e) => MapEntry(k, e.toJson())),
    };

_CacheEntry _$CacheEntryFromJson(Map<String, dynamic> json) => _CacheEntry(
      filePath: json['filePath'] as String,
      lastModified: (json['lastModified'] as num).toInt(),
      contentHash: json['contentHash'] as String,
      outputs: (json['outputs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CacheEntryToJson(_CacheEntry instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'lastModified': instance.lastModified,
      'contentHash': instance.contentHash,
      'outputs': instance.outputs,
    };
