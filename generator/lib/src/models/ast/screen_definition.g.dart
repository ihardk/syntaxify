// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScreenDefinition _$ScreenDefinitionFromJson(Map<String, dynamic> json) =>
    _ScreenDefinition(
      id: json['id'] as String,
      layout: App.fromJson(json['layout'] as Map<String, dynamic>),
      appBar: json['appBar'] == null
          ? null
          : App.fromJson(json['appBar'] as Map<String, dynamic>),
      padding: json['padding'] as String?,
    );

Map<String, dynamic> _$ScreenDefinitionToJson(_ScreenDefinition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'layout': instance.layout.toJson(),
      'appBar': instance.appBar?.toJson(),
      'padding': instance.padding,
    };
