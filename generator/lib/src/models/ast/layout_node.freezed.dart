// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
LayoutNode _$LayoutNodeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'structural':
      return StructuralLayoutNode.fromJson(json);
    case 'primitive':
      return PrimitiveLayoutNode.fromJson(json);
    case 'interactive':
      return InteractiveLayoutNode.fromJson(json);
    case 'custom':
      return CustomLayoutNode.fromJson(json);
    case 'appBar':
      return AppBarNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LayoutNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LayoutNode {
  /// Serializes this LayoutNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LayoutNode);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LayoutNode()';
  }
}

/// @nodoc
class $LayoutNodeCopyWith<$Res> {
  $LayoutNodeCopyWith(LayoutNode _, $Res Function(LayoutNode) __);
}

/// Adds pattern-matching-related methods to [LayoutNode].
extension LayoutNodePatterns on LayoutNode {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StructuralLayoutNode value)? structural,
    TResult Function(PrimitiveLayoutNode value)? primitive,
    TResult Function(InteractiveLayoutNode value)? interactive,
    TResult Function(CustomLayoutNode value)? custom,
    TResult Function(AppBarNode value)? appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode() when structural != null:
        return structural(_that);
      case PrimitiveLayoutNode() when primitive != null:
        return primitive(_that);
      case InteractiveLayoutNode() when interactive != null:
        return interactive(_that);
      case CustomLayoutNode() when custom != null:
        return custom(_that);
      case AppBarNode() when appBar != null:
        return appBar(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(StructuralLayoutNode value) structural,
    required TResult Function(PrimitiveLayoutNode value) primitive,
    required TResult Function(InteractiveLayoutNode value) interactive,
    required TResult Function(CustomLayoutNode value) custom,
    required TResult Function(AppBarNode value) appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode():
        return structural(_that);
      case PrimitiveLayoutNode():
        return primitive(_that);
      case InteractiveLayoutNode():
        return interactive(_that);
      case CustomLayoutNode():
        return custom(_that);
      case AppBarNode():
        return appBar(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StructuralLayoutNode value)? structural,
    TResult? Function(PrimitiveLayoutNode value)? primitive,
    TResult? Function(InteractiveLayoutNode value)? interactive,
    TResult? Function(CustomLayoutNode value)? custom,
    TResult? Function(AppBarNode value)? appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode() when structural != null:
        return structural(_that);
      case PrimitiveLayoutNode() when primitive != null:
        return primitive(_that);
      case InteractiveLayoutNode() when interactive != null:
        return interactive(_that);
      case CustomLayoutNode() when custom != null:
        return custom(_that);
      case AppBarNode() when appBar != null:
        return appBar(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StructuralNode node, NodeMetadata meta)? structural,
    TResult Function(PrimitiveNode node, NodeMetadata meta)? primitive,
    TResult Function(InteractiveNode node, NodeMetadata meta)? interactive,
    TResult Function(CustomNode node, NodeMetadata meta)? custom,
    TResult Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)?
        appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode() when structural != null:
        return structural(_that.node, _that.meta);
      case PrimitiveLayoutNode() when primitive != null:
        return primitive(_that.node, _that.meta);
      case InteractiveLayoutNode() when interactive != null:
        return interactive(_that.node, _that.meta);
      case CustomLayoutNode() when custom != null:
        return custom(_that.node, _that.meta);
      case AppBarNode() when appBar != null:
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
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
  TResult when<TResult extends Object?>({
    required TResult Function(StructuralNode node, NodeMetadata meta)
        structural,
    required TResult Function(PrimitiveNode node, NodeMetadata meta) primitive,
    required TResult Function(InteractiveNode node, NodeMetadata meta)
        interactive,
    required TResult Function(CustomNode node, NodeMetadata meta) custom,
    required TResult Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode():
        return structural(_that.node, _that.meta);
      case PrimitiveLayoutNode():
        return primitive(_that.node, _that.meta);
      case InteractiveLayoutNode():
        return interactive(_that.node, _that.meta);
      case CustomLayoutNode():
        return custom(_that.node, _that.meta);
      case AppBarNode():
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StructuralNode node, NodeMetadata meta)? structural,
    TResult? Function(PrimitiveNode node, NodeMetadata meta)? primitive,
    TResult? Function(InteractiveNode node, NodeMetadata meta)? interactive,
    TResult? Function(CustomNode node, NodeMetadata meta)? custom,
    TResult? Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)?
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralLayoutNode() when structural != null:
        return structural(_that.node, _that.meta);
      case PrimitiveLayoutNode() when primitive != null:
        return primitive(_that.node, _that.meta);
      case InteractiveLayoutNode() when interactive != null:
        return interactive(_that.node, _that.meta);
      case CustomLayoutNode() when custom != null:
        return custom(_that.node, _that.meta);
      case AppBarNode() when appBar != null:
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class StructuralLayoutNode implements LayoutNode {
  const StructuralLayoutNode(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'structural';
  factory StructuralLayoutNode.fromJson(Map<String, dynamic> json) =>
      _$StructuralLayoutNodeFromJson(json);

  final StructuralNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StructuralLayoutNodeCopyWith<StructuralLayoutNode> get copyWith =>
      _$StructuralLayoutNodeCopyWithImpl<StructuralLayoutNode>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StructuralLayoutNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StructuralLayoutNode &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'LayoutNode.structural(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $StructuralLayoutNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $StructuralLayoutNodeCopyWith(StructuralLayoutNode value,
          $Res Function(StructuralLayoutNode) _then) =
      _$StructuralLayoutNodeCopyWithImpl;
  @useResult
  $Res call({StructuralNode node, NodeMetadata meta});

  $StructuralNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$StructuralLayoutNodeCopyWithImpl<$Res>
    implements $StructuralLayoutNodeCopyWith<$Res> {
  _$StructuralLayoutNodeCopyWithImpl(this._self, this._then);

  final StructuralLayoutNode _self;
  final $Res Function(StructuralLayoutNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(StructuralLayoutNode(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as StructuralNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StructuralNodeCopyWith<$Res> get node {
    return $StructuralNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class PrimitiveLayoutNode implements LayoutNode {
  const PrimitiveLayoutNode(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'primitive';
  factory PrimitiveLayoutNode.fromJson(Map<String, dynamic> json) =>
      _$PrimitiveLayoutNodeFromJson(json);

  final PrimitiveNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrimitiveLayoutNodeCopyWith<PrimitiveLayoutNode> get copyWith =>
      _$PrimitiveLayoutNodeCopyWithImpl<PrimitiveLayoutNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PrimitiveLayoutNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrimitiveLayoutNode &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'LayoutNode.primitive(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $PrimitiveLayoutNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $PrimitiveLayoutNodeCopyWith(
          PrimitiveLayoutNode value, $Res Function(PrimitiveLayoutNode) _then) =
      _$PrimitiveLayoutNodeCopyWithImpl;
  @useResult
  $Res call({PrimitiveNode node, NodeMetadata meta});

  $PrimitiveNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$PrimitiveLayoutNodeCopyWithImpl<$Res>
    implements $PrimitiveLayoutNodeCopyWith<$Res> {
  _$PrimitiveLayoutNodeCopyWithImpl(this._self, this._then);

  final PrimitiveLayoutNode _self;
  final $Res Function(PrimitiveLayoutNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(PrimitiveLayoutNode(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as PrimitiveNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimitiveNodeCopyWith<$Res> get node {
    return $PrimitiveNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class InteractiveLayoutNode implements LayoutNode {
  const InteractiveLayoutNode(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'interactive';
  factory InteractiveLayoutNode.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLayoutNodeFromJson(json);

  final InteractiveNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InteractiveLayoutNodeCopyWith<InteractiveLayoutNode> get copyWith =>
      _$InteractiveLayoutNodeCopyWithImpl<InteractiveLayoutNode>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InteractiveLayoutNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InteractiveLayoutNode &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'LayoutNode.interactive(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $InteractiveLayoutNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $InteractiveLayoutNodeCopyWith(InteractiveLayoutNode value,
          $Res Function(InteractiveLayoutNode) _then) =
      _$InteractiveLayoutNodeCopyWithImpl;
  @useResult
  $Res call({InteractiveNode node, NodeMetadata meta});

  $InteractiveNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$InteractiveLayoutNodeCopyWithImpl<$Res>
    implements $InteractiveLayoutNodeCopyWith<$Res> {
  _$InteractiveLayoutNodeCopyWithImpl(this._self, this._then);

  final InteractiveLayoutNode _self;
  final $Res Function(InteractiveLayoutNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(InteractiveLayoutNode(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as InteractiveNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractiveNodeCopyWith<$Res> get node {
    return $InteractiveNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class CustomLayoutNode implements LayoutNode {
  const CustomLayoutNode(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'custom';
  factory CustomLayoutNode.fromJson(Map<String, dynamic> json) =>
      _$CustomLayoutNodeFromJson(json);

  final CustomNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomLayoutNodeCopyWith<CustomLayoutNode> get copyWith =>
      _$CustomLayoutNodeCopyWithImpl<CustomLayoutNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomLayoutNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomLayoutNode &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'LayoutNode.custom(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $CustomLayoutNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $CustomLayoutNodeCopyWith(
          CustomLayoutNode value, $Res Function(CustomLayoutNode) _then) =
      _$CustomLayoutNodeCopyWithImpl;
  @useResult
  $Res call({CustomNode node, NodeMetadata meta});

  $CustomNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$CustomLayoutNodeCopyWithImpl<$Res>
    implements $CustomLayoutNodeCopyWith<$Res> {
  _$CustomLayoutNodeCopyWithImpl(this._self, this._then);

  final CustomLayoutNode _self;
  final $Res Function(CustomLayoutNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(CustomLayoutNode(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as CustomNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomNodeCopyWith<$Res> get node {
    return $CustomNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class AppBarNode implements LayoutNode {
  const AppBarNode(
      {this.title,
      final List<AppBarAction>? actions,
      this.leadingIcon,
      this.onLeadingPressed,
      final String? $type})
      : _actions = actions,
        $type = $type ?? 'appBar';
  factory AppBarNode.fromJson(Map<String, dynamic> json) =>
      _$AppBarNodeFromJson(json);

  final String? title;
  final List<AppBarAction>? _actions;
  List<AppBarAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final String? leadingIcon;
  final String? onLeadingPressed;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppBarNodeCopyWith<AppBarNode> get copyWith =>
      _$AppBarNodeCopyWithImpl<AppBarNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppBarNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppBarNode &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.leadingIcon, leadingIcon) ||
                other.leadingIcon == leadingIcon) &&
            (identical(other.onLeadingPressed, onLeadingPressed) ||
                other.onLeadingPressed == onLeadingPressed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_actions),
      leadingIcon,
      onLeadingPressed);

  @override
  String toString() {
    return 'LayoutNode.appBar(title: $title, actions: $actions, leadingIcon: $leadingIcon, onLeadingPressed: $onLeadingPressed)';
  }
}

/// @nodoc
abstract mixin class $AppBarNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $AppBarNodeCopyWith(
          AppBarNode value, $Res Function(AppBarNode) _then) =
      _$AppBarNodeCopyWithImpl;
  @useResult
  $Res call(
      {String? title,
      List<AppBarAction>? actions,
      String? leadingIcon,
      String? onLeadingPressed});
}

/// @nodoc
class _$AppBarNodeCopyWithImpl<$Res> implements $AppBarNodeCopyWith<$Res> {
  _$AppBarNodeCopyWithImpl(this._self, this._then);

  final AppBarNode _self;
  final $Res Function(AppBarNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? actions = freezed,
    Object? leadingIcon = freezed,
    Object? onLeadingPressed = freezed,
  }) {
    return _then(AppBarNode(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<AppBarAction>?,
      leadingIcon: freezed == leadingIcon
          ? _self.leadingIcon
          : leadingIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      onLeadingPressed: freezed == onLeadingPressed
          ? _self.onLeadingPressed
          : onLeadingPressed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
