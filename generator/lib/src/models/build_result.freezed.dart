// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'build_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BuildResult {
  int get filesGenerated;
  List<String> get generatedFiles;
  Duration get duration;
  List<String> get warnings;
  List<String> get errors;

  /// Create a copy of BuildResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BuildResultCopyWith<BuildResult> get copyWith =>
      _$BuildResultCopyWithImpl<BuildResult>(this as BuildResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BuildResult &&
            (identical(other.filesGenerated, filesGenerated) ||
                other.filesGenerated == filesGenerated) &&
            const DeepCollectionEquality()
                .equals(other.generatedFiles, generatedFiles) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filesGenerated,
      const DeepCollectionEquality().hash(generatedFiles),
      duration,
      const DeepCollectionEquality().hash(warnings),
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'BuildResult(filesGenerated: $filesGenerated, generatedFiles: $generatedFiles, duration: $duration, warnings: $warnings, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $BuildResultCopyWith<$Res> {
  factory $BuildResultCopyWith(
          BuildResult value, $Res Function(BuildResult) _then) =
      _$BuildResultCopyWithImpl;
  @useResult
  $Res call(
      {int filesGenerated,
      List<String> generatedFiles,
      Duration duration,
      List<String> warnings,
      List<String> errors});
}

/// @nodoc
class _$BuildResultCopyWithImpl<$Res> implements $BuildResultCopyWith<$Res> {
  _$BuildResultCopyWithImpl(this._self, this._then);

  final BuildResult _self;
  final $Res Function(BuildResult) _then;

  /// Create a copy of BuildResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filesGenerated = null,
    Object? generatedFiles = null,
    Object? duration = null,
    Object? warnings = null,
    Object? errors = null,
  }) {
    return _then(_self.copyWith(
      filesGenerated: null == filesGenerated
          ? _self.filesGenerated
          : filesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      generatedFiles: null == generatedFiles
          ? _self.generatedFiles
          : generatedFiles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BuildResult].
extension BuildResultPatterns on BuildResult {
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
    TResult Function(_BuildResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BuildResult() when $default != null:
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
    TResult Function(_BuildResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildResult():
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
    TResult? Function(_BuildResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildResult() when $default != null:
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
    TResult Function(int filesGenerated, List<String> generatedFiles,
            Duration duration, List<String> warnings, List<String> errors)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BuildResult() when $default != null:
        return $default(_that.filesGenerated, _that.generatedFiles,
            _that.duration, _that.warnings, _that.errors);
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
    TResult Function(int filesGenerated, List<String> generatedFiles,
            Duration duration, List<String> warnings, List<String> errors)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildResult():
        return $default(_that.filesGenerated, _that.generatedFiles,
            _that.duration, _that.warnings, _that.errors);
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
    TResult? Function(int filesGenerated, List<String> generatedFiles,
            Duration duration, List<String> warnings, List<String> errors)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BuildResult() when $default != null:
        return $default(_that.filesGenerated, _that.generatedFiles,
            _that.duration, _that.warnings, _that.errors);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BuildResult extends BuildResult {
  const _BuildResult(
      {required this.filesGenerated,
      required final List<String> generatedFiles,
      required this.duration,
      final List<String> warnings = const [],
      final List<String> errors = const []})
      : _generatedFiles = generatedFiles,
        _warnings = warnings,
        _errors = errors,
        super._();

  @override
  final int filesGenerated;
  final List<String> _generatedFiles;
  @override
  List<String> get generatedFiles {
    if (_generatedFiles is EqualUnmodifiableListView) return _generatedFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_generatedFiles);
  }

  @override
  final Duration duration;
  final List<String> _warnings;
  @override
  @JsonKey()
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  /// Create a copy of BuildResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BuildResultCopyWith<_BuildResult> get copyWith =>
      __$BuildResultCopyWithImpl<_BuildResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuildResult &&
            (identical(other.filesGenerated, filesGenerated) ||
                other.filesGenerated == filesGenerated) &&
            const DeepCollectionEquality()
                .equals(other._generatedFiles, _generatedFiles) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filesGenerated,
      const DeepCollectionEquality().hash(_generatedFiles),
      duration,
      const DeepCollectionEquality().hash(_warnings),
      const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'BuildResult(filesGenerated: $filesGenerated, generatedFiles: $generatedFiles, duration: $duration, warnings: $warnings, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$BuildResultCopyWith<$Res>
    implements $BuildResultCopyWith<$Res> {
  factory _$BuildResultCopyWith(
          _BuildResult value, $Res Function(_BuildResult) _then) =
      __$BuildResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int filesGenerated,
      List<String> generatedFiles,
      Duration duration,
      List<String> warnings,
      List<String> errors});
}

/// @nodoc
class __$BuildResultCopyWithImpl<$Res> implements _$BuildResultCopyWith<$Res> {
  __$BuildResultCopyWithImpl(this._self, this._then);

  final _BuildResult _self;
  final $Res Function(_BuildResult) _then;

  /// Create a copy of BuildResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filesGenerated = null,
    Object? generatedFiles = null,
    Object? duration = null,
    Object? warnings = null,
    Object? errors = null,
  }) {
    return _then(_BuildResult(
      filesGenerated: null == filesGenerated
          ? _self.filesGenerated
          : filesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      generatedFiles: null == generatedFiles
          ? _self._generatedFiles
          : generatedFiles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
