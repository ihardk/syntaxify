// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenDefinition {
  String get name => throw _privateConstructorUsedError;
  String get componentName => throw _privateConstructorUsedError;
  List<TokenProperty> get properties => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenDefinitionCopyWith<TokenDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDefinitionCopyWith<$Res> {
  factory $TokenDefinitionCopyWith(
          TokenDefinition value, $Res Function(TokenDefinition) then) =
      _$TokenDefinitionCopyWithImpl<$Res, TokenDefinition>;
  @useResult
  $Res call(
      {String name, String componentName, List<TokenProperty> properties});
}

/// @nodoc
class _$TokenDefinitionCopyWithImpl<$Res, $Val extends TokenDefinition>
    implements $TokenDefinitionCopyWith<$Res> {
  _$TokenDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? componentName = null,
    Object? properties = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: null == componentName
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<TokenProperty>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenDefinitionImplCopyWith<$Res>
    implements $TokenDefinitionCopyWith<$Res> {
  factory _$$TokenDefinitionImplCopyWith(_$TokenDefinitionImpl value,
          $Res Function(_$TokenDefinitionImpl) then) =
      __$$TokenDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String componentName, List<TokenProperty> properties});
}

/// @nodoc
class __$$TokenDefinitionImplCopyWithImpl<$Res>
    extends _$TokenDefinitionCopyWithImpl<$Res, _$TokenDefinitionImpl>
    implements _$$TokenDefinitionImplCopyWith<$Res> {
  __$$TokenDefinitionImplCopyWithImpl(
      _$TokenDefinitionImpl _value, $Res Function(_$TokenDefinitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? componentName = null,
    Object? properties = null,
  }) {
    return _then(_$TokenDefinitionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: null == componentName
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<TokenProperty>,
    ));
  }
}

/// @nodoc

class _$TokenDefinitionImpl implements _TokenDefinition {
  const _$TokenDefinitionImpl(
      {required this.name,
      required this.componentName,
      required final List<TokenProperty> properties})
      : _properties = properties;

  @override
  final String name;
  @override
  final String componentName;
  final List<TokenProperty> _properties;
  @override
  List<TokenProperty> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  @override
  String toString() {
    return 'TokenDefinition(name: $name, componentName: $componentName, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDefinitionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, componentName,
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDefinitionImplCopyWith<_$TokenDefinitionImpl> get copyWith =>
      __$$TokenDefinitionImplCopyWithImpl<_$TokenDefinitionImpl>(
          this, _$identity);
}

abstract class _TokenDefinition implements TokenDefinition {
  const factory _TokenDefinition(
      {required final String name,
      required final String componentName,
      required final List<TokenProperty> properties}) = _$TokenDefinitionImpl;

  @override
  String get name;
  @override
  String get componentName;
  @override
  List<TokenProperty> get properties;
  @override
  @JsonKey(ignore: true)
  _$$TokenDefinitionImplCopyWith<_$TokenDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TokenProperty {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenPropertyCopyWith<TokenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPropertyCopyWith<$Res> {
  factory $TokenPropertyCopyWith(
          TokenProperty value, $Res Function(TokenProperty) then) =
      _$TokenPropertyCopyWithImpl<$Res, TokenProperty>;
  @useResult
  $Res call(
      {String name, String type, String? defaultValue, String? description});
}

/// @nodoc
class _$TokenPropertyCopyWithImpl<$Res, $Val extends TokenProperty>
    implements $TokenPropertyCopyWith<$Res> {
  _$TokenPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenPropertyImplCopyWith<$Res>
    implements $TokenPropertyCopyWith<$Res> {
  factory _$$TokenPropertyImplCopyWith(
          _$TokenPropertyImpl value, $Res Function(_$TokenPropertyImpl) then) =
      __$$TokenPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String type, String? defaultValue, String? description});
}

/// @nodoc
class __$$TokenPropertyImplCopyWithImpl<$Res>
    extends _$TokenPropertyCopyWithImpl<$Res, _$TokenPropertyImpl>
    implements _$$TokenPropertyImplCopyWith<$Res> {
  __$$TokenPropertyImplCopyWithImpl(
      _$TokenPropertyImpl _value, $Res Function(_$TokenPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_$TokenPropertyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TokenPropertyImpl implements _TokenProperty {
  const _$TokenPropertyImpl(
      {required this.name,
      required this.type,
      this.defaultValue,
      this.description});

  @override
  final String name;
  @override
  final String type;
  @override
  final String? defaultValue;
  @override
  final String? description;

  @override
  String toString() {
    return 'TokenProperty(name: $name, type: $type, defaultValue: $defaultValue, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPropertyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.defaultValue, defaultValue) ||
                other.defaultValue == defaultValue) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, type, defaultValue, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPropertyImplCopyWith<_$TokenPropertyImpl> get copyWith =>
      __$$TokenPropertyImplCopyWithImpl<_$TokenPropertyImpl>(this, _$identity);
}

abstract class _TokenProperty implements TokenProperty {
  const factory _TokenProperty(
      {required final String name,
      required final String type,
      final String? defaultValue,
      final String? description}) = _$TokenPropertyImpl;

  @override
  String get name;
  @override
  String get type;
  @override
  String? get defaultValue;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TokenPropertyImplCopyWith<_$TokenPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ComponentTokens {
  String get componentName => throw _privateConstructorUsedError;
  Map<String, TokenDefinition> get variantTokens =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComponentTokensCopyWith<ComponentTokens> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentTokensCopyWith<$Res> {
  factory $ComponentTokensCopyWith(
          ComponentTokens value, $Res Function(ComponentTokens) then) =
      _$ComponentTokensCopyWithImpl<$Res, ComponentTokens>;
  @useResult
  $Res call({String componentName, Map<String, TokenDefinition> variantTokens});
}

/// @nodoc
class _$ComponentTokensCopyWithImpl<$Res, $Val extends ComponentTokens>
    implements $ComponentTokensCopyWith<$Res> {
  _$ComponentTokensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? componentName = null,
    Object? variantTokens = null,
  }) {
    return _then(_value.copyWith(
      componentName: null == componentName
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      variantTokens: null == variantTokens
          ? _value.variantTokens
          : variantTokens // ignore: cast_nullable_to_non_nullable
              as Map<String, TokenDefinition>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComponentTokensImplCopyWith<$Res>
    implements $ComponentTokensCopyWith<$Res> {
  factory _$$ComponentTokensImplCopyWith(_$ComponentTokensImpl value,
          $Res Function(_$ComponentTokensImpl) then) =
      __$$ComponentTokensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String componentName, Map<String, TokenDefinition> variantTokens});
}

/// @nodoc
class __$$ComponentTokensImplCopyWithImpl<$Res>
    extends _$ComponentTokensCopyWithImpl<$Res, _$ComponentTokensImpl>
    implements _$$ComponentTokensImplCopyWith<$Res> {
  __$$ComponentTokensImplCopyWithImpl(
      _$ComponentTokensImpl _value, $Res Function(_$ComponentTokensImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? componentName = null,
    Object? variantTokens = null,
  }) {
    return _then(_$ComponentTokensImpl(
      componentName: null == componentName
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      variantTokens: null == variantTokens
          ? _value._variantTokens
          : variantTokens // ignore: cast_nullable_to_non_nullable
              as Map<String, TokenDefinition>,
    ));
  }
}

/// @nodoc

class _$ComponentTokensImpl implements _ComponentTokens {
  const _$ComponentTokensImpl(
      {required this.componentName,
      required final Map<String, TokenDefinition> variantTokens})
      : _variantTokens = variantTokens;

  @override
  final String componentName;
  final Map<String, TokenDefinition> _variantTokens;
  @override
  Map<String, TokenDefinition> get variantTokens {
    if (_variantTokens is EqualUnmodifiableMapView) return _variantTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_variantTokens);
  }

  @override
  String toString() {
    return 'ComponentTokens(componentName: $componentName, variantTokens: $variantTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentTokensImpl &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other._variantTokens, _variantTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, componentName,
      const DeepCollectionEquality().hash(_variantTokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentTokensImplCopyWith<_$ComponentTokensImpl> get copyWith =>
      __$$ComponentTokensImplCopyWithImpl<_$ComponentTokensImpl>(
          this, _$identity);
}

abstract class _ComponentTokens implements ComponentTokens {
  const factory _ComponentTokens(
          {required final String componentName,
          required final Map<String, TokenDefinition> variantTokens}) =
      _$ComponentTokensImpl;

  @override
  String get componentName;
  @override
  Map<String, TokenDefinition> get variantTokens;
  @override
  @JsonKey(ignore: true)
  _$$ComponentTokensImplCopyWith<_$ComponentTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
