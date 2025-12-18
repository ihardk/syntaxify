import 'package:freezed_annotation/freezed_annotation.dart';
import 'ast_node.dart';

part 'screen_definition.freezed.dart';
part 'screen_definition.g.dart';

@freezed
class ScreenDefinition with _$ScreenDefinition {
  const factory ScreenDefinition({
    required String id,
    required AstNode layout,
    AppBarNode? appBar,
    String? padding, // Token
  }) = _ScreenDefinition;

  factory ScreenDefinition.fromJson(Map<String, dynamic> json) =>
      _$ScreenDefinitionFromJson(json);
}
