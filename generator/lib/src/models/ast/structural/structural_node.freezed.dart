// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'structural_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
StructuralNode _$StructuralNodeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'column':
      return ColumnNode.fromJson(json);
    case 'row':
      return RowNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'StructuralNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$StructuralNode {
  List<LayoutNode> get children;
  MainAxisAlignment? get mainAxisAlignment;
  CrossAxisAlignment? get crossAxisAlignment;
  String? get spacing;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StructuralNodeCopyWith<StructuralNode> get copyWith =>
      _$StructuralNodeCopyWithImpl<StructuralNode>(
          this as StructuralNode, _$identity);

  /// Serializes this StructuralNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StructuralNode &&
            const DeepCollectionEquality().equals(other.children, children) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.spacing, spacing) || other.spacing == spacing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @override
  String toString() {
    return 'StructuralNode(children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }
}

/// @nodoc
abstract mixin class $StructuralNodeCopyWith<$Res> {
  factory $StructuralNodeCopyWith(
          StructuralNode value, $Res Function(StructuralNode) _then) =
      _$StructuralNodeCopyWithImpl;
  @useResult
  $Res call(
      {List<LayoutNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class _$StructuralNodeCopyWithImpl<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  _$StructuralNodeCopyWithImpl(this._self, this._then);

  final StructuralNode _self;
  final $Res Function(StructuralNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(_self.copyWith(
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _self.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _self.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StructuralNode].
extension StructuralNodePatterns on StructuralNode {
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
    TResult Function(ColumnNode value)? column,
    TResult Function(RowNode value)? row,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
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
    required TResult Function(ColumnNode value) column,
    required TResult Function(RowNode value) row,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that);
      case RowNode():
        return row(_that);
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
    TResult? Function(ColumnNode value)? column,
    TResult? Function(RowNode value)? row,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
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
    TResult Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        row,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case RowNode() when row != null:
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
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
    required TResult Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        row,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case RowNode():
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
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
    TResult? Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        row,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case RowNode() when row != null:
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class ColumnNode implements StructuralNode {
  const ColumnNode(
      {required final List<LayoutNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'column';
  factory ColumnNode.fromJson(Map<String, dynamic> json) =>
      _$ColumnNodeFromJson(json);

  final List<LayoutNode> _children;
  @override
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final MainAxisAlignment? mainAxisAlignment;
  @override
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  final String? spacing;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColumnNodeCopyWith<ColumnNode> get copyWith =>
      _$ColumnNodeCopyWithImpl<ColumnNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ColumnNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColumnNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.spacing, spacing) || other.spacing == spacing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @override
  String toString() {
    return 'StructuralNode.column(children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }
}

/// @nodoc
abstract mixin class $ColumnNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $ColumnNodeCopyWith(
          ColumnNode value, $Res Function(ColumnNode) _then) =
      _$ColumnNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<LayoutNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class _$ColumnNodeCopyWithImpl<$Res> implements $ColumnNodeCopyWith<$Res> {
  _$ColumnNodeCopyWithImpl(this._self, this._then);

  final ColumnNode _self;
  final $Res Function(ColumnNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(ColumnNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _self.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _self.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class RowNode implements StructuralNode {
  const RowNode(
      {required final List<LayoutNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'row';
  factory RowNode.fromJson(Map<String, dynamic> json) =>
      _$RowNodeFromJson(json);

  final List<LayoutNode> _children;
  @override
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final MainAxisAlignment? mainAxisAlignment;
  @override
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  final String? spacing;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RowNodeCopyWith<RowNode> get copyWith =>
      _$RowNodeCopyWithImpl<RowNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RowNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RowNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.spacing, spacing) || other.spacing == spacing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @override
  String toString() {
    return 'StructuralNode.row(children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }
}

/// @nodoc
abstract mixin class $RowNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $RowNodeCopyWith(RowNode value, $Res Function(RowNode) _then) =
      _$RowNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<LayoutNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class _$RowNodeCopyWithImpl<$Res> implements $RowNodeCopyWith<$Res> {
  _$RowNodeCopyWithImpl(this._self, this._then);

  final RowNode _self;
  final $Res Function(RowNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(RowNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _self.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _self.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
