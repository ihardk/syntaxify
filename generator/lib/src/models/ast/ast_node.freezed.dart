// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ast_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AstNode _$AstNodeFromJson(Map<String, dynamic> json) {
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
      throw CheckedFromJsonException(json, 'runtimeType', 'AstNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AstNode {
  String? get id => throw _privateConstructorUsedError;
  String? get visibleWhen => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
  }) =>
      throw _privateConstructorUsedError;
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
  }) =>
      throw _privateConstructorUsedError;
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
  }) =>
      throw _privateConstructorUsedError;
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
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AstNodeCopyWith<AstNode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AstNodeCopyWith<$Res> {
  factory $AstNodeCopyWith(AstNode value, $Res Function(AstNode) then) =
      _$AstNodeCopyWithImpl<$Res, AstNode>;
  @useResult
  $Res call({String? id, String? visibleWhen});
}

/// @nodoc
class _$AstNodeCopyWithImpl<$Res, $Val extends AstNode>
    implements $AstNodeCopyWith<$Res> {
  _$AstNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColumnNodeImplCopyWith<$Res>
    implements $AstNodeCopyWith<$Res> {
  factory _$$ColumnNodeImplCopyWith(
          _$ColumnNodeImpl value, $Res Function(_$ColumnNodeImpl) then) =
      __$$ColumnNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      List<AstNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class __$$ColumnNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$ColumnNodeImpl>
    implements _$$ColumnNodeImplCopyWith<$Res> {
  __$$ColumnNodeImplCopyWithImpl(
      _$ColumnNodeImpl _value, $Res Function(_$ColumnNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(_$ColumnNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<AstNode>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _value.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _value.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      spacing: freezed == spacing
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColumnNodeImpl implements ColumnNode {
  const _$ColumnNodeImpl(
      {this.id,
      this.visibleWhen,
      required final List<AstNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'column';

  factory _$ColumnNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColumnNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final List<AstNode> _children;
  @override
  List<AstNode> get children {
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

  @override
  String toString() {
    return 'AstNode.column(id: $id, visibleWhen: $visibleWhen, children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColumnNodeImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColumnNodeImplCopyWith<_$ColumnNodeImpl> get copyWith =>
      __$$ColumnNodeImplCopyWithImpl<_$ColumnNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return column(id, visibleWhen, children, mainAxisAlignment,
        crossAxisAlignment, spacing);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return column?.call(id, visibleWhen, children, mainAxisAlignment,
        crossAxisAlignment, spacing);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (column != null) {
      return column(id, visibleWhen, children, mainAxisAlignment,
          crossAxisAlignment, spacing);
    }
    return orElse();
  }

  @override
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
    return column(this);
  }

  @override
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
    return column?.call(this);
  }

  @override
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
    if (column != null) {
      return column(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ColumnNodeImplToJson(
      this,
    );
  }
}

abstract class ColumnNode implements AstNode {
  const factory ColumnNode(
      {final String? id,
      final String? visibleWhen,
      required final List<AstNode> children,
      final MainAxisAlignment? mainAxisAlignment,
      final CrossAxisAlignment? crossAxisAlignment,
      final String? spacing}) = _$ColumnNodeImpl;

  factory ColumnNode.fromJson(Map<String, dynamic> json) =
      _$ColumnNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  List<AstNode> get children;
  MainAxisAlignment? get mainAxisAlignment;
  CrossAxisAlignment? get crossAxisAlignment;
  String? get spacing;
  @override
  @JsonKey(ignore: true)
  _$$ColumnNodeImplCopyWith<_$ColumnNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RowNodeImplCopyWith<$Res> implements $AstNodeCopyWith<$Res> {
  factory _$$RowNodeImplCopyWith(
          _$RowNodeImpl value, $Res Function(_$RowNodeImpl) then) =
      __$$RowNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? visibleWhen,
      List<AstNode> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      String? spacing});
}

/// @nodoc
class __$$RowNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$RowNodeImpl>
    implements _$$RowNodeImplCopyWith<$Res> {
  __$$RowNodeImplCopyWithImpl(
      _$RowNodeImpl _value, $Res Function(_$RowNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
  }) {
    return _then(_$RowNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<AstNode>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _value.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _value.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      spacing: freezed == spacing
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RowNodeImpl implements RowNode {
  const _$RowNodeImpl(
      {this.id,
      this.visibleWhen,
      required final List<AstNode> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      final String? $type})
      : _children = children,
        $type = $type ?? 'row';

  factory _$RowNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RowNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  final List<AstNode> _children;
  @override
  List<AstNode> get children {
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

  @override
  String toString() {
    return 'AstNode.row(id: $id, visibleWhen: $visibleWhen, children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RowNodeImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      spacing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RowNodeImplCopyWith<_$RowNodeImpl> get copyWith =>
      __$$RowNodeImplCopyWithImpl<_$RowNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return row(id, visibleWhen, children, mainAxisAlignment, crossAxisAlignment,
        spacing);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return row?.call(id, visibleWhen, children, mainAxisAlignment,
        crossAxisAlignment, spacing);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (row != null) {
      return row(id, visibleWhen, children, mainAxisAlignment,
          crossAxisAlignment, spacing);
    }
    return orElse();
  }

  @override
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
    return row(this);
  }

  @override
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
    return row?.call(this);
  }

  @override
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
    if (row != null) {
      return row(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RowNodeImplToJson(
      this,
    );
  }
}

abstract class RowNode implements AstNode {
  const factory RowNode(
      {final String? id,
      final String? visibleWhen,
      required final List<AstNode> children,
      final MainAxisAlignment? mainAxisAlignment,
      final CrossAxisAlignment? crossAxisAlignment,
      final String? spacing}) = _$RowNodeImpl;

  factory RowNode.fromJson(Map<String, dynamic> json) = _$RowNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  List<AstNode> get children;
  MainAxisAlignment? get mainAxisAlignment;
  CrossAxisAlignment? get crossAxisAlignment;
  String? get spacing;
  @override
  @JsonKey(ignore: true)
  _$$RowNodeImplCopyWith<_$RowNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextNodeImplCopyWith<$Res> implements $AstNodeCopyWith<$Res> {
  factory _$$TextNodeImplCopyWith(
          _$TextNodeImpl value, $Res Function(_$TextNodeImpl) then) =
      __$$TextNodeImplCopyWithImpl<$Res>;
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
class __$$TextNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$TextNodeImpl>
    implements _$$TextNodeImplCopyWith<$Res> {
  __$$TextNodeImplCopyWithImpl(
      _$TextNodeImpl _value, $Res Function(_$TextNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? text = null,
    Object? variant = freezed,
    Object? align = freezed,
    Object? maxLines = freezed,
    Object? overflow = freezed,
  }) {
    return _then(_$TextNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as TextVariant?,
      align: freezed == align
          ? _value.align
          : align // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      overflow: freezed == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextNodeImpl implements TextNode {
  const _$TextNodeImpl(
      {this.id,
      this.visibleWhen,
      required this.text,
      this.variant,
      this.align,
      this.maxLines,
      this.overflow,
      final String? $type})
      : $type = $type ?? 'text';

  factory _$TextNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final String text;
  @override
  final TextVariant? variant;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.text(id: $id, visibleWhen: $visibleWhen, text: $text, variant: $variant, align: $align, maxLines: $maxLines, overflow: $overflow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextNodeImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, visibleWhen, text, variant, align, maxLines, overflow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextNodeImplCopyWith<_$TextNodeImpl> get copyWith =>
      __$$TextNodeImplCopyWithImpl<_$TextNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return text(id, visibleWhen, this.text, variant, align, maxLines, overflow);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return text?.call(
        id, visibleWhen, this.text, variant, align, maxLines, overflow);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (text != null) {
      return text(
          id, visibleWhen, this.text, variant, align, maxLines, overflow);
    }
    return orElse();
  }

  @override
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
    return text(this);
  }

  @override
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
    return text?.call(this);
  }

  @override
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
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextNodeImplToJson(
      this,
    );
  }
}

abstract class TextNode implements AstNode {
  const factory TextNode(
      {final String? id,
      final String? visibleWhen,
      required final String text,
      final TextVariant? variant,
      final TextAlign? align,
      final int? maxLines,
      final TextOverflow? overflow}) = _$TextNodeImpl;

  factory TextNode.fromJson(Map<String, dynamic> json) =
      _$TextNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  String get text;
  TextVariant? get variant;
  TextAlign? get align;
  int? get maxLines;
  TextOverflow? get overflow;
  @override
  @JsonKey(ignore: true)
  _$$TextNodeImplCopyWith<_$TextNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ButtonNodeImplCopyWith<$Res>
    implements $AstNodeCopyWith<$Res> {
  factory _$$ButtonNodeImplCopyWith(
          _$ButtonNodeImpl value, $Res Function(_$ButtonNodeImpl) then) =
      __$$ButtonNodeImplCopyWithImpl<$Res>;
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
class __$$ButtonNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$ButtonNodeImpl>
    implements _$$ButtonNodeImplCopyWith<$Res> {
  __$$ButtonNodeImplCopyWithImpl(
      _$ButtonNodeImpl _value, $Res Function(_$ButtonNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
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
    return _then(_$ButtonNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: freezed == onPressed
          ? _value.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String?,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as ButtonVariant?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as ButtonSize?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPosition: freezed == iconPosition
          ? _value.iconPosition
          : iconPosition // ignore: cast_nullable_to_non_nullable
              as IconPosition?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDisabled: freezed == isDisabled
          ? _value.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      fullWidth: freezed == fullWidth
          ? _value.fullWidth
          : fullWidth // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ButtonNodeImpl implements ButtonNode {
  const _$ButtonNodeImpl(
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

  factory _$ButtonNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ButtonNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final String label;
  @override
  final String? onPressed;
  @override
  final ButtonVariant? variant;
  @override
  final ButtonSize? size;
  @override
  final String? icon;
  @override
  final IconPosition? iconPosition;
  @override
  final bool? isLoading;
  @override
  final bool? isDisabled;
  @override
  final bool? fullWidth;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.button(id: $id, visibleWhen: $visibleWhen, label: $label, onPressed: $onPressed, variant: $variant, size: $size, icon: $icon, iconPosition: $iconPosition, isLoading: $isLoading, isDisabled: $isDisabled, fullWidth: $fullWidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ButtonNodeImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ButtonNodeImplCopyWith<_$ButtonNodeImpl> get copyWith =>
      __$$ButtonNodeImplCopyWithImpl<_$ButtonNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return button(id, visibleWhen, label, onPressed, variant, size, this.icon,
        iconPosition, isLoading, isDisabled, fullWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return button?.call(id, visibleWhen, label, onPressed, variant, size,
        this.icon, iconPosition, isLoading, isDisabled, fullWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (button != null) {
      return button(id, visibleWhen, label, onPressed, variant, size, this.icon,
          iconPosition, isLoading, isDisabled, fullWidth);
    }
    return orElse();
  }

  @override
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
    return button(this);
  }

  @override
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
    return button?.call(this);
  }

  @override
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
    if (button != null) {
      return button(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ButtonNodeImplToJson(
      this,
    );
  }
}

abstract class ButtonNode implements AstNode {
  const factory ButtonNode(
      {final String? id,
      final String? visibleWhen,
      required final String label,
      final String? onPressed,
      final ButtonVariant? variant,
      final ButtonSize? size,
      final String? icon,
      final IconPosition? iconPosition,
      final bool? isLoading,
      final bool? isDisabled,
      final bool? fullWidth}) = _$ButtonNodeImpl;

  factory ButtonNode.fromJson(Map<String, dynamic> json) =
      _$ButtonNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  String get label;
  String? get onPressed;
  ButtonVariant? get variant;
  ButtonSize? get size;
  String? get icon;
  IconPosition? get iconPosition;
  bool? get isLoading;
  bool? get isDisabled;
  bool? get fullWidth;
  @override
  @JsonKey(ignore: true)
  _$$ButtonNodeImplCopyWith<_$ButtonNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextFieldNodeImplCopyWith<$Res>
    implements $AstNodeCopyWith<$Res> {
  factory _$$TextFieldNodeImplCopyWith(
          _$TextFieldNodeImpl value, $Res Function(_$TextFieldNodeImpl) then) =
      __$$TextFieldNodeImplCopyWithImpl<$Res>;
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
class __$$TextFieldNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$TextFieldNodeImpl>
    implements _$$TextFieldNodeImplCopyWith<$Res> {
  __$$TextFieldNodeImplCopyWithImpl(
      _$TextFieldNodeImpl _value, $Res Function(_$TextFieldNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
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
    return _then(_$TextFieldNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      hint: freezed == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _value.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      binding: freezed == binding
          ? _value.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _value.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onSubmitted: freezed == onSubmitted
          ? _value.onSubmitted
          : onSubmitted // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixIcon: freezed == prefixIcon
          ? _value.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixIcon: freezed == suffixIcon
          ? _value.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as KeyboardType?,
      textInputAction: freezed == textInputAction
          ? _value.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
      obscureText: freezed == obscureText
          ? _value.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool?,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as TextFieldVariant?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextFieldNodeImpl implements TextFieldNode {
  const _$TextFieldNodeImpl(
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

  factory _$TextFieldNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextFieldNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final String? label;
  @override
  final String? hint;
  @override
  final String? helperText;
  @override
  final String? binding;
  @override
  final String? onChanged;
  @override
  final String? onSubmitted;
  @override
  final String? prefixIcon;
  @override
  final String? suffixIcon;
  @override
  final KeyboardType? keyboardType;
  @override
  final TextInputAction? textInputAction;
  @override
  final bool? obscureText;
  @override
  final String? errorText;
  @override
  final int? maxLines;
  @override
  final int? maxLength;
  @override
  final TextFieldVariant? variant;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.textField(id: $id, visibleWhen: $visibleWhen, label: $label, hint: $hint, helperText: $helperText, binding: $binding, onChanged: $onChanged, onSubmitted: $onSubmitted, prefixIcon: $prefixIcon, suffixIcon: $suffixIcon, keyboardType: $keyboardType, textInputAction: $textInputAction, obscureText: $obscureText, errorText: $errorText, maxLines: $maxLines, maxLength: $maxLength, variant: $variant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextFieldNodeImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextFieldNodeImplCopyWith<_$TextFieldNodeImpl> get copyWith =>
      __$$TextFieldNodeImplCopyWithImpl<_$TextFieldNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return textField(
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
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return textField?.call(
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
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (textField != null) {
      return textField(
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
    }
    return orElse();
  }

  @override
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
    return textField(this);
  }

  @override
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
    return textField?.call(this);
  }

  @override
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
    if (textField != null) {
      return textField(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextFieldNodeImplToJson(
      this,
    );
  }
}

abstract class TextFieldNode implements AstNode {
  const factory TextFieldNode(
      {final String? id,
      final String? visibleWhen,
      final String? label,
      final String? hint,
      final String? helperText,
      final String? binding,
      final String? onChanged,
      final String? onSubmitted,
      final String? prefixIcon,
      final String? suffixIcon,
      final KeyboardType? keyboardType,
      final TextInputAction? textInputAction,
      final bool? obscureText,
      final String? errorText,
      final int? maxLines,
      final int? maxLength,
      final TextFieldVariant? variant}) = _$TextFieldNodeImpl;

  factory TextFieldNode.fromJson(Map<String, dynamic> json) =
      _$TextFieldNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  String? get label;
  String? get hint;
  String? get helperText;
  String? get binding;
  String? get onChanged;
  String? get onSubmitted;
  String? get prefixIcon;
  String? get suffixIcon;
  KeyboardType? get keyboardType;
  TextInputAction? get textInputAction;
  bool? get obscureText;
  String? get errorText;
  int? get maxLines;
  int? get maxLength;
  TextFieldVariant? get variant;
  @override
  @JsonKey(ignore: true)
  _$$TextFieldNodeImplCopyWith<_$TextFieldNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IconNodeImplCopyWith<$Res> implements $AstNodeCopyWith<$Res> {
  factory _$$IconNodeImplCopyWith(
          _$IconNodeImpl value, $Res Function(_$IconNodeImpl) then) =
      __$$IconNodeImplCopyWithImpl<$Res>;
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
class __$$IconNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$IconNodeImpl>
    implements _$$IconNodeImplCopyWith<$Res> {
  __$$IconNodeImplCopyWithImpl(
      _$IconNodeImpl _value, $Res Function(_$IconNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? name = null,
    Object? size = freezed,
    Object? semantic = freezed,
  }) {
    return _then(_$IconNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as IconSize?,
      semantic: freezed == semantic
          ? _value.semantic
          : semantic // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IconNodeImpl implements IconNode {
  const _$IconNodeImpl(
      {this.id,
      this.visibleWhen,
      required this.name,
      this.size,
      this.semantic,
      final String? $type})
      : $type = $type ?? 'icon';

  factory _$IconNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$IconNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final String name;
  @override
  final IconSize? size;
  @override
  final ColorSemantic? semantic;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.icon(id: $id, visibleWhen: $visibleWhen, name: $name, size: $size, semantic: $semantic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IconNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.semantic, semantic) ||
                other.semantic == semantic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, visibleWhen, name, size, semantic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IconNodeImplCopyWith<_$IconNodeImpl> get copyWith =>
      __$$IconNodeImplCopyWithImpl<_$IconNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return icon(id, visibleWhen, name, size, semantic);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return icon?.call(id, visibleWhen, name, size, semantic);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (icon != null) {
      return icon(id, visibleWhen, name, size, semantic);
    }
    return orElse();
  }

  @override
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
    return icon(this);
  }

  @override
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
    return icon?.call(this);
  }

  @override
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
    if (icon != null) {
      return icon(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IconNodeImplToJson(
      this,
    );
  }
}

abstract class IconNode implements AstNode {
  const factory IconNode(
      {final String? id,
      final String? visibleWhen,
      required final String name,
      final IconSize? size,
      final ColorSemantic? semantic}) = _$IconNodeImpl;

  factory IconNode.fromJson(Map<String, dynamic> json) =
      _$IconNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  String get name;
  IconSize? get size;
  ColorSemantic? get semantic;
  @override
  @JsonKey(ignore: true)
  _$$IconNodeImplCopyWith<_$IconNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpacerNodeImplCopyWith<$Res>
    implements $AstNodeCopyWith<$Res> {
  factory _$$SpacerNodeImplCopyWith(
          _$SpacerNodeImpl value, $Res Function(_$SpacerNodeImpl) then) =
      __$$SpacerNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? visibleWhen, SpacerSize? size, int? flex});
}

/// @nodoc
class __$$SpacerNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$SpacerNodeImpl>
    implements _$$SpacerNodeImplCopyWith<$Res> {
  __$$SpacerNodeImplCopyWithImpl(
      _$SpacerNodeImpl _value, $Res Function(_$SpacerNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? size = freezed,
    Object? flex = freezed,
  }) {
    return _then(_$SpacerNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as SpacerSize?,
      flex: freezed == flex
          ? _value.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpacerNodeImpl implements SpacerNode {
  const _$SpacerNodeImpl(
      {this.id, this.visibleWhen, this.size, this.flex, final String? $type})
      : $type = $type ?? 'spacer';

  factory _$SpacerNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpacerNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final SpacerSize? size;
  @override
  final int? flex;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.spacer(id: $id, visibleWhen: $visibleWhen, size: $size, flex: $flex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpacerNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visibleWhen, visibleWhen) ||
                other.visibleWhen == visibleWhen) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, visibleWhen, size, flex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpacerNodeImplCopyWith<_$SpacerNodeImpl> get copyWith =>
      __$$SpacerNodeImplCopyWithImpl<_$SpacerNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return spacer(id, visibleWhen, size, flex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return spacer?.call(id, visibleWhen, size, flex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (spacer != null) {
      return spacer(id, visibleWhen, size, flex);
    }
    return orElse();
  }

  @override
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
    return spacer(this);
  }

  @override
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
    return spacer?.call(this);
  }

  @override
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
    if (spacer != null) {
      return spacer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SpacerNodeImplToJson(
      this,
    );
  }
}

abstract class SpacerNode implements AstNode {
  const factory SpacerNode(
      {final String? id,
      final String? visibleWhen,
      final SpacerSize? size,
      final int? flex}) = _$SpacerNodeImpl;

  factory SpacerNode.fromJson(Map<String, dynamic> json) =
      _$SpacerNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  SpacerSize? get size;
  int? get flex;
  @override
  @JsonKey(ignore: true)
  _$$SpacerNodeImplCopyWith<_$SpacerNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppBarNodeImplCopyWith<$Res>
    implements $AstNodeCopyWith<$Res> {
  factory _$$AppBarNodeImplCopyWith(
          _$AppBarNodeImpl value, $Res Function(_$AppBarNodeImpl) then) =
      __$$AppBarNodeImplCopyWithImpl<$Res>;
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
class __$$AppBarNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$AppBarNodeImpl>
    implements _$$AppBarNodeImplCopyWith<$Res> {
  __$$AppBarNodeImplCopyWithImpl(
      _$AppBarNodeImpl _value, $Res Function(_$AppBarNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? visibleWhen = freezed,
    Object? title = freezed,
    Object? leadingIcon = freezed,
    Object? leadingAction = freezed,
    Object? actions = freezed,
  }) {
    return _then(_$AppBarNodeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleWhen: freezed == visibleWhen
          ? _value.visibleWhen
          : visibleWhen // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingIcon: freezed == leadingIcon
          ? _value.leadingIcon
          : leadingIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingAction: freezed == leadingAction
          ? _value.leadingAction
          : leadingAction // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<AppBarAction>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBarNodeImpl implements AppBarNode {
  const _$AppBarNodeImpl(
      {this.id,
      this.visibleWhen,
      this.title,
      this.leadingIcon,
      this.leadingAction,
      final List<AppBarAction>? actions,
      final String? $type})
      : _actions = actions,
        $type = $type ?? 'appBar';

  factory _$AppBarNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBarNodeImplFromJson(json);

  @override
  final String? id;
  @override
  final String? visibleWhen;
  @override
  final String? title;
  @override
  final String? leadingIcon;
  @override
  final String? leadingAction;
  final List<AppBarAction>? _actions;
  @override
  List<AppBarAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AstNode.appBar(id: $id, visibleWhen: $visibleWhen, title: $title, leadingIcon: $leadingIcon, leadingAction: $leadingAction, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBarNodeImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visibleWhen,
      title,
      leadingIcon,
      leadingAction,
      const DeepCollectionEquality().hash(_actions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBarNodeImplCopyWith<_$AppBarNodeImpl> get copyWith =>
      __$$AppBarNodeImplCopyWithImpl<_$AppBarNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)
        column,
    required TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return appBar(id, visibleWhen, title, leadingIcon, leadingAction, actions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult? Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    return appBar?.call(
        id, visibleWhen, title, leadingIcon, leadingAction, actions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            String? spacing)?
        column,
    TResult Function(
            String? id,
            String? visibleWhen,
            List<AstNode> children,
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
    if (appBar != null) {
      return appBar(
          id, visibleWhen, title, leadingIcon, leadingAction, actions);
    }
    return orElse();
  }

  @override
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
    return appBar(this);
  }

  @override
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
    return appBar?.call(this);
  }

  @override
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
    if (appBar != null) {
      return appBar(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBarNodeImplToJson(
      this,
    );
  }
}

abstract class AppBarNode implements AstNode {
  const factory AppBarNode(
      {final String? id,
      final String? visibleWhen,
      final String? title,
      final String? leadingIcon,
      final String? leadingAction,
      final List<AppBarAction>? actions}) = _$AppBarNodeImpl;

  factory AppBarNode.fromJson(Map<String, dynamic> json) =
      _$AppBarNodeImpl.fromJson;

  @override
  String? get id;
  @override
  String? get visibleWhen;
  String? get title;
  String? get leadingIcon;
  String? get leadingAction;
  List<AppBarAction>? get actions;
  @override
  @JsonKey(ignore: true)
  _$$AppBarNodeImplCopyWith<_$AppBarNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
