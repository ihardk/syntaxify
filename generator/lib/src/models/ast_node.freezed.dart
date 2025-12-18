// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ast_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AstNode {
  String get name => throw _privateConstructorUsedError;
  String get className => throw _privateConstructorUsedError;
  List<AstProp> get properties => throw _privateConstructorUsedError;
  List<String> get variants => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AstNodeCopyWith<AstNode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AstNodeCopyWith<$Res> {
  factory $AstNodeCopyWith(AstNode value, $Res Function(AstNode) then) =
      _$AstNodeCopyWithImpl<$Res, AstNode>;
  @useResult
  $Res call(
      {String name,
      String className,
      List<AstProp> properties,
      List<String> variants,
      String? description});
}

/// @nodoc
class _$AstNodeCopyWithImpl<$Res, $Val extends AstNode>
    implements $AstNodeCopyWith<$Res> {
  _$AstNodeCopyWithImpl(this._value, this._then);

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
              as List<AstProp>,
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
abstract class _$$AstNodeImplCopyWith<$Res> implements $AstNodeCopyWith<$Res> {
  factory _$$AstNodeImplCopyWith(
          _$AstNodeImpl value, $Res Function(_$AstNodeImpl) then) =
      __$$AstNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String className,
      List<AstProp> properties,
      List<String> variants,
      String? description});
}

/// @nodoc
class __$$AstNodeImplCopyWithImpl<$Res>
    extends _$AstNodeCopyWithImpl<$Res, _$AstNodeImpl>
    implements _$$AstNodeImplCopyWith<$Res> {
  __$$AstNodeImplCopyWithImpl(
      _$AstNodeImpl _value, $Res Function(_$AstNodeImpl) _then)
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
    return _then(_$AstNodeImpl(
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
              as List<AstProp>,
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

class _$AstNodeImpl implements _AstNode {
  const _$AstNodeImpl(
      {required this.name,
      required this.className,
      required final List<AstProp> properties,
      required final List<String> variants,
      this.description})
      : _properties = properties,
        _variants = variants;

  @override
  final String name;
  @override
  final String className;
  final List<AstProp> _properties;
  @override
  List<AstProp> get properties {
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
    return 'AstNode(name: $name, className: $className, properties: $properties, variants: $variants, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AstNodeImpl &&
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
  _$$AstNodeImplCopyWith<_$AstNodeImpl> get copyWith =>
      __$$AstNodeImplCopyWithImpl<_$AstNodeImpl>(this, _$identity);
}

abstract class _AstNode implements AstNode {
  const factory _AstNode(
      {required final String name,
      required final String className,
      required final List<AstProp> properties,
      required final List<String> variants,
      final String? description}) = _$AstNodeImpl;

  @override
  String get name;
  @override
  String get className;
  @override
  List<AstProp> get properties;
  @override
  List<String> get variants;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$AstNodeImplCopyWith<_$AstNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AstProp {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AstPropCopyWith<AstProp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AstPropCopyWith<$Res> {
  factory $AstPropCopyWith(AstProp value, $Res Function(AstProp) then) =
      _$AstPropCopyWithImpl<$Res, AstProp>;
  @useResult
  $Res call(
      {String name,
      String type,
      bool isRequired,
      String? defaultValue,
      String? description});
}

/// @nodoc
class _$AstPropCopyWithImpl<$Res, $Val extends AstProp>
    implements $AstPropCopyWith<$Res> {
  _$AstPropCopyWithImpl(this._value, this._then);

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
abstract class _$$AstPropImplCopyWith<$Res> implements $AstPropCopyWith<$Res> {
  factory _$$AstPropImplCopyWith(
          _$AstPropImpl value, $Res Function(_$AstPropImpl) then) =
      __$$AstPropImplCopyWithImpl<$Res>;
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
class __$$AstPropImplCopyWithImpl<$Res>
    extends _$AstPropCopyWithImpl<$Res, _$AstPropImpl>
    implements _$$AstPropImplCopyWith<$Res> {
  __$$AstPropImplCopyWithImpl(
      _$AstPropImpl _value, $Res Function(_$AstPropImpl) _then)
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
    return _then(_$AstPropImpl(
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

class _$AstPropImpl implements _AstProp {
  const _$AstPropImpl(
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
    return 'AstProp(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AstPropImpl &&
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
  _$$AstPropImplCopyWith<_$AstPropImpl> get copyWith =>
      __$$AstPropImplCopyWithImpl<_$AstPropImpl>(this, _$identity);
}

abstract class _AstProp implements AstProp {
  const factory _AstProp(
      {required final String name,
      required final String type,
      required final bool isRequired,
      final String? defaultValue,
      final String? description}) = _$AstPropImpl;

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
  _$$AstPropImplCopyWith<_$AstPropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AstEnum {
  String get name => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AstEnumCopyWith<AstEnum> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AstEnumCopyWith<$Res> {
  factory $AstEnumCopyWith(AstEnum value, $Res Function(AstEnum) then) =
      _$AstEnumCopyWithImpl<$Res, AstEnum>;
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class _$AstEnumCopyWithImpl<$Res, $Val extends AstEnum>
    implements $AstEnumCopyWith<$Res> {
  _$AstEnumCopyWithImpl(this._value, this._then);

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
abstract class _$$AstEnumImplCopyWith<$Res> implements $AstEnumCopyWith<$Res> {
  factory _$$AstEnumImplCopyWith(
          _$AstEnumImpl value, $Res Function(_$AstEnumImpl) then) =
      __$$AstEnumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class __$$AstEnumImplCopyWithImpl<$Res>
    extends _$AstEnumCopyWithImpl<$Res, _$AstEnumImpl>
    implements _$$AstEnumImplCopyWith<$Res> {
  __$$AstEnumImplCopyWithImpl(
      _$AstEnumImpl _value, $Res Function(_$AstEnumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? description = freezed,
  }) {
    return _then(_$AstEnumImpl(
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

class _$AstEnumImpl implements _AstEnum {
  const _$AstEnumImpl(
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
    return 'AstEnum(name: $name, values: $values, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AstEnumImpl &&
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
  _$$AstEnumImplCopyWith<_$AstEnumImpl> get copyWith =>
      __$$AstEnumImplCopyWithImpl<_$AstEnumImpl>(this, _$identity);
}

abstract class _AstEnum implements AstEnum {
  const factory _AstEnum(
      {required final String name,
      required final List<String> values,
      final String? description}) = _$AstEnumImpl;

  @override
  String get name;
  @override
  List<String> get values;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$AstEnumImplCopyWith<_$AstEnumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ParseResult {
  List<AstNode> get nodes => throw _privateConstructorUsedError;
  List<AstEnum> get enums => throw _privateConstructorUsedError;
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
  $Res call({List<AstNode> nodes, List<AstEnum> enums, List<String> errors});
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
    Object? nodes = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<AstNode>,
      enums: null == enums
          ? _value.enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<AstEnum>,
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
  $Res call({List<AstNode> nodes, List<AstEnum> enums, List<String> errors});
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
    Object? nodes = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_$ParseResultImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<AstNode>,
      enums: null == enums
          ? _value._enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<AstEnum>,
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
      {required final List<AstNode> nodes,
      final List<AstEnum> enums = const [],
      required final List<String> errors})
      : _nodes = nodes,
        _enums = enums,
        _errors = errors,
        super._();

  final List<AstNode> _nodes;
  @override
  List<AstNode> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<AstEnum> _enums;
  @override
  @JsonKey()
  List<AstEnum> get enums {
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
    return 'ParseResult(nodes: $nodes, enums: $enums, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseResultImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._enums, _enums) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
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
      {required final List<AstNode> nodes,
      final List<AstEnum> enums,
      required final List<String> errors}) = _$ParseResultImpl;
  const _ParseResult._() : super._();

  @override
  List<AstNode> get nodes;
  @override
  List<AstEnum> get enums;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$ParseResultImplCopyWith<_$ParseResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
