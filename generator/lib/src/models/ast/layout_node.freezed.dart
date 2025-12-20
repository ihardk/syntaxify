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
    case 'column':
      return ColumnNode.fromJson(json);
    case 'row':
      return RowNode.fromJson(json);
    case 'text':
      return TextNode.fromJson(json);
    case 'button':
      return ButtonNode.fromJson(json);
    case 'textField':
      return TextFieldNode.fromJson(json);
    case 'icon':
      return IconNode.fromJson(json);
    case 'spacer':
      return SpacerNode.fromJson(json);
    case 'appBar':
      return AppBarNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LayoutNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LayoutNode {
  String? get id;
  String? get visibleWhen;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LayoutNodeCopyWith<LayoutNode> get copyWith =>
      _$LayoutNodeCopyWithImpl<LayoutNode>(this as LayoutNode, _$identity);

  /// Serializes this LayoutNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LayoutNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, visibleWhen);

  @override
  String toString() {
    return 'LayoutNode(id: $id, visibleWhen: $visibleWhen)';
  }
}

/// @nodoc
abstract mixin class $LayoutNodeCopyWith<$Res> {
  factory $LayoutNodeCopyWith(LayoutNode value, $Res Function(LayoutNode) _then) =
      _$LayoutNodeCopyWithImpl;
  @useResult
  $Res call({String? id, String? visibleWhen});
}

/// @nodoc
class _$LayoutNodeCopyWithImpl<$Res> implements $LayoutNodeCopyWith<$Res> {
  _$LayoutNodeCopyWithImpl(this._self, this._then);

  final LayoutNode _self;
  final $Res Function(LayoutNode) _then;

  /// Create a copy of LayoutNode
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
    TResult Function(ColumnNode value)? column,
    TResult Function(RowNode value)? row,
    TResult Function(TextNode value)? text,
    TResult Function(ButtonNode value)? button,
    TResult Function(TextFieldNode value)? textField,
    TResult Function(IconNode value)? icon,
    TResult Function(SpacerNode value)? spacer,
    TResult Function(AppBarNode value)? appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
      case TextNode() when text != null:
        return text(_that);
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
      case IconNode() when icon != null:
        return icon(_that);
      case SpacerNode() when spacer != null:
        return spacer(_that);
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
    required TResult Function(ColumnNode value) column,
    required TResult Function(RowNode value) row,
    required TResult Function(TextNode value) text,
    required TResult Function(ButtonNode value) button,
    required TResult Function(TextFieldNode value) textField,
    required TResult Function(IconNode value) icon,
    required TResult Function(SpacerNode value) spacer,
    required TResult Function(AppBarNode value) appBar,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that);
      case RowNode():
        return row(_that);
      case TextNode():
        return text(_that);
      case ButtonNode():
        return button(_that);
      case TextFieldNode():
        return textField(_that);
      case IconNode():
        return icon(_that);
      case SpacerNode():
        return spacer(_that);
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
    TResult? Function(ColumnNode value)? column,
    TResult? Function(RowNode value)? row,
    TResult? Function(TextNode value)? text,
    TResult? Function(ButtonNode value)? button,
    TResult? Function(TextFieldNode value)? textField,
    TResult? Function(IconNode value)? icon,
    TResult? Function(SpacerNode value)? spacer,
    TResult? Function(AppBarNode value)? appBar,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that);
      case RowNode() when row != null:
        return row(_that);
      case TextNode() when text != null:
        return text(_that);
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
      case IconNode() when icon != null:
        return icon(_that);
      case SpacerNode() when spacer != null:
        return spacer(_that);
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
    TResult Function(
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        row,
    TResult Function(
            String? id,
            String? visibleWhen,
            String text,
            TextVariant? variant,
            TextAlign? align,
            int? maxLines,
            TextOverflow? overflow)?
        text,
    TResult Function(
            String? id,
            String? visibleWhen,
            String label,
            String? onPressed,
            ButtonVariant? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool? isLoading,
            bool? isDisabled,
            bool? fullWidth)?
        button,
    TResult Function(
            String? id,
            String? visibleWhen,
            String? label,
            String? hint,
            String? helperText,
            String? binding,
            String? onChanged,
            String? onSubmitted,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool? obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            TextFieldVariant? variant)?
        textField,
    TResult Function(String? id, String? visibleWhen, String name,
            IconSize? size, ColorSemantic? semantic)?
        icon,
    TResult Function(
            String? id, String? visibleWhen, SpacerSize? size, int? flex)?
        spacer,
    TResult Function(
            String? id,
            String? visibleWhen,
            String? title,
            String? leadingIcon,
            String? leadingAction,
            List<AppBarAction>? actions)?
        appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case RowNode() when row != null:
        return row(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case TextNode() when text != null:
        return text(_that.id, _that.visibleWhen, _that.text, _that.variant,
            _that.align, _that.maxLines, _that.overflow);
      case ButtonNode() when button != null:
        return button(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.onPressed,
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
      case TextFieldNode() when textField != null:
        return textField(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.hint,
            _that.helperText,
            _that.binding,
            _that.onChanged,
            _that.onSubmitted,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
      case IconNode() when icon != null:
        return icon(_that.id, _that.visibleWhen, _that.name, _that.size,
            _that.semantic);
      case SpacerNode() when spacer != null:
        return spacer(_that.id, _that.visibleWhen, _that.size, _that.flex);
      case AppBarNode() when appBar != null:
        return appBar(_that.id, _that.visibleWhen, _that.title,
            _that.leadingIcon, _that.leadingAction, _that.actions);
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
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        row,
    required TResult Function(
            String? id,
            String? visibleWhen,
            String text,
            TextVariant? variant,
            TextAlign? align,
            int? maxLines,
            TextOverflow? overflow)
        text,
    required TResult Function(
            String? id,
            String? visibleWhen,
            String label,
            String? onPressed,
            ButtonVariant? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool? isLoading,
            bool? isDisabled,
            bool? fullWidth)
        button,
    required TResult Function(
            String? id,
            String? visibleWhen,
            String? label,
            String? hint,
            String? helperText,
            String? binding,
            String? onChanged,
            String? onSubmitted,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool? obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            TextFieldVariant? variant)
        textField,
    required TResult Function(String? id, String? visibleWhen, String name,
            IconSize? size, ColorSemantic? semantic)
        icon,
    required TResult Function(
            String? id, String? visibleWhen, SpacerSize? size, int? flex)
        spacer,
    required TResult Function(
            String? id,
            String? visibleWhen,
            String? title,
            String? leadingIcon,
            String? leadingAction,
            List<AppBarAction>? actions)
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode():
        return column(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case RowNode():
        return row(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case TextNode():
        return text(_that.id, _that.visibleWhen, _that.text, _that.variant,
            _that.align, _that.maxLines, _that.overflow);
      case ButtonNode():
        return button(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.onPressed,
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
      case TextFieldNode():
        return textField(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.hint,
            _that.helperText,
            _that.binding,
            _that.onChanged,
            _that.onSubmitted,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
      case IconNode():
        return icon(_that.id, _that.visibleWhen, _that.name, _that.size,
            _that.semantic);
      case SpacerNode():
        return spacer(_that.id, _that.visibleWhen, _that.size, _that.flex);
      case AppBarNode():
        return appBar(_that.id, _that.visibleWhen, _that.title,
            _that.leadingIcon, _that.leadingAction, _that.actions);
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
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<LayoutNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        row,
    TResult? Function(
            String? id,
            String? visibleWhen,
            String text,
            TextVariant? variant,
            TextAlign? align,
            int? maxLines,
            TextOverflow? overflow)?
        text,
    TResult? Function(
            String? id,
            String? visibleWhen,
            String label,
            String? onPressed,
            ButtonVariant? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool? isLoading,
            bool? isDisabled,
            bool? fullWidth)?
        button,
    TResult? Function(
            String? id,
            String? visibleWhen,
            String? label,
            String? hint,
            String? helperText,
            String? binding,
            String? onChanged,
            String? onSubmitted,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool? obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            TextFieldVariant? variant)?
        textField,
    TResult? Function(String? id, String? visibleWhen, String name,
            IconSize? size, ColorSemantic? semantic)?
        icon,
    TResult? Function(
            String? id, String? visibleWhen, SpacerSize? size, int? flex)?
        spacer,
    TResult? Function(
            String? id,
            String? visibleWhen,
            String? title,
            String? leadingIcon,
            String? leadingAction,
            List<AppBarAction>? actions)?
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case ColumnNode() when column != null:
        return column(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case RowNode() when row != null:
        return row(_that.id, _that.visibleWhen, _that.children,
            _that.mainAxisAlignment, _that.crossAxisAlignment, _that.spacing);
      case TextNode() when text != null:
        return text(_that.id, _that.visibleWhen, _that.text, _that.variant,
            _that.align, _that.maxLines, _that.overflow);
      case ButtonNode() when button != null:
        return button(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.onPressed,
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
      case TextFieldNode() when textField != null:
        return textField(
            _that.id,
            _that.visibleWhen,
            _that.label,
            _that.hint,
            _that.helperText,
            _that.binding,
            _that.onChanged,
            _that.onSubmitted,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
      case IconNode() when icon != null:
        return icon(_that.id, _that.visibleWhen, _that.name, _that.size,
            _that.semantic);
      case SpacerNode() when spacer != null:
        return spacer(_that.id, _that.visibleWhen, _that.size, _that.flex);
      case AppBarNode() when appBar != null:
        return appBar(_that.id, _that.visibleWhen, _that.title,
            _that.leadingIcon, _that.leadingAction, _that.actions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class ColumnNode implements LayoutNode {
  const ColumnNode(
      {this.id,
      this.visibleWhen,
      required final List<LayoutNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'column';
  factory ColumnNode.fromJson(Map<String, dynamic> json) =>
      _$ColumnNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
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

  /// Create a copy of LayoutNode
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
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
      id,
      visibleWhen,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @override
  String toString() {
    return 'LayoutNode.column(id: $id, visibleWhen: $visibleWhen, children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }
}

/// @nodoc
abstract mixin class $ColumnNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $ColumnNodeCopyWith(
          ColumnNode value, $Res Function(ColumnNode) _then) =
      _$ColumnNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      List<LayoutNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class _$ColumnNodeCopyWithImpl<$Res> implements $ColumnNodeCopyWith<$Res> {
  _$ColumnNodeCopyWithImpl(this._self, this._then);

  final ColumnNode _self;
  final $Res Function(ColumnNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(ColumnNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
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
class RowNode implements LayoutNode {
  const RowNode(
      {this.id,
      this.visibleWhen,
      required final List<LayoutNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'row';
  factory RowNode.fromJson(Map<String, dynamic> json) =>
      _$RowNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
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

  /// Create a copy of LayoutNode
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
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
      id,
      visibleWhen,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @override
  String toString() {
    return 'LayoutNode.row(id: $id, visibleWhen: $visibleWhen, children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }
}

/// @nodoc
abstract mixin class $RowNodeCopyWith<$Res> implements $LayoutNodeCopyWith<$Res> {
  factory $RowNodeCopyWith(RowNode value, $Res Function(RowNode) _then) =
      _$RowNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      List<LayoutNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class _$RowNodeCopyWithImpl<$Res> implements $RowNodeCopyWith<$Res> {
  _$RowNodeCopyWithImpl(this._self, this._then);

  final RowNode _self;
  final $Res Function(RowNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(RowNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
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
class TextNode implements LayoutNode {
  const TextNode(
      {this.id,
      this.visibleWhen,
      required this.text,
      this.variant,
      this.align,
      this.maxLines,
      this.overflow,
      final String? $type})
      : $type = $type ?? 'text';
  factory TextNode.fromJson(Map<String, dynamic> json) =>
      _$TextNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextNodeCopyWith<TextNode> get copyWith =>
      _$TextNodeCopyWithImpl<TextNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.align, align) || other.align == align) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, visibleWhen, text, variant, align, maxLines, overflow);

  @override
  String toString() {
    return 'LayoutNode.text(id: $id, visibleWhen: $visibleWhen, text: $text, variant: $variant, align: $align, maxLines: $maxLines, overflow: $overflow)';
  }
}

/// @nodoc
abstract mixin class $TextNodeCopyWith<$Res> implements $LayoutNodeCopyWith<$Res> {
  factory $TextNodeCopyWith(TextNode value, $Res Function(TextNode) _then) =
      _$TextNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      String text,
      TextVariant? variant,
      TextAlign? align,
      int? maxLines,
      TextOverflow? overflow});
}

/// @nodoc
class _$TextNodeCopyWithImpl<$Res> implements $TextNodeCopyWith<$Res> {
  _$TextNodeCopyWithImpl(this._self, this._then);

  final TextNode _self;
  final $Res Function(TextNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? text = null,
    Object? variant = freezed,
    Object? align = freezed,
    Object? maxLines = freezed,
    Object? overflow = freezed,
  }) {
    return _then(TextNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as TextVariant?,
      align: freezed == align
          ? _self.align
          : align // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      overflow: freezed == overflow
          ? _self.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ButtonNode implements LayoutNode {
  const ButtonNode(
      {this.id,
      this.visibleWhen,
      required this.label,
      this.onPressed,
      this.variant,
      this.size,
      this.icon,
      this.iconPosition,
      this.isLoading,
      this.isDisabled,
      this.fullWidth,
      final String? $type})
      : $type = $type ?? 'button';
  factory ButtonNode.fromJson(Map<String, dynamic> json) =>
      _$ButtonNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final String label;
  final String? onPressed;
  final ButtonVariant? variant;
  final ButtonSize? size;
  final String? icon;
  final IconPosition? iconPosition;
  final bool? isLoading;
  final bool? isDisabled;
  final bool? fullWidth;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonNodeCopyWith<ButtonNode> get copyWith =>
      _$ButtonNodeCopyWithImpl<ButtonNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ButtonNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconPosition, iconPosition) ||
                other.iconPosition == iconPosition) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled) &&
            (identical(other.fullWidth, fullWidth) ||
                other.fullWidth == fullWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      label,
      onPressed,
      variant,
      size,
      icon,
      iconPosition,
      isLoading,
      isDisabled,
      fullWidth);

  @override
  String toString() {
    return 'LayoutNode.button(id: $id, visibleWhen: $visibleWhen, label: $label, onPressed: $onPressed, variant: $variant, size: $size, icon: $icon, iconPosition: $iconPosition, isLoading: $isLoading, isDisabled: $isDisabled, fullWidth: $fullWidth)';
  }
}

/// @nodoc
abstract mixin class $ButtonNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $ButtonNodeCopyWith(
          ButtonNode value, $Res Function(ButtonNode) _then) =
      _$ButtonNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      String label,
      String? onPressed,
      ButtonVariant? variant,
      ButtonSize? size,
      String? icon,
      IconPosition? iconPosition,
      bool? isLoading,
      bool? isDisabled,
      bool? fullWidth});
}

/// @nodoc
class _$ButtonNodeCopyWithImpl<$Res> implements $ButtonNodeCopyWith<$Res> {
  _$ButtonNodeCopyWithImpl(this._self, this._then);

  final ButtonNode _self;
  final $Res Function(ButtonNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? label = null,
    Object? onPressed = freezed,
    Object? variant = freezed,
    Object? size = freezed,
    Object? icon = freezed,
    Object? iconPosition = freezed,
    Object? isLoading = freezed,
    Object? isDisabled = freezed,
    Object? fullWidth = freezed,
  }) {
    return _then(ButtonNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: freezed == onPressed
          ? _self.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String?,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as ButtonVariant?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as ButtonSize?,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPosition: freezed == iconPosition
          ? _self.iconPosition
          : iconPosition // ignore: cast_nullable_to_non_nullable
              as IconPosition?,
      isLoading: freezed == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDisabled: freezed == isDisabled
          ? _self.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      fullWidth: freezed == fullWidth
          ? _self.fullWidth
          : fullWidth // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class TextFieldNode implements LayoutNode {
  const TextFieldNode(
      {this.id,
      this.visibleWhen,
      this.label,
      this.hint,
      this.helperText,
      this.binding,
      this.onChanged,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.textInputAction,
      this.obscureText,
      this.errorText,
      this.maxLines,
      this.maxLength,
      this.variant,
      final String? $type})
      : $type = $type ?? 'textField';
  factory TextFieldNode.fromJson(Map<String, dynamic> json) =>
      _$TextFieldNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? binding;
  final String? onChanged;
  final String? onSubmitted;
  final String? prefixIcon;
  final String? suffixIcon;
  final KeyboardType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final TextFieldVariant? variant;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextFieldNodeCopyWith<TextFieldNode> get copyWith =>
      _$TextFieldNodeCopyWithImpl<TextFieldNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextFieldNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextFieldNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.helperText, helperText) ||
                other.helperText == helperText) &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged) &&
            (identical(other.onSubmitted, onSubmitted) ||
                other.onSubmitted == onSubmitted) &&
            (identical(other.prefixIcon, prefixIcon) ||
                other.prefixIcon == prefixIcon) &&
            (identical(other.suffixIcon, suffixIcon) ||
                other.suffixIcon == suffixIcon) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            (identical(other.textInputAction, textInputAction) ||
                other.textInputAction == textInputAction) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength) &&
            (identical(other.variant, variant) || other.variant == variant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      label,
      hint,
      helperText,
      binding,
      onChanged,
      onSubmitted,
      prefixIcon,
      suffixIcon,
      keyboardType,
      textInputAction,
      obscureText,
      errorText,
      maxLines,
      maxLength,
      variant);

  @override
  String toString() {
    return 'LayoutNode.textField(id: $id, visibleWhen: $visibleWhen, label: $label, hint: $hint, helperText: $helperText, binding: $binding, onChanged: $onChanged, onSubmitted: $onSubmitted, prefixIcon: $prefixIcon, suffixIcon: $suffixIcon, keyboardType: $keyboardType, textInputAction: $textInputAction, obscureText: $obscureText, errorText: $errorText, maxLines: $maxLines, maxLength: $maxLength, variant: $variant)';
  }
}

/// @nodoc
abstract mixin class $TextFieldNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $TextFieldNodeCopyWith(
          TextFieldNode value, $Res Function(TextFieldNode) _then) =
      _$TextFieldNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      String? label,
      String? hint,
      String? helperText,
      String? binding,
      String? onChanged,
      String? onSubmitted,
      String? prefixIcon,
      String? suffixIcon,
      KeyboardType? keyboardType,
      TextInputAction? textInputAction,
      bool? obscureText,
      String? errorText,
      int? maxLines,
      int? maxLength,
      TextFieldVariant? variant});
}

/// @nodoc
class _$TextFieldNodeCopyWithImpl<$Res>
    implements $TextFieldNodeCopyWith<$Res> {
  _$TextFieldNodeCopyWithImpl(this._self, this._then);

  final TextFieldNode _self;
  final $Res Function(TextFieldNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? label = freezed,
    Object? hint = freezed,
    Object? helperText = freezed,
    Object? binding = freezed,
    Object? onChanged = freezed,
    Object? onSubmitted = freezed,
    Object? prefixIcon = freezed,
    Object? suffixIcon = freezed,
    Object? keyboardType = freezed,
    Object? textInputAction = freezed,
    Object? obscureText = freezed,
    Object? errorText = freezed,
    Object? maxLines = freezed,
    Object? maxLength = freezed,
    Object? variant = freezed,
  }) {
    return _then(TextFieldNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      hint: freezed == hint
          ? _self.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _self.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      binding: freezed == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onSubmitted: freezed == onSubmitted
          ? _self.onSubmitted
          : onSubmitted // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixIcon: freezed == prefixIcon
          ? _self.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixIcon: freezed == suffixIcon
          ? _self.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _self.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as KeyboardType?,
      textInputAction: freezed == textInputAction
          ? _self.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
      obscureText: freezed == obscureText
          ? _self.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool?,
      errorText: freezed == errorText
          ? _self.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _self.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as TextFieldVariant?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class IconNode implements LayoutNode {
  const IconNode(
      {this.id,
      this.visibleWhen,
      required this.name,
      this.size,
      this.semantic,
      final String? $type})
      : $type = $type ?? 'icon';
  factory IconNode.fromJson(Map<String, dynamic> json) =>
      _$IconNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final String name;
  final IconSize? size;
  final ColorSemantic? semantic;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IconNodeCopyWith<IconNode> get copyWith =>
      _$IconNodeCopyWithImpl<IconNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IconNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IconNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.semantic, semantic) ||
                other.semantic == semantic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, visibleWhen, name, size, semantic);

  @override
  String toString() {
    return 'LayoutNode.icon(id: $id, visibleWhen: $visibleWhen, name: $name, size: $size, semantic: $semantic)';
  }
}

/// @nodoc
abstract mixin class $IconNodeCopyWith<$Res> implements $LayoutNodeCopyWith<$Res> {
  factory $IconNodeCopyWith(IconNode value, $Res Function(IconNode) _then) =
      _$IconNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      String name,
      IconSize? size,
      ColorSemantic? semantic});
}

/// @nodoc
class _$IconNodeCopyWithImpl<$Res> implements $IconNodeCopyWith<$Res> {
  _$IconNodeCopyWithImpl(this._self, this._then);

  final IconNode _self;
  final $Res Function(IconNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? name = null,
    Object? size = freezed,
    Object? semantic = freezed,
  }) {
    return _then(IconNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as IconSize?,
      semantic: freezed == semantic
          ? _self.semantic
          : semantic // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SpacerNode implements LayoutNode {
  const SpacerNode(
      {this.id, this.visibleWhen, this.size, this.flex, final String? $type})
      : $type = $type ?? 'spacer';
  factory SpacerNode.fromJson(Map<String, dynamic> json) =>
      _$SpacerNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final SpacerSize? size;
  final int? flex;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpacerNodeCopyWith<SpacerNode> get copyWith =>
      _$SpacerNodeCopyWithImpl<SpacerNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SpacerNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SpacerNode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, visibleWhen, size, flex);

  @override
  String toString() {
    return 'LayoutNode.spacer(id: $id, visibleWhen: $visibleWhen, size: $size, flex: $flex)';
  }
}

/// @nodoc
abstract mixin class $SpacerNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $SpacerNodeCopyWith(
          SpacerNode value, $Res Function(SpacerNode) _then) =
      _$SpacerNodeCopyWithImpl;
  @override
  @useResult
  $Res call({String? id, String? visibleWhen, SpacerSize? size, int? flex});
}

/// @nodoc
class _$SpacerNodeCopyWithImpl<$Res> implements $SpacerNodeCopyWith<$Res> {
  _$SpacerNodeCopyWithImpl(this._self, this._then);

  final SpacerNode _self;
  final $Res Function(SpacerNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? size = freezed,
    Object? flex = freezed,
  }) {
    return _then(SpacerNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as SpacerSize?,
      flex: freezed == flex
          ? _self.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class AppBarNode implements LayoutNode {
  const AppBarNode(
      {this.id,
      this.visibleWhen,
      this.title,
      this.leadingIcon,
      this.leadingAction,
      final List<AppBarAction>? actions,
      final String? $type})
      : _actions = actions,
        $type = $type ?? 'appBar';
  factory AppBarNode.fromJson(Map<String, dynamic> json) =>
      _$AppBarNodeFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final String? title;
  final String? leadingIcon;
  final String? leadingAction;
  final List<AppBarAction>? _actions;
  List<AppBarAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.leadingIcon, leadingIcon) ||
                other.leadingIcon == leadingIcon) &&
            (identical(other.leadingAction, leadingAction) ||
                other.leadingAction == leadingAction) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      title,
      leadingIcon,
      leadingAction,
      const DeepCollectionEquality().hash(_actions));

  @override
  String toString() {
    return 'LayoutNode.appBar(id: $id, visibleWhen: $visibleWhen, title: $title, leadingIcon: $leadingIcon, leadingAction: $leadingAction, actions: $actions)';
  }
}

/// @nodoc
abstract mixin class $AppBarNodeCopyWith<$Res>
    implements $LayoutNodeCopyWith<$Res> {
  factory $AppBarNodeCopyWith(
          AppBarNode value, $Res Function(AppBarNode) _then) =
      _$AppBarNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      String? title,
      String? leadingIcon,
      String? leadingAction,
      List<AppBarAction>? actions});
}

/// @nodoc
class _$AppBarNodeCopyWithImpl<$Res> implements $AppBarNodeCopyWith<$Res> {
  _$AppBarNodeCopyWithImpl(this._self, this._then);

  final AppBarNode _self;
  final $Res Function(AppBarNode) _then;

  /// Create a copy of LayoutNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? title = freezed,
    Object? leadingIcon = freezed,
    Object? leadingAction = freezed,
    Object? actions = freezed,
  }) {
    return _then(AppBarNode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _self.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingIcon: freezed == leadingIcon
          ? _self.leadingIcon
          : leadingIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingAction: freezed == leadingAction
          ? _self.leadingAction
          : leadingAction // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<AppBarAction>?,
    ));
  }
}

// dart format on
