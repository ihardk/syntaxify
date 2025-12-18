// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ast_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ColumnNodeImpl _$$ColumnNodeImplFromJson(Map<String, dynamic> json) =>
    _$ColumnNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      children: (json['children'] as List<dynamic>)
          .map((e) => AstNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainAxisAlignment: $enumDecodeNullable(
          _$MainAxisAlignmentEnumMap, json['mainAxisAlignment']),
      crossAxisAlignment: $enumDecodeNullable(
          _$CrossAxisAlignmentEnumMap, json['crossAxisAlignment']),
      spacing: json['spacing'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ColumnNodeImplToJson(_$ColumnNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
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
};

_$RowNodeImpl _$$RowNodeImplFromJson(Map<String, dynamic> json) =>
    _$RowNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      children: (json['children'] as List<dynamic>)
          .map((e) => AstNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainAxisAlignment: $enumDecodeNullable(
          _$MainAxisAlignmentEnumMap, json['mainAxisAlignment']),
      crossAxisAlignment: $enumDecodeNullable(
          _$CrossAxisAlignmentEnumMap, json['crossAxisAlignment']),
      spacing: json['spacing'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RowNodeImplToJson(_$RowNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'mainAxisAlignment':
          _$MainAxisAlignmentEnumMap[instance.mainAxisAlignment],
      'crossAxisAlignment':
          _$CrossAxisAlignmentEnumMap[instance.crossAxisAlignment],
      'spacing': instance.spacing,
      'runtimeType': instance.$type,
    };

_$TextNodeImpl _$$TextNodeImplFromJson(Map<String, dynamic> json) =>
    _$TextNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      text: json['text'] as String,
      variant: $enumDecodeNullable(_$TextVariantEnumMap, json['variant']),
      align: $enumDecodeNullable(_$TextAlignEnumMap, json['align']),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      overflow: $enumDecodeNullable(_$TextOverflowEnumMap, json['overflow']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TextNodeImplToJson(_$TextNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'text': instance.text,
      'variant': _$TextVariantEnumMap[instance.variant],
      'align': _$TextAlignEnumMap[instance.align],
      'maxLines': instance.maxLines,
      'overflow': _$TextOverflowEnumMap[instance.overflow],
      'runtimeType': instance.$type,
    };

const _$TextVariantEnumMap = {
  TextVariant.displayLarge: 'displayLarge',
  TextVariant.headlineMedium: 'headlineMedium',
  TextVariant.titleMedium: 'titleMedium',
  TextVariant.bodyLarge: 'bodyLarge',
  TextVariant.bodyMedium: 'bodyMedium',
  TextVariant.labelSmall: 'labelSmall',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right',
  TextAlign.justify: 'justify',
};

const _$TextOverflowEnumMap = {
  TextOverflow.clip: 'clip',
  TextOverflow.ellipsis: 'ellipsis',
  TextOverflow.fade: 'fade',
};

_$ButtonNodeImpl _$$ButtonNodeImplFromJson(Map<String, dynamic> json) =>
    _$ButtonNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      label: json['label'] as String,
      onPressed: json['onPressed'] as String?,
      variant: $enumDecodeNullable(_$ButtonVariantEnumMap, json['variant']),
      size: $enumDecodeNullable(_$ButtonSizeEnumMap, json['size']),
      icon: json['icon'] as String?,
      iconPosition:
          $enumDecodeNullable(_$IconPositionEnumMap, json['iconPosition']),
      isLoading: json['isLoading'] as bool?,
      isDisabled: json['isDisabled'] as bool?,
      fullWidth: json['fullWidth'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ButtonNodeImplToJson(_$ButtonNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'label': instance.label,
      'onPressed': instance.onPressed,
      'variant': _$ButtonVariantEnumMap[instance.variant],
      'size': _$ButtonSizeEnumMap[instance.size],
      'icon': instance.icon,
      'iconPosition': _$IconPositionEnumMap[instance.iconPosition],
      'isLoading': instance.isLoading,
      'isDisabled': instance.isDisabled,
      'fullWidth': instance.fullWidth,
      'runtimeType': instance.$type,
    };

const _$ButtonVariantEnumMap = {
  ButtonVariant.filled: 'filled',
  ButtonVariant.outlined: 'outlined',
  ButtonVariant.text: 'text',
  ButtonVariant.elevated: 'elevated',
  ButtonVariant.filledTonal: 'filledTonal',
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

_$TextFieldNodeImpl _$$TextFieldNodeImplFromJson(Map<String, dynamic> json) =>
    _$TextFieldNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      label: json['label'] as String?,
      hint: json['hint'] as String?,
      helperText: json['helperText'] as String?,
      binding: json['binding'] as String?,
      onChanged: json['onChanged'] as String?,
      onSubmitted: json['onSubmitted'] as String?,
      prefixIcon: json['prefixIcon'] as String?,
      suffixIcon: json['suffixIcon'] as String?,
      keyboardType:
          $enumDecodeNullable(_$KeyboardTypeEnumMap, json['keyboardType']),
      textInputAction: $enumDecodeNullable(
          _$TextInputActionEnumMap, json['textInputAction']),
      obscureText: json['obscureText'] as bool?,
      errorText: json['errorText'] as String?,
      maxLines: (json['maxLines'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      variant: $enumDecodeNullable(_$TextFieldVariantEnumMap, json['variant']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TextFieldNodeImplToJson(_$TextFieldNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'label': instance.label,
      'hint': instance.hint,
      'helperText': instance.helperText,
      'binding': instance.binding,
      'onChanged': instance.onChanged,
      'onSubmitted': instance.onSubmitted,
      'prefixIcon': instance.prefixIcon,
      'suffixIcon': instance.suffixIcon,
      'keyboardType': _$KeyboardTypeEnumMap[instance.keyboardType],
      'textInputAction': _$TextInputActionEnumMap[instance.textInputAction],
      'obscureText': instance.obscureText,
      'errorText': instance.errorText,
      'maxLines': instance.maxLines,
      'maxLength': instance.maxLength,
      'variant': _$TextFieldVariantEnumMap[instance.variant],
      'runtimeType': instance.$type,
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

const _$TextFieldVariantEnumMap = {
  TextFieldVariant.outlined: 'outlined',
  TextFieldVariant.filled: 'filled',
};

_$IconNodeImpl _$$IconNodeImplFromJson(Map<String, dynamic> json) =>
    _$IconNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      name: json['name'] as String,
      size: $enumDecodeNullable(_$IconSizeEnumMap, json['size']),
      semantic: $enumDecodeNullable(_$ColorSemanticEnumMap, json['semantic']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IconNodeImplToJson(_$IconNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'name': instance.name,
      'size': _$IconSizeEnumMap[instance.size],
      'semantic': _$ColorSemanticEnumMap[instance.semantic],
      'runtimeType': instance.$type,
    };

const _$IconSizeEnumMap = {
  IconSize.xs: 'xs',
  IconSize.sm: 'sm',
  IconSize.md: 'md',
  IconSize.lg: 'lg',
  IconSize.xl: 'xl',
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

_$SpacerNodeImpl _$$SpacerNodeImplFromJson(Map<String, dynamic> json) =>
    _$SpacerNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      size: $enumDecodeNullable(_$SpacerSizeEnumMap, json['size']),
      flex: (json['flex'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SpacerNodeImplToJson(_$SpacerNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'size': _$SpacerSizeEnumMap[instance.size],
      'flex': instance.flex,
      'runtimeType': instance.$type,
    };

const _$SpacerSizeEnumMap = {
  SpacerSize.xs: 'xs',
  SpacerSize.sm: 'sm',
  SpacerSize.md: 'md',
  SpacerSize.lg: 'lg',
  SpacerSize.xl: 'xl',
  SpacerSize.flex: 'flex',
};

_$AppBarNodeImpl _$$AppBarNodeImplFromJson(Map<String, dynamic> json) =>
    _$AppBarNodeImpl(
      id: json['id'] as String?,
      visibleWhen: json['visibleWhen'] as String?,
      title: json['title'] as String?,
      leadingIcon: json['leadingIcon'] as String?,
      leadingAction: json['leadingAction'] as String?,
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => AppBarAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AppBarNodeImplToJson(_$AppBarNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visibleWhen': instance.visibleWhen,
      'title': instance.title,
      'leadingIcon': instance.leadingIcon,
      'leadingAction': instance.leadingAction,
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
