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

CheckboxNode _$CheckboxNodeFromJson(Map<String, dynamic> json) => CheckboxNode(
      binding: json['binding'] as String,
      label: json['label'] as String?,
      onChanged: json['onChanged'] as String?,
      tristate: json['tristate'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CheckboxNodeToJson(CheckboxNode instance) =>
    <String, dynamic>{
      'binding': instance.binding,
      'label': instance.label,
      'onChanged': instance.onChanged,
      'tristate': instance.tristate,
      'runtimeType': instance.$type,
    };

SwitchNode _$SwitchNodeFromJson(Map<String, dynamic> json) => SwitchNode(
      binding: json['binding'] as String,
      label: json['label'] as String?,
      onChanged: json['onChanged'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SwitchNodeToJson(SwitchNode instance) =>
    <String, dynamic>{
      'binding': instance.binding,
      'label': instance.label,
      'onChanged': instance.onChanged,
      'runtimeType': instance.$type,
    };

IconButtonNode _$IconButtonNodeFromJson(Map<String, dynamic> json) =>
    IconButtonNode(
      icon: json['icon'] as String,
      onPressed: json['onPressed'] as String?,
      size: (json['size'] as num?)?.toDouble(),
      color: $enumDecodeNullable(_$ColorSemanticEnumMap, json['color']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$IconButtonNodeToJson(IconButtonNode instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'onPressed': instance.onPressed,
      'size': instance.size,
      'color': _$ColorSemanticEnumMap[instance.color],
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

DropdownNode _$DropdownNodeFromJson(Map<String, dynamic> json) => DropdownNode(
      binding: json['binding'] as String,
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
      label: json['label'] as String?,
      onChanged: json['onChanged'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DropdownNodeToJson(DropdownNode instance) =>
    <String, dynamic>{
      'binding': instance.binding,
      'items': instance.items,
      'label': instance.label,
      'onChanged': instance.onChanged,
      'runtimeType': instance.$type,
    };

RadioNode _$RadioNodeFromJson(Map<String, dynamic> json) => RadioNode(
      binding: json['binding'] as String,
      value: json['value'] as String,
      label: json['label'] as String?,
      onChanged: json['onChanged'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$RadioNodeToJson(RadioNode instance) => <String, dynamic>{
      'binding': instance.binding,
      'value': instance.value,
      'label': instance.label,
      'onChanged': instance.onChanged,
      'runtimeType': instance.$type,
    };

SliderNode _$SliderNodeFromJson(Map<String, dynamic> json) => SliderNode(
      binding: json['binding'] as String,
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      divisions: (json['divisions'] as num?)?.toInt(),
      label: json['label'] as String?,
      onChanged: json['onChanged'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SliderNodeToJson(SliderNode instance) =>
    <String, dynamic>{
      'binding': instance.binding,
      'min': instance.min,
      'max': instance.max,
      'divisions': instance.divisions,
      'label': instance.label,
      'onChanged': instance.onChanged,
      'runtimeType': instance.$type,
    };
