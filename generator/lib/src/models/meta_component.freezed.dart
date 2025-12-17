// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meta_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MetaComponent {
  String get name => throw _privateConstructorUsedError;
  String get className => throw _privateConstructorUsedError;
  List<MetaField> get fields => throw _privateConstructorUsedError;
  List<String> get variants => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MetaComponentCopyWith<MetaComponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaComponentCopyWith<$Res> {
  factory $MetaComponentCopyWith(
          MetaComponent value, $Res Function(MetaComponent) then) =
      _$MetaComponentCopyWithImpl<$Res, MetaComponent>;
  @useResult
  $Res call(
      {String name,
      String className,
      List<MetaField> fields,
      List<String> variants,
      String? description});
}

/// @nodoc
class _$MetaComponentCopyWithImpl<$Res, $Val extends MetaComponent>
    implements $MetaComponentCopyWith<$Res> {
  _$MetaComponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? fields = null,
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
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<MetaField>,
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
abstract class _$$MetaComponentImplCopyWith<$Res>
    implements $MetaComponentCopyWith<$Res> {
  factory _$$MetaComponentImplCopyWith(
          _$MetaComponentImpl value, $Res Function(_$MetaComponentImpl) then) =
      __$$MetaComponentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String className,
      List<MetaField> fields,
      List<String> variants,
      String? description});
}

/// @nodoc
class __$$MetaComponentImplCopyWithImpl<$Res>
    extends _$MetaComponentCopyWithImpl<$Res, _$MetaComponentImpl>
    implements _$$MetaComponentImplCopyWith<$Res> {
  __$$MetaComponentImplCopyWithImpl(
      _$MetaComponentImpl _value, $Res Function(_$MetaComponentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? fields = null,
    Object? variants = null,
    Object? description = freezed,
  }) {
    return _then(_$MetaComponentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<MetaField>,
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

class _$MetaComponentImpl implements _MetaComponent {
  const _$MetaComponentImpl(
      {required this.name,
      required this.className,
      required final List<MetaField> fields,
      required final List<String> variants,
      this.description})
      : _fields = fields,
        _variants = variants;

  @override
  final String name;
  @override
  final String className;
  final List<MetaField> _fields;
  @override
  List<MetaField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
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
    return 'MetaComponent(name: $name, className: $className, fields: $fields, variants: $variants, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaComponentImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.className, className) ||
                other.className == className) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      className,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_variants),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaComponentImplCopyWith<_$MetaComponentImpl> get copyWith =>
      __$$MetaComponentImplCopyWithImpl<_$MetaComponentImpl>(this, _$identity);
}

abstract class _MetaComponent implements MetaComponent {
  const factory _MetaComponent(
      {required final String name,
      required final String className,
      required final List<MetaField> fields,
      required final List<String> variants,
      final String? description}) = _$MetaComponentImpl;

  @override
  String get name;
  @override
  String get className;
  @override
  List<MetaField> get fields;
  @override
  List<String> get variants;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MetaComponentImplCopyWith<_$MetaComponentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MetaField {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MetaFieldCopyWith<MetaField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaFieldCopyWith<$Res> {
  factory $MetaFieldCopyWith(MetaField value, $Res Function(MetaField) then) =
      _$MetaFieldCopyWithImpl<$Res, MetaField>;
  @useResult
  $Res call(
      {String name,
      String type,
      bool isRequired,
      String? defaultValue,
      String? description});
}

/// @nodoc
class _$MetaFieldCopyWithImpl<$Res, $Val extends MetaField>
    implements $MetaFieldCopyWith<$Res> {
  _$MetaFieldCopyWithImpl(this._value, this._then);

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
abstract class _$$MetaFieldImplCopyWith<$Res>
    implements $MetaFieldCopyWith<$Res> {
  factory _$$MetaFieldImplCopyWith(
          _$MetaFieldImpl value, $Res Function(_$MetaFieldImpl) then) =
      __$$MetaFieldImplCopyWithImpl<$Res>;
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
class __$$MetaFieldImplCopyWithImpl<$Res>
    extends _$MetaFieldCopyWithImpl<$Res, _$MetaFieldImpl>
    implements _$$MetaFieldImplCopyWith<$Res> {
  __$$MetaFieldImplCopyWithImpl(
      _$MetaFieldImpl _value, $Res Function(_$MetaFieldImpl) _then)
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
    return _then(_$MetaFieldImpl(
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

class _$MetaFieldImpl implements _MetaField {
  const _$MetaFieldImpl(
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
    return 'MetaField(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaFieldImpl &&
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
  _$$MetaFieldImplCopyWith<_$MetaFieldImpl> get copyWith =>
      __$$MetaFieldImplCopyWithImpl<_$MetaFieldImpl>(this, _$identity);
}

abstract class _MetaField implements MetaField {
  const factory _MetaField(
      {required final String name,
      required final String type,
      required final bool isRequired,
      final String? defaultValue,
      final String? description}) = _$MetaFieldImpl;

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
  _$$MetaFieldImplCopyWith<_$MetaFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ParseResult {
  List<MetaComponent> get components => throw _privateConstructorUsedError;
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
  $Res call({List<MetaComponent> components, List<String> errors});
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
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<MetaComponent>,
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
  $Res call({List<MetaComponent> components, List<String> errors});
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
    Object? errors = null,
  }) {
    return _then(_$ParseResultImpl(
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<MetaComponent>,
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
      {required final List<MetaComponent> components,
      required final List<String> errors})
      : _components = components,
        _errors = errors,
        super._();

  final List<MetaComponent> _components;
  @override
  List<MetaComponent> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
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
    return 'ParseResult(components: $components, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseResultImpl &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_components),
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParseResultImplCopyWith<_$ParseResultImpl> get copyWith =>
      __$$ParseResultImplCopyWithImpl<_$ParseResultImpl>(this, _$identity);
}

abstract class _ParseResult extends ParseResult {
  const factory _ParseResult(
      {required final List<MetaComponent> components,
      required final List<String> errors}) = _$ParseResultImpl;
  const _ParseResult._() : super._();

  @override
  List<MetaComponent> get components;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$ParseResultImplCopyWith<_$ParseResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
