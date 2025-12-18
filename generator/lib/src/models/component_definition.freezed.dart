// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ComponentDefinition {
  String get name => throw _privateConstructorUsedError;
  String get className => throw _privateConstructorUsedError;
  List<ComponentProp> get properties => throw _privateConstructorUsedError;
  List<String> get variants => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComponentDefinitionCopyWith<ComponentDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentDefinitionCopyWith<$Res> {
  factory $ComponentDefinitionCopyWith(
          ComponentDefinition value, $Res Function(ComponentDefinition) then) =
      _$ComponentDefinitionCopyWithImpl<$Res, ComponentDefinition>;
  @useResult
  $Res call(
      {String name,
      String className,
      List<ComponentProp> properties,
      List<String> variants,
      String? description});
}

/// @nodoc
class _$ComponentDefinitionCopyWithImpl<$Res, $Val extends ComponentDefinition>
    implements $ComponentDefinitionCopyWith<$Res> {
  _$ComponentDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? properties = null,
    Object? variants = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ComponentProp>,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComponentDefinitionImplCopyWith<$Res>
    implements $ComponentDefinitionCopyWith<$Res> {
  factory _$$ComponentDefinitionImplCopyWith(_$ComponentDefinitionImpl value,
          $Res Function(_$ComponentDefinitionImpl) then) =
      __$$ComponentDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String className,
      List<ComponentProp> properties,
      List<String> variants,
      String? description});
}

/// @nodoc
class __$$ComponentDefinitionImplCopyWithImpl<$Res>
    extends _$ComponentDefinitionCopyWithImpl<$Res, _$ComponentDefinitionImpl>
    implements _$$ComponentDefinitionImplCopyWith<$Res> {
  __$$ComponentDefinitionImplCopyWithImpl(_$ComponentDefinitionImpl _value,
      $Res Function(_$ComponentDefinitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? properties = null,
    Object? variants = null,
    Object? description = freezed,
  }) {
    return _then(_$ComponentDefinitionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ComponentProp>,
      variants: null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ComponentDefinitionImpl implements _ComponentDefinition {
  const _$ComponentDefinitionImpl(
      {required this.name,
      required this.className,
      required final List<ComponentProp> properties,
      required final List<String> variants,
      this.description})
      : _properties = properties,
        _variants = variants;

  @override
  final String name;
  @override
  final String className;
  final List<ComponentProp> _properties;
  @override
  List<ComponentProp> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  final List<String> _variants;
  @override
  List<String> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  final String? description;

  @override
  String toString() {
    return 'ComponentDefinition(name: $name, className: $className, properties: $properties, variants: $variants, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentDefinitionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.className, className) ||
                other.className == className) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      className,
      const DeepCollectionEquality().hash(_properties),
      const DeepCollectionEquality().hash(_variants),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentDefinitionImplCopyWith<_$ComponentDefinitionImpl> get copyWith =>
      __$$ComponentDefinitionImplCopyWithImpl<_$ComponentDefinitionImpl>(
          this, _$identity);
}

abstract class _ComponentDefinition implements ComponentDefinition {
  const factory _ComponentDefinition(
      {required final String name,
      required final String className,
      required final List<ComponentProp> properties,
      required final List<String> variants,
      final String? description}) = _$ComponentDefinitionImpl;

  @override
  String get name;
  @override
  String get className;
  @override
  List<ComponentProp> get properties;
  @override
  List<String> get variants;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$ComponentDefinitionImplCopyWith<_$ComponentDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ComponentProp {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComponentPropCopyWith<ComponentProp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentPropCopyWith<$Res> {
  factory $ComponentPropCopyWith(
          ComponentProp value, $Res Function(ComponentProp) then) =
      _$ComponentPropCopyWithImpl<$Res, ComponentProp>;
  @useResult
  $Res call(
      {String name,
      String type,
      bool isRequired,
      String? defaultValue,
      String? description});
}

/// @nodoc
class _$ComponentPropCopyWithImpl<$Res, $Val extends ComponentProp>
    implements $ComponentPropCopyWith<$Res> {
  _$ComponentPropCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? isRequired = null,
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
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$ComponentPropImplCopyWith<$Res>
    implements $ComponentPropCopyWith<$Res> {
  factory _$$ComponentPropImplCopyWith(
          _$ComponentPropImpl value, $Res Function(_$ComponentPropImpl) then) =
      __$$ComponentPropImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      bool isRequired,
      String? defaultValue,
      String? description});
}

/// @nodoc
class __$$ComponentPropImplCopyWithImpl<$Res>
    extends _$ComponentPropCopyWithImpl<$Res, _$ComponentPropImpl>
    implements _$$ComponentPropImplCopyWith<$Res> {
  __$$ComponentPropImplCopyWithImpl(
      _$ComponentPropImpl _value, $Res Function(_$ComponentPropImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? isRequired = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_$ComponentPropImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$ComponentPropImpl implements _ComponentProp {
  const _$ComponentPropImpl(
      {required this.name,
      required this.type,
      required this.isRequired,
      this.defaultValue,
      this.description});

  @override
  final String name;
  @override
  final String type;
  @override
  final bool isRequired;
  @override
  final String? defaultValue;
  @override
  final String? description;

  @override
  String toString() {
    return 'ComponentProp(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentPropImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.defaultValue, defaultValue) ||
                other.defaultValue == defaultValue) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, type, isRequired, defaultValue, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentPropImplCopyWith<_$ComponentPropImpl> get copyWith =>
      __$$ComponentPropImplCopyWithImpl<_$ComponentPropImpl>(this, _$identity);
}

abstract class _ComponentProp implements ComponentProp {
  const factory _ComponentProp(
      {required final String name,
      required final String type,
      required final bool isRequired,
      final String? defaultValue,
      final String? description}) = _$ComponentPropImpl;

  @override
  String get name;
  @override
  String get type;
  @override
  bool get isRequired;
  @override
  String? get defaultValue;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$ComponentPropImplCopyWith<_$ComponentPropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ComponentEnum {
  String get name => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComponentEnumCopyWith<ComponentEnum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentEnumCopyWith<$Res> {
  factory $ComponentEnumCopyWith(
          ComponentEnum value, $Res Function(ComponentEnum) then) =
      _$ComponentEnumCopyWithImpl<$Res, ComponentEnum>;
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class _$ComponentEnumCopyWithImpl<$Res, $Val extends ComponentEnum>
    implements $ComponentEnumCopyWith<$Res> {
  _$ComponentEnumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComponentEnumImplCopyWith<$Res>
    implements $ComponentEnumCopyWith<$Res> {
  factory _$$ComponentEnumImplCopyWith(
          _$ComponentEnumImpl value, $Res Function(_$ComponentEnumImpl) then) =
      __$$ComponentEnumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class __$$ComponentEnumImplCopyWithImpl<$Res>
    extends _$ComponentEnumCopyWithImpl<$Res, _$ComponentEnumImpl>
    implements _$$ComponentEnumImplCopyWith<$Res> {
  __$$ComponentEnumImplCopyWithImpl(
      _$ComponentEnumImpl _value, $Res Function(_$ComponentEnumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? description = freezed,
  }) {
    return _then(_$ComponentEnumImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ComponentEnumImpl implements _ComponentEnum {
  const _$ComponentEnumImpl(
      {required this.name,
      required final List<String> values,
      this.description})
      : _values = values;

  @override
  final String name;
  final List<String> _values;
  @override
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  final String? description;

  @override
  String toString() {
    return 'ComponentEnum(name: $name, values: $values, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentEnumImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_values), description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentEnumImplCopyWith<_$ComponentEnumImpl> get copyWith =>
      __$$ComponentEnumImplCopyWithImpl<_$ComponentEnumImpl>(this, _$identity);
}

abstract class _ComponentEnum implements ComponentEnum {
  const factory _ComponentEnum(
      {required final String name,
      required final List<String> values,
      final String? description}) = _$ComponentEnumImpl;

  @override
  String get name;
  @override
  List<String> get values;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$ComponentEnumImplCopyWith<_$ComponentEnumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ParseResult {
  List<ComponentDefinition> get components =>
      throw _privateConstructorUsedError;
  List<ScreenDefinition> get screens => throw _privateConstructorUsedError;
  List<ComponentEnum> get enums => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ParseResultCopyWith<ParseResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParseResultCopyWith<$Res> {
  factory $ParseResultCopyWith(
          ParseResult value, $Res Function(ParseResult) then) =
      _$ParseResultCopyWithImpl<$Res, ParseResult>;
  @useResult
  $Res call(
      {List<ComponentDefinition> components,
      List<ScreenDefinition> screens,
      List<ComponentEnum> enums,
      List<String> errors});
}

/// @nodoc
class _$ParseResultCopyWithImpl<$Res, $Val extends ParseResult>
    implements $ParseResultCopyWith<$Res> {
  _$ParseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? components = null,
    Object? screens = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentDefinition>,
      screens: null == screens
          ? _value.screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenDefinition>,
      enums: null == enums
          ? _value.enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<ComponentEnum>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParseResultImplCopyWith<$Res>
    implements $ParseResultCopyWith<$Res> {
  factory _$$ParseResultImplCopyWith(
          _$ParseResultImpl value, $Res Function(_$ParseResultImpl) then) =
      __$$ParseResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ComponentDefinition> components,
      List<ScreenDefinition> screens,
      List<ComponentEnum> enums,
      List<String> errors});
}

/// @nodoc
class __$$ParseResultImplCopyWithImpl<$Res>
    extends _$ParseResultCopyWithImpl<$Res, _$ParseResultImpl>
    implements _$$ParseResultImplCopyWith<$Res> {
  __$$ParseResultImplCopyWithImpl(
      _$ParseResultImpl _value, $Res Function(_$ParseResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? components = null,
    Object? screens = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_$ParseResultImpl(
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentDefinition>,
      screens: null == screens
          ? _value._screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenDefinition>,
      enums: null == enums
          ? _value._enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<ComponentEnum>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ParseResultImpl extends _ParseResult {
  const _$ParseResultImpl(
      {required final List<ComponentDefinition> components,
      final List<ScreenDefinition> screens = const [],
      final List<ComponentEnum> enums = const [],
      required final List<String> errors})
      : _components = components,
        _screens = screens,
        _enums = enums,
        _errors = errors,
        super._();

  final List<ComponentDefinition> _components;
  @override
  List<ComponentDefinition> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  final List<ScreenDefinition> _screens;
  @override
  @JsonKey()
  List<ScreenDefinition> get screens {
    if (_screens is EqualUnmodifiableListView) return _screens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screens);
  }

  final List<ComponentEnum> _enums;
  @override
  @JsonKey()
  List<ComponentEnum> get enums {
    if (_enums is EqualUnmodifiableListView) return _enums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enums);
  }

  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'ParseResult(components: $components, screens: $screens, enums: $enums, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseResultImpl &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            const DeepCollectionEquality().equals(other._screens, _screens) &&
            const DeepCollectionEquality().equals(other._enums, _enums) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_components),
      const DeepCollectionEquality().hash(_screens),
      const DeepCollectionEquality().hash(_enums),
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParseResultImplCopyWith<_$ParseResultImpl> get copyWith =>
      __$$ParseResultImplCopyWithImpl<_$ParseResultImpl>(this, _$identity);
}

abstract class _ParseResult extends ParseResult {
  const factory _ParseResult(
      {required final List<ComponentDefinition> components,
      final List<ScreenDefinition> screens,
      final List<ComponentEnum> enums,
      required final List<String> errors}) = _$ParseResultImpl;
  const _ParseResult._() : super._();

  @override
  List<ComponentDefinition> get components;
  @override
  List<ScreenDefinition> get screens;
  @override
  List<ComponentEnum> get enums;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$ParseResultImplCopyWith<_$ParseResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
