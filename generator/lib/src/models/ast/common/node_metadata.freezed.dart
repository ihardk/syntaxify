// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NodeMetadata {
  /// Unique identifier for the node.
  String? get id;

  /// Condition for visibility (e.g., 'params.showButton').
  String? get visibleWhen;

  /// Create a copy of NodeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<NodeMetadata> get copyWith =>
      _$NodeMetadataCopyWithImpl<NodeMetadata>(
          this as NodeMetadata, _$identity);

  /// Serializes this NodeMetadata to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NodeMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, visibleWhen);

  @override
  String toString() {
    return 'NodeMetadata(id: $id, visibleWhen: $visibleWhen)';
  }
}

/// @nodoc
abstract mixin class $NodeMetadataCopyWith<$Res> {
  factory $NodeMetadataCopyWith(
          NodeMetadata value, $Res Function(NodeMetadata) _then) =
      _$NodeMetadataCopyWithImpl;
  @useResult
  $Res call({String? id, String? visibleWhen});
}

/// @nodoc
class _$NodeMetadataCopyWithImpl<$Res> implements $NodeMetadataCopyWith<$Res> {
  _$NodeMetadataCopyWithImpl(this._self, this._then);

  final NodeMetadata _self;
  final $Res Function(NodeMetadata) _then;

  /// Create a copy of NodeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NodeMetadata].
extension NodeMetadataPatterns on NodeMetadata {
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
    TResult Function(_NodeMetadata value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata() when $default != null:
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
    TResult Function(_NodeMetadata value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata():
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
    TResult? Function(_NodeMetadata value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata() when $default != null:
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
    TResult Function(String? id, String? visibleWhen)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata() when $default != null:
        return $default(_that.id, _that.visibleWhen);
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
    TResult Function(String? id, String? visibleWhen) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata():
        return $default(_that.id, _that.visibleWhen);
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
    TResult? Function(String? id, String? visibleWhen)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NodeMetadata() when $default != null:
        return $default(_that.id, _that.visibleWhen);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NodeMetadata implements NodeMetadata {
  const _NodeMetadata({this.id, this.visibleWhen});
  factory _NodeMetadata.fromJson(Map<String, dynamic> json) =>
      _$NodeMetadataFromJson(json);

  /// Unique identifier for the node.
  @override
  final String? id;

  /// Condition for visibility (e.g., 'params.showButton').
  @override
  final String? visibleWhen;

  /// Create a copy of NodeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NodeMetadataCopyWith<_NodeMetadata> get copyWith =>
      __$NodeMetadataCopyWithImpl<_NodeMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NodeMetadataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NodeMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, visibleWhen);

  @override
  String toString() {
    return 'NodeMetadata(id: $id, visibleWhen: $visibleWhen)';
  }
}

/// @nodoc
abstract mixin class _$NodeMetadataCopyWith<$Res>
    implements $NodeMetadataCopyWith<$Res> {
  factory _$NodeMetadataCopyWith(
          _NodeMetadata value, $Res Function(_NodeMetadata) _then) =
      __$NodeMetadataCopyWithImpl;
  @override
  @useResult
  $Res call({String? id, String? visibleWhen});
}

/// @nodoc
class __$NodeMetadataCopyWithImpl<$Res>
    implements _$NodeMetadataCopyWith<$Res> {
  __$NodeMetadataCopyWithImpl(this._self, this._then);

  final _NodeMetadata _self;
  final $Res Function(_NodeMetadata) _then;

  /// Create a copy of NodeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
  }) {
    return _then(_NodeMetadata(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
