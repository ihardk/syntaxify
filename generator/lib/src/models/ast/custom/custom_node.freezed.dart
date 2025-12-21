// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomNode {
  /// The specific type of the component (e.g., 'Carousel', 'GoogleMap')
  String get type;

  /// Key-value pairs of properties for the component
  Map<String, dynamic> get props;

  /// Child nodes, if the component supports children
  List<LayoutNode> get children;

  /// Create a copy of CustomNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomNodeCopyWith<CustomNode> get copyWith =>
      _$CustomNodeCopyWithImpl<CustomNode>(this as CustomNode, _$identity);

  /// Serializes this CustomNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomNode &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.props, props) &&
            const DeepCollectionEquality().equals(other.children, children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(props),
      const DeepCollectionEquality().hash(children));

  @override
  String toString() {
    return 'CustomNode(type: $type, props: $props, children: $children)';
  }
}

/// @nodoc
abstract mixin class $CustomNodeCopyWith<$Res> {
  factory $CustomNodeCopyWith(
          CustomNode value, $Res Function(CustomNode) _then) =
      _$CustomNodeCopyWithImpl;
  @useResult
  $Res call(
      {String type, Map<String, dynamic> props, List<LayoutNode> children});
}

/// @nodoc
class _$CustomNodeCopyWithImpl<$Res> implements $CustomNodeCopyWith<$Res> {
  _$CustomNodeCopyWithImpl(this._self, this._then);

  final CustomNode _self;
  final $Res Function(CustomNode) _then;

  /// Create a copy of CustomNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? props = null,
    Object? children = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      props: null == props
          ? _self.props
          : props // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomNode].
extension CustomNodePatterns on CustomNode {
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
    TResult Function(_CustomNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomNode() when $default != null:
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
    TResult Function(_CustomNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomNode():
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
    TResult? Function(_CustomNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomNode() when $default != null:
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
            String type, Map<String, dynamic> props, List<LayoutNode> children)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomNode() when $default != null:
        return $default(_that.type, _that.props, _that.children);
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
            String type, Map<String, dynamic> props, List<LayoutNode> children)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomNode():
        return $default(_that.type, _that.props, _that.children);
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
            String type, Map<String, dynamic> props, List<LayoutNode> children)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomNode() when $default != null:
        return $default(_that.type, _that.props, _that.children);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomNode implements CustomNode {
  const _CustomNode(
      {required this.type,
      final Map<String, dynamic> props = const {},
      final List<LayoutNode> children = const []})
      : _props = props,
        _children = children;
  factory _CustomNode.fromJson(Map<String, dynamic> json) =>
      _$CustomNodeFromJson(json);

  /// The specific type of the component (e.g., 'Carousel', 'GoogleMap')
  @override
  final String type;

  /// Key-value pairs of properties for the component
  final Map<String, dynamic> _props;

  /// Key-value pairs of properties for the component
  @override
  @JsonKey()
  Map<String, dynamic> get props {
    if (_props is EqualUnmodifiableMapView) return _props;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_props);
  }

  /// Child nodes, if the component supports children
  final List<LayoutNode> _children;

  /// Child nodes, if the component supports children
  @override
  @JsonKey()
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  /// Create a copy of CustomNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomNodeCopyWith<_CustomNode> get copyWith =>
      __$CustomNodeCopyWithImpl<_CustomNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomNode &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._props, _props) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_props),
      const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'CustomNode(type: $type, props: $props, children: $children)';
  }
}

/// @nodoc
abstract mixin class _$CustomNodeCopyWith<$Res>
    implements $CustomNodeCopyWith<$Res> {
  factory _$CustomNodeCopyWith(
          _CustomNode value, $Res Function(_CustomNode) _then) =
      __$CustomNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type, Map<String, dynamic> props, List<LayoutNode> children});
}

/// @nodoc
class __$CustomNodeCopyWithImpl<$Res> implements _$CustomNodeCopyWith<$Res> {
  __$CustomNodeCopyWithImpl(this._self, this._then);

  final _CustomNode _self;
  final $Res Function(_CustomNode) _then;

  /// Create a copy of CustomNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? props = null,
    Object? children = null,
  }) {
    return _then(_CustomNode(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      props: null == props
          ? _self._props
          : props // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
    ));
  }
}

// dart format on
