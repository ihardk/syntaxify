// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScreenDefinition {
  String get id;
  AstNode get layout;
  AstNode? get appBar;
  String? get padding;

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScreenDefinitionCopyWith<ScreenDefinition> get copyWith =>
      _$ScreenDefinitionCopyWithImpl<ScreenDefinition>(
          this as ScreenDefinition, _$identity);

  /// Serializes this ScreenDefinition to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenDefinition &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.appBar, appBar) || other.appBar == appBar) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, layout, appBar, padding);

  @override
  String toString() {
    return 'ScreenDefinition(id: $id, layout: $layout, appBar: $appBar, padding: $padding)';
  }
}

/// @nodoc
abstract mixin class $ScreenDefinitionCopyWith<$Res> {
  factory $ScreenDefinitionCopyWith(
          ScreenDefinition value, $Res Function(ScreenDefinition) _then) =
      _$ScreenDefinitionCopyWithImpl;
  @useResult
  $Res call({String id, AstNode layout, AstNode? appBar, String? padding});

  $AstNodeCopyWith<$Res> get layout;
  $AstNodeCopyWith<$Res>? get appBar;
}

/// @nodoc
class _$ScreenDefinitionCopyWithImpl<$Res>
    implements $ScreenDefinitionCopyWith<$Res> {
  _$ScreenDefinitionCopyWithImpl(this._self, this._then);

  final ScreenDefinition _self;
  final $Res Function(ScreenDefinition) _then;

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? layout = null,
    Object? appBar = freezed,
    Object? padding = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      layout: null == layout
          ? _self.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as AstNode,
      appBar: freezed == appBar
          ? _self.appBar
          : appBar // ignore: cast_nullable_to_non_nullable
              as AstNode?,
      padding: freezed == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AstNodeCopyWith<$Res> get layout {
    return $AstNodeCopyWith<$Res>(_self.layout, (value) {
      return _then(_self.copyWith(layout: value));
    });
  }

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AstNodeCopyWith<$Res>? get appBar {
    if (_self.appBar == null) {
      return null;
    }

    return $AstNodeCopyWith<$Res>(_self.appBar!, (value) {
      return _then(_self.copyWith(appBar: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ScreenDefinition].
extension ScreenDefinitionPatterns on ScreenDefinition {
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
    TResult Function(_ScreenDefinition value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition() when $default != null:
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
    TResult Function(_ScreenDefinition value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition():
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
    TResult? Function(_ScreenDefinition value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition() when $default != null:
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
            String id, AstNode layout, AstNode? appBar, String? padding)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition() when $default != null:
        return $default(_that.id, _that.layout, _that.appBar, _that.padding);
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
            String id, AstNode layout, AstNode? appBar, String? padding)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition():
        return $default(_that.id, _that.layout, _that.appBar, _that.padding);
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
            String id, AstNode layout, AstNode? appBar, String? padding)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenDefinition() when $default != null:
        return $default(_that.id, _that.layout, _that.appBar, _that.padding);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScreenDefinition implements ScreenDefinition {
  const _ScreenDefinition(
      {required this.id, required this.layout, this.appBar, this.padding});
  factory _ScreenDefinition.fromJson(Map<String, dynamic> json) =>
      _$ScreenDefinitionFromJson(json);

  @override
  final String id;
  @override
  final AstNode layout;
  @override
  final AstNode? appBar;
  @override
  final String? padding;

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenDefinitionCopyWith<_ScreenDefinition> get copyWith =>
      __$ScreenDefinitionCopyWithImpl<_ScreenDefinition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScreenDefinitionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScreenDefinition &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.appBar, appBar) || other.appBar == appBar) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, layout, appBar, padding);

  @override
  String toString() {
    return 'ScreenDefinition(id: $id, layout: $layout, appBar: $appBar, padding: $padding)';
  }
}

/// @nodoc
abstract mixin class _$ScreenDefinitionCopyWith<$Res>
    implements $ScreenDefinitionCopyWith<$Res> {
  factory _$ScreenDefinitionCopyWith(
          _ScreenDefinition value, $Res Function(_ScreenDefinition) _then) =
      __$ScreenDefinitionCopyWithImpl;
  @override
  @useResult
  $Res call({String id, AstNode layout, AstNode? appBar, String? padding});

  @override
  $AstNodeCopyWith<$Res> get layout;
  @override
  $AstNodeCopyWith<$Res>? get appBar;
}

/// @nodoc
class __$ScreenDefinitionCopyWithImpl<$Res>
    implements _$ScreenDefinitionCopyWith<$Res> {
  __$ScreenDefinitionCopyWithImpl(this._self, this._then);

  final _ScreenDefinition _self;
  final $Res Function(_ScreenDefinition) _then;

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? layout = null,
    Object? appBar = freezed,
    Object? padding = freezed,
  }) {
    return _then(_ScreenDefinition(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      layout: null == layout
          ? _self.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as AstNode,
      appBar: freezed == appBar
          ? _self.appBar
          : appBar // ignore: cast_nullable_to_non_nullable
              as AstNode?,
      padding: freezed == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AstNodeCopyWith<$Res> get layout {
    return $AstNodeCopyWith<$Res>(_self.layout, (value) {
      return _then(_self.copyWith(layout: value));
    });
  }

  /// Create a copy of ScreenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AstNodeCopyWith<$Res>? get appBar {
    if (_self.appBar == null) {
      return null;
    }

    return $AstNodeCopyWith<$Res>(_self.appBar!, (value) {
      return _then(_self.copyWith(appBar: value));
    });
  }
}

// dart format on
