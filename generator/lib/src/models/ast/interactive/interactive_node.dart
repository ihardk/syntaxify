import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/node_props.dart';

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

  factory InteractiveNode.fromJson(Map<String, dynamic> json) =>
      _$InteractiveNodeFromJson(json);
}
