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
    case 'checkbox':
      return CheckboxNode.fromJson(json);
    case 'toggleNode':
      return ToggleNode.fromJson(json);
    case 'iconButton':
      return IconButtonNode.fromJson(json);
    case 'dropdown':
      return DropdownNode.fromJson(json);
    case 'radio':
      return RadioNode.fromJson(json);
    case 'slider':
      return SliderNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'InteractiveNode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$InteractiveNode {
  /// Serializes this InteractiveNode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InteractiveNode);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'InteractiveNode()';
  }
}

/// @nodoc
class $InteractiveNodeCopyWith<$Res> {
  $InteractiveNodeCopyWith(
      InteractiveNode _, $Res Function(InteractiveNode) __);
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
    TResult Function(CheckboxNode value)? checkbox,
    TResult Function(ToggleNode value)? toggleNode,
    TResult Function(IconButtonNode value)? iconButton,
    TResult Function(DropdownNode value)? dropdown,
    TResult Function(RadioNode value)? radio,
    TResult Function(SliderNode value)? slider,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
      case CheckboxNode() when checkbox != null:
        return checkbox(_that);
      case ToggleNode() when toggleNode != null:
        return toggleNode(_that);
      case IconButtonNode() when iconButton != null:
        return iconButton(_that);
      case DropdownNode() when dropdown != null:
        return dropdown(_that);
      case RadioNode() when radio != null:
        return radio(_that);
      case SliderNode() when slider != null:
        return slider(_that);
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
    required TResult Function(CheckboxNode value) checkbox,
    required TResult Function(ToggleNode value) toggleNode,
    required TResult Function(IconButtonNode value) iconButton,
    required TResult Function(DropdownNode value) dropdown,
    required TResult Function(RadioNode value) radio,
    required TResult Function(SliderNode value) slider,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode():
        return button(_that);
      case TextFieldNode():
        return textField(_that);
      case CheckboxNode():
        return checkbox(_that);
      case ToggleNode():
        return toggleNode(_that);
      case IconButtonNode():
        return iconButton(_that);
      case DropdownNode():
        return dropdown(_that);
      case RadioNode():
        return radio(_that);
      case SliderNode():
        return slider(_that);
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
    TResult? Function(CheckboxNode value)? checkbox,
    TResult? Function(ToggleNode value)? toggleNode,
    TResult? Function(IconButtonNode value)? iconButton,
    TResult? Function(DropdownNode value)? dropdown,
    TResult? Function(RadioNode value)? radio,
    TResult? Function(SliderNode value)? slider,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that);
      case TextFieldNode() when textField != null:
        return textField(_that);
      case CheckboxNode() when checkbox != null:
        return checkbox(_that);
      case ToggleNode() when toggleNode != null:
        return toggleNode(_that);
      case IconButtonNode() when iconButton != null:
        return iconButton(_that);
      case DropdownNode() when dropdown != null:
        return dropdown(_that);
      case RadioNode() when radio != null:
        return radio(_that);
      case SliderNode() when slider != null:
        return slider(_that);
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
    TResult Function(
            String binding, String? label, String? onChanged, bool? tristate)?
        checkbox,
    TResult Function(String binding, String? label, String? onChanged)?
        toggleNode,
    TResult Function(
            String icon, String? onPressed, double? size, ColorSemantic? color)?
        iconButton,
    TResult Function(String binding, List<String> items, String? label,
            String? onChanged)?
        dropdown,
    TResult Function(
            String binding, String value, String? label, String? onChanged)?
        radio,
    TResult Function(String binding, double? min, double? max, int? divisions,
            String? label, String? onChanged)?
        slider,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode() when textField != null:
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
      case CheckboxNode() when checkbox != null:
        return checkbox(
            _that.binding, _that.label, _that.onChanged, _that.tristate);
      case ToggleNode() when toggleNode != null:
        return toggleNode(_that.binding, _that.label, _that.onChanged);
      case IconButtonNode() when iconButton != null:
        return iconButton(_that.icon, _that.onPressed, _that.size, _that.color);
      case DropdownNode() when dropdown != null:
        return dropdown(
            _that.binding, _that.items, _that.label, _that.onChanged);
      case RadioNode() when radio != null:
        return radio(_that.binding, _that.value, _that.label, _that.onChanged);
      case SliderNode() when slider != null:
        return slider(_that.binding, _that.min, _that.max, _that.divisions,
            _that.label, _that.onChanged);
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
    required TResult Function(
            String binding, String? label, String? onChanged, bool? tristate)
        checkbox,
    required TResult Function(String binding, String? label, String? onChanged)
        toggleNode,
    required TResult Function(
            String icon, String? onPressed, double? size, ColorSemantic? color)
        iconButton,
    required TResult Function(String binding, List<String> items, String? label,
            String? onChanged)
        dropdown,
    required TResult Function(
            String binding, String value, String? label, String? onChanged)
        radio,
    required TResult Function(String binding, double? min, double? max,
            int? divisions, String? label, String? onChanged)
        slider,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode():
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode():
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
      case CheckboxNode():
        return checkbox(
            _that.binding, _that.label, _that.onChanged, _that.tristate);
      case ToggleNode():
        return toggleNode(_that.binding, _that.label, _that.onChanged);
      case IconButtonNode():
        return iconButton(_that.icon, _that.onPressed, _that.size, _that.color);
      case DropdownNode():
        return dropdown(
            _that.binding, _that.items, _that.label, _that.onChanged);
      case RadioNode():
        return radio(_that.binding, _that.value, _that.label, _that.onChanged);
      case SliderNode():
        return slider(_that.binding, _that.min, _that.max, _that.divisions,
            _that.label, _that.onChanged);
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
    TResult? Function(
            String binding, String? label, String? onChanged, bool? tristate)?
        checkbox,
    TResult? Function(String binding, String? label, String? onChanged)?
        toggleNode,
    TResult? Function(
            String icon, String? onPressed, double? size, ColorSemantic? color)?
        iconButton,
    TResult? Function(String binding, List<String> items, String? label,
            String? onChanged)?
        dropdown,
    TResult? Function(
            String binding, String value, String? label, String? onChanged)?
        radio,
    TResult? Function(String binding, double? min, double? max, int? divisions,
            String? label, String? onChanged)?
        slider,
  }) {
    final _that = this;
    switch (_that) {
      case ButtonNode() when button != null:
        return button(_that.label, _that.onPressed, _that.props);
      case TextFieldNode() when textField != null:
        return textField(_that.label, _that.binding, _that.onChanged,
            _that.onSubmitted, _that.props);
      case CheckboxNode() when checkbox != null:
        return checkbox(
            _that.binding, _that.label, _that.onChanged, _that.tristate);
      case ToggleNode() when toggleNode != null:
        return toggleNode(_that.binding, _that.label, _that.onChanged);
      case IconButtonNode() when iconButton != null:
        return iconButton(_that.icon, _that.onPressed, _that.size, _that.color);
      case DropdownNode() when dropdown != null:
        return dropdown(
            _that.binding, _that.items, _that.label, _that.onChanged);
      case RadioNode() when radio != null:
        return radio(_that.binding, _that.value, _that.label, _that.onChanged);
      case SliderNode() when slider != null:
        return slider(_that.binding, _that.min, _that.max, _that.divisions,
            _that.label, _that.onChanged);
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

  final String label;
  final String? onPressed;
  final ButtonProps? props;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
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

  final String? label;
  final String? binding;
  final String? onChanged;
  final String? onSubmitted;
  final TextFieldProps? props;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
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

/// @nodoc
@JsonSerializable()
class CheckboxNode implements InteractiveNode {
  const CheckboxNode(
      {required this.binding,
      this.label,
      this.onChanged,
      this.tristate,
      final String? $type})
      : $type = $type ?? 'checkbox';
  factory CheckboxNode.fromJson(Map<String, dynamic> json) =>
      _$CheckboxNodeFromJson(json);

  final String binding;
  final String? label;
  final String? onChanged;
  final bool? tristate;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckboxNodeCopyWith<CheckboxNode> get copyWith =>
      _$CheckboxNodeCopyWithImpl<CheckboxNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CheckboxNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckboxNode &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged) &&
            (identical(other.tristate, tristate) ||
                other.tristate == tristate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, binding, label, onChanged, tristate);

  @override
  String toString() {
    return 'InteractiveNode.checkbox(binding: $binding, label: $label, onChanged: $onChanged, tristate: $tristate)';
  }
}

/// @nodoc
abstract mixin class $CheckboxNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $CheckboxNodeCopyWith(
          CheckboxNode value, $Res Function(CheckboxNode) _then) =
      _$CheckboxNodeCopyWithImpl;
  @useResult
  $Res call({String binding, String? label, String? onChanged, bool? tristate});
}

/// @nodoc
class _$CheckboxNodeCopyWithImpl<$Res> implements $CheckboxNodeCopyWith<$Res> {
  _$CheckboxNodeCopyWithImpl(this._self, this._then);

  final CheckboxNode _self;
  final $Res Function(CheckboxNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? binding = null,
    Object? label = freezed,
    Object? onChanged = freezed,
    Object? tristate = freezed,
  }) {
    return _then(CheckboxNode(
      binding: null == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      tristate: freezed == tristate
          ? _self.tristate
          : tristate // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ToggleNode implements InteractiveNode {
  const ToggleNode(
      {required this.binding, this.label, this.onChanged, final String? $type})
      : $type = $type ?? 'toggleNode';
  factory ToggleNode.fromJson(Map<String, dynamic> json) =>
      _$ToggleNodeFromJson(json);

  final String binding;
  final String? label;
  final String? onChanged;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToggleNodeCopyWith<ToggleNode> get copyWith =>
      _$ToggleNodeCopyWithImpl<ToggleNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToggleNode &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, binding, label, onChanged);

  @override
  String toString() {
    return 'InteractiveNode.toggleNode(binding: $binding, label: $label, onChanged: $onChanged)';
  }
}

/// @nodoc
abstract mixin class $ToggleNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $ToggleNodeCopyWith(
          ToggleNode value, $Res Function(ToggleNode) _then) =
      _$ToggleNodeCopyWithImpl;
  @useResult
  $Res call({String binding, String? label, String? onChanged});
}

/// @nodoc
class _$ToggleNodeCopyWithImpl<$Res> implements $ToggleNodeCopyWith<$Res> {
  _$ToggleNodeCopyWithImpl(this._self, this._then);

  final ToggleNode _self;
  final $Res Function(ToggleNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? binding = null,
    Object? label = freezed,
    Object? onChanged = freezed,
  }) {
    return _then(ToggleNode(
      binding: null == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class IconButtonNode implements InteractiveNode {
  const IconButtonNode(
      {required this.icon,
      this.onPressed,
      this.size,
      this.color,
      final String? $type})
      : $type = $type ?? 'iconButton';
  factory IconButtonNode.fromJson(Map<String, dynamic> json) =>
      _$IconButtonNodeFromJson(json);

  final String icon;
  final String? onPressed;
  final double? size;
  final ColorSemantic? color;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IconButtonNodeCopyWith<IconButtonNode> get copyWith =>
      _$IconButtonNodeCopyWithImpl<IconButtonNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IconButtonNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IconButtonNode &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, icon, onPressed, size, color);

  @override
  String toString() {
    return 'InteractiveNode.iconButton(icon: $icon, onPressed: $onPressed, size: $size, color: $color)';
  }
}

/// @nodoc
abstract mixin class $IconButtonNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $IconButtonNodeCopyWith(
          IconButtonNode value, $Res Function(IconButtonNode) _then) =
      _$IconButtonNodeCopyWithImpl;
  @useResult
  $Res call(
      {String icon, String? onPressed, double? size, ColorSemantic? color});
}

/// @nodoc
class _$IconButtonNodeCopyWithImpl<$Res>
    implements $IconButtonNodeCopyWith<$Res> {
  _$IconButtonNodeCopyWithImpl(this._self, this._then);

  final IconButtonNode _self;
  final $Res Function(IconButtonNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? icon = null,
    Object? onPressed = freezed,
    Object? size = freezed,
    Object? color = freezed,
  }) {
    return _then(IconButtonNode(
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: freezed == onPressed
          ? _self.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorSemantic?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class DropdownNode implements InteractiveNode {
  const DropdownNode(
      {required this.binding,
      required final List<String> items,
      this.label,
      this.onChanged,
      final String? $type})
      : _items = items,
        $type = $type ?? 'dropdown';
  factory DropdownNode.fromJson(Map<String, dynamic> json) =>
      _$DropdownNodeFromJson(json);

  final String binding;
  final List<String> _items;
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final String? label;
  final String? onChanged;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DropdownNodeCopyWith<DropdownNode> get copyWith =>
      _$DropdownNodeCopyWithImpl<DropdownNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DropdownNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DropdownNode &&
            (identical(other.binding, binding) || other.binding == binding) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, binding,
      const DeepCollectionEquality().hash(_items), label, onChanged);

  @override
  String toString() {
    return 'InteractiveNode.dropdown(binding: $binding, items: $items, label: $label, onChanged: $onChanged)';
  }
}

/// @nodoc
abstract mixin class $DropdownNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $DropdownNodeCopyWith(
          DropdownNode value, $Res Function(DropdownNode) _then) =
      _$DropdownNodeCopyWithImpl;
  @useResult
  $Res call(
      {String binding, List<String> items, String? label, String? onChanged});
}

/// @nodoc
class _$DropdownNodeCopyWithImpl<$Res> implements $DropdownNodeCopyWith<$Res> {
  _$DropdownNodeCopyWithImpl(this._self, this._then);

  final DropdownNode _self;
  final $Res Function(DropdownNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? binding = null,
    Object? items = null,
    Object? label = freezed,
    Object? onChanged = freezed,
  }) {
    return _then(DropdownNode(
      binding: null == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class RadioNode implements InteractiveNode {
  const RadioNode(
      {required this.binding,
      required this.value,
      this.label,
      this.onChanged,
      final String? $type})
      : $type = $type ?? 'radio';
  factory RadioNode.fromJson(Map<String, dynamic> json) =>
      _$RadioNodeFromJson(json);

  final String binding;
  final String value;
  final String? label;
  final String? onChanged;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RadioNodeCopyWith<RadioNode> get copyWith =>
      _$RadioNodeCopyWithImpl<RadioNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RadioNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RadioNode &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, binding, value, label, onChanged);

  @override
  String toString() {
    return 'InteractiveNode.radio(binding: $binding, value: $value, label: $label, onChanged: $onChanged)';
  }
}

/// @nodoc
abstract mixin class $RadioNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $RadioNodeCopyWith(RadioNode value, $Res Function(RadioNode) _then) =
      _$RadioNodeCopyWithImpl;
  @useResult
  $Res call({String binding, String value, String? label, String? onChanged});
}

/// @nodoc
class _$RadioNodeCopyWithImpl<$Res> implements $RadioNodeCopyWith<$Res> {
  _$RadioNodeCopyWithImpl(this._self, this._then);

  final RadioNode _self;
  final $Res Function(RadioNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? binding = null,
    Object? value = null,
    Object? label = freezed,
    Object? onChanged = freezed,
  }) {
    return _then(RadioNode(
      binding: null == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SliderNode implements InteractiveNode {
  const SliderNode(
      {required this.binding,
      this.min,
      this.max,
      this.divisions,
      this.label,
      this.onChanged,
      final String? $type})
      : $type = $type ?? 'slider';
  factory SliderNode.fromJson(Map<String, dynamic> json) =>
      _$SliderNodeFromJson(json);

  final String binding;
  final double? min;
  final double? max;
  final int? divisions;
  final String? label;
  final String? onChanged;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SliderNodeCopyWith<SliderNode> get copyWith =>
      _$SliderNodeCopyWithImpl<SliderNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SliderNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SliderNode &&
            (identical(other.binding, binding) || other.binding == binding) &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.divisions, divisions) ||
                other.divisions == divisions) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onChanged, onChanged) ||
                other.onChanged == onChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, binding, min, max, divisions, label, onChanged);

  @override
  String toString() {
    return 'InteractiveNode.slider(binding: $binding, min: $min, max: $max, divisions: $divisions, label: $label, onChanged: $onChanged)';
  }
}

/// @nodoc
abstract mixin class $SliderNodeCopyWith<$Res>
    implements $InteractiveNodeCopyWith<$Res> {
  factory $SliderNodeCopyWith(
          SliderNode value, $Res Function(SliderNode) _then) =
      _$SliderNodeCopyWithImpl;
  @useResult
  $Res call(
      {String binding,
      double? min,
      double? max,
      int? divisions,
      String? label,
      String? onChanged});
}

/// @nodoc
class _$SliderNodeCopyWithImpl<$Res> implements $SliderNodeCopyWith<$Res> {
  _$SliderNodeCopyWithImpl(this._self, this._then);

  final SliderNode _self;
  final $Res Function(SliderNode) _then;

  /// Create a copy of InteractiveNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? binding = null,
    Object? min = freezed,
    Object? max = freezed,
    Object? divisions = freezed,
    Object? label = freezed,
    Object? onChanged = freezed,
  }) {
    return _then(SliderNode(
      binding: null == binding
          ? _self.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as String,
      min: freezed == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
      divisions: freezed == divisions
          ? _self.divisions
          : divisions // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      onChanged: freezed == onChanged
          ? _self.onChanged
          : onChanged // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
