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
sealed class App with _$App {
  // --- Hierarchical Nodes ---

  const factory App.structural({
    required StructuralNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = StructuralApp;

  const factory App.primitive({
    required PrimitiveNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = PrimitiveApp;

  const factory App.interactive({
    required InteractiveNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = InteractiveApp;

  const factory App.custom({
    required CustomNode node,
    @Default(NodeMetadata()) NodeMetadata meta,
  }) = CustomApp;

  // --- Legacy Support (Shim) ---
  // These factories maintain backward compatibility for parsing,
  // mapping old JSON structure to the new hierarchy.

  factory App.column({
    String? id,
    String? visibleWhen,
    required List<App> children,
    MainAlignment? mainAxisAlignment,
    CrossAlignment? crossAxisAlignment,
    String? spacing,
  }) =>
      App.structural(
        node: StructuralNode.column(
          children: children,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: spacing,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.row({
    String? id,
    String? visibleWhen,
    required List<App> children,
    MainAlignment? mainAxisAlignment,
    CrossAlignment? crossAxisAlignment,
    String? spacing,
  }) =>
      App.structural(
        node: StructuralNode.row(
          children: children,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: spacing,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.container({
    String? id,
    String? visibleWhen,
    App? child,
    double? width,
    double? height,
    String? padding,
    String? margin,
    ColorSemantic? color,
    double? borderRadius,
    ContainerSemantic? semantic,
  }) =>
      App.structural(
        node: StructuralNode.container(
          child: child,
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          color: color,
          borderRadius: borderRadius,
          semantic: semantic,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.card({
    String? id,
    String? visibleWhen,
    required List<App> children,
    String? variant,
    String? padding,
    double? elevation,
  }) =>
      App.structural(
        node: StructuralNode.card(
          children: children,
          variant: variant,
          padding: padding,
          elevation: elevation,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.listView({
    String? id,
    String? visibleWhen,
    required List<App> children,
    SyntaxAxis? scrollDirection,
    String? spacing,
    bool? shrinkWrap,
  }) =>
      App.structural(
        node: StructuralNode.listView(
          children: children,
          scrollDirection: scrollDirection,
          spacing: spacing,
          shrinkWrap: shrinkWrap,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.text({
    String? id,
    String? visibleWhen,
    required String text,
    String? variant,
    SyntaxTextAlign? align,
    int? maxLines,
    SyntaxTextOverflow? overflow,
  }) =>
      App.primitive(
        node: PrimitiveNode.text(
          text: text,
          variant: variant,
          align: align,
          maxLines: maxLines,
          overflow: overflow,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.button({
    String? id,
    String? visibleWhen,
    required String label,
    String? onPressed,
    String? variant,
    ButtonSize? size,
    String? icon,
    IconPosition? iconPosition,
    bool? isLoading,
    bool? isDisabled,
    bool? fullWidth,
  }) =>
      App.interactive(
        node: InteractiveNode.button(
          label: label,
          onPressed: onPressed,
          props: ButtonProps(
            variant: variant ?? 'primary',
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

  factory App.textField({
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
    String? variant,
  }) =>
      App.interactive(
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

  factory App.icon({
    String? id,
    String? visibleWhen,
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) =>
      App.primitive(
        node: PrimitiveNode.icon(
          name: name,
          size: size,
          semantic: semantic,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.spacer({
    String? id,
    String? visibleWhen,
    SpacerSize? size,
    int? flex,
  }) =>
      App.primitive(
        node: PrimitiveNode.spacer(
          size: size,
          flex: flex,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.sizedBox({
    String? id,
    String? visibleWhen,
    double? width,
    double? height,
    App? child,
  }) =>
      App.primitive(
        node: PrimitiveNode.sizedBox(
          width: width,
          height: height,
          child: child,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.expanded({
    String? id,
    String? visibleWhen,
    required App child,
    int? flex,
  }) =>
      App.primitive(
        node: PrimitiveNode.expanded(
          child: child,
          flex: flex,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.image({
    String? id,
    String? visibleWhen,
    required String src,
    double? width,
    double? height,
    ImageFit? fit,
    String? placeholder,
    String? errorWidget,
  }) =>
      App.primitive(
        node: PrimitiveNode.image(
          src: src,
          width: width,
          height: height,
          fit: fit,
          placeholder: placeholder,
          errorWidget: errorWidget,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.divider({
    String? id,
    String? visibleWhen,
    double? thickness,
    ColorSemantic? color,
    double? indent,
    double? endIndent,
  }) =>
      App.primitive(
        node: PrimitiveNode.divider(
          thickness: thickness,
          color: color,
          indent: indent,
          endIndent: endIndent,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.circularProgressIndicator({
    String? id,
    String? visibleWhen,
    double? value,
    ColorSemantic? color,
    double? strokeWidth,
  }) =>
      App.primitive(
        node: PrimitiveNode.circularProgressIndicator(
          value: value,
          color: color,
          strokeWidth: strokeWidth,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.checkbox({
    String? id,
    String? visibleWhen,
    required String binding,
    String? label,
    String? onChanged,
    bool? tristate,
  }) =>
      App.interactive(
        node: InteractiveNode.checkbox(
          binding: binding,
          label: label,
          onChanged: onChanged,
          tristate: tristate,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.switchWidget({
    String? id,
    String? visibleWhen,
    required String binding,
    String? label,
    String? onChanged,
  }) =>
      App.interactive(
        node: InteractiveNode.switchNode(
          binding: binding,
          label: label,
          onChanged: onChanged,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.iconButton({
    String? id,
    String? visibleWhen,
    required String icon,
    String? onPressed,
    double? size,
    ColorSemantic? color,
  }) =>
      App.interactive(
        node: InteractiveNode.iconButton(
          icon: icon,
          onPressed: onPressed,
          size: size,
          color: color,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.dropdown({
    String? id,
    String? visibleWhen,
    required String binding,
    required List<String> items,
    String? label,
    String? onChanged,
  }) =>
      App.interactive(
        node: InteractiveNode.dropdown(
          binding: binding,
          items: items,
          label: label,
          onChanged: onChanged,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.radio({
    String? id,
    String? visibleWhen,
    required String binding,
    required String value,
    String? label,
    String? onChanged,
  }) =>
      App.interactive(
        node: InteractiveNode.radio(
          binding: binding,
          value: value,
          label: label,
          onChanged: onChanged,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.slider({
    String? id,
    String? visibleWhen,
    required String binding,
    double? min,
    double? max,
    int? divisions,
    String? label,
    String? onChanged,
  }) =>
      App.interactive(
        node: InteractiveNode.slider(
          binding: binding,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          onChanged: onChanged,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.stack({
    String? id,
    String? visibleWhen,
    required List<App> children,
    StackFit? fit,
    AlignmentEnum? alignment,
  }) =>
      App.structural(
        node: StructuralNode.stack(
          children: children,
          fit: fit,
          alignment: alignment,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.gridView({
    String? id,
    String? visibleWhen,
    required List<App> children,
    required int crossAxisCount,
    String? spacing,
    String? crossAxisSpacing,
    double? childAspectRatio,
    bool? shrinkWrap,
  }) =>
      App.structural(
        node: StructuralNode.gridView(
          children: children,
          crossAxisCount: crossAxisCount,
          spacing: spacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
          shrinkWrap: shrinkWrap,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.padding({
    String? id,
    String? visibleWhen,
    required App child,
    required String padding,
  }) =>
      App.structural(
        node: StructuralNode.padding(
          child: child,
          padding: padding,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  factory App.center({
    String? id,
    String? visibleWhen,
    required App child,
  }) =>
      App.structural(
        node: StructuralNode.center(
          child: child,
        ),
        meta: NodeMetadata(id: id, visibleWhen: visibleWhen),
      );

  const factory App.appBar({
    String? title,
    List<AppBarAction>? actions,
    String? leadingIcon,
    String? onLeadingPressed,
  }) = AppBarNode;

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);
}
