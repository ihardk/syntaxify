// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreenDefinitionImpl _$$ScreenDefinitionImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenDefinitionImpl(
      id: json['id'] as String,
      layout: AstNode.fromJson(json['layout'] as Map<String, dynamic>),
      appBar: json['appBar'] == null
          ? null
          : AppBarNode.fromJson(json['appBar'] as Map<String, dynamic>),
      padding: json['padding'] as String?,
    );

Map<String, dynamic> _$$ScreenDefinitionImplToJson(
        _$ScreenDefinitionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'layout': instance.layout.toJson(),
      'appBar': instance.appBar?.toJson(),
      'padding': instance.padding,
    };
