// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ButtonProps {
  String? get variant;
  ButtonSize? get size;
  String? get icon;
  IconPosition? get iconPosition;
  bool get isLoading;
  bool get isDisabled;
  bool get fullWidth;

  /// Create a copy of ButtonProps
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonPropsCopyWith<ButtonProps> get copyWith =>
      _$ButtonPropsCopyWithImpl<ButtonProps>(this as ButtonProps, _$identity);

  /// Serializes this ButtonProps to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonProps &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconPosition, iconPosition) ||
                other.iconPosition == iconPosition) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled) &&
            (identical(other.fullWidth, fullWidth) ||
                other.fullWidth == fullWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, variant, size, icon,
      iconPosition, isLoading, isDisabled, fullWidth);

  @override
  String toString() {
    return 'ButtonProps(variant: $variant, size: $size, icon: $icon, iconPosition: $iconPosition, isLoading: $isLoading, isDisabled: $isDisabled, fullWidth: $fullWidth)';
  }
}

/// @nodoc
abstract mixin class $ButtonPropsCopyWith<$Res> {
  factory $ButtonPropsCopyWith(
          ButtonProps value, $Res Function(ButtonProps) _then) =
      _$ButtonPropsCopyWithImpl;
  @useResult
  $Res call(
      {String? variant,
      ButtonSize? size,
      String? icon,
      IconPosition? iconPosition,
      bool isLoading,
      bool isDisabled,
      bool fullWidth});
}

/// @nodoc
class _$ButtonPropsCopyWithImpl<$Res> implements $ButtonPropsCopyWith<$Res> {
  _$ButtonPropsCopyWithImpl(this._self, this._then);

  final ButtonProps _self;
  final $Res Function(ButtonProps) _then;

  /// Create a copy of ButtonProps
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? variant = freezed,
    Object? size = freezed,
    Object? icon = freezed,
    Object? iconPosition = freezed,
    Object? isLoading = null,
    Object? isDisabled = null,
    Object? fullWidth = null,
  }) {
    return _then(_self.copyWith(
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as ButtonSize?,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPosition: freezed == iconPosition
          ? _self.iconPosition
          : iconPosition // ignore: cast_nullable_to_non_nullable
              as IconPosition?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDisabled: null == isDisabled
          ? _self.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fullWidth: null == fullWidth
          ? _self.fullWidth
          : fullWidth // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ButtonProps].
extension ButtonPropsPatterns on ButtonProps {
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
    TResult Function(_ButtonProps value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ButtonProps() when $default != null:
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
    TResult Function(_ButtonProps value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ButtonProps():
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
    TResult? Function(_ButtonProps value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ButtonProps() when $default != null:
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
            String? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool isLoading,
            bool isDisabled,
            bool fullWidth)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ButtonProps() when $default != null:
        return $default(
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
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
            String? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool isLoading,
            bool isDisabled,
            bool fullWidth)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ButtonProps():
        return $default(
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
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
            String? variant,
            ButtonSize? size,
            String? icon,
            IconPosition? iconPosition,
            bool isLoading,
            bool isDisabled,
            bool fullWidth)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ButtonProps() when $default != null:
        return $default(
            _that.variant,
            _that.size,
            _that.icon,
            _that.iconPosition,
            _that.isLoading,
            _that.isDisabled,
            _that.fullWidth);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ButtonProps implements ButtonProps {
  const _ButtonProps(
      {this.variant,
      this.size,
      this.icon,
      this.iconPosition,
      this.isLoading = false,
      this.isDisabled = false,
      this.fullWidth = false});
  factory _ButtonProps.fromJson(Map<String, dynamic> json) =>
      _$ButtonPropsFromJson(json);

  @override
  final String? variant;
  @override
  final ButtonSize? size;
  @override
  final String? icon;
  @override
  final IconPosition? iconPosition;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isDisabled;
  @override
  @JsonKey()
  final bool fullWidth;

  /// Create a copy of ButtonProps
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ButtonPropsCopyWith<_ButtonProps> get copyWith =>
      __$ButtonPropsCopyWithImpl<_ButtonProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ButtonPropsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ButtonProps &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconPosition, iconPosition) ||
                other.iconPosition == iconPosition) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled) &&
            (identical(other.fullWidth, fullWidth) ||
                other.fullWidth == fullWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, variant, size, icon,
      iconPosition, isLoading, isDisabled, fullWidth);

  @override
  String toString() {
    return 'ButtonProps(variant: $variant, size: $size, icon: $icon, iconPosition: $iconPosition, isLoading: $isLoading, isDisabled: $isDisabled, fullWidth: $fullWidth)';
  }
}

/// @nodoc
abstract mixin class _$ButtonPropsCopyWith<$Res>
    implements $ButtonPropsCopyWith<$Res> {
  factory _$ButtonPropsCopyWith(
          _ButtonProps value, $Res Function(_ButtonProps) _then) =
      __$ButtonPropsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? variant,
      ButtonSize? size,
      String? icon,
      IconPosition? iconPosition,
      bool isLoading,
      bool isDisabled,
      bool fullWidth});
}

/// @nodoc
class __$ButtonPropsCopyWithImpl<$Res> implements _$ButtonPropsCopyWith<$Res> {
  __$ButtonPropsCopyWithImpl(this._self, this._then);

  final _ButtonProps _self;
  final $Res Function(_ButtonProps) _then;

  /// Create a copy of ButtonProps
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? variant = freezed,
    Object? size = freezed,
    Object? icon = freezed,
    Object? iconPosition = freezed,
    Object? isLoading = null,
    Object? isDisabled = null,
    Object? fullWidth = null,
  }) {
    return _then(_ButtonProps(
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as ButtonSize?,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPosition: freezed == iconPosition
          ? _self.iconPosition
          : iconPosition // ignore: cast_nullable_to_non_nullable
              as IconPosition?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDisabled: null == isDisabled
          ? _self.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fullWidth: null == fullWidth
          ? _self.fullWidth
          : fullWidth // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$TextFieldProps {
  String? get hint;
  String? get helperText;
  String? get prefixIcon;
  String? get suffixIcon;
  KeyboardType? get keyboardType;
  TextInputAction? get textInputAction;
  bool get obscureText;
  String? get errorText;
  int? get maxLines;
  int? get maxLength;
  String? get variant;

  /// Create a copy of TextFieldProps
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextFieldPropsCopyWith<TextFieldProps> get copyWith =>
      _$TextFieldPropsCopyWithImpl<TextFieldProps>(
          this as TextFieldProps, _$identity);

  /// Serializes this TextFieldProps to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextFieldProps &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.helperText, helperText) ||
                other.helperText == helperText) &&
            (identical(other.prefixIcon, prefixIcon) ||
                other.prefixIcon == prefixIcon) &&
            (identical(other.suffixIcon, suffixIcon) ||
                other.suffixIcon == suffixIcon) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            (identical(other.textInputAction, textInputAction) ||
                other.textInputAction == textInputAction) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength) &&
            (identical(other.variant, variant) || other.variant == variant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hint,
      helperText,
      prefixIcon,
      suffixIcon,
      keyboardType,
      textInputAction,
      obscureText,
      errorText,
      maxLines,
      maxLength,
      variant);

  @override
  String toString() {
    return 'TextFieldProps(hint: $hint, helperText: $helperText, prefixIcon: $prefixIcon, suffixIcon: $suffixIcon, keyboardType: $keyboardType, textInputAction: $textInputAction, obscureText: $obscureText, errorText: $errorText, maxLines: $maxLines, maxLength: $maxLength, variant: $variant)';
  }
}

/// @nodoc
abstract mixin class $TextFieldPropsCopyWith<$Res> {
  factory $TextFieldPropsCopyWith(
          TextFieldProps value, $Res Function(TextFieldProps) _then) =
      _$TextFieldPropsCopyWithImpl;
  @useResult
  $Res call(
      {String? hint,
      String? helperText,
      String? prefixIcon,
      String? suffixIcon,
      KeyboardType? keyboardType,
      TextInputAction? textInputAction,
      bool obscureText,
      String? errorText,
      int? maxLines,
      int? maxLength,
      String? variant});
}

/// @nodoc
class _$TextFieldPropsCopyWithImpl<$Res>
    implements $TextFieldPropsCopyWith<$Res> {
  _$TextFieldPropsCopyWithImpl(this._self, this._then);

  final TextFieldProps _self;
  final $Res Function(TextFieldProps) _then;

  /// Create a copy of TextFieldProps
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hint = freezed,
    Object? helperText = freezed,
    Object? prefixIcon = freezed,
    Object? suffixIcon = freezed,
    Object? keyboardType = freezed,
    Object? textInputAction = freezed,
    Object? obscureText = null,
    Object? errorText = freezed,
    Object? maxLines = freezed,
    Object? maxLength = freezed,
    Object? variant = freezed,
  }) {
    return _then(_self.copyWith(
      hint: freezed == hint
          ? _self.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _self.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixIcon: freezed == prefixIcon
          ? _self.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixIcon: freezed == suffixIcon
          ? _self.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _self.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as KeyboardType?,
      textInputAction: freezed == textInputAction
          ? _self.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
      obscureText: null == obscureText
          ? _self.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: freezed == errorText
          ? _self.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _self.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TextFieldProps].
extension TextFieldPropsPatterns on TextFieldProps {
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
    TResult Function(_TextFieldProps value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps() when $default != null:
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
    TResult Function(_TextFieldProps value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps():
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
    TResult? Function(_TextFieldProps value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps() when $default != null:
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
            String? hint,
            String? helperText,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            String? variant)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps() when $default != null:
        return $default(
            _that.hint,
            _that.helperText,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
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
            String? hint,
            String? helperText,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            String? variant)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps():
        return $default(
            _that.hint,
            _that.helperText,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
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
            String? hint,
            String? helperText,
            String? prefixIcon,
            String? suffixIcon,
            KeyboardType? keyboardType,
            TextInputAction? textInputAction,
            bool obscureText,
            String? errorText,
            int? maxLines,
            int? maxLength,
            String? variant)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldProps() when $default != null:
        return $default(
            _that.hint,
            _that.helperText,
            _that.prefixIcon,
            _that.suffixIcon,
            _that.keyboardType,
            _that.textInputAction,
            _that.obscureText,
            _that.errorText,
            _that.maxLines,
            _that.maxLength,
            _that.variant);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TextFieldProps implements TextFieldProps {
  const _TextFieldProps(
      {this.hint,
      this.helperText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.textInputAction,
      this.obscureText = false,
      this.errorText,
      this.maxLines,
      this.maxLength,
      this.variant});
  factory _TextFieldProps.fromJson(Map<String, dynamic> json) =>
      _$TextFieldPropsFromJson(json);

  @override
  final String? hint;
  @override
  final String? helperText;
  @override
  final String? prefixIcon;
  @override
  final String? suffixIcon;
  @override
  final KeyboardType? keyboardType;
  @override
  final TextInputAction? textInputAction;
  @override
  @JsonKey()
  final bool obscureText;
  @override
  final String? errorText;
  @override
  final int? maxLines;
  @override
  final int? maxLength;
  @override
  final String? variant;

  /// Create a copy of TextFieldProps
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextFieldPropsCopyWith<_TextFieldProps> get copyWith =>
      __$TextFieldPropsCopyWithImpl<_TextFieldProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextFieldPropsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextFieldProps &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.helperText, helperText) ||
                other.helperText == helperText) &&
            (identical(other.prefixIcon, prefixIcon) ||
                other.prefixIcon == prefixIcon) &&
            (identical(other.suffixIcon, suffixIcon) ||
                other.suffixIcon == suffixIcon) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            (identical(other.textInputAction, textInputAction) ||
                other.textInputAction == textInputAction) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength) &&
            (identical(other.variant, variant) || other.variant == variant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hint,
      helperText,
      prefixIcon,
      suffixIcon,
      keyboardType,
      textInputAction,
      obscureText,
      errorText,
      maxLines,
      maxLength,
      variant);

  @override
  String toString() {
    return 'TextFieldProps(hint: $hint, helperText: $helperText, prefixIcon: $prefixIcon, suffixIcon: $suffixIcon, keyboardType: $keyboardType, textInputAction: $textInputAction, obscureText: $obscureText, errorText: $errorText, maxLines: $maxLines, maxLength: $maxLength, variant: $variant)';
  }
}

/// @nodoc
abstract mixin class _$TextFieldPropsCopyWith<$Res>
    implements $TextFieldPropsCopyWith<$Res> {
  factory _$TextFieldPropsCopyWith(
          _TextFieldProps value, $Res Function(_TextFieldProps) _then) =
      __$TextFieldPropsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? hint,
      String? helperText,
      String? prefixIcon,
      String? suffixIcon,
      KeyboardType? keyboardType,
      TextInputAction? textInputAction,
      bool obscureText,
      String? errorText,
      int? maxLines,
      int? maxLength,
      String? variant});
}

/// @nodoc
class __$TextFieldPropsCopyWithImpl<$Res>
    implements _$TextFieldPropsCopyWith<$Res> {
  __$TextFieldPropsCopyWithImpl(this._self, this._then);

  final _TextFieldProps _self;
  final $Res Function(_TextFieldProps) _then;

  /// Create a copy of TextFieldProps
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hint = freezed,
    Object? helperText = freezed,
    Object? prefixIcon = freezed,
    Object? suffixIcon = freezed,
    Object? keyboardType = freezed,
    Object? textInputAction = freezed,
    Object? obscureText = null,
    Object? errorText = freezed,
    Object? maxLines = freezed,
    Object? maxLength = freezed,
    Object? variant = freezed,
  }) {
    return _then(_TextFieldProps(
      hint: freezed == hint
          ? _self.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      helperText: freezed == helperText
          ? _self.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixIcon: freezed == prefixIcon
          ? _self.prefixIcon
          : prefixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixIcon: freezed == suffixIcon
          ? _self.suffixIcon
          : suffixIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _self.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as KeyboardType?,
      textInputAction: freezed == textInputAction
          ? _self.textInputAction
          : textInputAction // ignore: cast_nullable_to_non_nullable
              as TextInputAction?,
      obscureText: null == obscureText
          ? _self.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: freezed == errorText
          ? _self.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _self.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
