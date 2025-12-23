// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructuralApp _$StructuralAppFromJson(Map<String, dynamic> json) =>
    StructuralApp(
      node: StructuralNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StructuralAppToJson(StructuralApp instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

PrimitiveApp _$PrimitiveAppFromJson(Map<String, dynamic> json) => PrimitiveApp(
      node: PrimitiveNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PrimitiveAppToJson(PrimitiveApp instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

InteractiveApp _$InteractiveAppFromJson(Map<String, dynamic> json) =>
    InteractiveApp(
      node: InteractiveNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$InteractiveAppToJson(InteractiveApp instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'meta': instance.meta.toJson(),
      'runtimeType': instance.$type,
    };

CustomApp _$CustomAppFromJson(Map<String, dynamic> json) => CustomApp(
      node: CustomNode.fromJson(json['node'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? const NodeMetadata()
          : NodeMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CustomAppToJson(CustomApp instance) => <String, dynamic>{
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
