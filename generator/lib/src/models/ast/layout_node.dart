import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';
import 'app_bar_action.dart';

part 'layout_node.freezed.dart';
part 'layout_node.g.dart';

/// Represents a node in the Syntaxify Layout Tree.
///
/// Use these factory constructors to define UI layouts in `.screen.dart` files:
/// - [LayoutNode.column] - Vertical layout
/// - [LayoutNode.row] - Horizontal layout
/// - [LayoutNode.text] - Text display
/// - [LayoutNode.button] - Button widget
/// - [LayoutNode.textField] - Text input field
/// - [LayoutNode.icon] - Icon widget
/// - [LayoutNode.spacer] - Spacing between elements
/// - [LayoutNode.appBar] - App bar for screens
@freezed
sealed class LayoutNode with _$LayoutNode {
  // --- Layout Nodes ---

  const factory LayoutNode.column({
    String? id,
    String? visibleWhen,
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = ColumnNode;

  const factory LayoutNode.row({
    String? id,
    String? visibleWhen,
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = RowNode;

  // --- Primitive Nodes ---

  const factory LayoutNode.text({
    String? id,
    String? visibleWhen,
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) = TextNode;

  const factory LayoutNode.button({
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
  }) = ButtonNode;

  const factory LayoutNode.textField({
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
  }) = TextFieldNode;

  const factory LayoutNode.icon({
    String? id,
    String? visibleWhen,
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) = IconNode;

  const factory LayoutNode.spacer({
    String? id,
    String? visibleWhen,
    SpacerSize? size,
    int? flex,
  }) = SpacerNode;

  // --- P1 Nodes (Base Set) ---
  // Adding AppBarNode as it is referenced in ScreenDefinition

  const factory LayoutNode.appBar({
    String? id,
    String? visibleWhen,
    String? title,
    String? leadingIcon,
    String? leadingAction,
    List<AppBarAction>? actions,
  }) = AppBarNode;

  factory LayoutNode.fromJson(Map<String, dynamic> json) =>
      _$LayoutNodeFromJson(json);
}
