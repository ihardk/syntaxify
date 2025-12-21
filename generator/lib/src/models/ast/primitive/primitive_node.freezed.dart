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
    case 'image':
      return ImageNode.fromJson(json);
    case 'divider':
      return DividerNode.fromJson(json);
    case 'circularProgressIndicator':
      return CircularProgressIndicatorNode.fromJson(json);
    case 'sizedBox':
      return SizedBoxNode.fromJson(json);
    case 'expanded':
      return ExpandedNode.fromJson(json);

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
    TResult Function(ImageNode value)? image,
    TResult Function(DividerNode value)? divider,
    TResult Function(CircularProgressIndicatorNode value)?
        circularProgressIndicator,
    TResult Function(SizedBoxNode value)? sizedBox,
    TResult Function(ExpandedNode value)? expanded,
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
      case ImageNode() when image != null:
        return image(_that);
      case DividerNode() when divider != null:
        return divider(_that);
      case CircularProgressIndicatorNode()
          when circularProgressIndicator != null:
        return circularProgressIndicator(_that);
      case SizedBoxNode() when sizedBox != null:
        return sizedBox(_that);
      case ExpandedNode() when expanded != null:
        return expanded(_that);
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
    required TResult Function(ImageNode value) image,
    required TResult Function(DividerNode value) divider,
    required TResult Function(CircularProgressIndicatorNode value)
        circularProgressIndicator,
    required TResult Function(SizedBoxNode value) sizedBox,
    required TResult Function(ExpandedNode value) expanded,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode():
        return text(_that);
      case IconNode():
        return icon(_that);
      case SpacerNode():
        return spacer(_that);
      case ImageNode():
        return image(_that);
      case DividerNode():
        return divider(_that);
      case CircularProgressIndicatorNode():
        return circularProgressIndicator(_that);
      case SizedBoxNode():
        return sizedBox(_that);
      case ExpandedNode():
        return expanded(_that);
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
    TResult? Function(ImageNode value)? image,
    TResult? Function(DividerNode value)? divider,
    TResult? Function(CircularProgressIndicatorNode value)?
        circularProgressIndicator,
    TResult? Function(SizedBoxNode value)? sizedBox,
    TResult? Function(ExpandedNode value)? expanded,
  }) {
    final _that = this;
    switch (_that) {
      case TextNode() when text != null:
        return text(_that);
      case IconNode() when icon != null:
        return icon(_that);
      case SpacerNode() when spacer != null:
        return spacer(_that);
      case ImageNode() when image != null:
        return image(_that);
      case DividerNode() when divider != null:
        return divider(_that);
      case CircularProgressIndicatorNode()
          when circularProgressIndicator != null:
        return circularProgressIndicator(_that);
      case SizedBoxNode() when sizedBox != null:
        return sizedBox(_that);
      case ExpandedNode() when expanded != null:
        return expanded(_that);
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
    TResult Function(String src, double? width, double? height, ImageFit? fit,
            String? placeholder, String? errorWidget)?
        image,
    TResult Function(double? thickness, ColorSemantic? color, double? indent,
            double? endIndent)?
        divider,
    TResult Function(double? value, ColorSemantic? color, double? strokeWidth)?
        circularProgressIndicator,
    TResult Function(double? width, double? height, LayoutNode? child)?
        sizedBox,
    TResult Function(LayoutNode child, int? flex)? expanded,
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
      case ImageNode() when image != null:
        return image(_that.src, _that.width, _that.height, _that.fit,
            _that.placeholder, _that.errorWidget);
      case DividerNode() when divider != null:
        return divider(
            _that.thickness, _that.color, _that.indent, _that.endIndent);
      case CircularProgressIndicatorNode()
          when circularProgressIndicator != null:
        return circularProgressIndicator(
            _that.value, _that.color, _that.strokeWidth);
      case SizedBoxNode() when sizedBox != null:
        return sizedBox(_that.width, _that.height, _that.child);
      case ExpandedNode() when expanded != null:
        return expanded(_that.child, _that.flex);
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
    required TResult Function(String src, double? width, double? height,
            ImageFit? fit, String? placeholder, String? errorWidget)
        image,
    required TResult Function(double? thickness, ColorSemantic? color,
            double? indent, double? endIndent)
        divider,
    required TResult Function(
            double? value, ColorSemantic? color, double? strokeWidth)
        circularProgressIndicator,
    required TResult Function(double? width, double? height, LayoutNode? child)
        sizedBox,
    required TResult Function(LayoutNode child, int? flex) expanded,
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
      case ImageNode():
        return image(_that.src, _that.width, _that.height, _that.fit,
            _that.placeholder, _that.errorWidget);
      case DividerNode():
        return divider(
            _that.thickness, _that.color, _that.indent, _that.endIndent);
      case CircularProgressIndicatorNode():
        return circularProgressIndicator(
            _that.value, _that.color, _that.strokeWidth);
      case SizedBoxNode():
        return sizedBox(_that.width, _that.height, _that.child);
      case ExpandedNode():
        return expanded(_that.child, _that.flex);
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
    TResult? Function(String src, double? width, double? height, ImageFit? fit,
            String? placeholder, String? errorWidget)?
        image,
    TResult? Function(double? thickness, ColorSemantic? color, double? indent,
            double? endIndent)?
        divider,
    TResult? Function(double? value, ColorSemantic? color, double? strokeWidth)?
        circularProgressIndicator,
    TResult? Function(double? width, double? height, LayoutNode? child)?
        sizedBox,
    TResult? Function(LayoutNode child, int? flex)? expanded,
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
      case ImageNode() when image != null:
        return image(_that.src, _that.width, _that.height, _that.fit,
            _that.placeholder, _that.errorWidget);
      case DividerNode() when divider != null:
        return divider(
            _that.thickness, _that.color, _that.indent, _that.endIndent);
      case CircularProgressIndicatorNode()
          when circularProgressIndicator != null:
        return circularProgressIndicator(
            _that.value, _that.color, _that.strokeWidth);
      case SizedBoxNode() when sizedBox != null:
        return sizedBox(_that.width, _that.height, _that.child);
      case ExpandedNode() when expanded != null:
        return expanded(_that.child, _that.flex);
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

/// @nodoc
@JsonSerializable()
class ImageNode implements PrimitiveNode {
  const ImageNode(
      {required this.src,
      this.width,
      this.height,
      this.fit,
      this.placeholder,
      this.errorWidget,
      final String? $type})
      : $type = $type ?? 'image';
  factory ImageNode.fromJson(Map<String, dynamic> json) =>
      _$ImageNodeFromJson(json);

  final String src;
  final double? width;
  final double? height;
  final ImageFit? fit;
  final String? placeholder;
  final String? errorWidget;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageNodeCopyWith<ImageNode> get copyWith =>
      _$ImageNodeCopyWithImpl<ImageNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageNode &&
            (identical(other.src, src) || other.src == src) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.fit, fit) || other.fit == fit) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder) &&
            (identical(other.errorWidget, errorWidget) ||
                other.errorWidget == errorWidget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, src, width, height, fit, placeholder, errorWidget);

  @override
  String toString() {
    return 'PrimitiveNode.image(src: $src, width: $width, height: $height, fit: $fit, placeholder: $placeholder, errorWidget: $errorWidget)';
  }
}

/// @nodoc
abstract mixin class $ImageNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $ImageNodeCopyWith(ImageNode value, $Res Function(ImageNode) _then) =
      _$ImageNodeCopyWithImpl;
  @useResult
  $Res call(
      {String src,
      double? width,
      double? height,
      ImageFit? fit,
      String? placeholder,
      String? errorWidget});
}

/// @nodoc
class _$ImageNodeCopyWithImpl<$Res> implements $ImageNodeCopyWith<$Res> {
  _$ImageNodeCopyWithImpl(this._self, this._then);

  final ImageNode _self;
  final $Res Function(ImageNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? src = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? fit = freezed,
    Object? placeholder = freezed,
    Object? errorWidget = freezed,
  }) {
    return _then(ImageNode(
      src: null == src
          ? _self.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      fit: freezed == fit
          ? _self.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as ImageFit?,
      placeholder: freezed == placeholder
          ? _self.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String?,
      errorWidget: freezed == errorWidget
          ? _self.errorWidget
          : errorWidget // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class DividerNode implements PrimitiveNode {
  const DividerNode(
      {this.thickness,
      this.color,
      this.indent,
      this.endIndent,
      final String? $type})
      : $type = $type ?? 'divider';
  factory DividerNode.fromJson(Map<String, dynamic> json) =>
      _$DividerNodeFromJson(json);

  final double? thickness;
  final ColorSemantic? color;
  final double? indent;
  final double? endIndent;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DividerNodeCopyWith<DividerNode> get copyWith =>
      _$DividerNodeCopyWithImpl<DividerNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DividerNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DividerNode &&
            (identical(other.thickness, thickness) ||
                other.thickness == thickness) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.indent, indent) || other.indent == indent) &&
            (identical(other.endIndent, endIndent) ||
                other.endIndent == endIndent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, thickness, color, indent, endIndent);

  @override
  String toString() {
    return 'PrimitiveNode.divider(thickness: $thickness, color: $color, indent: $indent, endIndent: $endIndent)';
  }
}

/// @nodoc
abstract mixin class $DividerNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $DividerNodeCopyWith(
          DividerNode value, $Res Function(DividerNode) _then) =
      _$DividerNodeCopyWithImpl;
  @useResult
  $Res call(
      {double? thickness,
      ColorSemantic? color,
      double? indent,
      double? endIndent});
}

/// @nodoc
class _$DividerNodeCopyWithImpl<$Res> implements $DividerNodeCopyWith<$Res> {
  _$DividerNodeCopyWithImpl(this._self, this._then);

  final DividerNode _self;
  final $Res Function(DividerNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? thickness = freezed,
    Object? color = freezed,
    Object? indent = freezed,
    Object? endIndent = freezed,
  }) {
    return _then(DividerNode(
      thickness: freezed == thickness
          ? _self.thickness
          : thickness // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
      indent: freezed == indent
          ? _self.indent
          : indent // ignore: cast_nullable_to_non_nullable
              as double?,
      endIndent: freezed == endIndent
          ? _self.endIndent
          : endIndent // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class CircularProgressIndicatorNode implements PrimitiveNode {
  const CircularProgressIndicatorNode(
      {this.value, this.color, this.strokeWidth, final String? $type})
      : $type = $type ?? 'circularProgressIndicator';
  factory CircularProgressIndicatorNode.fromJson(Map<String, dynamic> json) =>
      _$CircularProgressIndicatorNodeFromJson(json);

  final double? value;
  final ColorSemantic? color;
  final double? strokeWidth;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CircularProgressIndicatorNodeCopyWith<CircularProgressIndicatorNode>
      get copyWith => _$CircularProgressIndicatorNodeCopyWithImpl<
          CircularProgressIndicatorNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CircularProgressIndicatorNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CircularProgressIndicatorNode &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, color, strokeWidth);

  @override
  String toString() {
    return 'PrimitiveNode.circularProgressIndicator(value: $value, color: $color, strokeWidth: $strokeWidth)';
  }
}

/// @nodoc
abstract mixin class $CircularProgressIndicatorNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $CircularProgressIndicatorNodeCopyWith(
          CircularProgressIndicatorNode value,
          $Res Function(CircularProgressIndicatorNode) _then) =
      _$CircularProgressIndicatorNodeCopyWithImpl;
  @useResult
  $Res call({double? value, ColorSemantic? color, double? strokeWidth});
}

/// @nodoc
class _$CircularProgressIndicatorNodeCopyWithImpl<$Res>
    implements $CircularProgressIndicatorNodeCopyWith<$Res> {
  _$CircularProgressIndicatorNodeCopyWithImpl(this._self, this._then);

  final CircularProgressIndicatorNode _self;
  final $Res Function(CircularProgressIndicatorNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? color = freezed,
    Object? strokeWidth = freezed,
  }) {
    return _then(CircularProgressIndicatorNode(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
      strokeWidth: freezed == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SizedBoxNode implements PrimitiveNode {
  const SizedBoxNode({this.width, this.height, this.child, final String? $type})
      : $type = $type ?? 'sizedBox';
  factory SizedBoxNode.fromJson(Map<String, dynamic> json) =>
      _$SizedBoxNodeFromJson(json);

  final double? width;
  final double? height;
  final LayoutNode? child;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SizedBoxNodeCopyWith<SizedBoxNode> get copyWith =>
      _$SizedBoxNodeCopyWithImpl<SizedBoxNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SizedBoxNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SizedBoxNode &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.child, child) || other.child == child));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, width, height, child);

  @override
  String toString() {
    return 'PrimitiveNode.sizedBox(width: $width, height: $height, child: $child)';
  }
}

/// @nodoc
abstract mixin class $SizedBoxNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $SizedBoxNodeCopyWith(
          SizedBoxNode value, $Res Function(SizedBoxNode) _then) =
      _$SizedBoxNodeCopyWithImpl;
  @useResult
  $Res call({double? width, double? height, LayoutNode? child});

  $LayoutNodeCopyWith<$Res>? get child;
}

/// @nodoc
class _$SizedBoxNodeCopyWithImpl<$Res> implements $SizedBoxNodeCopyWith<$Res> {
  _$SizedBoxNodeCopyWithImpl(this._self, this._then);

  final SizedBoxNode _self;
  final $Res Function(SizedBoxNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? width = freezed,
    Object? height = freezed,
    Object? child = freezed,
  }) {
    return _then(SizedBoxNode(
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      child: freezed == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutNode?,
    ));
  }

  /// Create a copy of PrimitiveNode
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
class ExpandedNode implements PrimitiveNode {
  const ExpandedNode({required this.child, this.flex, final String? $type})
      : $type = $type ?? 'expanded';
  factory ExpandedNode.fromJson(Map<String, dynamic> json) =>
      _$ExpandedNodeFromJson(json);

  final LayoutNode child;
  final int? flex;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpandedNodeCopyWith<ExpandedNode> get copyWith =>
      _$ExpandedNodeCopyWithImpl<ExpandedNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExpandedNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpandedNode &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child, flex);

  @override
  String toString() {
    return 'PrimitiveNode.expanded(child: $child, flex: $flex)';
  }
}

/// @nodoc
abstract mixin class $ExpandedNodeCopyWith<$Res>
    implements $PrimitiveNodeCopyWith<$Res> {
  factory $ExpandedNodeCopyWith(
          ExpandedNode value, $Res Function(ExpandedNode) _then) =
      _$ExpandedNodeCopyWithImpl;
  @useResult
  $Res call({LayoutNode child, int? flex});

  $LayoutNodeCopyWith<$Res> get child;
}

/// @nodoc
class _$ExpandedNodeCopyWithImpl<$Res> implements $ExpandedNodeCopyWith<$Res> {
  _$ExpandedNodeCopyWithImpl(this._self, this._then);

  final ExpandedNode _self;
  final $Res Function(ExpandedNode) _then;

  /// Create a copy of PrimitiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? flex = freezed,
  }) {
    return _then(ExpandedNode(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutNode,
      flex: freezed == flex
          ? _self.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of PrimitiveNode
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
