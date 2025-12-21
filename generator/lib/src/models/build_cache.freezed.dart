// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'build_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BuildCache {
  /// Cache format version for future compatibility
  String get version;

  /// Last build timestamp (milliseconds since epoch)
  int get lastBuildTime;

  /// Map of file paths to their cache entries
  Map<String, CacheEntry> get entries;

  /// Create a copy of BuildCache
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BuildCacheCopyWith<BuildCache> get copyWith =>
      _$BuildCacheCopyWithImpl<BuildCache>(this as BuildCache, _$identity);

  /// Serializes this BuildCache to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BuildCache &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastBuildTime, lastBuildTime) ||
                other.lastBuildTime == lastBuildTime) &&
            const DeepCollectionEquality().equals(other.entries, entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, lastBuildTime,
      const DeepCollectionEquality().hash(entries));

  @override
  String toString() {
    return 'BuildCache(version: $version, lastBuildTime: $lastBuildTime, entries: $entries)';
  }
}

/// @nodoc
abstract mixin class $BuildCacheCopyWith<$Res> {
  factory $BuildCacheCopyWith(
          BuildCache value, $Res Function(BuildCache) _then) =
      _$BuildCacheCopyWithImpl;
  @useResult
  $Res call(
      {String version, int lastBuildTime, Map<String, CacheEntry> entries});
}

/// @nodoc
class _$BuildCacheCopyWithImpl<$Res> implements $BuildCacheCopyWith<$Res> {
  _$BuildCacheCopyWithImpl(this._self, this._then);

  final BuildCache _self;
  final $Res Function(BuildCache) _then;

  /// Create a copy of BuildCache
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? lastBuildTime = null,
    Object? entries = null,
  }) {
    return _then(_self.copyWith(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      lastBuildTime: null == lastBuildTime
          ? _self.lastBuildTime
          : lastBuildTime // ignore: cast_nullable_to_non_nullable
              as int,
      entries: null == entries
          ? _self.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, CacheEntry>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BuildCache].
extension BuildCachePatterns on BuildCache {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BuildCache value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BuildCache() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BuildCache value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildCache():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BuildCache value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildCache() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String version, int lastBuildTime, Map<String, CacheEntry> entries)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BuildCache() when $default != null:
        return $default(_that.version, _that.lastBuildTime, _that.entries);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String version, int lastBuildTime, Map<String, CacheEntry> entries)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildCache():
        return $default(_that.version, _that.lastBuildTime, _that.entries);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String version, int lastBuildTime, Map<String, CacheEntry> entries)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildCache() when $default != null:
        return $default(_that.version, _that.lastBuildTime, _that.entries);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BuildCache implements BuildCache {
  const _BuildCache(
      {this.version = '1.0.0',
      required this.lastBuildTime,
      final Map<String, CacheEntry> entries = const {}})
      : _entries = entries;
  factory _BuildCache.fromJson(Map<String, dynamic> json) =>
      _$BuildCacheFromJson(json);

  /// Cache format version for future compatibility
  @override
  @JsonKey()
  final String version;

  /// Last build timestamp (milliseconds since epoch)
  @override
  final int lastBuildTime;

  /// Map of file paths to their cache entries
  final Map<String, CacheEntry> _entries;

  /// Map of file paths to their cache entries
  @override
  @JsonKey()
  Map<String, CacheEntry> get entries {
    if (_entries is EqualUnmodifiableMapView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entries);
  }

  /// Create a copy of BuildCache
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BuildCacheCopyWith<_BuildCache> get copyWith =>
      __$BuildCacheCopyWithImpl<_BuildCache>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BuildCacheToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuildCache &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastBuildTime, lastBuildTime) ||
                other.lastBuildTime == lastBuildTime) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, lastBuildTime,
      const DeepCollectionEquality().hash(_entries));

  @override
  String toString() {
    return 'BuildCache(version: $version, lastBuildTime: $lastBuildTime, entries: $entries)';
  }
}

/// @nodoc
abstract mixin class _$BuildCacheCopyWith<$Res>
    implements $BuildCacheCopyWith<$Res> {
  factory _$BuildCacheCopyWith(
          _BuildCache value, $Res Function(_BuildCache) _then) =
      __$BuildCacheCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String version, int lastBuildTime, Map<String, CacheEntry> entries});
}

/// @nodoc
class __$BuildCacheCopyWithImpl<$Res> implements _$BuildCacheCopyWith<$Res> {
  __$BuildCacheCopyWithImpl(this._self, this._then);

  final _BuildCache _self;
  final $Res Function(_BuildCache) _then;

  /// Create a copy of BuildCache
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
    Object? lastBuildTime = null,
    Object? entries = null,
  }) {
    return _then(_BuildCache(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      lastBuildTime: null == lastBuildTime
          ? _self.lastBuildTime
          : lastBuildTime // ignore: cast_nullable_to_non_nullable
              as int,
      entries: null == entries
          ? _self._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, CacheEntry>,
    ));
  }
}

/// @nodoc
mixin _$CacheEntry {
  /// File path relative to project root
  String get filePath;

  /// Last modification time (milliseconds since epoch)
  int get lastModified;

  /// Content hash (SHA-256) for change detection
  String get contentHash;

  /// Generated output files for this source file
  List<String> get outputs;

  /// Create a copy of CacheEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CacheEntryCopyWith<CacheEntry> get copyWith =>
      _$CacheEntryCopyWithImpl<CacheEntry>(this as CacheEntry, _$identity);

  /// Serializes this CacheEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CacheEntry &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.contentHash, contentHash) ||
                other.contentHash == contentHash) &&
            const DeepCollectionEquality().equals(other.outputs, outputs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filePath, lastModified,
      contentHash, const DeepCollectionEquality().hash(outputs));

  @override
  String toString() {
    return 'CacheEntry(filePath: $filePath, lastModified: $lastModified, contentHash: $contentHash, outputs: $outputs)';
  }
}

/// @nodoc
abstract mixin class $CacheEntryCopyWith<$Res> {
  factory $CacheEntryCopyWith(
          CacheEntry value, $Res Function(CacheEntry) _then) =
      _$CacheEntryCopyWithImpl;
  @useResult
  $Res call(
      {String filePath,
      int lastModified,
      String contentHash,
      List<String> outputs});
}

/// @nodoc
class _$CacheEntryCopyWithImpl<$Res> implements $CacheEntryCopyWith<$Res> {
  _$CacheEntryCopyWithImpl(this._self, this._then);

  final CacheEntry _self;
  final $Res Function(CacheEntry) _then;

  /// Create a copy of CacheEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? lastModified = null,
    Object? contentHash = null,
    Object? outputs = null,
  }) {
    return _then(_self.copyWith(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: null == lastModified
          ? _self.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as int,
      contentHash: null == contentHash
          ? _self.contentHash
          : contentHash // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _self.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CacheEntry].
extension CacheEntryPatterns on CacheEntry {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CacheEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CacheEntry() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CacheEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CacheEntry():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CacheEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CacheEntry() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String filePath, int lastModified, String contentHash,
            List<String> outputs)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CacheEntry() when $default != null:
        return $default(_that.filePath, _that.lastModified, _that.contentHash,
            _that.outputs);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String filePath, int lastModified, String contentHash,
            List<String> outputs)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CacheEntry():
        return $default(_that.filePath, _that.lastModified, _that.contentHash,
            _that.outputs);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String filePath, int lastModified, String contentHash,
            List<String> outputs)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CacheEntry() when $default != null:
        return $default(_that.filePath, _that.lastModified, _that.contentHash,
            _that.outputs);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CacheEntry implements CacheEntry {
  const _CacheEntry(
      {required this.filePath,
      required this.lastModified,
      required this.contentHash,
      final List<String> outputs = const []})
      : _outputs = outputs;
  factory _CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);

  /// File path relative to project root
  @override
  final String filePath;

  /// Last modification time (milliseconds since epoch)
  @override
  final int lastModified;

  /// Content hash (SHA-256) for change detection
  @override
  final String contentHash;

  /// Generated output files for this source file
  final List<String> _outputs;

  /// Generated output files for this source file
  @override
  @JsonKey()
  List<String> get outputs {
    if (_outputs is EqualUnmodifiableListView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputs);
  }

  /// Create a copy of CacheEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CacheEntryCopyWith<_CacheEntry> get copyWith =>
      __$CacheEntryCopyWithImpl<_CacheEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CacheEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CacheEntry &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.contentHash, contentHash) ||
                other.contentHash == contentHash) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filePath, lastModified,
      contentHash, const DeepCollectionEquality().hash(_outputs));

  @override
  String toString() {
    return 'CacheEntry(filePath: $filePath, lastModified: $lastModified, contentHash: $contentHash, outputs: $outputs)';
  }
}

/// @nodoc
abstract mixin class _$CacheEntryCopyWith<$Res>
    implements $CacheEntryCopyWith<$Res> {
  factory _$CacheEntryCopyWith(
          _CacheEntry value, $Res Function(_CacheEntry) _then) =
      __$CacheEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String filePath,
      int lastModified,
      String contentHash,
      List<String> outputs});
}

/// @nodoc
class __$CacheEntryCopyWithImpl<$Res> implements _$CacheEntryCopyWith<$Res> {
  __$CacheEntryCopyWithImpl(this._self, this._then);

  final _CacheEntry _self;
  final $Res Function(_CacheEntry) _then;

  /// Create a copy of CacheEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filePath = null,
    Object? lastModified = null,
    Object? contentHash = null,
    Object? outputs = null,
  }) {
    return _then(_CacheEntry(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: null == lastModified
          ? _self.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as int,
      contentHash: null == contentHash
          ? _self.contentHash
          : contentHash // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _self._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
