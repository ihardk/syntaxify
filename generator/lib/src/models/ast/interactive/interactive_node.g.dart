// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interactive_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonNode _$ButtonNodeFromJson(Map<String, dynamic> json) => ButtonNode(
      label: json['label'] as String,
      onPressed: json['onPressed'] as String?,
      props: json['props'] == null
          ? null
          : ButtonProps.fromJson(json['props'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ButtonNodeToJson(ButtonNode instance) =>
    <String, dynamic>{
      'label': instance.label,
      'onPressed': instance.onPressed,
      'props': instance.props?.toJson(),
      'runtimeType': instance.$type,
    };

TextFieldNode _$TextFieldNodeFromJson(Map<String, dynamic> json) =>
    TextFieldNode(
      label: json['label'] as String?,
      binding: json['binding'] as String?,
      onChanged: json['onChanged'] as String?,
      onSubmitted: json['onSubmitted'] as String?,
      props: json['props'] == null
          ? null
          : TextFieldProps.fromJson(json['props'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TextFieldNodeToJson(TextFieldNode instance) =>
    <String, dynamic>{
      'label': instance.label,
      'binding': instance.binding,
      'onChanged': instance.onChanged,
      'onSubmitted': instance.onSubmitted,
      'props': instance.props?.toJson(),
      'runtimeType': instance.$type,
    };
