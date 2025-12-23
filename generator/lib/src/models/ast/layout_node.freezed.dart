// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
App _$AppFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'structural':
      return StructuralApp.fromJson(json);
    case 'primitive':
      return PrimitiveApp.fromJson(json);
    case 'interactive':
      return InteractiveApp.fromJson(json);
    case 'custom':
      return CustomApp.fromJson(json);
    case 'appBar':
      return AppBarNode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'App',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$App {
  /// Serializes this App to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is App);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'App()';
  }
}

/// @nodoc
class $AppCopyWith<$Res> {
  $AppCopyWith(App _, $Res Function(App) __);
}

/// Adds pattern-matching-related methods to [App].
extension AppPatterns on App {
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
    TResult Function(StructuralApp value)? structural,
    TResult Function(PrimitiveApp value)? primitive,
    TResult Function(InteractiveApp value)? interactive,
    TResult Function(CustomApp value)? custom,
    TResult Function(AppBarNode value)? appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp() when structural != null:
        return structural(_that);
      case PrimitiveApp() when primitive != null:
        return primitive(_that);
      case InteractiveApp() when interactive != null:
        return interactive(_that);
      case CustomApp() when custom != null:
        return custom(_that);
      case AppBarNode() when appBar != null:
        return appBar(_that);
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
    required TResult Function(StructuralApp value) structural,
    required TResult Function(PrimitiveApp value) primitive,
    required TResult Function(InteractiveApp value) interactive,
    required TResult Function(CustomApp value) custom,
    required TResult Function(AppBarNode value) appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp():
        return structural(_that);
      case PrimitiveApp():
        return primitive(_that);
      case InteractiveApp():
        return interactive(_that);
      case CustomApp():
        return custom(_that);
      case AppBarNode():
        return appBar(_that);
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
    TResult? Function(StructuralApp value)? structural,
    TResult? Function(PrimitiveApp value)? primitive,
    TResult? Function(InteractiveApp value)? interactive,
    TResult? Function(CustomApp value)? custom,
    TResult? Function(AppBarNode value)? appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp() when structural != null:
        return structural(_that);
      case PrimitiveApp() when primitive != null:
        return primitive(_that);
      case InteractiveApp() when interactive != null:
        return interactive(_that);
      case CustomApp() when custom != null:
        return custom(_that);
      case AppBarNode() when appBar != null:
        return appBar(_that);
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
    TResult Function(StructuralNode node, NodeMetadata meta)? structural,
    TResult Function(PrimitiveNode node, NodeMetadata meta)? primitive,
    TResult Function(InteractiveNode node, NodeMetadata meta)? interactive,
    TResult Function(CustomNode node, NodeMetadata meta)? custom,
    TResult Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)?
        appBar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp() when structural != null:
        return structural(_that.node, _that.meta);
      case PrimitiveApp() when primitive != null:
        return primitive(_that.node, _that.meta);
      case InteractiveApp() when interactive != null:
        return interactive(_that.node, _that.meta);
      case CustomApp() when custom != null:
        return custom(_that.node, _that.meta);
      case AppBarNode() when appBar != null:
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
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
    required TResult Function(StructuralNode node, NodeMetadata meta)
        structural,
    required TResult Function(PrimitiveNode node, NodeMetadata meta) primitive,
    required TResult Function(InteractiveNode node, NodeMetadata meta)
        interactive,
    required TResult Function(CustomNode node, NodeMetadata meta) custom,
    required TResult Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp():
        return structural(_that.node, _that.meta);
      case PrimitiveApp():
        return primitive(_that.node, _that.meta);
      case InteractiveApp():
        return interactive(_that.node, _that.meta);
      case CustomApp():
        return custom(_that.node, _that.meta);
      case AppBarNode():
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
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
    TResult? Function(StructuralNode node, NodeMetadata meta)? structural,
    TResult? Function(PrimitiveNode node, NodeMetadata meta)? primitive,
    TResult? Function(InteractiveNode node, NodeMetadata meta)? interactive,
    TResult? Function(CustomNode node, NodeMetadata meta)? custom,
    TResult? Function(String? title, List<AppBarAction>? actions,
            String? leadingIcon, String? onLeadingPressed)?
        appBar,
  }) {
    final _that = this;
    switch (_that) {
      case StructuralApp() when structural != null:
        return structural(_that.node, _that.meta);
      case PrimitiveApp() when primitive != null:
        return primitive(_that.node, _that.meta);
      case InteractiveApp() when interactive != null:
        return interactive(_that.node, _that.meta);
      case CustomApp() when custom != null:
        return custom(_that.node, _that.meta);
      case AppBarNode() when appBar != null:
        return appBar(_that.title, _that.actions, _that.leadingIcon,
            _that.onLeadingPressed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class StructuralApp implements App {
  const StructuralApp(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'structural';
  factory StructuralApp.fromJson(Map<String, dynamic> json) =>
      _$StructuralAppFromJson(json);

  final StructuralNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StructuralAppCopyWith<StructuralApp> get copyWith =>
      _$StructuralAppCopyWithImpl<StructuralApp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StructuralAppToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StructuralApp &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'App.structural(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $StructuralAppCopyWith<$Res>
    implements $AppCopyWith<$Res> {
  factory $StructuralAppCopyWith(
          StructuralApp value, $Res Function(StructuralApp) _then) =
      _$StructuralAppCopyWithImpl;
  @useResult
  $Res call({StructuralNode node, NodeMetadata meta});

  $StructuralNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$StructuralAppCopyWithImpl<$Res>
    implements $StructuralAppCopyWith<$Res> {
  _$StructuralAppCopyWithImpl(this._self, this._then);

  final StructuralApp _self;
  final $Res Function(StructuralApp) _then;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(StructuralApp(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as StructuralNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StructuralNodeCopyWith<$Res> get node {
    return $StructuralNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class PrimitiveApp implements App {
  const PrimitiveApp(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'primitive';
  factory PrimitiveApp.fromJson(Map<String, dynamic> json) =>
      _$PrimitiveAppFromJson(json);

  final PrimitiveNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrimitiveAppCopyWith<PrimitiveApp> get copyWith =>
      _$PrimitiveAppCopyWithImpl<PrimitiveApp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PrimitiveAppToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrimitiveApp &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'App.primitive(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $PrimitiveAppCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory $PrimitiveAppCopyWith(
          PrimitiveApp value, $Res Function(PrimitiveApp) _then) =
      _$PrimitiveAppCopyWithImpl;
  @useResult
  $Res call({PrimitiveNode node, NodeMetadata meta});

  $PrimitiveNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$PrimitiveAppCopyWithImpl<$Res> implements $PrimitiveAppCopyWith<$Res> {
  _$PrimitiveAppCopyWithImpl(this._self, this._then);

  final PrimitiveApp _self;
  final $Res Function(PrimitiveApp) _then;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(PrimitiveApp(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as PrimitiveNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimitiveNodeCopyWith<$Res> get node {
    return $PrimitiveNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class InteractiveApp implements App {
  const InteractiveApp(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'interactive';
  factory InteractiveApp.fromJson(Map<String, dynamic> json) =>
      _$InteractiveAppFromJson(json);

  final InteractiveNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InteractiveAppCopyWith<InteractiveApp> get copyWith =>
      _$InteractiveAppCopyWithImpl<InteractiveApp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InteractiveAppToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InteractiveApp &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'App.interactive(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $InteractiveAppCopyWith<$Res>
    implements $AppCopyWith<$Res> {
  factory $InteractiveAppCopyWith(
          InteractiveApp value, $Res Function(InteractiveApp) _then) =
      _$InteractiveAppCopyWithImpl;
  @useResult
  $Res call({InteractiveNode node, NodeMetadata meta});

  $InteractiveNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$InteractiveAppCopyWithImpl<$Res>
    implements $InteractiveAppCopyWith<$Res> {
  _$InteractiveAppCopyWithImpl(this._self, this._then);

  final InteractiveApp _self;
  final $Res Function(InteractiveApp) _then;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(InteractiveApp(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as InteractiveNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractiveNodeCopyWith<$Res> get node {
    return $InteractiveNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class CustomApp implements App {
  const CustomApp(
      {required this.node,
      this.meta = const NodeMetadata(),
      final String? $type})
      : $type = $type ?? 'custom';
  factory CustomApp.fromJson(Map<String, dynamic> json) =>
      _$CustomAppFromJson(json);

  final CustomNode node;
  @JsonKey()
  final NodeMetadata meta;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomAppCopyWith<CustomApp> get copyWith =>
      _$CustomAppCopyWithImpl<CustomApp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomAppToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomApp &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, node, meta);

  @override
  String toString() {
    return 'App.custom(node: $node, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $CustomAppCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory $CustomAppCopyWith(CustomApp value, $Res Function(CustomApp) _then) =
      _$CustomAppCopyWithImpl;
  @useResult
  $Res call({CustomNode node, NodeMetadata meta});

  $CustomNodeCopyWith<$Res> get node;
  $NodeMetadataCopyWith<$Res> get meta;
}

/// @nodoc
class _$CustomAppCopyWithImpl<$Res> implements $CustomAppCopyWith<$Res> {
  _$CustomAppCopyWithImpl(this._self, this._then);

  final CustomApp _self;
  final $Res Function(CustomApp) _then;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? node = null,
    Object? meta = null,
  }) {
    return _then(CustomApp(
      node: null == node
          ? _self.node
          : node // ignore: cast_nullable_to_non_nullable
              as CustomNode,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NodeMetadata,
    ));
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomNodeCopyWith<$Res> get node {
    return $CustomNodeCopyWith<$Res>(_self.node, (value) {
      return _then(_self.copyWith(node: value));
    });
  }

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NodeMetadataCopyWith<$Res> get meta {
    return $NodeMetadataCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class AppBarNode implements App {
  const AppBarNode(
      {this.title,
      final List<AppBarAction>? actions,
      this.leadingIcon,
      this.onLeadingPressed,
      final String? $type})
      : _actions = actions,
        $type = $type ?? 'appBar';
  factory AppBarNode.fromJson(Map<String, dynamic> json) =>
      _$AppBarNodeFromJson(json);

  final String? title;
  final List<AppBarAction>? _actions;
  List<AppBarAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final String? leadingIcon;
  final String? onLeadingPressed;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppBarNodeCopyWith<AppBarNode> get copyWith =>
      _$AppBarNodeCopyWithImpl<AppBarNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppBarNodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppBarNode &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.leadingIcon, leadingIcon) ||
                other.leadingIcon == leadingIcon) &&
            (identical(other.onLeadingPressed, onLeadingPressed) ||
                other.onLeadingPressed == onLeadingPressed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_actions),
      leadingIcon,
      onLeadingPressed);

  @override
  String toString() {
    return 'App.appBar(title: $title, actions: $actions, leadingIcon: $leadingIcon, onLeadingPressed: $onLeadingPressed)';
  }
}

/// @nodoc
abstract mixin class $AppBarNodeCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory $AppBarNodeCopyWith(
          AppBarNode value, $Res Function(AppBarNode) _then) =
      _$AppBarNodeCopyWithImpl;
  @useResult
  $Res call(
      {String? title,
      List<AppBarAction>? actions,
      String? leadingIcon,
      String? onLeadingPressed});
}

/// @nodoc
class _$AppBarNodeCopyWithImpl<$Res> implements $AppBarNodeCopyWith<$Res> {
  _$AppBarNodeCopyWithImpl(this._self, this._then);

  final AppBarNode _self;
  final $Res Function(AppBarNode) _then;

  /// Create a copy of App
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? actions = freezed,
    Object? leadingIcon = freezed,
    Object? onLeadingPressed = freezed,
  }) {
    return _then(AppBarNode(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<AppBarAction>?,
      leadingIcon: freezed == leadingIcon
          ? _self.leadingIcon
          : leadingIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      onLeadingPressed: freezed == onLeadingPressed
          ? _self.onLeadingPressed
          : onLeadingPressed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
