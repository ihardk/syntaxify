// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bar_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppBarAction {
  String get icon;
  String get onPressed;
  String? get tooltip;

  /// Create a copy of AppBarAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppBarActionCopyWith<AppBarAction> get copyWith =>
      _$AppBarActionCopyWithImpl<AppBarAction>(
          this as AppBarAction, _$identity);

  /// Serializes this AppBarAction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppBarAction &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.tooltip, tooltip) || other.tooltip == tooltip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, icon, onPressed, tooltip);

  @override
  String toString() {
    return 'AppBarAction(icon: $icon, onPressed: $onPressed, tooltip: $tooltip)';
  }
}

/// @nodoc
abstract mixin class $AppBarActionCopyWith<$Res> {
  factory $AppBarActionCopyWith(
          AppBarAction value, $Res Function(AppBarAction) _then) =
      _$AppBarActionCopyWithImpl;
  @useResult
  $Res call({String icon, String onPressed, String? tooltip});
}

/// @nodoc
class _$AppBarActionCopyWithImpl<$Res> implements $AppBarActionCopyWith<$Res> {
  _$AppBarActionCopyWithImpl(this._self, this._then);

  final AppBarAction _self;
  final $Res Function(AppBarAction) _then;

  /// Create a copy of AppBarAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? onPressed = null,
    Object? tooltip = freezed,
  }) {
    return _then(_self.copyWith(
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: null == onPressed
          ? _self.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _self.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppBarAction].
extension AppBarActionPatterns on AppBarAction {
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
    TResult Function(_AppBarAction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppBarAction() when $default != null:
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
    TResult Function(_AppBarAction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppBarAction():
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
    TResult? Function(_AppBarAction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppBarAction() when $default != null:
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
    TResult Function(String icon, String onPressed, String? tooltip)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppBarAction() when $default != null:
        return $default(_that.icon, _that.onPressed, _that.tooltip);
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
    TResult Function(String icon, String onPressed, String? tooltip) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppBarAction():
        return $default(_that.icon, _that.onPressed, _that.tooltip);
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
    TResult? Function(String icon, String onPressed, String? tooltip)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppBarAction() when $default != null:
        return $default(_that.icon, _that.onPressed, _that.tooltip);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppBarAction implements AppBarAction {
  const _AppBarAction(
      {required this.icon, required this.onPressed, this.tooltip});
  factory _AppBarAction.fromJson(Map<String, dynamic> json) =>
      _$AppBarActionFromJson(json);

  @override
  final String icon;
  @override
  final String onPressed;
  @override
  final String? tooltip;

  /// Create a copy of AppBarAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppBarActionCopyWith<_AppBarAction> get copyWith =>
      __$AppBarActionCopyWithImpl<_AppBarAction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppBarActionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppBarAction &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.tooltip, tooltip) || other.tooltip == tooltip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, icon, onPressed, tooltip);

  @override
  String toString() {
    return 'AppBarAction(icon: $icon, onPressed: $onPressed, tooltip: $tooltip)';
  }
}

/// @nodoc
abstract mixin class _$AppBarActionCopyWith<$Res>
    implements $AppBarActionCopyWith<$Res> {
  factory _$AppBarActionCopyWith(
          _AppBarAction value, $Res Function(_AppBarAction) _then) =
      __$AppBarActionCopyWithImpl;
  @override
  @useResult
  $Res call({String icon, String onPressed, String? tooltip});
}

/// @nodoc
class __$AppBarActionCopyWithImpl<$Res>
    implements _$AppBarActionCopyWith<$Res> {
  __$AppBarActionCopyWithImpl(this._self, this._then);

  final _AppBarAction _self;
  final $Res Function(_AppBarAction) _then;

  /// Create a copy of AppBarAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? icon = null,
    Object? onPressed = null,
    Object? tooltip = freezed,
  }) {
    return _then(_AppBarAction(
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: null == onPressed
          ? _self.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _self.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
