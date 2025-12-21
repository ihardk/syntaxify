// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ValidationError {
  /// The type of validation error
  ValidationErrorType get type;

  /// Human-readable error message
  String get message;

  /// Path to the problematic node (e.g., "column.children[0].button")
  String? get nodePath;

  /// Field name that caused the error
  String? get fieldName;

  /// Suggested fix for the error
  String? get suggestion;

  /// Error severity level
  ErrorSeverity get severity;

  /// Create a copy of ValidationError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValidationErrorCopyWith<ValidationError> get copyWith =>
      _$ValidationErrorCopyWithImpl<ValidationError>(
          this as ValidationError, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValidationError &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.nodePath, nodePath) ||
                other.nodePath == nodePath) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, message, nodePath, fieldName, suggestion, severity);

  @override
  String toString() {
    return 'ValidationError(type: $type, message: $message, nodePath: $nodePath, fieldName: $fieldName, suggestion: $suggestion, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class $ValidationErrorCopyWith<$Res> {
  factory $ValidationErrorCopyWith(
          ValidationError value, $Res Function(ValidationError) _then) =
      _$ValidationErrorCopyWithImpl;
  @useResult
  $Res call(
      {ValidationErrorType type,
      String message,
      String? nodePath,
      String? fieldName,
      String? suggestion,
      ErrorSeverity severity});
}

/// @nodoc
class _$ValidationErrorCopyWithImpl<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  _$ValidationErrorCopyWithImpl(this._self, this._then);

  final ValidationError _self;
  final $Res Function(ValidationError) _then;

  /// Create a copy of ValidationError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? nodePath = freezed,
    Object? fieldName = freezed,
    Object? suggestion = freezed,
    Object? severity = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ValidationErrorType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      nodePath: freezed == nodePath
          ? _self.nodePath
          : nodePath // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      suggestion: freezed == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ErrorSeverity,
    ));
  }
}

/// Adds pattern-matching-related methods to [ValidationError].
extension ValidationErrorPatterns on ValidationError {
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
    TResult Function(_ValidationError value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ValidationError() when $default != null:
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
    TResult Function(_ValidationError value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ValidationError():
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
    TResult? Function(_ValidationError value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ValidationError() when $default != null:
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
    TResult Function(ValidationErrorType type, String message, String? nodePath,
            String? fieldName, String? suggestion, ErrorSeverity severity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ValidationError() when $default != null:
        return $default(_that.type, _that.message, _that.nodePath,
            _that.fieldName, _that.suggestion, _that.severity);
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
    TResult Function(ValidationErrorType type, String message, String? nodePath,
            String? fieldName, String? suggestion, ErrorSeverity severity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ValidationError():
        return $default(_that.type, _that.message, _that.nodePath,
            _that.fieldName, _that.suggestion, _that.severity);
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
            ValidationErrorType type,
            String message,
            String? nodePath,
            String? fieldName,
            String? suggestion,
            ErrorSeverity severity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ValidationError() when $default != null:
        return $default(_that.type, _that.message, _that.nodePath,
            _that.fieldName, _that.suggestion, _that.severity);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ValidationError implements ValidationError {
  const _ValidationError(
      {required this.type,
      required this.message,
      this.nodePath,
      this.fieldName,
      this.suggestion,
      this.severity = ErrorSeverity.error});

  /// The type of validation error
  @override
  final ValidationErrorType type;

  /// Human-readable error message
  @override
  final String message;

  /// Path to the problematic node (e.g., "column.children[0].button")
  @override
  final String? nodePath;

  /// Field name that caused the error
  @override
  final String? fieldName;

  /// Suggested fix for the error
  @override
  final String? suggestion;

  /// Error severity level
  @override
  @JsonKey()
  final ErrorSeverity severity;

  /// Create a copy of ValidationError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ValidationErrorCopyWith<_ValidationError> get copyWith =>
      __$ValidationErrorCopyWithImpl<_ValidationError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ValidationError &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.nodePath, nodePath) ||
                other.nodePath == nodePath) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, message, nodePath, fieldName, suggestion, severity);

  @override
  String toString() {
    return 'ValidationError(type: $type, message: $message, nodePath: $nodePath, fieldName: $fieldName, suggestion: $suggestion, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class _$ValidationErrorCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$ValidationErrorCopyWith(
          _ValidationError value, $Res Function(_ValidationError) _then) =
      __$ValidationErrorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ValidationErrorType type,
      String message,
      String? nodePath,
      String? fieldName,
      String? suggestion,
      ErrorSeverity severity});
}

/// @nodoc
class __$ValidationErrorCopyWithImpl<$Res>
    implements _$ValidationErrorCopyWith<$Res> {
  __$ValidationErrorCopyWithImpl(this._self, this._then);

  final _ValidationError _self;
  final $Res Function(_ValidationError) _then;

  /// Create a copy of ValidationError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? nodePath = freezed,
    Object? fieldName = freezed,
    Object? suggestion = freezed,
    Object? severity = null,
  }) {
    return _then(_ValidationError(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ValidationErrorType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      nodePath: freezed == nodePath
          ? _self.nodePath
          : nodePath // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      suggestion: freezed == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ErrorSeverity,
    ));
  }
}

// dart format on
