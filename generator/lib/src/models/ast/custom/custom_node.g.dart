// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomNode _$CustomNodeFromJson(Map<String, dynamic> json) => _CustomNode(
      type: json['type'] as String,
      props: json['props'] as Map<String, dynamic>? ?? const {},
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CustomNodeToJson(_CustomNode instance) =>
    <String, dynamic>{
      'type': instance.type,
      'props': instance.props,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };
