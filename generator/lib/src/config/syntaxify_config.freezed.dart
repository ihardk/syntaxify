// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syntaxify_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyntaxifyConfig {
  /// Directory containing `.meta.dart` and `.screen.dart` files.
  String get metaDir;

  /// Output directory for generated code.
  String get outputDir;

  /// Design system directory path.
  String get designSystemDir;

  /// Tokens directory path.
  String get tokensDir;

  /// Whether to generate screens from `.screen.dart` files.
  bool get generateScreens;

  /// Whether to generate components from `.meta.dart` files.
  bool get generateComponents;

  /// Create a copy of SyntaxifyConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyntaxifyConfigCopyWith<SyntaxifyConfig> get copyWith =>
      _$SyntaxifyConfigCopyWithImpl<SyntaxifyConfig>(
          this as SyntaxifyConfig, _$identity);

  /// Serializes this SyntaxifyConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SyntaxifyConfig &&
            (identical(other.metaDir, metaDir) || other.metaDir == metaDir) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.designSystemDir, designSystemDir) ||
                other.designSystemDir == designSystemDir) &&
            (identical(other.tokensDir, tokensDir) ||
                other.tokensDir == tokensDir) &&
            (identical(other.generateScreens, generateScreens) ||
                other.generateScreens == generateScreens) &&
            (identical(other.generateComponents, generateComponents) ||
                other.generateComponents == generateComponents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, metaDir, outputDir,
      designSystemDir, tokensDir, generateScreens, generateComponents);

  @override
  String toString() {
    return 'SyntaxifyConfig(metaDir: $metaDir, outputDir: $outputDir, designSystemDir: $designSystemDir, tokensDir: $tokensDir, generateScreens: $generateScreens, generateComponents: $generateComponents)';
  }
}

/// @nodoc
abstract mixin class $SyntaxifyConfigCopyWith<$Res> {
  factory $SyntaxifyConfigCopyWith(
          SyntaxifyConfig value, $Res Function(SyntaxifyConfig) _then) =
      _$SyntaxifyConfigCopyWithImpl;
  @useResult
  $Res call(
      {String metaDir,
      String outputDir,
      String designSystemDir,
      String tokensDir,
      bool generateScreens,
      bool generateComponents});
}

/// @nodoc
class _$SyntaxifyConfigCopyWithImpl<$Res>
    implements $SyntaxifyConfigCopyWith<$Res> {
  _$SyntaxifyConfigCopyWithImpl(this._self, this._then);

  final SyntaxifyConfig _self;
  final $Res Function(SyntaxifyConfig) _then;

  /// Create a copy of SyntaxifyConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metaDir = null,
    Object? outputDir = null,
    Object? designSystemDir = null,
    Object? tokensDir = null,
    Object? generateScreens = null,
    Object? generateComponents = null,
  }) {
    return _then(_self.copyWith(
      metaDir: null == metaDir
          ? _self.metaDir
          : metaDir // ignore: cast_nullable_to_non_nullable
              as String,
      outputDir: null == outputDir
          ? _self.outputDir
          : outputDir // ignore: cast_nullable_to_non_nullable
              as String,
      designSystemDir: null == designSystemDir
          ? _self.designSystemDir
          : designSystemDir // ignore: cast_nullable_to_non_nullable
              as String,
      tokensDir: null == tokensDir
          ? _self.tokensDir
          : tokensDir // ignore: cast_nullable_to_non_nullable
              as String,
      generateScreens: null == generateScreens
          ? _self.generateScreens
          : generateScreens // ignore: cast_nullable_to_non_nullable
              as bool,
      generateComponents: null == generateComponents
          ? _self.generateComponents
          : generateComponents // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyntaxifyConfig].
extension SyntaxifyConfigPatterns on SyntaxifyConfig {
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
    TResult Function(_SyntaxifyConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig() when $default != null:
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
    TResult Function(_SyntaxifyConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig():
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
    TResult? Function(_SyntaxifyConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig() when $default != null:
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
    TResult Function(String metaDir, String outputDir, String designSystemDir,
            String tokensDir, bool generateScreens, bool generateComponents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig() when $default != null:
        return $default(_that.metaDir, _that.outputDir, _that.designSystemDir,
            _that.tokensDir, _that.generateScreens, _that.generateComponents);
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
    TResult Function(String metaDir, String outputDir, String designSystemDir,
            String tokensDir, bool generateScreens, bool generateComponents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig():
        return $default(_that.metaDir, _that.outputDir, _that.designSystemDir,
            _that.tokensDir, _that.generateScreens, _that.generateComponents);
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
    TResult? Function(String metaDir, String outputDir, String designSystemDir,
            String tokensDir, bool generateScreens, bool generateComponents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyntaxifyConfig() when $default != null:
        return $default(_that.metaDir, _that.outputDir, _that.designSystemDir,
            _that.tokensDir, _that.generateScreens, _that.generateComponents);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SyntaxifyConfig implements SyntaxifyConfig {
  const _SyntaxifyConfig(
      {this.metaDir = 'meta',
      this.outputDir = 'lib/syntaxify',
      this.designSystemDir = 'lib/syntaxify/design_system',
      this.tokensDir = 'lib/syntaxify/design_system',
      this.generateScreens = true,
      this.generateComponents = true});
  factory _SyntaxifyConfig.fromJson(Map<String, dynamic> json) =>
      _$SyntaxifyConfigFromJson(json);

  /// Directory containing `.meta.dart` and `.screen.dart` files.
  @override
  @JsonKey()
  final String metaDir;

  /// Output directory for generated code.
  @override
  @JsonKey()
  final String outputDir;

  /// Design system directory path.
  @override
  @JsonKey()
  final String designSystemDir;

  /// Tokens directory path.
  @override
  @JsonKey()
  final String tokensDir;

  /// Whether to generate screens from `.screen.dart` files.
  @override
  @JsonKey()
  final bool generateScreens;

  /// Whether to generate components from `.meta.dart` files.
  @override
  @JsonKey()
  final bool generateComponents;

  /// Create a copy of SyntaxifyConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyntaxifyConfigCopyWith<_SyntaxifyConfig> get copyWith =>
      __$SyntaxifyConfigCopyWithImpl<_SyntaxifyConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SyntaxifyConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SyntaxifyConfig &&
            (identical(other.metaDir, metaDir) || other.metaDir == metaDir) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.designSystemDir, designSystemDir) ||
                other.designSystemDir == designSystemDir) &&
            (identical(other.tokensDir, tokensDir) ||
                other.tokensDir == tokensDir) &&
            (identical(other.generateScreens, generateScreens) ||
                other.generateScreens == generateScreens) &&
            (identical(other.generateComponents, generateComponents) ||
                other.generateComponents == generateComponents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, metaDir, outputDir,
      designSystemDir, tokensDir, generateScreens, generateComponents);

  @override
  String toString() {
    return 'SyntaxifyConfig(metaDir: $metaDir, outputDir: $outputDir, designSystemDir: $designSystemDir, tokensDir: $tokensDir, generateScreens: $generateScreens, generateComponents: $generateComponents)';
  }
}

/// @nodoc
abstract mixin class _$SyntaxifyConfigCopyWith<$Res>
    implements $SyntaxifyConfigCopyWith<$Res> {
  factory _$SyntaxifyConfigCopyWith(
          _SyntaxifyConfig value, $Res Function(_SyntaxifyConfig) _then) =
      __$SyntaxifyConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String metaDir,
      String outputDir,
      String designSystemDir,
      String tokensDir,
      bool generateScreens,
      bool generateComponents});
}

/// @nodoc
class __$SyntaxifyConfigCopyWithImpl<$Res>
    implements _$SyntaxifyConfigCopyWith<$Res> {
  __$SyntaxifyConfigCopyWithImpl(this._self, this._then);

  final _SyntaxifyConfig _self;
  final $Res Function(_SyntaxifyConfig) _then;

  /// Create a copy of SyntaxifyConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? metaDir = null,
    Object? outputDir = null,
    Object? designSystemDir = null,
    Object? tokensDir = null,
    Object? generateScreens = null,
    Object? generateComponents = null,
  }) {
    return _then(_SyntaxifyConfig(
      metaDir: null == metaDir
          ? _self.metaDir
          : metaDir // ignore: cast_nullable_to_non_nullable
              as String,
      outputDir: null == outputDir
          ? _self.outputDir
          : outputDir // ignore: cast_nullable_to_non_nullable
              as String,
      designSystemDir: null == designSystemDir
          ? _self.designSystemDir
          : designSystemDir // ignore: cast_nullable_to_non_nullable
              as String,
      tokensDir: null == tokensDir
          ? _self.tokensDir
          : tokensDir // ignore: cast_nullable_to_non_nullable
              as String,
      generateScreens: null == generateScreens
          ? _self.generateScreens
          : generateScreens // ignore: cast_nullable_to_non_nullable
              as bool,
      generateComponents: null == generateComponents
          ? _self.generateComponents
          : generateComponents // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
