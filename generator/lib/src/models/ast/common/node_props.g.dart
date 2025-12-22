// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ButtonProps _$ButtonPropsFromJson(Map<String, dynamic> json) => _ButtonProps(
      variant: json['variant'] as String?,
      size: $enumDecodeNullable(_$ButtonSizeEnumMap, json['size']),
      icon: json['icon'] as String?,
      iconPosition:
          $enumDecodeNullable(_$IconPositionEnumMap, json['iconPosition']),
      isLoading: json['isLoading'] as bool? ?? false,
      isDisabled: json['isDisabled'] as bool? ?? false,
      fullWidth: json['fullWidth'] as bool? ?? false,
    );

Map<String, dynamic> _$ButtonPropsToJson(_ButtonProps instance) =>
    <String, dynamic>{
      'variant': instance.variant,
      'size': _$ButtonSizeEnumMap[instance.size],
      'icon': instance.icon,
      'iconPosition': _$IconPositionEnumMap[instance.iconPosition],
      'isLoading': instance.isLoading,
      'isDisabled': instance.isDisabled,
      'fullWidth': instance.fullWidth,
    };

const _$ButtonSizeEnumMap = {
  ButtonSize.sm: 'sm',
  ButtonSize.md: 'md',
  ButtonSize.lg: 'lg',
};

const _$IconPositionEnumMap = {
  IconPosition.leading: 'leading',
  IconPosition.trailing: 'trailing',
  IconPosition.only: 'only',
};

_TextFieldProps _$TextFieldPropsFromJson(Map<String, dynamic> json) =>
    _TextFieldProps(
      hint: json['hint'] as String?,
      helperText: json['helperText'] as String?,
      prefixIcon: json['prefixIcon'] as String?,
      suffixIcon: json['suffixIcon'] as String?,
      keyboardType:
          $enumDecodeNullable(_$KeyboardTypeEnumMap, json['keyboardType']),
      textInputAction: $enumDecodeNullable(
          _$TextInputActionEnumMap, json['textInputAction']),
      obscureText: json['obscureText'] as bool? ?? false,
      errorText: json['errorText'] as String?,
      maxLines: (json['maxLines'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      variant: json['variant'] as String?,
    );

Map<String, dynamic> _$TextFieldPropsToJson(_TextFieldProps instance) =>
    <String, dynamic>{
      'hint': instance.hint,
      'helperText': instance.helperText,
      'prefixIcon': instance.prefixIcon,
      'suffixIcon': instance.suffixIcon,
      'keyboardType': _$KeyboardTypeEnumMap[instance.keyboardType],
      'textInputAction': _$TextInputActionEnumMap[instance.textInputAction],
      'obscureText': instance.obscureText,
      'errorText': instance.errorText,
      'maxLines': instance.maxLines,
      'maxLength': instance.maxLength,
      'variant': instance.variant,
    };

const _$KeyboardTypeEnumMap = {
  KeyboardType.text: 'text',
  KeyboardType.email: 'email',
  KeyboardType.number: 'number',
  KeyboardType.phone: 'phone',
  KeyboardType.url: 'url',
  KeyboardType.multiline: 'multiline',
};

const _$TextInputActionEnumMap = {
  TextInputAction.done: 'done',
  TextInputAction.next: 'next',
  TextInputAction.search: 'search',
  TextInputAction.send: 'send',
  TextInputAction.go: 'go',
};
