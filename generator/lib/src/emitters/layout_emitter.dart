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
      container: _emitContainer,
      card: _emitCard,
      listView: _emitListView,
    );
  }

  Expression _emitPrimitive(PrimitiveNode node) {
    return node.map(
      text: _emitText,
      icon: _emitIcon,
      spacer: _emitSpacer,
      image: _emitImage,
      divider: _emitDivider,
      circularProgressIndicator: _emitCircularProgressIndicator,
      sizedBox: _emitSizedBox,
      expanded: _emitExpanded,
    );
  }

  Expression _emitInteractive(InteractiveNode node) {
    return node.map(
      button: _emitButton,
      textField: _emitTextField,
      checkbox: _emitCheckbox,
      switchNode: _emitSwitch,
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
    // If flex is specified or size is SpacerSize.flex, use Spacer widget
    if (node.flex != null || node.size == SpacerSize.flex) {
      return refer('Spacer').newInstance([], {
        if (node.flex != null) 'flex': literalNum(node.flex!),
      });
    }

    // Otherwise, use SizedBox with semantic spacing
    final height = _getSpacingValue(node.size);
    return refer('SizedBox').newInstance([], {
      'height': literalNum(height),
    });
  }

  // Helper to convert SpacerSize to pixel values
  double _getSpacingValue(SpacerSize? size) {
    switch (size) {
      case SpacerSize.xs:
        return 4.0;
      case SpacerSize.sm:
        return 8.0;
      case SpacerSize.md:
      case null:
        return 16.0; // Default
      case SpacerSize.lg:
        return 24.0;
      case SpacerSize.xl:
        return 32.0;
      case SpacerSize.flex:
        return 16.0; // Fallback, shouldn't reach here
    }
  }

  Expression _emitAppBar(AppBarNode node) {
    // AppBar is typically a PreferredSizeWidget, but for AST purposes it maps to AppBar
    return refer('AppBar').newInstance([], {
      if (node.title != null)
        'title': refer('AppText')
            .newInstance([], {'text': literalString(node.title!)})
    });
  }

  // --- New Structural Node Emitters ---

  Expression _emitContainer(ContainerNode node) {
    return refer('Container').newInstance([], {
      if (node.child != null) 'child': emit(node.child!),
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.padding != null)
        'padding': refer('EdgeInsets').property('all').call([
          literalNum(16), // Parse padding string later
        ]),
      if (node.margin != null)
        'margin': refer('EdgeInsets').property('all').call([
          literalNum(16), // Parse margin string later
        ]),
      if (node.borderRadius != null)
        'decoration': refer('BoxDecoration').newInstance([], {
          'borderRadius': refer('BorderRadius')
              .property('circular')
              .call([literalNum(node.borderRadius!)])
        }),
    });
  }

  Expression _emitCard(CardNode node) {
    return refer('Card').newInstance([], {
      'child': refer('Column').newInstance([], {
        'children': literalList(node.children.map(emit).toList()),
      }),
      if (node.elevation != null) 'elevation': literalNum(node.elevation!),
    });
  }

  Expression _emitListView(ListViewNode node) {
    return refer('ListView').newInstance([], {
      'children': literalList(node.children.map(emit).toList()),
      if (node.scrollDirection != null && node.scrollDirection != Axis.vertical)
        'scrollDirection': refer('Axis.${node.scrollDirection!.name}'),
      if (node.shrinkWrap == true) 'shrinkWrap': literalTrue,
    });
  }

  // --- New Primitive Node Emitters ---

  Expression _emitImage(ImageNode node) {
    // Determine image type from src
    if (node.src.startsWith('http://') || node.src.startsWith('https://')) {
      return refer('Image').property('network').call([
        literalString(node.src),
      ], {
        if (node.width != null) 'width': literalNum(node.width!),
        if (node.height != null) 'height': literalNum(node.height!),
        if (node.fit != null) 'fit': refer('BoxFit.${node.fit!.name}'),
      });
    } else if (node.src.startsWith('assets/')) {
      return refer('Image').property('asset').call([
        literalString(node.src),
      ], {
        if (node.width != null) 'width': literalNum(node.width!),
        if (node.height != null) 'height': literalNum(node.height!),
        if (node.fit != null) 'fit': refer('BoxFit.${node.fit!.name}'),
      });
    } else {
      // Default to asset
      return refer('Image').property('asset').call([
        literalString(node.src),
      ], {
        if (node.width != null) 'width': literalNum(node.width!),
        if (node.height != null) 'height': literalNum(node.height!),
        if (node.fit != null) 'fit': refer('BoxFit.${node.fit!.name}'),
      });
    }
  }

  Expression _emitDivider(DividerNode node) {
    return refer('Divider').newInstance([], {
      if (node.thickness != null) 'thickness': literalNum(node.thickness!),
      if (node.indent != null) 'indent': literalNum(node.indent!),
      if (node.endIndent != null) 'endIndent': literalNum(node.endIndent!),
    });
  }

  Expression _emitCircularProgressIndicator(
      CircularProgressIndicatorNode node) {
    return refer('CircularProgressIndicator').newInstance([], {
      if (node.value != null) 'value': literalNum(node.value!),
      if (node.strokeWidth != null)
        'strokeWidth': literalNum(node.strokeWidth!),
    });
  }

  // --- New Interactive Node Emitters ---

  Expression _emitCheckbox(CheckboxNode node) {
    return refer('CheckboxListTile').newInstance([], {
      'value': refer(node.binding),
      'onChanged': node.onChanged != null
          ? refer(node.onChanged!)
          : refer('(value) {}'),
      if (node.label != null) 'title': refer('Text').newInstance([
        literalString(node.label!),
      ]),
      if (node.tristate == true) 'tristate': literalTrue,
    });
  }

  Expression _emitSwitch(SwitchNode node) {
    return refer('SwitchListTile').newInstance([], {
      'value': refer(node.binding),
      'onChanged': node.onChanged != null
          ? refer(node.onChanged!)
          : refer('(value) {}'),
      if (node.label != null) 'title': refer('Text').newInstance([
        literalString(node.label!),
      ]),
    });
  }

  Expression _emitSizedBox(SizedBoxNode node) {
    return refer('SizedBox').newInstance([], {
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.child != null) 'child': emit(node.child!),
    });
  }

  Expression _emitExpanded(ExpandedNode node) {
    return refer('Expanded').newInstance([], {
      'child': emit(node.child),
      if (node.flex != null) 'flex': literalNum(node.flex!),
    });
  }
}
