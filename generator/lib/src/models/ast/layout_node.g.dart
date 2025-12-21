// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructuralLayoutNode _$StructuralLayoutNodeFromJson(
        Map<String, dynamic> json) =>
    StructuralLayoutNode(
      node: StructuralNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StructuralLayoutNodeToJson(
        StructuralLayoutNode instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

PrimitiveLayoutNode _$PrimitiveLayoutNodeFromJson(Map<String, dynamic> json) =>
    PrimitiveLayoutNode(
      node: PrimitiveNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PrimitiveLayoutNodeToJson(
        PrimitiveLayoutNode instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

InteractiveLayoutNode _$InteractiveLayoutNodeFromJson(
        Map<String, dynamic> json) =>
    InteractiveLayoutNode(
      node: InteractiveNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$InteractiveLayoutNodeToJson(
        InteractiveLayoutNode instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

CustomLayoutNode _$CustomLayoutNodeFromJson(Map<String, dynamic> json) =>
    CustomLayoutNode(
      node: CustomNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CustomLayoutNodeToJson(CustomLayoutNode instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

AppBarNode _$AppBarNodeFromJson(Map<String, dynamic> json) => AppBarNode(
      title: json['title'] as String?,
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => AppBarAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadingIcon: json['leadingIcon'] as String?,
      onLeadingPressed: json['onLeadingPressed'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$AppBarNodeToJson(AppBarNode instance) =>
    <String, dynamic>{
      'title': instance.title,
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
      'leadingIcon': instance.leadingIcon,
      'onLeadingPressed': instance.onLeadingPressed,
      'runtimeType': instance.$type,
    };
