import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/node_props.dart';
import '../enums.dart';

part 'interactive_node.freezed.dart';
part 'interactive_node.g.dart';

/// Interactive nodes that accept user input.
@freezed
sealed class InteractiveNode with _$InteractiveNode {
  const factory InteractiveNode.button({
    required String label,
    String? onPressed,
    ButtonProps? props,
  }) = ButtonNode;

  const factory InteractiveNode.textField({
    String? label,
    String? binding,
    String? onChanged,
    String? onSubmitted,
    TextFieldProps? props,
  }) = TextFieldNode;

  const factory InteractiveNode.checkbox({
    required String binding,
    String? label,
    String? onChanged,
    bool? tristate,
  }) = CheckboxNode;

  const factory InteractiveNode.switchNode({
    required String binding,
    String? label,
    String? onChanged,
  }) = SwitchNode;

  const factory InteractiveNode.iconButton({
    required String icon,
    String? onPressed,
    double? size,
    ColorSemantic? color,
  }) = IconButtonNode;

  const factory InteractiveNode.dropdown({
    required String binding,
    required List<String> items,
    String? label,
    String? onChanged,
  }) = DropdownNode;

  const factory InteractiveNode.radio({
    required String binding,
    required String value,
    String? label,
    String? onChanged,
  }) = RadioNode;

  const factory InteractiveNode.slider({
    required String binding,
    double? min,
    double? max,
    int? divisions,
    String? label,
    String? onChanged,
  }) = SliderNode;

  factory InteractiveNode.fromJson(Map<String, dynamic> json) =>
      _$InteractiveNodeFromJson(json);
}
