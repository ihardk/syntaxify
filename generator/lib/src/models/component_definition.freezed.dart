// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComponentDefinition {
  String get name;
  String get className;
  List<ComponentProp> get properties;
  List<String> get variants;
  String? get description;

  /// Create a copy of ComponentDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComponentDefinitionCopyWith<ComponentDefinition> get copyWith =>
      _$ComponentDefinitionCopyWithImpl<ComponentDefinition>(
          this as ComponentDefinition, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComponentDefinition &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.className, className) ||
                other.className == className) &&
            const DeepCollectionEquality()
                .equals(other.properties, properties) &&
            const DeepCollectionEquality().equals(other.variants, variants) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      className,
      const DeepCollectionEquality().hash(properties),
      const DeepCollectionEquality().hash(variants),
      description);

  @override
  String toString() {
    return 'ComponentDefinition(name: $name, className: $className, properties: $properties, variants: $variants, description: $description)';
  }
}

/// @nodoc
abstract mixin class $ComponentDefinitionCopyWith<$Res> {
  factory $ComponentDefinitionCopyWith(
          ComponentDefinition value, $Res Function(ComponentDefinition) _then) =
      _$ComponentDefinitionCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String className,
      List<ComponentProp> properties,
      List<String> variants,
      String? description});
}

/// @nodoc
class _$ComponentDefinitionCopyWithImpl<$Res>
    implements $ComponentDefinitionCopyWith<$Res> {
  _$ComponentDefinitionCopyWithImpl(this._self, this._then);

  final ComponentDefinition _self;
  final $Res Function(ComponentDefinition) _then;

  /// Create a copy of ComponentDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? properties = null,
    Object? variants = null,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _self.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ComponentProp>,
      variants: null == variants
          ? _self.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComponentDefinition].
extension ComponentDefinitionPatterns on ComponentDefinition {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ComponentDefinition value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ComponentDefinition value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ComponentDefinition value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String name,
            String className,
            List<ComponentProp> properties,
            List<String> variants,
            String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition() when $default != null:
        return $default(_that.name, _that.className, _that.properties,
            _that.variants, _that.description);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String name,
            String className,
            List<ComponentProp> properties,
            List<String> variants,
            String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition():
        return $default(_that.name, _that.className, _that.properties,
            _that.variants, _that.description);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String name,
            String className,
            List<ComponentProp> properties,
            List<String> variants,
            String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentDefinition() when $default != null:
        return $default(_that.name, _that.className, _that.properties,
            _that.variants, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComponentDefinition implements ComponentDefinition {
  const _ComponentDefinition(
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

  /// Create a copy of ComponentDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComponentDefinitionCopyWith<_ComponentDefinition> get copyWith =>
      __$ComponentDefinitionCopyWithImpl<_ComponentDefinition>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComponentDefinition &&
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

  @override
  String toString() {
    return 'ComponentDefinition(name: $name, className: $className, properties: $properties, variants: $variants, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$ComponentDefinitionCopyWith<$Res>
    implements $ComponentDefinitionCopyWith<$Res> {
  factory _$ComponentDefinitionCopyWith(_ComponentDefinition value,
          $Res Function(_ComponentDefinition) _then) =
      __$ComponentDefinitionCopyWithImpl;
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
class __$ComponentDefinitionCopyWithImpl<$Res>
    implements _$ComponentDefinitionCopyWith<$Res> {
  __$ComponentDefinitionCopyWithImpl(this._self, this._then);

  final _ComponentDefinition _self;
  final $Res Function(_ComponentDefinition) _then;

  /// Create a copy of ComponentDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? className = null,
    Object? properties = null,
    Object? variants = null,
    Object? description = freezed,
  }) {
    return _then(_ComponentDefinition(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _self._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ComponentProp>,
      variants: null == variants
          ? _self._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComponentProp {
  String get name;
  String get type;
  bool get isRequired;
  String? get defaultValue;
  String? get description;

  /// Create a copy of ComponentProp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComponentPropCopyWith<ComponentProp> get copyWith =>
      _$ComponentPropCopyWithImpl<ComponentProp>(
          this as ComponentProp, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComponentProp &&
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

  @override
  String toString() {
    return 'ComponentProp(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue, description: $description)';
  }
}

/// @nodoc
abstract mixin class $ComponentPropCopyWith<$Res> {
  factory $ComponentPropCopyWith(
          ComponentProp value, $Res Function(ComponentProp) _then) =
      _$ComponentPropCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String type,
      bool isRequired,
      String? defaultValue,
      String? description});
}

/// @nodoc
class _$ComponentPropCopyWithImpl<$Res>
    implements $ComponentPropCopyWith<$Res> {
  _$ComponentPropCopyWithImpl(this._self, this._then);

  final ComponentProp _self;
  final $Res Function(ComponentProp) _then;

  /// Create a copy of ComponentProp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? isRequired = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: freezed == defaultValue
          ? _self.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComponentProp].
extension ComponentPropPatterns on ComponentProp {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ComponentProp value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentProp() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ComponentProp value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentProp():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ComponentProp value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentProp() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, String type, bool isRequired,
            String? defaultValue, String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentProp() when $default != null:
        return $default(_that.name, _that.type, _that.isRequired,
            _that.defaultValue, _that.description);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, String type, bool isRequired,
            String? defaultValue, String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentProp():
        return $default(_that.name, _that.type, _that.isRequired,
            _that.defaultValue, _that.description);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String name, String type, bool isRequired,
            String? defaultValue, String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentProp() when $default != null:
        return $default(_that.name, _that.type, _that.isRequired,
            _that.defaultValue, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComponentProp implements ComponentProp {
  const _ComponentProp(
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

  /// Create a copy of ComponentProp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComponentPropCopyWith<_ComponentProp> get copyWith =>
      __$ComponentPropCopyWithImpl<_ComponentProp>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComponentProp &&
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

  @override
  String toString() {
    return 'ComponentProp(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$ComponentPropCopyWith<$Res>
    implements $ComponentPropCopyWith<$Res> {
  factory _$ComponentPropCopyWith(
          _ComponentProp value, $Res Function(_ComponentProp) _then) =
      __$ComponentPropCopyWithImpl;
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
class __$ComponentPropCopyWithImpl<$Res>
    implements _$ComponentPropCopyWith<$Res> {
  __$ComponentPropCopyWithImpl(this._self, this._then);

  final _ComponentProp _self;
  final $Res Function(_ComponentProp) _then;

  /// Create a copy of ComponentProp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? isRequired = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_ComponentProp(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: freezed == defaultValue
          ? _self.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComponentEnum {
  String get name;
  List<String> get values;
  String? get description;

  /// Create a copy of ComponentEnum
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComponentEnumCopyWith<ComponentEnum> get copyWith =>
      _$ComponentEnumCopyWithImpl<ComponentEnum>(
          this as ComponentEnum, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComponentEnum &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.values, values) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(values), description);

  @override
  String toString() {
    return 'ComponentEnum(name: $name, values: $values, description: $description)';
  }
}

/// @nodoc
abstract mixin class $ComponentEnumCopyWith<$Res> {
  factory $ComponentEnumCopyWith(
          ComponentEnum value, $Res Function(ComponentEnum) _then) =
      _$ComponentEnumCopyWithImpl;
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class _$ComponentEnumCopyWithImpl<$Res>
    implements $ComponentEnumCopyWith<$Res> {
  _$ComponentEnumCopyWithImpl(this._self, this._then);

  final ComponentEnum _self;
  final $Res Function(ComponentEnum) _then;

  /// Create a copy of ComponentEnum
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _self.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComponentEnum].
extension ComponentEnumPatterns on ComponentEnum {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ComponentEnum value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ComponentEnum value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ComponentEnum value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, List<String> values, String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum() when $default != null:
        return $default(_that.name, _that.values, _that.description);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, List<String> values, String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum():
        return $default(_that.name, _that.values, _that.description);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String name, List<String> values, String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentEnum() when $default != null:
        return $default(_that.name, _that.values, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComponentEnum implements ComponentEnum {
  const _ComponentEnum(
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

  /// Create a copy of ComponentEnum
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComponentEnumCopyWith<_ComponentEnum> get copyWith =>
      __$ComponentEnumCopyWithImpl<_ComponentEnum>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComponentEnum &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_values), description);

  @override
  String toString() {
    return 'ComponentEnum(name: $name, values: $values, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$ComponentEnumCopyWith<$Res>
    implements $ComponentEnumCopyWith<$Res> {
  factory _$ComponentEnumCopyWith(
          _ComponentEnum value, $Res Function(_ComponentEnum) _then) =
      __$ComponentEnumCopyWithImpl;
  @override
  @useResult
  $Res call({String name, List<String> values, String? description});
}

/// @nodoc
class __$ComponentEnumCopyWithImpl<$Res>
    implements _$ComponentEnumCopyWith<$Res> {
  __$ComponentEnumCopyWithImpl(this._self, this._then);

  final _ComponentEnum _self;
  final $Res Function(_ComponentEnum) _then;

  /// Create a copy of ComponentEnum
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? description = freezed,
  }) {
    return _then(_ComponentEnum(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _self._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ParseResult {
  List<ComponentDefinition> get components;
  List<ScreenDefinition> get screens;
  List<ComponentEnum> get enums;
  List<String> get errors;

  /// Create a copy of ParseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParseResultCopyWith<ParseResult> get copyWith =>
      _$ParseResultCopyWithImpl<ParseResult>(this as ParseResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParseResult &&
            const DeepCollectionEquality()
                .equals(other.components, components) &&
            const DeepCollectionEquality().equals(other.screens, screens) &&
            const DeepCollectionEquality().equals(other.enums, enums) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(components),
      const DeepCollectionEquality().hash(screens),
      const DeepCollectionEquality().hash(enums),
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'ParseResult(components: $components, screens: $screens, enums: $enums, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $ParseResultCopyWith<$Res> {
  factory $ParseResultCopyWith(
          ParseResult value, $Res Function(ParseResult) _then) =
      _$ParseResultCopyWithImpl;
  @useResult
  $Res call(
      {List<ComponentDefinition> components,
      List<ScreenDefinition> screens,
      List<ComponentEnum> enums,
      List<String> errors});
}

/// @nodoc
class _$ParseResultCopyWithImpl<$Res> implements $ParseResultCopyWith<$Res> {
  _$ParseResultCopyWithImpl(this._self, this._then);

  final ParseResult _self;
  final $Res Function(ParseResult) _then;

  /// Create a copy of ParseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? components = null,
    Object? screens = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_self.copyWith(
      components: null == components
          ? _self.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentDefinition>,
      screens: null == screens
          ? _self.screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenDefinition>,
      enums: null == enums
          ? _self.enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<ComponentEnum>,
      errors: null == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ParseResult].
extension ParseResultPatterns on ParseResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ParseResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ParseResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ParseResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ParseResult():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ParseResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ParseResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<ComponentDefinition> components,
            List<ScreenDefinition> screens,
            List<ComponentEnum> enums,
            List<String> errors)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ParseResult() when $default != null:
        return $default(
            _that.components, _that.screens, _that.enums, _that.errors);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<ComponentDefinition> components,
            List<ScreenDefinition> screens,
            List<ComponentEnum> enums,
            List<String> errors)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ParseResult():
        return $default(
            _that.components, _that.screens, _that.enums, _that.errors);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<ComponentDefinition> components,
            List<ScreenDefinition> screens,
            List<ComponentEnum> enums,
            List<String> errors)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ParseResult() when $default != null:
        return $default(
            _that.components, _that.screens, _that.enums, _that.errors);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ParseResult extends ParseResult {
  const _ParseResult(
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

  /// Create a copy of ParseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParseResultCopyWith<_ParseResult> get copyWith =>
      __$ParseResultCopyWithImpl<_ParseResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ParseResult &&
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

  @override
  String toString() {
    return 'ParseResult(components: $components, screens: $screens, enums: $enums, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$ParseResultCopyWith<$Res>
    implements $ParseResultCopyWith<$Res> {
  factory _$ParseResultCopyWith(
          _ParseResult value, $Res Function(_ParseResult) _then) =
      __$ParseResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ComponentDefinition> components,
      List<ScreenDefinition> screens,
      List<ComponentEnum> enums,
      List<String> errors});
}

/// @nodoc
class __$ParseResultCopyWithImpl<$Res> implements _$ParseResultCopyWith<$Res> {
  __$ParseResultCopyWithImpl(this._self, this._then);

  final _ParseResult _self;
  final $Res Function(_ParseResult) _then;

  /// Create a copy of ParseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? components = null,
    Object? screens = null,
    Object? enums = null,
    Object? errors = null,
  }) {
    return _then(_ParseResult(
      components: null == components
          ? _self._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentDefinition>,
      screens: null == screens
          ? _self._screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenDefinition>,
      enums: null == enums
          ? _self._enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<ComponentEnum>,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
