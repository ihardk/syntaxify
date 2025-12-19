import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';
import 'app_bar_action.dart';

part 'ast_node.freezed.dart';
part 'ast_node.g.dart';

/// Represents a node in the Syntaxify Abstract Syntax Tree.
///
/// Use these factory constructors to define UI layouts in `.screen.dart` files:
/// - [AstNode.column] - Vertical layout
/// - [AstNode.row] - Horizontal layout
/// - [AstNode.text] - Text display
/// - [AstNode.button] - Button widget
/// - [AstNode.textField] - Text input field
/// - [AstNode.icon] - Icon widget
/// - [AstNode.spacer] - Spacing between elements
/// - [AstNode.appBar] - App bar for screens
@freezed
sealed class AstNode with _$AstNode {
  // --- Layout Nodes ---

  const factory AstNode.column({
    String? id,
    String? visibleWhen,
    required List<AstNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = ColumnNode;

  const factory AstNode.row({
    String? id,
    String? visibleWhen,
    required List<AstNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = RowNode;

  // --- Primitive Nodes ---

  const factory AstNode.text({
    String? id,
    String? visibleWhen,
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) = TextNode;

  const factory AstNode.button({
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

  const factory AstNode.textField({
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

  const factory AstNode.icon({
    String? id,
    String? visibleWhen,
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) = IconNode;

  const factory AstNode.spacer({
    String? id,
    String? visibleWhen,
    SpacerSize? size,
    int? flex,
  }) = SpacerNode;

  // --- P1 Nodes (Base Set) ---
  // Adding AppBarNode as it is referenced in ScreenDefinition

  const factory AstNode.appBar({
    String? id,
    String? visibleWhen,
    String? title,
    String? leadingIcon,
    String? leadingAction,
    List<AppBarAction>? actions,
  }) = AppBarNode;

  factory AstNode.fromJson(Map<String, dynamic> json) =>
      _$AstNodeFromJson(json);
}
