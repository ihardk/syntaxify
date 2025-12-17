// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'build_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BuildResult {
  int get filesGenerated => throw _privateConstructorUsedError;
  List<String> get generatedFiles => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BuildResultCopyWith<BuildResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildResultCopyWith<$Res> {
  factory $BuildResultCopyWith(
          BuildResult value, $Res Function(BuildResult) then) =
      _$BuildResultCopyWithImpl<$Res, BuildResult>;
  @useResult
  $Res call(
      {int filesGenerated,
      List<String> generatedFiles,
      Duration duration,
      List<String> warnings,
      List<String> errors});
}

/// @nodoc
class _$BuildResultCopyWithImpl<$Res, $Val extends BuildResult>
    implements $BuildResultCopyWith<$Res> {
  _$BuildResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filesGenerated = null,
    Object? generatedFiles = null,
    Object? duration = null,
    Object? warnings = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      filesGenerated: null == filesGenerated
          ? _value.filesGenerated
          : filesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      generatedFiles: null == generatedFiles
          ? _value.generatedFiles
          : generatedFiles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuildResultImplCopyWith<$Res>
    implements $BuildResultCopyWith<$Res> {
  factory _$$BuildResultImplCopyWith(
          _$BuildResultImpl value, $Res Function(_$BuildResultImpl) then) =
      __$$BuildResultImplCopyWithImpl<$Res>;
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
class __$$BuildResultImplCopyWithImpl<$Res>
    extends _$BuildResultCopyWithImpl<$Res, _$BuildResultImpl>
    implements _$$BuildResultImplCopyWith<$Res> {
  __$$BuildResultImplCopyWithImpl(
      _$BuildResultImpl _value, $Res Function(_$BuildResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filesGenerated = null,
    Object? generatedFiles = null,
    Object? duration = null,
    Object? warnings = null,
    Object? errors = null,
  }) {
    return _then(_$BuildResultImpl(
      filesGenerated: null == filesGenerated
          ? _value.filesGenerated
          : filesGenerated // ignore: cast_nullable_to_non_nullable
              as int,
      generatedFiles: null == generatedFiles
          ? _value._generatedFiles
          : generatedFiles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BuildResultImpl extends _BuildResult {
  const _$BuildResultImpl(
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

  @override
  String toString() {
    return 'BuildResult(filesGenerated: $filesGenerated, generatedFiles: $generatedFiles, duration: $duration, warnings: $warnings, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildResultImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildResultImplCopyWith<_$BuildResultImpl> get copyWith =>
      __$$BuildResultImplCopyWithImpl<_$BuildResultImpl>(this, _$identity);
}

abstract class _BuildResult extends BuildResult {
  const factory _BuildResult(
      {required final int filesGenerated,
      required final List<String> generatedFiles,
      required final Duration duration,
      final List<String> warnings,
      final List<String> errors}) = _$BuildResultImpl;
  const _BuildResult._() : super._();

  @override
  int get filesGenerated;
  @override
  List<String> get generatedFiles;
  @override
  Duration get duration;
  @override
  List<String> get warnings;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$BuildResultImplCopyWith<_$BuildResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
