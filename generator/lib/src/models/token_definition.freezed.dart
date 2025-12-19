// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenDefinition {
  String get name;
  String get componentName;
  List<TokenProperty> get properties;

  /// Create a copy of TokenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenDefinitionCopyWith<TokenDefinition> get copyWith =>
      _$TokenDefinitionCopyWithImpl<TokenDefinition>(
          this as TokenDefinition, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenDefinition &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other.properties, properties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, componentName,
      const DeepCollectionEquality().hash(properties));

  @override
  String toString() {
    return 'TokenDefinition(name: $name, componentName: $componentName, properties: $properties)';
  }
}

/// @nodoc
abstract mixin class $TokenDefinitionCopyWith<$Res> {
  factory $TokenDefinitionCopyWith(
          TokenDefinition value, $Res Function(TokenDefinition) _then) =
      _$TokenDefinitionCopyWithImpl;
  @useResult
  $Res call(
      {String name, String componentName, List<TokenProperty> properties});
}

/// @nodoc
class _$TokenDefinitionCopyWithImpl<$Res>
    implements $TokenDefinitionCopyWith<$Res> {
  _$TokenDefinitionCopyWithImpl(this._self, this._then);

  final TokenDefinition _self;
  final $Res Function(TokenDefinition) _then;

  /// Create a copy of TokenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? componentName = null,
    Object? properties = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: null == componentName
          ? _self.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _self.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<TokenProperty>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TokenDefinition].
extension TokenDefinitionPatterns on TokenDefinition {
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
    TResult Function(_TokenDefinition value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition() when $default != null:
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
    TResult Function(_TokenDefinition value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition():
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
    TResult? Function(_TokenDefinition value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition() when $default != null:
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
            String name, String componentName, List<TokenProperty> properties)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition() when $default != null:
        return $default(_that.name, _that.componentName, _that.properties);
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
            String name, String componentName, List<TokenProperty> properties)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition():
        return $default(_that.name, _that.componentName, _that.properties);
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
            String name, String componentName, List<TokenProperty> properties)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenDefinition() when $default != null:
        return $default(_that.name, _that.componentName, _that.properties);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TokenDefinition implements TokenDefinition {
  const _TokenDefinition(
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

  /// Create a copy of TokenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenDefinitionCopyWith<_TokenDefinition> get copyWith =>
      __$TokenDefinitionCopyWithImpl<_TokenDefinition>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenDefinition &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, componentName,
      const DeepCollectionEquality().hash(_properties));

  @override
  String toString() {
    return 'TokenDefinition(name: $name, componentName: $componentName, properties: $properties)';
  }
}

/// @nodoc
abstract mixin class _$TokenDefinitionCopyWith<$Res>
    implements $TokenDefinitionCopyWith<$Res> {
  factory _$TokenDefinitionCopyWith(
          _TokenDefinition value, $Res Function(_TokenDefinition) _then) =
      __$TokenDefinitionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name, String componentName, List<TokenProperty> properties});
}

/// @nodoc
class __$TokenDefinitionCopyWithImpl<$Res>
    implements _$TokenDefinitionCopyWith<$Res> {
  __$TokenDefinitionCopyWithImpl(this._self, this._then);

  final _TokenDefinition _self;
  final $Res Function(_TokenDefinition) _then;

  /// Create a copy of TokenDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? componentName = null,
    Object? properties = null,
  }) {
    return _then(_TokenDefinition(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: null == componentName
          ? _self.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _self._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<TokenProperty>,
    ));
  }
}

/// @nodoc
mixin _$TokenProperty {
  String get name;
  String get type;
  String? get defaultValue;
  String? get description;

  /// Create a copy of TokenProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenPropertyCopyWith<TokenProperty> get copyWith =>
      _$TokenPropertyCopyWithImpl<TokenProperty>(
          this as TokenProperty, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenProperty &&
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

  @override
  String toString() {
    return 'TokenProperty(name: $name, type: $type, defaultValue: $defaultValue, description: $description)';
  }
}

/// @nodoc
abstract mixin class $TokenPropertyCopyWith<$Res> {
  factory $TokenPropertyCopyWith(
          TokenProperty value, $Res Function(TokenProperty) _then) =
      _$TokenPropertyCopyWithImpl;
  @useResult
  $Res call(
      {String name, String type, String? defaultValue, String? description});
}

/// @nodoc
class _$TokenPropertyCopyWithImpl<$Res>
    implements $TokenPropertyCopyWith<$Res> {
  _$TokenPropertyCopyWithImpl(this._self, this._then);

  final TokenProperty _self;
  final $Res Function(TokenProperty) _then;

  /// Create a copy of TokenProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
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

/// Adds pattern-matching-related methods to [TokenProperty].
extension TokenPropertyPatterns on TokenProperty {
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
    TResult Function(_TokenProperty value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenProperty() when $default != null:
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
    TResult Function(_TokenProperty value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenProperty():
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
    TResult? Function(_TokenProperty value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenProperty() when $default != null:
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
    TResult Function(String name, String type, String? defaultValue,
            String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenProperty() when $default != null:
        return $default(
            _that.name, _that.type, _that.defaultValue, _that.description);
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
            String name, String type, String? defaultValue, String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenProperty():
        return $default(
            _that.name, _that.type, _that.defaultValue, _that.description);
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
    TResult? Function(String name, String type, String? defaultValue,
            String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenProperty() when $default != null:
        return $default(
            _that.name, _that.type, _that.defaultValue, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TokenProperty implements TokenProperty {
  const _TokenProperty(
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

  /// Create a copy of TokenProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenPropertyCopyWith<_TokenProperty> get copyWith =>
      __$TokenPropertyCopyWithImpl<_TokenProperty>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenProperty &&
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

  @override
  String toString() {
    return 'TokenProperty(name: $name, type: $type, defaultValue: $defaultValue, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$TokenPropertyCopyWith<$Res>
    implements $TokenPropertyCopyWith<$Res> {
  factory _$TokenPropertyCopyWith(
          _TokenProperty value, $Res Function(_TokenProperty) _then) =
      __$TokenPropertyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name, String type, String? defaultValue, String? description});
}

/// @nodoc
class __$TokenPropertyCopyWithImpl<$Res>
    implements _$TokenPropertyCopyWith<$Res> {
  __$TokenPropertyCopyWithImpl(this._self, this._then);

  final _TokenProperty _self;
  final $Res Function(_TokenProperty) _then;

  /// Create a copy of TokenProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? defaultValue = freezed,
    Object? description = freezed,
  }) {
    return _then(_TokenProperty(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
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
mixin _$ComponentTokens {
  String get componentName;
  Map<String, TokenDefinition> get variantTokens;

  /// Create a copy of ComponentTokens
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComponentTokensCopyWith<ComponentTokens> get copyWith =>
      _$ComponentTokensCopyWithImpl<ComponentTokens>(
          this as ComponentTokens, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComponentTokens &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other.variantTokens, variantTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, componentName,
      const DeepCollectionEquality().hash(variantTokens));

  @override
  String toString() {
    return 'ComponentTokens(componentName: $componentName, variantTokens: $variantTokens)';
  }
}

/// @nodoc
abstract mixin class $ComponentTokensCopyWith<$Res> {
  factory $ComponentTokensCopyWith(
          ComponentTokens value, $Res Function(ComponentTokens) _then) =
      _$ComponentTokensCopyWithImpl;
  @useResult
  $Res call({String componentName, Map<String, TokenDefinition> variantTokens});
}

/// @nodoc
class _$ComponentTokensCopyWithImpl<$Res>
    implements $ComponentTokensCopyWith<$Res> {
  _$ComponentTokensCopyWithImpl(this._self, this._then);

  final ComponentTokens _self;
  final $Res Function(ComponentTokens) _then;

  /// Create a copy of ComponentTokens
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? componentName = null,
    Object? variantTokens = null,
  }) {
    return _then(_self.copyWith(
      componentName: null == componentName
          ? _self.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      variantTokens: null == variantTokens
          ? _self.variantTokens
          : variantTokens // ignore: cast_nullable_to_non_nullable
              as Map<String, TokenDefinition>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComponentTokens].
extension ComponentTokensPatterns on ComponentTokens {
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
    TResult Function(_ComponentTokens value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens() when $default != null:
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
    TResult Function(_ComponentTokens value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens():
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
    TResult? Function(_ComponentTokens value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens() when $default != null:
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
            String componentName, Map<String, TokenDefinition> variantTokens)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens() when $default != null:
        return $default(_that.componentName, _that.variantTokens);
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
            String componentName, Map<String, TokenDefinition> variantTokens)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens():
        return $default(_that.componentName, _that.variantTokens);
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
            String componentName, Map<String, TokenDefinition> variantTokens)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComponentTokens() when $default != null:
        return $default(_that.componentName, _that.variantTokens);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComponentTokens implements ComponentTokens {
  const _ComponentTokens(
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

  /// Create a copy of ComponentTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComponentTokensCopyWith<_ComponentTokens> get copyWith =>
      __$ComponentTokensCopyWithImpl<_ComponentTokens>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComponentTokens &&
            (identical(other.componentName, componentName) ||
                other.componentName == componentName) &&
            const DeepCollectionEquality()
                .equals(other._variantTokens, _variantTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, componentName,
      const DeepCollectionEquality().hash(_variantTokens));

  @override
  String toString() {
    return 'ComponentTokens(componentName: $componentName, variantTokens: $variantTokens)';
  }
}

/// @nodoc
abstract mixin class _$ComponentTokensCopyWith<$Res>
    implements $ComponentTokensCopyWith<$Res> {
  factory _$ComponentTokensCopyWith(
          _ComponentTokens value, $Res Function(_ComponentTokens) _then) =
      __$ComponentTokensCopyWithImpl;
  @override
  @useResult
  $Res call({String componentName, Map<String, TokenDefinition> variantTokens});
}

/// @nodoc
class __$ComponentTokensCopyWithImpl<$Res>
    implements _$ComponentTokensCopyWith<$Res> {
  __$ComponentTokensCopyWithImpl(this._self, this._then);

  final _ComponentTokens _self;
  final $Res Function(_ComponentTokens) _then;

  /// Create a copy of ComponentTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? componentName = null,
    Object? variantTokens = null,
  }) {
    return _then(_ComponentTokens(
      componentName: null == componentName
          ? _self.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      variantTokens: null == variantTokens
          ? _self._variantTokens
          : variantTokens // ignore: cast_nullable_to_non_nullable
              as Map<String, TokenDefinition>,
    ));
  }
}

// dart format on
