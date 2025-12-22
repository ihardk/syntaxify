// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primitive_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextNode _$TextNodeFromJson(Map<String, dynamic> json) => TextNode(
      text: json['text'] as String,
      variant: $enumDecodeNullable(_$TextVariantEnumMap, json['variant']),
      align: $enumDecodeNullable(_$SyntaxTextAlignEnumMap, json['align']),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      overflow:
          $enumDecodeNullable(_$SyntaxTextOverflowEnumMap, json['overflow']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TextNodeToJson(TextNode instance) => <String, dynamic>{
      'text': instance.text,
      'variant': _$TextVariantEnumMap[instance.variant],
      'align': _$SyntaxTextAlignEnumMap[instance.align],
      'maxLines': instance.maxLines,
      'overflow': _$SyntaxTextOverflowEnumMap[instance.overflow],
      'runtimeType': instance.$type,
    };

const _$TextVariantEnumMap = {
  TextVariant.displayLarge: 'displayLarge',
  TextVariant.headlineMedium: 'headlineMedium',
  TextVariant.titleMedium: 'titleMedium',
  TextVariant.bodyLarge: 'bodyLarge',
  TextVariant.bodyMedium: 'bodyMedium',
  TextVariant.labelSmall: 'labelSmall',
};

const _$SyntaxTextAlignEnumMap = {
  SyntaxTextAlign.left: 'left',
  SyntaxTextAlign.center: 'center',
  SyntaxTextAlign.right: 'right',
  SyntaxTextAlign.justify: 'justify',
};

const _$SyntaxTextOverflowEnumMap = {
  SyntaxTextOverflow.visible: 'visible',
  SyntaxTextOverflow.clip: 'clip',
  SyntaxTextOverflow.ellipsis: 'ellipsis',
  SyntaxTextOverflow.fade: 'fade',
};

IconNode _$IconNodeFromJson(Map<String, dynamic> json) => IconNode(
      name: json['name'] as String,
      size: $enumDecodeNullable(_$IconSizeEnumMap, json['size']),
      semantic: $enumDecodeNullable(_$ColorSemanticEnumMap, json['semantic']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$IconNodeToJson(IconNode instance) => <String, dynamic>{
      'name': instance.name,
      'size': _$IconSizeEnumMap[instance.size],
      'semantic': _$ColorSemanticEnumMap[instance.semantic],
      'runtimeType': instance.$type,
    };

const _$IconSizeEnumMap = {
  IconSize.xs: 'xs',
  IconSize.sm: 'sm',
  IconSize.md: 'md',
  IconSize.lg: 'lg',
  IconSize.xl: 'xl',
};

const _$ColorSemanticEnumMap = {
  ColorSemantic.primary: 'primary',
  ColorSemantic.secondary: 'secondary',
  ColorSemantic.tertiary: 'tertiary',
  ColorSemantic.error: 'error',
  ColorSemantic.warning: 'warning',
  ColorSemantic.success: 'success',
  ColorSemantic.info: 'info',
  ColorSemantic.surface: 'surface',
  ColorSemantic.onSurface: 'onSurface',
};

SpacerNode _$SpacerNodeFromJson(Map<String, dynamic> json) => SpacerNode(
      size: $enumDecodeNullable(_$SpacerSizeEnumMap, json['size']),
      flex: (json['flex'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SpacerNodeToJson(SpacerNode instance) =>
    <String, dynamic>{
      'size': _$SpacerSizeEnumMap[instance.size],
      'flex': instance.flex,
      'runtimeType': instance.$type,
    };

const _$SpacerSizeEnumMap = {
  SpacerSize.xs: 'xs',
  SpacerSize.sm: 'sm',
  SpacerSize.md: 'md',
  SpacerSize.lg: 'lg',
  SpacerSize.xl: 'xl',
  SpacerSize.flex: 'flex',
};

ImageNode _$ImageNodeFromJson(Map<String, dynamic> json) => ImageNode(
      src: json['src'] as String,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      fit: $enumDecodeNullable(_$ImageFitEnumMap, json['fit']),
      placeholder: json['placeholder'] as String?,
      errorWidget: json['errorWidget'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ImageNodeToJson(ImageNode instance) => <String, dynamic>{
      'src': instance.src,
      'width': instance.width,
      'height': instance.height,
      'fit': _$ImageFitEnumMap[instance.fit],
      'placeholder': instance.placeholder,
      'errorWidget': instance.errorWidget,
      'runtimeType': instance.$type,
    };

const _$ImageFitEnumMap = {
  ImageFit.cover: 'cover',
  ImageFit.contain: 'contain',
  ImageFit.fill: 'fill',
  ImageFit.fitWidth: 'fitWidth',
  ImageFit.fitHeight: 'fitHeight',
  ImageFit.none: 'none',
};

DividerNode _$DividerNodeFromJson(Map<String, dynamic> json) => DividerNode(
      thickness: (json['thickness'] as num?)?.toDouble(),
      color: $enumDecodeNullable(_$ColorSemanticEnumMap, json['color']),
      indent: (json['indent'] as num?)?.toDouble(),
      endIndent: (json['endIndent'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DividerNodeToJson(DividerNode instance) =>
    <String, dynamic>{
      'thickness': instance.thickness,
      'color': _$ColorSemanticEnumMap[instance.color],
      'indent': instance.indent,
      'endIndent': instance.endIndent,
      'runtimeType': instance.$type,
    };

CircularProgressIndicatorNode _$CircularProgressIndicatorNodeFromJson(
        Map<String, dynamic> json) =>
    CircularProgressIndicatorNode(
      value: (json['value'] as num?)?.toDouble(),
      color: $enumDecodeNullable(_$ColorSemanticEnumMap, json['color']),
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CircularProgressIndicatorNodeToJson(
        CircularProgressIndicatorNode instance) =>
    <String, dynamic>{
      'value': instance.value,
      'color': _$ColorSemanticEnumMap[instance.color],
      'strokeWidth': instance.strokeWidth,
      'runtimeType': instance.$type,
    };

SizedBoxNode _$SizedBoxNodeFromJson(Map<String, dynamic> json) => SizedBoxNode(
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      child: json['child'] == null
          ? null
          : LayoutNode.fromJson(json['child'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SizedBoxNodeToJson(SizedBoxNode instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'child': instance.child?.toJson(),
      'runtimeType': instance.$type,
    };

ExpandedNode _$ExpandedNodeFromJson(Map<String, dynamic> json) => ExpandedNode(
      child: LayoutNode.fromJson(json['child'] as Map<String, dynamic>),
      flex: (json['flex'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ExpandedNodeToJson(ExpandedNode instance) =>
    <String, dynamic>{
      'child': instance.child.toJson(),
      'flex': instance.flex,
      'runtimeType': instance.$type,
    };
