// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primitive_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextNode _$TextNodeFromJson(Map<String, dynamic> json) => TextNode(
      text: json['text'] as String,
      variant: $enumDecodeNullable(_$TextVariantEnumMap, json['variant']),
      align: $enumDecodeNullable(_$TextAlignEnumMap, json['align']),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      overflow: $enumDecodeNullable(_$TextOverflowEnumMap, json['overflow']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TextNodeToJson(TextNode instance) => <String, dynamic>{
      'text': instance.text,
      'variant': _$TextVariantEnumMap[instance.variant],
      'align': _$TextAlignEnumMap[instance.align],
      'maxLines': instance.maxLines,
      'overflow': _$TextOverflowEnumMap[instance.overflow],
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

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right',
  TextAlign.justify: 'justify',
};

const _$TextOverflowEnumMap = {
  TextOverflow.visible: 'visible',
  TextOverflow.clip: 'clip',
  TextOverflow.ellipsis: 'ellipsis',
  TextOverflow.fade: 'fade',
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
