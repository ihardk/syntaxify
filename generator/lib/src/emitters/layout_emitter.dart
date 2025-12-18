import 'package:code_builder/code_builder.dart';
import 'package:forge/src/models/ast/nodes.dart';

/// Emits Flutter code from AST nodes.
class LayoutEmitter {
  const LayoutEmitter();

  /// Converts an [AstNode] into a [Spec] (Expression).
  Expression emit(AstNode node) {
    return node.map(
      // Layout
      column: _emitColumn,
      row: _emitRow,

      // Primitives
      text: _emitText,
      button: _emitButton,
      textField: _emitTextField,
      icon: _emitIcon,
      spacer: _emitSpacer,

      // Base
      appBar: _emitAppBar,
    );
  }

  Expression _emitColumn(ColumnNode node) {
    return refer('Column').newInstance([], {
      'children': literalList(node.children.map(emit).toList()),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitRow(RowNode node) {
    return refer('Row').newInstance([], {
      'children': literalList(node.children.map(emit).toList()),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitText(TextNode node) {
    return refer('Text').newInstance([
      literalString(node.text),
    ], {
      if (node.variant != null)
        'style':
            refer('DesignSystem.of(context).typography.${node.variant!.name}'),
    });
  }

  Expression _emitButton(ButtonNode node) {
    return refer('AppButton').newInstance([], {
      'label': literalString(node.label),
      'onPressed':
          node.onPressed != null ? refer(node.onPressed!) : literalNull,
      if (node.variant != null && node.variant != ButtonVariant.filled)
        'variant': refer('ButtonVariant.${node.variant!.name}'),
      if (node.size != null) 'size': refer('ButtonSize.${node.size!.name}'),
      if (node.icon != null) 'icon': refer('Icons.${node.icon!}'),
      if (node.isDisabled == true) 'isDisabled': literalTrue,
      if (node.fullWidth == true) 'fullWidth': literalTrue,
    });
  }

  Expression _emitTextField(TextFieldNode node) {
    return refer('AppInput').newInstance([], {
      'label': literalString(node.label ?? ''),
      if (node.hint != null) 'hint': literalString(node.hint!),
      if (node.obscureText == true) 'obscureText': literalTrue,
      if (node.keyboardType != null)
        'keyboardType': refer('TextInputType.${node.keyboardType!.name}'),
    });
  }

  Expression _emitIcon(IconNode node) {
    return refer('Icon').newInstance([
      refer('Icons.${node.name}'),
    ], {
      if (node.size != null)
        'size': literalNum(24), // TODO: Map size enum to values
    });
  }

  Expression _emitSpacer(SpacerNode node) {
    return refer('Spacer').newInstance([], {
      if (node.flex != null) 'flex': literalNum(node.flex!),
    });
  }

  Expression _emitAppBar(AppBarNode node) {
    // AppBar is typically a PreferredSizeWidget, but for AST purposes it maps to AppBar
    return refer('AppBar').newInstance([], {
      if (node.title != null)
        'title': refer('Text').newInstance([literalString(node.title!)])
    });
  }
}
