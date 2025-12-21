import 'package:freezed_annotation/freezed_annotation.dart';
import 'structural/structural_node.dart';
import 'primitive/primitive_node.dart';
import 'interactive/interactive_node.dart';
import 'custom/custom_node.dart';
import 'common/node_metadata.dart';
import 'common/node_props.dart';
import 'enums.dart';
import 'app_bar_action.dart';

part 'layout_node.freezed.dart';
part 'layout_node.g.dart';

/// Represents a node in the Syntaxify Layout Tree.
///
/// This is the root union for all layout nodes, now categorized into:
/// - [StructuralNode] (Column, Row)
/// - [PrimitiveNode] (Text, Icon, Spacer)
/// - [InteractiveNode] (Button, TextField)
@freezed
sealed class LayoutNode with _$LayoutNode {
  // --- Hierarchical Nodes ---

  const factory LayoutNode.structural({
    required StructuralNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = StructuralLayoutNode;

  const factory LayoutNode.primitive({
    required PrimitiveNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = PrimitiveLayoutNode;

  const factory LayoutNode.interactive({
    required InteractiveNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = InteractiveLayoutNode;

  const factory LayoutNode.custom({
    required CustomNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = CustomLayoutNode;

  // --- Legacy Support (Shim) ---
  // These factories maintain backward compatibility for parsing,
  // mapping old JSON structure to the new hierarchy.

  factory LayoutNode.column({
    String? id,
    String? visibleWhen,
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) =>
      LayoutNode.structural(
        node: StructuralNode.column(
          children: children,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: spacing,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.row({
    String? id,
    String? visibleWhen,
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) =>
      LayoutNode.structural(
        node: StructuralNode.row(
          children: children,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: spacing,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.text({
    String? id,
    String? visibleWhen,
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) =>
      LayoutNode.primitive(
        node: PrimitiveNode.text(
          text: text,
          variant: variant,
          align: align,
          maxLines: maxLines,
          overflow: overflow,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.button({
    String? id,
    String? visibleWhen,
    required String label,
    String? onPressed,
    ButtonVariant? variant,
    ButtonSize? size,
    String? icon,
    IconPosition? iconPosition,
    bool? isLoading,
    bool? isDisabled,
    bool? fullWidth,
  }) =>
      LayoutNode.interactive(
        node: InteractiveNode.button(
          label: label,
          onPressed: onPressed,
          props: ButtonProps(
            variant: variant,
            size: size,
            icon: icon,
            iconPosition: iconPosition,
            isLoading: isLoading ?? false,
            isDisabled: isDisabled ?? false,
            fullWidth: fullWidth ?? false,
          ),
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.textField({
    String? id,
    String? visibleWhen,
    String? label,
    String? hint,
    String? helperText,
    String? binding,
    String? onChanged,
    String? onSubmitted,
    String? prefixIcon,
    String? suffixIcon,
    KeyboardType? keyboardType,
    TextInputAction? textInputAction,
    bool? obscureText,
    String? errorText,
    int? maxLines,
    int? maxLength,
    TextFieldVariant? variant,
  }) =>
      LayoutNode.interactive(
        node: InteractiveNode.textField(
          label: label,
          binding: binding,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          props: TextFieldProps(
            hint: hint,
            helperText: helperText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText ?? false,
            errorText: errorText,
            maxLines: maxLines,
            maxLength: maxLength,
            variant: variant,
          ),
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.icon({
    String? id,
    String? visibleWhen,
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) =>
      LayoutNode.primitive(
        node: PrimitiveNode.icon(
          name: name,
          size: size,
          semantic: semantic,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory LayoutNode.spacer({
    String? id,
    String? visibleWhen,
    SpacerSize? size,
    int? flex,
  }) =>
      LayoutNode.primitive(
        node: PrimitiveNode.spacer(
          size: size,
          flex: flex,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  const factory LayoutNode.appBar({
    String? title,
    List<AppBarAction>? actions,
    String? leadingIcon,
    String? onLeadingPressed,
  }) = AppBarNode;

  factory LayoutNode.fromJson(Map<String, dynamic> json) =>
      _$LayoutNodeFromJson(json);
}
