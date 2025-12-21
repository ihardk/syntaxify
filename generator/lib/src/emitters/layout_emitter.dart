import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';

/// Emits Flutter code from layout nodes.
import 'package:syntaxify/src/generators/generator_registry.dart';

/// Emits Flutter code from layout nodes.
class LayoutEmitter {
  const LayoutEmitter({this.registry});

  final GeneratorRegistry? registry;

  /// Converts a [LayoutNode] into a [Spec] (Expression).
  Expression emit(LayoutNode node) {
    return node.map(
      structural: (n) => _emitStructural(n.node),
      primitive: (n) => _emitPrimitive(n.node),
      interactive: (n) => _emitInteractive(n.node),
      custom: (n) => _emitCustom(n.node),
      appBar: (n) => _emitAppBar(n),
    );
  }

  // --- Sub-Emitters ---

  Expression _emitStructural(StructuralNode node) {
    return node.map(
      column: _emitColumn,
      row: _emitRow,
    );
  }

  Expression _emitPrimitive(PrimitiveNode node) {
    return node.map(
      text: _emitText,
      icon: _emitIcon,
      spacer: _emitSpacer,
    );
  }

  Expression _emitInteractive(InteractiveNode node) {
    return node.map(
      button: _emitButton,
      textField: _emitTextField,
    );
  }

  Expression _emitCustom(CustomNode node) {
    final handler = registry?.getCustomEmitter(node.type);
    if (handler != null) {
      return handler.emit(node);
    }
    // Placeholder if no handler found
    return refer('Placeholder').newInstance([], {
      'child':
          literalString('Custom Component (Missing Handler): ${node.type}'),
    });
  }

  // --- Specific Emitters ---

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
    return refer('AppText').newInstance([], {
      'text': literalString(node.text),
      if (node.variant != null)
        'variant': refer('TextVariant.${node.variant!.name}'),
      if (node.align != null) 'align': refer('TextAlign.${node.align!.name}'),
      if (node.maxLines != null) 'maxLines': literalNum(node.maxLines!),
      if (node.overflow != null)
        'overflow': refer('TextOverflow.${node.overflow!.name}'),
    });
  }

  Expression _emitButton(ButtonNode node) {
    final props = node.props;
    return refer('AppButton').newInstance([], {
      'label': literalString(node.label),
      'onPressed':
          node.onPressed != null ? refer(node.onPressed!) : literalNull,
      if (props?.variant != null && props?.variant != ButtonVariant.filled)
        'variant': refer('ButtonVariant.${props!.variant!.name}'),
      if (props?.size != null) 'size': refer('ButtonSize.${props!.size!.name}'),
      if (props?.icon != null) 'icon': refer('Icons.${props!.icon!}'),
      if (props?.isDisabled == true) 'isDisabled': literalTrue,
      if (props?.fullWidth == true) 'fullWidth': literalTrue,
      if (props?.isLoading == true) 'isLoading': literalTrue,
    });
  }

  Expression _emitTextField(TextFieldNode node) {
    final props = node.props;
    // Map KeyboardType enum to Flutter's TextInputType
    String? keyboardTypeValue;
    if (props?.keyboardType != null) {
      switch (props!.keyboardType!) {
        case KeyboardType.email:
          keyboardTypeValue = 'emailAddress';
          break;
        case KeyboardType.number:
          keyboardTypeValue = 'number';
          break;
        case KeyboardType.phone:
          keyboardTypeValue = 'phone';
          break;
        case KeyboardType.url:
          keyboardTypeValue = 'url';
          break;
        case KeyboardType.multiline:
          keyboardTypeValue = 'multiline';
          break;
        case KeyboardType.text:
          keyboardTypeValue = 'text';
          break;
      }
    }

    return refer('AppInput').newInstance([], {
      'label': literalString(node.label ?? ''),
      if (props?.hint != null) 'hint': literalString(props!.hint!),
      if (props?.obscureText == true) 'obscureText': literalTrue,
      if (keyboardTypeValue != null)
        'keyboardType': refer('TextInputType.$keyboardTypeValue'),
    });
  }

  Expression _emitIcon(IconNode node) {
    return refer('Icon').newInstance([
      refer('Icons.${node.name}'),
    ], {
      if (node.size != null) 'size': literalNum(24),
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
        'title': refer('AppText')
            .newInstance([], {'text': literalString(node.title!)})
    });
  }
}
