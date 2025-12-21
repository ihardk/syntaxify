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
