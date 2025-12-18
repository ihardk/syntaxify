// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScreenDefinition _$ScreenDefinitionFromJson(Map<String, dynamic> json) {
  return _ScreenDefinition.fromJson(json);
}

/// @nodoc
mixin _$ScreenDefinition {
  String get id => throw _privateConstructorUsedError;
  AstNode get layout => throw _privateConstructorUsedError;
  AppBarNode? get appBar => throw _privateConstructorUsedError;
  String? get padding => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScreenDefinitionCopyWith<ScreenDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenDefinitionCopyWith<$Res> {
  factory $ScreenDefinitionCopyWith(
          ScreenDefinition value, $Res Function(ScreenDefinition) then) =
      _$ScreenDefinitionCopyWithImpl<$Res, ScreenDefinition>;
  @useResult
  $Res call({String id, AstNode layout, AppBarNode? appBar, String? padding});

  $AstNodeCopyWith<$Res> get layout;
}

/// @nodoc
class _$ScreenDefinitionCopyWithImpl<$Res, $Val extends ScreenDefinition>
    implements $ScreenDefinitionCopyWith<$Res> {
  _$ScreenDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? layout = null,
    Object? appBar = freezed,
    Object? padding = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as AstNode,
      appBar: freezed == appBar
          ? _value.appBar
          : appBar // ignore: cast_nullable_to_non_nullable
              as AppBarNode?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AstNodeCopyWith<$Res> get layout {
    return $AstNodeCopyWith<$Res>(_value.layout, (value) {
      return _then(_value.copyWith(layout: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScreenDefinitionImplCopyWith<$Res>
    implements $ScreenDefinitionCopyWith<$Res> {
  factory _$$ScreenDefinitionImplCopyWith(_$ScreenDefinitionImpl value,
          $Res Function(_$ScreenDefinitionImpl) then) =
      __$$ScreenDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AstNode layout, AppBarNode? appBar, String? padding});

  @override
  $AstNodeCopyWith<$Res> get layout;
}

/// @nodoc
class __$$ScreenDefinitionImplCopyWithImpl<$Res>
    extends _$ScreenDefinitionCopyWithImpl<$Res, _$ScreenDefinitionImpl>
    implements _$$ScreenDefinitionImplCopyWith<$Res> {
  __$$ScreenDefinitionImplCopyWithImpl(_$ScreenDefinitionImpl _value,
      $Res Function(_$ScreenDefinitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? layout = null,
    Object? appBar = freezed,
    Object? padding = freezed,
  }) {
    return _then(_$ScreenDefinitionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as AstNode,
      appBar: freezed == appBar
          ? _value.appBar
          : appBar // ignore: cast_nullable_to_non_nullable
              as AppBarNode?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenDefinitionImpl implements _ScreenDefinition {
  const _$ScreenDefinitionImpl(
      {required this.id, required this.layout, this.appBar, this.padding});

  factory _$ScreenDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenDefinitionImplFromJson(json);

  @override
  final String id;
  @override
  final AstNode layout;
  @override
  final AppBarNode? appBar;
  @override
  final String? padding;

  @override
  String toString() {
    return 'ScreenDefinition(id: $id, layout: $layout, appBar: $appBar, padding: $padding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenDefinitionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            const DeepCollectionEquality().equals(other.appBar, appBar) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, layout,
      const DeepCollectionEquality().hash(appBar), padding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenDefinitionImplCopyWith<_$ScreenDefinitionImpl> get copyWith =>
      __$$ScreenDefinitionImplCopyWithImpl<_$ScreenDefinitionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenDefinitionImplToJson(
      this,
    );
  }
}

abstract class _ScreenDefinition implements ScreenDefinition {
  const factory _ScreenDefinition(
      {required final String id,
      required final AstNode layout,
      final AppBarNode? appBar,
      final String? padding}) = _$ScreenDefinitionImpl;

  factory _ScreenDefinition.fromJson(Map<String, dynamic> json) =
      _$ScreenDefinitionImpl.fromJson;

  @override
  String get id;
  @override
  AstNode get layout;
  @override
  AppBarNode? get appBar;
  @override
  String? get padding;
  @override
  @JsonKey(ignore: true)
  _$$ScreenDefinitionImplCopyWith<_$ScreenDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
