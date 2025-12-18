// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bar_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppBarAction _$AppBarActionFromJson(Map<String, dynamic> json) {
  return _AppBarAction.fromJson(json);
}

/// @nodoc
mixin _$AppBarAction {
  String get icon => throw _privateConstructorUsedError;
  String get onPressed => throw _privateConstructorUsedError;
  String? get tooltip => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppBarActionCopyWith<AppBarAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBarActionCopyWith<$Res> {
  factory $AppBarActionCopyWith(
          AppBarAction value, $Res Function(AppBarAction) then) =
      _$AppBarActionCopyWithImpl<$Res, AppBarAction>;
  @useResult
  $Res call({String icon, String onPressed, String? tooltip});
}

/// @nodoc
class _$AppBarActionCopyWithImpl<$Res, $Val extends AppBarAction>
    implements $AppBarActionCopyWith<$Res> {
  _$AppBarActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? onPressed = null,
    Object? tooltip = freezed,
  }) {
    return _then(_value.copyWith(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: null == onPressed
          ? _value.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppBarActionImplCopyWith<$Res>
    implements $AppBarActionCopyWith<$Res> {
  factory _$$AppBarActionImplCopyWith(
          _$AppBarActionImpl value, $Res Function(_$AppBarActionImpl) then) =
      __$$AppBarActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String icon, String onPressed, String? tooltip});
}

/// @nodoc
class __$$AppBarActionImplCopyWithImpl<$Res>
    extends _$AppBarActionCopyWithImpl<$Res, _$AppBarActionImpl>
    implements _$$AppBarActionImplCopyWith<$Res> {
  __$$AppBarActionImplCopyWithImpl(
      _$AppBarActionImpl _value, $Res Function(_$AppBarActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? onPressed = null,
    Object? tooltip = freezed,
  }) {
    return _then(_$AppBarActionImpl(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      onPressed: null == onPressed
          ? _value.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBarActionImpl implements _AppBarAction {
  const _$AppBarActionImpl(
      {required this.icon, required this.onPressed, this.tooltip});

  factory _$AppBarActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBarActionImplFromJson(json);

  @override
  final String icon;
  @override
  final String onPressed;
  @override
  final String? tooltip;

  @override
  String toString() {
    return 'AppBarAction(icon: $icon, onPressed: $onPressed, tooltip: $tooltip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBarActionImpl &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.tooltip, tooltip) || other.tooltip == tooltip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, icon, onPressed, tooltip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBarActionImplCopyWith<_$AppBarActionImpl> get copyWith =>
      __$$AppBarActionImplCopyWithImpl<_$AppBarActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBarActionImplToJson(
      this,
    );
  }
}

abstract class _AppBarAction implements AppBarAction {
  const factory _AppBarAction(
      {required final String icon,
      required final String onPressed,
      final String? tooltip}) = _$AppBarActionImpl;

  factory _AppBarAction.fromJson(Map<String, dynamic> json) =
      _$AppBarActionImpl.fromJson;

  @override
  String get icon;
  @override
  String get onPressed;
  @override
  String? get tooltip;
  @override
  @JsonKey(ignore: true)
  _$$AppBarActionImplCopyWith<_$AppBarActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
