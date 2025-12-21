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
    case 'container':
      return ContainerNode.fromJson(json);
    case 'card':
      return CardNode.fromJson(json);
    case 'listView':
      return ListViewNode.fromJson(json);
    case 'stack':
      return StackNode.fromJson(json);
    case 'gridView':
      return GridViewNode.fromJson(json);
    case 'padding':
      return PaddingNode.fromJson(json);
    case 'center':
      return CenterNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'StructuralNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$StructuralNode {
  /// Serializes this StructuralNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StructuralNode);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StructuralNode()';
  }
}

/// @nodoc
class $StructuralNodeCopyWith<$Res> {
  $StructuralNodeCopyWith(StructuralNode _, $Res Function(StructuralNode) __);
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
    TResult Function(ContainerNode value)? container,
    TResult Function(CardNode value)? card,
    TResult Function(ListViewNode value)? listView,
    TResult Function(StackNode value)? stack,
    TResult Function(GridViewNode value)? gridView,
    TResult Function(PaddingNode value)? padding,
    TResult Function(CenterNode value)? center,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
      case ContainerNode() when container != null:
        return container(_that);
      case CardNode() when card != null:
        return card(_that);
      case ListViewNode() when listView != null:
        return listView(_that);
      case StackNode() when stack != null:
        return stack(_that);
      case GridViewNode() when gridView != null:
        return gridView(_that);
      case PaddingNode() when padding != null:
        return padding(_that);
      case CenterNode() when center != null:
        return center(_that);
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
    required TResult Function(ContainerNode value) container,
    required TResult Function(CardNode value) card,
    required TResult Function(ListViewNode value) listView,
    required TResult Function(StackNode value) stack,
    required TResult Function(GridViewNode value) gridView,
    required TResult Function(PaddingNode value) padding,
    required TResult Function(CenterNode value) center,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that);
      case RowNode():
        return row(_that);
      case ContainerNode():
        return container(_that);
      case CardNode():
        return card(_that);
      case ListViewNode():
        return listView(_that);
      case StackNode():
        return stack(_that);
      case GridViewNode():
        return gridView(_that);
      case PaddingNode():
        return padding(_that);
      case CenterNode():
        return center(_that);
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
    TResult? Function(ContainerNode value)? container,
    TResult? Function(CardNode value)? card,
    TResult? Function(ListViewNode value)? listView,
    TResult? Function(StackNode value)? stack,
    TResult? Function(GridViewNode value)? gridView,
    TResult? Function(PaddingNode value)? padding,
    TResult? Function(CenterNode value)? center,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
      case ContainerNode() when container != null:
        return container(_that);
      case CardNode() when card != null:
        return card(_that);
      case ListViewNode() when listView != null:
        return listView(_that);
      case StackNode() when stack != null:
        return stack(_that);
      case GridViewNode() when gridView != null:
        return gridView(_that);
      case PaddingNode() when padding != null:
        return padding(_that);
      case CenterNode() when center != null:
        return center(_that);
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
    TResult Function(
            LayoutNode? child,
            double? width,
            double? height,
            String? padding,
            String? margin,
            ColorSemantic? color,
            double? borderRadius,
            ContainerSemantic? semantic)?
        container,
    TResult Function(List<LayoutNode> children, CardVariant? variant,
            String? padding, double? elevation)?
        card,
    TResult Function(List<LayoutNode> children, Axis? scrollDirection,
            String? spacing, bool? shrinkWrap)?
        listView,
    TResult Function(
            List<LayoutNode> children, StackFit? fit, AlignmentEnum? alignment)?
        stack,
    TResult Function(
            List<LayoutNode> children,
            int crossAxisCount,
            String? spacing,
            String? crossAxisSpacing,
            double? childAspectRatio,
            bool? shrinkWrap)?
        gridView,
    TResult Function(LayoutNode child, String padding)? padding,
    TResult Function(LayoutNode child)? center,
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
      case ContainerNode() when container != null:
        return container(_that.child, _that.width, _that.height, _that.padding,
            _that.margin, _that.color, _that.borderRadius, _that.semantic);
      case CardNode() when card != null:
        return card(
            _that.children, _that.variant, _that.padding, _that.elevation);
      case ListViewNode() when listView != null:
        return listView(_that.children, _that.scrollDirection, _that.spacing,
            _that.shrinkWrap);
      case StackNode() when stack != null:
        return stack(_that.children, _that.fit, _that.alignment);
      case GridViewNode() when gridView != null:
        return gridView(_that.children, _that.crossAxisCount, _that.spacing,
            _that.crossAxisSpacing, _that.childAspectRatio, _that.shrinkWrap);
      case PaddingNode() when padding != null:
        return padding(_that.child, _that.padding);
      case CenterNode() when center != null:
        return center(_that.child);
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
    required TResult Function(
            LayoutNode? child,
            double? width,
            double? height,
            String? padding,
            String? margin,
            ColorSemantic? color,
            double? borderRadius,
            ContainerSemantic? semantic)
        container,
    required TResult Function(List<LayoutNode> children, CardVariant? variant,
            String? padding, double? elevation)
        card,
    required TResult Function(List<LayoutNode> children, Axis? scrollDirection,
            String? spacing, bool? shrinkWrap)
        listView,
    required TResult Function(
            List<LayoutNode> children, StackFit? fit, AlignmentEnum? alignment)
        stack,
    required TResult Function(
            List<LayoutNode> children,
            int crossAxisCount,
            String? spacing,
            String? crossAxisSpacing,
            double? childAspectRatio,
            bool? shrinkWrap)
        gridView,
    required TResult Function(LayoutNode child, String padding) padding,
    required TResult Function(LayoutNode child) center,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case RowNode():
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case ContainerNode():
        return container(_that.child, _that.width, _that.height, _that.padding,
            _that.margin, _that.color, _that.borderRadius, _that.semantic);
      case CardNode():
        return card(
            _that.children, _that.variant, _that.padding, _that.elevation);
      case ListViewNode():
        return listView(_that.children, _that.scrollDirection, _that.spacing,
            _that.shrinkWrap);
      case StackNode():
        return stack(_that.children, _that.fit, _that.alignment);
      case GridViewNode():
        return gridView(_that.children, _that.crossAxisCount, _that.spacing,
            _that.crossAxisSpacing, _that.childAspectRatio, _that.shrinkWrap);
      case PaddingNode():
        return padding(_that.child, _that.padding);
      case CenterNode():
        return center(_that.child);
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
    TResult? Function(
            LayoutNode? child,
            double? width,
            double? height,
            String? padding,
            String? margin,
            ColorSemantic? color,
            double? borderRadius,
            ContainerSemantic? semantic)?
        container,
    TResult? Function(List<LayoutNode> children, CardVariant? variant,
            String? padding, double? elevation)?
        card,
    TResult? Function(List<LayoutNode> children, Axis? scrollDirection,
            String? spacing, bool? shrinkWrap)?
        listView,
    TResult? Function(
            List<LayoutNode> children, StackFit? fit, AlignmentEnum? alignment)?
        stack,
    TResult? Function(
            List<LayoutNode> children,
            int crossAxisCount,
            String? spacing,
            String? crossAxisSpacing,
            double? childAspectRatio,
            bool? shrinkWrap)?
        gridView,
    TResult? Function(LayoutNode child, String padding)? padding,
    TResult? Function(LayoutNode child)? center,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case RowNode() when row != null:
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.spacing);
      case ContainerNode() when container != null:
        return container(_that.child, _that.width, _that.height, _that.padding,
            _that.margin, _that.color, _that.borderRadius, _that.semantic);
      case CardNode() when card != null:
        return card(
            _that.children, _that.variant, _that.padding, _that.elevation);
      case ListViewNode() when listView != null:
        return listView(_that.children, _that.scrollDirection, _that.spacing,
            _that.shrinkWrap);
      case StackNode() when stack != null:
        return stack(_that.children, _that.fit, _that.alignment);
      case GridViewNode() when gridView != null:
        return gridView(_that.children, _that.crossAxisCount, _that.spacing,
            _that.crossAxisSpacing, _that.childAspectRatio, _that.shrinkWrap);
      case PaddingNode() when padding != null:
        return padding(_that.child, _that.padding);
      case CenterNode() when center != null:
        return center(_that.child);
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
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
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
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
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

/// @nodoc
@JsonSerializable()
class ContainerNode implements StructuralNode {
  const ContainerNode(
      {this.child,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.color,
      this.borderRadius,
      this.semantic,
      final String? $type})
      : $type = $type ?? 'container';
  factory ContainerNode.fromJson(Map<String, dynamic> json) =>
      _$ContainerNodeFromJson(json);

  final LayoutNode? child;
  final double? width;
  final double? height;
  final String? padding;
  final String? margin;
  final ColorSemantic? color;
  final double? borderRadius;
  final ContainerSemantic? semantic;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContainerNodeCopyWith<ContainerNode> get copyWith =>
      _$ContainerNodeCopyWithImpl<ContainerNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContainerNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContainerNode &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.margin, margin) || other.margin == margin) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.borderRadius, borderRadius) ||
                other.borderRadius == borderRadius) &&
            (identical(other.semantic, semantic) ||
                other.semantic == semantic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child, width, height, padding,
      margin, color, borderRadius, semantic);

  @override
  String toString() {
    return 'StructuralNode.container(child: $child, width: $width, height: $height, padding: $padding, margin: $margin, color: $color, borderRadius: $borderRadius, semantic: $semantic)';
  }
}

/// @nodoc
abstract mixin class $ContainerNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $ContainerNodeCopyWith(
          ContainerNode value, $Res Function(ContainerNode) _then) =
      _$ContainerNodeCopyWithImpl;
  @useResult
  $Res call(
      {LayoutNode? child,
      double? width,
      double? height,
      String? padding,
      String? margin,
      ColorSemantic? color,
      double? borderRadius,
      ContainerSemantic? semantic});

  $LayoutNodeCopyWith<$Res>? get child;
}

/// @nodoc
class _$ContainerNodeCopyWithImpl<$Res>
    implements $ContainerNodeCopyWith<$Res> {
  _$ContainerNodeCopyWithImpl(this._self, this._then);

  final ContainerNode _self;
  final $Res Function(ContainerNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? padding = freezed,
    Object? margin = freezed,
    Object? color = freezed,
    Object? borderRadius = freezed,
    Object? semantic = freezed,
  }) {
    return _then(ContainerNode(
      child: freezed == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutNode?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      padding: freezed == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      margin: freezed == margin
          ? _self.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
      borderRadius: freezed == borderRadius
          ? _self.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      semantic: freezed == semantic
          ? _self.semantic
          : semantic // ignore: cast_nullable_to_non_nullable
              as ContainerSemantic?,
    ));
  }

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutNodeCopyWith<$Res>? get child {
    if (_self.child == null) {
      return null;
    }

    return $LayoutNodeCopyWith<$Res>(_self.child!, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class CardNode implements StructuralNode {
  const CardNode(
      {required final List<LayoutNode> children,
      this.variant,
      this.padding,
      this.elevation,
      final String? $type})
      : _children = children,
        $type = $type ?? 'card';
  factory CardNode.fromJson(Map<String, dynamic> json) =>
      _$CardNodeFromJson(json);

  final List<LayoutNode> _children;
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final CardVariant? variant;
  final String? padding;
  final double? elevation;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardNodeCopyWith<CardNode> get copyWith =>
      _$CardNodeCopyWithImpl<CardNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      variant,
      padding,
      elevation);

  @override
  String toString() {
    return 'StructuralNode.card(children: $children, variant: $variant, padding: $padding, elevation: $elevation)';
  }
}

/// @nodoc
abstract mixin class $CardNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $CardNodeCopyWith(CardNode value, $Res Function(CardNode) _then) =
      _$CardNodeCopyWithImpl;
  @useResult
  $Res call(
      {List<LayoutNode> children,
      CardVariant? variant,
      String? padding,
      double? elevation});
}

/// @nodoc
class _$CardNodeCopyWithImpl<$Res> implements $CardNodeCopyWith<$Res> {
  _$CardNodeCopyWithImpl(this._self, this._then);

  final CardNode _self;
  final $Res Function(CardNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? variant = freezed,
    Object? padding = freezed,
    Object? elevation = freezed,
  }) {
    return _then(CardNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as CardVariant?,
      padding: freezed == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      elevation: freezed == elevation
          ? _self.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ListViewNode implements StructuralNode {
  const ListViewNode(
      {required final List<LayoutNode> children,
      this.scrollDirection,
      this.spacing,
      this.shrinkWrap,
      final String? $type})
      : _children = children,
        $type = $type ?? 'listView';
  factory ListViewNode.fromJson(Map<String, dynamic> json) =>
      _$ListViewNodeFromJson(json);

  final List<LayoutNode> _children;
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final Axis? scrollDirection;
  final String? spacing;
  final bool? shrinkWrap;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListViewNodeCopyWith<ListViewNode> get copyWith =>
      _$ListViewNodeCopyWithImpl<ListViewNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ListViewNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListViewNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.scrollDirection, scrollDirection) ||
                other.scrollDirection == scrollDirection) &&
            (identical(other.spacing, spacing) || other.spacing == spacing) &&
            (identical(other.shrinkWrap, shrinkWrap) ||
                other.shrinkWrap == shrinkWrap));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      scrollDirection,
      spacing,
      shrinkWrap);

  @override
  String toString() {
    return 'StructuralNode.listView(children: $children, scrollDirection: $scrollDirection, spacing: $spacing, shrinkWrap: $shrinkWrap)';
  }
}

/// @nodoc
abstract mixin class $ListViewNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $ListViewNodeCopyWith(
          ListViewNode value, $Res Function(ListViewNode) _then) =
      _$ListViewNodeCopyWithImpl;
  @useResult
  $Res call(
      {List<LayoutNode> children,
      Axis? scrollDirection,
      String? spacing,
      bool? shrinkWrap});
}

/// @nodoc
class _$ListViewNodeCopyWithImpl<$Res> implements $ListViewNodeCopyWith<$Res> {
  _$ListViewNodeCopyWithImpl(this._self, this._then);

  final ListViewNode _self;
  final $Res Function(ListViewNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? scrollDirection = freezed,
    Object? spacing = freezed,
    Object? shrinkWrap = freezed,
  }) {
    return _then(ListViewNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      scrollDirection: freezed == scrollDirection
          ? _self.scrollDirection
          : scrollDirection // ignore: cast_nullable_to_non_nullable
              as Axis?,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
      shrinkWrap: freezed == shrinkWrap
          ? _self.shrinkWrap
          : shrinkWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class StackNode implements StructuralNode {
  const StackNode(
      {required final List<LayoutNode> children,
      this.fit,
      this.alignment,
      final String? $type})
      : _children = children,
        $type = $type ?? 'stack';
  factory StackNode.fromJson(Map<String, dynamic> json) =>
      _$StackNodeFromJson(json);

  final List<LayoutNode> _children;
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final StackFit? fit;
  final AlignmentEnum? alignment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StackNodeCopyWith<StackNode> get copyWith =>
      _$StackNodeCopyWithImpl<StackNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StackNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StackNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.fit, fit) || other.fit == fit) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_children), fit, alignment);

  @override
  String toString() {
    return 'StructuralNode.stack(children: $children, fit: $fit, alignment: $alignment)';
  }
}

/// @nodoc
abstract mixin class $StackNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $StackNodeCopyWith(StackNode value, $Res Function(StackNode) _then) =
      _$StackNodeCopyWithImpl;
  @useResult
  $Res call(
      {List<LayoutNode> children, StackFit? fit, AlignmentEnum? alignment});
}

/// @nodoc
class _$StackNodeCopyWithImpl<$Res> implements $StackNodeCopyWith<$Res> {
  _$StackNodeCopyWithImpl(this._self, this._then);

  final StackNode _self;
  final $Res Function(StackNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? fit = freezed,
    Object? alignment = freezed,
  }) {
    return _then(StackNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      fit: freezed == fit
          ? _self.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as StackFit?,
      alignment: freezed == alignment
          ? _self.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as AlignmentEnum?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class GridViewNode implements StructuralNode {
  const GridViewNode(
      {required final List<LayoutNode> children,
      required this.crossAxisCount,
      this.spacing,
      this.crossAxisSpacing,
      this.childAspectRatio,
      this.shrinkWrap,
      final String? $type})
      : _children = children,
        $type = $type ?? 'gridView';
  factory GridViewNode.fromJson(Map<String, dynamic> json) =>
      _$GridViewNodeFromJson(json);

  final List<LayoutNode> _children;
  List<LayoutNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final int crossAxisCount;
  final String? spacing;
  final String? crossAxisSpacing;
  final double? childAspectRatio;
  final bool? shrinkWrap;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GridViewNodeCopyWith<GridViewNode> get copyWith =>
      _$GridViewNodeCopyWithImpl<GridViewNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GridViewNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GridViewNode &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.crossAxisCount, crossAxisCount) ||
                other.crossAxisCount == crossAxisCount) &&
            (identical(other.spacing, spacing) || other.spacing == spacing) &&
            (identical(other.crossAxisSpacing, crossAxisSpacing) ||
                other.crossAxisSpacing == crossAxisSpacing) &&
            (identical(other.childAspectRatio, childAspectRatio) ||
                other.childAspectRatio == childAspectRatio) &&
            (identical(other.shrinkWrap, shrinkWrap) ||
                other.shrinkWrap == shrinkWrap));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      crossAxisCount,
      spacing,
      crossAxisSpacing,
      childAspectRatio,
      shrinkWrap);

  @override
  String toString() {
    return 'StructuralNode.gridView(children: $children, crossAxisCount: $crossAxisCount, spacing: $spacing, crossAxisSpacing: $crossAxisSpacing, childAspectRatio: $childAspectRatio, shrinkWrap: $shrinkWrap)';
  }
}

/// @nodoc
abstract mixin class $GridViewNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $GridViewNodeCopyWith(
          GridViewNode value, $Res Function(GridViewNode) _then) =
      _$GridViewNodeCopyWithImpl;
  @useResult
  $Res call(
      {List<LayoutNode> children,
      int crossAxisCount,
      String? spacing,
      String? crossAxisSpacing,
      double? childAspectRatio,
      bool? shrinkWrap});
}

/// @nodoc
class _$GridViewNodeCopyWithImpl<$Res> implements $GridViewNodeCopyWith<$Res> {
  _$GridViewNodeCopyWithImpl(this._self, this._then);

  final GridViewNode _self;
  final $Res Function(GridViewNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? crossAxisCount = null,
    Object? spacing = freezed,
    Object? crossAxisSpacing = freezed,
    Object? childAspectRatio = freezed,
    Object? shrinkWrap = freezed,
  }) {
    return _then(GridViewNode(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LayoutNode>,
      crossAxisCount: null == crossAxisCount
          ? _self.crossAxisCount
          : crossAxisCount // ignore: cast_nullable_to_non_nullable
              as int,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
      crossAxisSpacing: freezed == crossAxisSpacing
          ? _self.crossAxisSpacing
          : crossAxisSpacing // ignore: cast_nullable_to_non_nullable
              as String?,
      childAspectRatio: freezed == childAspectRatio
          ? _self.childAspectRatio
          : childAspectRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      shrinkWrap: freezed == shrinkWrap
          ? _self.shrinkWrap
          : shrinkWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class PaddingNode implements StructuralNode {
  const PaddingNode(
      {required this.child, required this.padding, final String? $type})
      : $type = $type ?? 'padding';
  factory PaddingNode.fromJson(Map<String, dynamic> json) =>
      _$PaddingNodeFromJson(json);

  final LayoutNode child;
  final String padding;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaddingNodeCopyWith<PaddingNode> get copyWith =>
      _$PaddingNodeCopyWithImpl<PaddingNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaddingNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaddingNode &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child, padding);

  @override
  String toString() {
    return 'StructuralNode.padding(child: $child, padding: $padding)';
  }
}

/// @nodoc
abstract mixin class $PaddingNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $PaddingNodeCopyWith(
          PaddingNode value, $Res Function(PaddingNode) _then) =
      _$PaddingNodeCopyWithImpl;
  @useResult
  $Res call({LayoutNode child, String padding});

  $LayoutNodeCopyWith<$Res> get child;
}

/// @nodoc
class _$PaddingNodeCopyWithImpl<$Res> implements $PaddingNodeCopyWith<$Res> {
  _$PaddingNodeCopyWithImpl(this._self, this._then);

  final PaddingNode _self;
  final $Res Function(PaddingNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? padding = null,
  }) {
    return _then(PaddingNode(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutNode,
      padding: null == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutNodeCopyWith<$Res> get child {
    return $LayoutNodeCopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class CenterNode implements StructuralNode {
  const CenterNode({required this.child, final String? $type})
      : $type = $type ?? 'center';
  factory CenterNode.fromJson(Map<String, dynamic> json) =>
      _$CenterNodeFromJson(json);

  final LayoutNode child;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CenterNodeCopyWith<CenterNode> get copyWith =>
      _$CenterNodeCopyWithImpl<CenterNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CenterNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CenterNode &&
            (identical(other.child, child) || other.child == child));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child);

  @override
  String toString() {
    return 'StructuralNode.center(child: $child)';
  }
}

/// @nodoc
abstract mixin class $CenterNodeCopyWith<$Res>
    implements $StructuralNodeCopyWith<$Res> {
  factory $CenterNodeCopyWith(
          CenterNode value, $Res Function(CenterNode) _then) =
      _$CenterNodeCopyWithImpl;
  @useResult
  $Res call({LayoutNode child});

  $LayoutNodeCopyWith<$Res> get child;
}

/// @nodoc
class _$CenterNodeCopyWithImpl<$Res> implements $CenterNodeCopyWith<$Res> {
  _$CenterNodeCopyWithImpl(this._self, this._then);

  final CenterNode _self;
  final $Res Function(CenterNode) _then;

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
  }) {
    return _then(CenterNode(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutNode,
    ));
  }

  /// Create a copy of StructuralNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutNodeCopyWith<$Res> get child {
    return $LayoutNodeCopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

// dart format on
