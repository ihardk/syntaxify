// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structural_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColumnNode _$ColumnNodeFromJson(Map<String, dynamic> json) => ColumnNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainAxisAlignment: $enumDecodeNullable(
          _$MainAxisAlignmentEnumMap, json['mainAxisAlignment']),
      crossAxisAlignment: $enumDecodeNullable(
          _$CrossAxisAlignmentEnumMap, json['crossAxisAlignment']),
      spacing: json['spacing'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ColumnNodeToJson(ColumnNode instance) =>
    <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'mainAxisAlignment':
          _$MainAxisAlignmentEnumMap[instance.mainAxisAlignment],
      'crossAxisAlignment':
          _$CrossAxisAlignmentEnumMap[instance.crossAxisAlignment],
      'spacing': instance.spacing,
      'runtimeType': instance.$type,
    };

const _$MainAxisAlignmentEnumMap = {
  MainAxisAlignment.start: 'start',
  MainAxisAlignment.center: 'center',
  MainAxisAlignment.end: 'end',
  MainAxisAlignment.spaceBetween: 'spaceBetween',
  MainAxisAlignment.spaceAround: 'spaceAround',
  MainAxisAlignment.spaceEvenly: 'spaceEvenly',
};

const _$CrossAxisAlignmentEnumMap = {
  CrossAxisAlignment.start: 'start',
  CrossAxisAlignment.center: 'center',
  CrossAxisAlignment.end: 'end',
  CrossAxisAlignment.stretch: 'stretch',
  CrossAxisAlignment.baseline: 'baseline',
};

RowNode _$RowNodeFromJson(Map<String, dynamic> json) => RowNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainAxisAlignment: $enumDecodeNullable(
          _$MainAxisAlignmentEnumMap, json['mainAxisAlignment']),
      crossAxisAlignment: $enumDecodeNullable(
          _$CrossAxisAlignmentEnumMap, json['crossAxisAlignment']),
      spacing: json['spacing'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$RowNodeToJson(RowNode instance) => <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'mainAxisAlignment':
          _$MainAxisAlignmentEnumMap[instance.mainAxisAlignment],
      'crossAxisAlignment':
          _$CrossAxisAlignmentEnumMap[instance.crossAxisAlignment],
      'spacing': instance.spacing,
      'runtimeType': instance.$type,
    };

ContainerNode _$ContainerNodeFromJson(Map<String, dynamic> json) =>
    ContainerNode(
      child: json['child'] == null
          ? null
          : LayoutNode.fromJson(json['child'] as Map<String, dynamic>),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      padding: json['padding'] as String?,
      margin: json['margin'] as String?,
      color: $enumDecodeNullable(_$ColorSemanticEnumMap, json['color']),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      semantic:
          $enumDecodeNullable(_$ContainerSemanticEnumMap, json['semantic']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ContainerNodeToJson(ContainerNode instance) =>
    <String, dynamic>{
      'child': instance.child?.toJson(),
      'width': instance.width,
      'height': instance.height,
      'padding': instance.padding,
      'margin': instance.margin,
      'color': _$ColorSemanticEnumMap[instance.color],
      'borderRadius': instance.borderRadius,
      'semantic': _$ContainerSemanticEnumMap[instance.semantic],
      'runtimeType': instance.$type,
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

const _$ContainerSemanticEnumMap = {
  ContainerSemantic.surface: 'surface',
  ContainerSemantic.primaryContainer: 'primaryContainer',
  ContainerSemantic.secondaryContainer: 'secondaryContainer',
};

CardNode _$CardNodeFromJson(Map<String, dynamic> json) => CardNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      variant: $enumDecodeNullable(_$CardVariantEnumMap, json['variant']),
      padding: json['padding'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CardNodeToJson(CardNode instance) => <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'variant': _$CardVariantEnumMap[instance.variant],
      'padding': instance.padding,
      'elevation': instance.elevation,
      'runtimeType': instance.$type,
    };

const _$CardVariantEnumMap = {
  CardVariant.elevated: 'elevated',
  CardVariant.outlined: 'outlined',
  CardVariant.filled: 'filled',
};

ListViewNode _$ListViewNodeFromJson(Map<String, dynamic> json) => ListViewNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      scrollDirection:
          $enumDecodeNullable(_$AxisEnumMap, json['scrollDirection']),
      spacing: json['spacing'] as String?,
      shrinkWrap: json['shrinkWrap'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ListViewNodeToJson(ListViewNode instance) =>
    <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'scrollDirection': _$AxisEnumMap[instance.scrollDirection],
      'spacing': instance.spacing,
      'shrinkWrap': instance.shrinkWrap,
      'runtimeType': instance.$type,
    };

const _$AxisEnumMap = {
  Axis.horizontal: 'horizontal',
  Axis.vertical: 'vertical',
};

StackNode _$StackNodeFromJson(Map<String, dynamic> json) => StackNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      fit: $enumDecodeNullable(_$StackFitEnumMap, json['fit']),
      alignment: $enumDecodeNullable(_$AlignmentEnumEnumMap, json['alignment']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StackNodeToJson(StackNode instance) => <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'fit': _$StackFitEnumMap[instance.fit],
      'alignment': _$AlignmentEnumEnumMap[instance.alignment],
      'runtimeType': instance.$type,
    };

const _$StackFitEnumMap = {
  StackFit.loose: 'loose',
  StackFit.expand: 'expand',
  StackFit.passthrough: 'passthrough',
};

const _$AlignmentEnumEnumMap = {
  AlignmentEnum.topLeft: 'topLeft',
  AlignmentEnum.topCenter: 'topCenter',
  AlignmentEnum.topRight: 'topRight',
  AlignmentEnum.centerLeft: 'centerLeft',
  AlignmentEnum.center: 'center',
  AlignmentEnum.centerRight: 'centerRight',
  AlignmentEnum.bottomLeft: 'bottomLeft',
  AlignmentEnum.bottomCenter: 'bottomCenter',
  AlignmentEnum.bottomRight: 'bottomRight',
};

GridViewNode _$GridViewNodeFromJson(Map<String, dynamic> json) => GridViewNode(
      children: (json['children'] as List<dynamic>)
          .map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      crossAxisCount: (json['crossAxisCount'] as num).toInt(),
      spacing: json['spacing'] as String?,
      crossAxisSpacing: json['crossAxisSpacing'] as String?,
      childAspectRatio: (json['childAspectRatio'] as num?)?.toDouble(),
      shrinkWrap: json['shrinkWrap'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$GridViewNodeToJson(GridViewNode instance) =>
    <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
      'crossAxisCount': instance.crossAxisCount,
      'spacing': instance.spacing,
      'crossAxisSpacing': instance.crossAxisSpacing,
      'childAspectRatio': instance.childAspectRatio,
      'shrinkWrap': instance.shrinkWrap,
      'runtimeType': instance.$type,
    };

PaddingNode _$PaddingNodeFromJson(Map<String, dynamic> json) => PaddingNode(
      child: LayoutNode.fromJson(json['child'] as Map<String, dynamic>),
      padding: json['padding'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PaddingNodeToJson(PaddingNode instance) =>
    <String, dynamic>{
      'child': instance.child.toJson(),
      'padding': instance.padding,
      'runtimeType': instance.$type,
    };

CenterNode _$CenterNodeFromJson(Map<String, dynamic> json) => CenterNode(
      child: LayoutNode.fromJson(json['child'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CenterNodeToJson(CenterNode instance) =>
    <String, dynamic>{
      'child': instance.child.toJson(),
      'runtimeType': instance.$type,
    };
