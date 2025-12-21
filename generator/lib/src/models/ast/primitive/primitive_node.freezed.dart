// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'primitive_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
PrimitiveNode _$PrimitiveNodeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'text':
      return TextNode.fromJson(json);
    case 'icon':
      return IconNode.fromJson(json);
    case 'spacer':
      return SpacerNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PrimitiveNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PrimitiveNode {
  /// Serializes this PrimitiveNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PrimitiveNode);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PrimitiveNode()';
  }
}

/// @nodoc
class $PrimitiveNodeCopyWith<$Res> {
  $PrimitiveNodeCopyWith(PrimitiveNode _, $Res Function(PrimitiveNode) __);
}

/// Adds pattern-matching-related methods to [PrimitiveNode].
extension PrimitiveNodePatterns on PrimitiveNode {
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
    TResult Function(TextNode value)? text,
    TResult Function(IconNode value)? icon,
    TResult Function(SpacerNode value)? spacer,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TextNode() when text != null:
        return text(_that);
      case IconNode() when icon != null:
        return icon(_that);
      case SpacerNode() when spacer != null:
        return spacer(_that);
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
    required TResult Function(TextNode value) text,
    required TResult Function(IconNode value) icon,
    required TResult Function(SpacerNode value) spacer,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode():
        return text(_that);
      case IconNode():
        return icon(_that);
      case SpacerNode():
        return spacer(_that);
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
    TResult? Function(TextNode value)? text,
    TResult? Function(IconNode value)? icon,
    TResult? Function(SpacerNode value)? spacer,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode() when text != null:
        return text(_that);
      case IconNode() when icon != null:
        return icon(_that);
      case SpacerNode() when spacer != null:
        return spacer(_that);
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
    TResult Function(String text, TextVariant? variant, TextAlign? align,
            int? maxLines, TextOverflow? overflow)?
        text,
    TResult Function(String name, IconSize? size, ColorSemantic? semantic)?
        icon,
    TResult Function(SpacerSize? size, int? flex)? spacer,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TextNode() when text != null:
        return text(_that.text, _that.variant, _that.align, _that.maxLines,
            _that.overflow);
      case IconNode() when icon != null:
        return icon(_that.name, _that.size, _that.semantic);
      case SpacerNode() when spacer != null:
        return spacer(_that.size, _that.flex);
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
    required TResult Function(String text, TextVariant? variant,
            TextAlign? align, int? maxLines, TextOverflow? overflow)
        text,
    required TResult Function(
            String name, IconSize? size, ColorSemantic? semantic)
        icon,
    required TResult Function(SpacerSize? size, int? flex) spacer,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode():
        return text(_that.text, _that.variant, _that.align, _that.maxLines,
            _that.overflow);
      case IconNode():
        return icon(_that.name, _that.size, _that.semantic);
      case SpacerNode():
        return spacer(_that.size, _that.flex);
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
    TResult? Function(String text, TextVariant? variant, TextAlign? align,
            int? maxLines, TextOverflow? overflow)?
        text,
    TResult? Function(String name, IconSize? size, ColorSemantic? semantic)?
        icon,
    TResult? Function(SpacerSize? size, int? flex)? spacer,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode() when text != null:
        return text(_that.text, _that.variant, _that.align, _that.maxLines,
            _that.overflow);
      case IconNode() when icon != null:
        return icon(_that.name, _that.size, _that.semantic);
      case SpacerNode() when spacer != null:
        return spacer(_that.size, _that.flex);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class TextNode implements PrimitiveNode {
  const TextNode(
      {required this.text,
      this.variant,
      this.align,
      this.maxLines,
      this.overflow,
      final String? $type})
      : $type = $type ?? 'text';
  factory TextNode.fromJson(Map<String, dynamic> json) =>
      _$TextNodeFromJson(json);

  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
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
  int get hashCode =>
      Object.hash(runtimeType, text, variant, align, maxLines, overflow);

  @override
  String toString() {
    return 'PrimitiveNode.text(text: $text, variant: $variant, align: $align, maxLines: $maxLines, overflow: $overflow)';
  }
}

/// @nodoc
abstract mixin class $TextNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $TextNodeCopyWith(TextNode value, $Res Function(TextNode) _then) =
      _$TextNodeCopyWithImpl;
  @useResult
  $Res call(
      {String text,
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

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? variant = freezed,
    Object? align = freezed,
    Object? maxLines = freezed,
    Object? overflow = freezed,
  }) {
    return _then(TextNode(
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
class IconNode implements PrimitiveNode {
  const IconNode(
      {required this.name, this.size, this.semantic, final String? $type})
      : $type = $type ?? 'icon';
  factory IconNode.fromJson(Map<String, dynamic> json) =>
      _$IconNodeFromJson(json);

  final String name;
  final IconSize? size;
  final ColorSemantic? semantic;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.semantic, semantic) ||
                other.semantic == semantic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, size, semantic);

  @override
  String toString() {
    return 'PrimitiveNode.icon(name: $name, size: $size, semantic: $semantic)';
  }
}

/// @nodoc
abstract mixin class $IconNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $IconNodeCopyWith(IconNode value, $Res Function(IconNode) _then) =
      _$IconNodeCopyWithImpl;
  @useResult
  $Res call({String name, IconSize? size, ColorSemantic? semantic});
}

/// @nodoc
class _$IconNodeCopyWithImpl<$Res> implements $IconNodeCopyWith<$Res> {
  _$IconNodeCopyWithImpl(this._self, this._then);

  final IconNode _self;
  final $Res Function(IconNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? size = freezed,
    Object? semantic = freezed,
  }) {
    return _then(IconNode(
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
class SpacerNode implements PrimitiveNode {
  const SpacerNode({this.size, this.flex, final String? $type})
      : $type = $type ?? 'spacer';
  factory SpacerNode.fromJson(Map<String, dynamic> json) =>
      _$SpacerNodeFromJson(json);

  final SpacerSize? size;
  final int? flex;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
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
            (identical(other.size, size) || other.size == size) &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, size, flex);

  @override
  String toString() {
    return 'PrimitiveNode.spacer(size: $size, flex: $flex)';
  }
}

/// @nodoc
abstract mixin class $SpacerNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $SpacerNodeCopyWith(
          SpacerNode value, $Res Function(SpacerNode) _then) =
      _$SpacerNodeCopyWithImpl;
  @useResult
  $Res call({SpacerSize? size, int? flex});
}

/// @nodoc
class _$SpacerNodeCopyWithImpl<$Res> implements $SpacerNodeCopyWith<$Res> {
  _$SpacerNodeCopyWithImpl(this._self, this._then);

  final SpacerNode _self;
  final $Res Function(SpacerNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? size = freezed,
    Object? flex = freezed,
  }) {
    return _then(SpacerNode(
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

// dart format on
