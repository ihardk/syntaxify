// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interactive_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
InteractiveNode _$InteractiveNodeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'button':
      return ButtonNode.fromJson(json);
    case 'textField':
      return TextFieldNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'InteractiveNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$InteractiveNode {
  String? get label;
  Object? get props;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InteractiveNodeCopyWith<InteractiveNode> get copyWith =>
      _$InteractiveNodeCopyWithImpl<InteractiveNode>(
          this as InteractiveNode, _$identity);

  /// Serializes this InteractiveNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InteractiveNode &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other.props, props));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, label, const DeepCollectionEquality().hash(props));

  @override
  String toString() {
    return 'InteractiveNode(label: $label, props: $props)';
  }
}

/// @nodoc
abstract mixin class $InteractiveNodeCopyWith<$Res> {
  factory $InteractiveNodeCopyWith(
          InteractiveNode value, $Res Function(InteractiveNode) _then) =
      _$InteractiveNodeCopyWithImpl;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$InteractiveNodeCopyWithImpl<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  _$InteractiveNodeCopyWithImpl(this._self, this._then);

  final InteractiveNode _self;
  final $Res Function(InteractiveNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label!
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [InteractiveNode].
extension InteractiveNodePatterns on InteractiveNode {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ButtonNode value)? button,
    TResult Function(TextFieldNode value)? textField,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(ButtonNode value) button,
    required TResult Function(TextFieldNode value) textField,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode():
        return button(_that);
      case TextFieldNode():
        return textField(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ButtonNode value)? button,
    TResult? Function(TextFieldNode value)? textField,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, String? onPressed, ButtonProps? props)?
        button,
    TResult Function(String? label, String? binding, String? onChanged,
            String? onSubmitted, TextFieldProps? props)?
        textField,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode() when textField != null:
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
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
  TResult when<TResult extends Object?>({
    required TResult Function(
            String label, String? onPressed, ButtonProps? props)
        button,
    required TResult Function(String? label, String? binding, String? onChanged,
            String? onSubmitted, TextFieldProps? props)
        textField,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode():
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode():
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, String? onPressed, ButtonProps? props)?
        button,
    TResult? Function(String? label, String? binding, String? onChanged,
            String? onSubmitted, TextFieldProps? props)?
        textField,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode() when textField != null:
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class ButtonNode implements InteractiveNode {
  const ButtonNode(
      {required this.label, this.onPressed, this.props, final String? $type})
      : $type = $type ?? 'button';
  factory ButtonNode.fromJson(Map<String, dynamic> json) =>
      _$ButtonNodeFromJson(json);

  @override
  final String label;
  final String? onPressed;
  @override
  final ButtonProps? props;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonNodeCopyWith<ButtonNode> get copyWith =>
      _$ButtonNodeCopyWithImpl<ButtonNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ButtonNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonNode &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.props, props) || other.props == props));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, onPressed, props);

  @override
  String toString() {
    return 'InteractiveNode.button(label: $label, onPressed: $onPressed, props: $props)';
  }
}

/// @nodoc
abstract mixin class $ButtonNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $ButtonNodeCopyWith(
          ButtonNode value, $Res Function(ButtonNode) _then) =
      _$ButtonNodeCopyWithImpl;
  @override
  @useResult
  $Res call({String label, String? onPressed, ButtonProps? props});

  $ButtonPropsCopyWith<$Res>? get props;
}

/// @nodoc
class _$ButtonNodeCopyWithImpl<$Res> implements $ButtonNodeCopyWith<$Res> {
  _$ButtonNodeCopyWithImpl(this._self, this._then);

  final ButtonNode _self;
  final $Res Function(ButtonNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? onPressed = freezed,
    Object? props = freezed,
  }) {
    return _then(ButtonNode(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: freezed == onPressed
          ? _self.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String?,
      props: freezed == props
          ? _self.props
          : props // ignore: cast_nullable_to_non_nullable
              as ButtonProps?,
    ));
  }

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ButtonPropsCopyWith<$Res>? get props {
    if (_self.props == null) {
      return null;
    }

    return $ButtonPropsCopyWith<$Res>(_self.props!, (value) {
      return _then(_self.copyWith(props: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class TextFieldNode implements InteractiveNode {
  const TextFieldNode(
      {this.label,
      this.binding,
      this.onChanged,
      this.onSubmitted,
      this.props,
      final String? $type})
      : $type = $type ?? 'textField';
  factory TextFieldNode.fromJson(Map<String, dynamic> json) =>
      _$TextFieldNodeFromJson(json);

  @override
  final String? label;
  final String? binding;
  final String? onChanged;
  final String? onSubmitted;
  @override
  final TextFieldProps? props;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextFieldNodeCopyWith<TextFieldNode> get copyWith =>
      _$TextFieldNodeCopyWithImpl<TextFieldNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextFieldNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextFieldNode &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged) &&
            (identical(other.onSubmitted, onSubmitted) ||
                other.onSubmitted == onSubmitted) &&
            (identical(other.props, props) || other.props == props));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, label, binding, onChanged, onSubmitted, props);

  @override
  String toString() {
    return 'InteractiveNode.textField(label: $label, binding: $binding, onChanged: $onChanged, onSubmitted: $onSubmitted, props: $props)';
  }
}

/// @nodoc
abstract mixin class $TextFieldNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $TextFieldNodeCopyWith(
          TextFieldNode value, $Res Function(TextFieldNode) _then) =
      _$TextFieldNodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? label,
      String? binding,
      String? onChanged,
      String? onSubmitted,
      TextFieldProps? props});

  $TextFieldPropsCopyWith<$Res>? get props;
}

/// @nodoc
class _$TextFieldNodeCopyWithImpl<$Res>
    implements $TextFieldNodeCopyWith<$Res> {
  _$TextFieldNodeCopyWithImpl(this._self, this._then);

  final TextFieldNode _self;
  final $Res Function(TextFieldNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = freezed,
    Object? binding = freezed,
    Object? onChanged = freezed,
    Object? onSubmitted = freezed,
    Object? props = freezed,
  }) {
    return _then(TextFieldNode(
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      binding: freezed == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onSubmitted: freezed == onSubmitted
          ? _self.onSubmitted
          : onSubmitted // ignore: cast_nullable_to_non_nullable
              as String?,
      props: freezed == props
          ? _self.props
          : props // ignore: cast_nullable_to_non_nullable
              as TextFieldProps?,
    ));
  }

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextFieldPropsCopyWith<$Res>? get props {
    if (_self.props == null) {
      return null;
    }

    return $TextFieldPropsCopyWith<$Res>(_self.props!, (value) {
      return _then(_self.copyWith(props: value));
    });
  }
}

// dart format on
