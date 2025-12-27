import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/node_emit_strategy.dart';

/// Emitter strategy for primitive display nodes.
///
/// Handles: Text, Icon, Spacer, Image, Divider, CircularProgressIndicator,
/// SizedBox, Expanded.
class PrimitiveEmitStrategy implements NodeEmitStrategy {
  @override
  Expression emit(dynamic node, EmitContext context) {
    if (node is PrimitiveNode) {
      return node.map(
        text: (n) => _emitText(n, context),
        icon: (n) => _emitIcon(n, context),
        spacer: (n) => _emitSpacer(n, context),
        image: (n) => _emitImage(n, context),
        divider: (n) => _emitDivider(n, context),
        circularProgressIndicator: (n) =>
            _emitCircularProgressIndicator(n, context),
        sizedBox: (n) => _emitSizedBox(n, context),
        expanded: (n) => _emitExpanded(n, context),
      );
    }
    throw ArgumentError('Expected PrimitiveNode, got ${node.runtimeType}');
  }

  Expression _emitText(TextNode node, EmitContext context) {
    return refer('AppText').newInstance([], {
      'text': literalString(node.text),
      if (node.variant != null) 'variant': refer('TextVariant.${node.variant}'),
      if (node.align != null) 'align': refer('TextAlign.${node.align!.name}'),
      if (node.maxLines != null) 'maxLines': literalNum(node.maxLines!),
      if (node.overflow != null)
        'overflow': refer('TextOverflow.${node.overflow!.name}'),
    });
  }

  Expression _emitIcon(IconNode node, EmitContext context) {
    return refer('AppIcon').newInstance([], {
      'name': literalString(node.name),
      if (node.size != null) 'size': literalNum(_getIconSize(node.size)),
    });
  }

  double _getIconSize(IconSize? size) {
    switch (size) {
      case IconSize.xs:
        return 16.0;
      case IconSize.sm:
        return 20.0;
      case IconSize.md:
        return 24.0;
      case IconSize.lg:
        return 32.0;
      case IconSize.xl:
        return 48.0;
      case null:
        return 24.0;
    }
  }

  Expression _emitSpacer(SpacerNode node, EmitContext context) {
    if (node.size != null) {
      final spacingValue = _getSpacingValue(node.size);
      return refer('SizedBox').newInstance([], {
        'height': literalNum(spacingValue),
        'width': literalNum(spacingValue),
      });
    }
    return refer('Spacer').newInstance([], {
      if (node.flex != null) 'flex': literalNum(node.flex!),
    });
  }

  double _getSpacingValue(SpacerSize? size) {
    switch (size) {
      case SpacerSize.xs:
        return 4.0;
      case SpacerSize.sm:
        return 8.0;
      case SpacerSize.md:
        return 16.0;
      case SpacerSize.lg:
        return 24.0;
      case SpacerSize.xl:
        return 32.0;
      case SpacerSize.flex:
        return 16.0; // flex uses Spacer widget, not SizedBox
      case null:
        return 16.0;
    }
  }

  Expression _emitImage(ImageNode node, EmitContext context) {
    return refer('AppImage').newInstance([], {
      'src': literalString(node.src),
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.fit != null) 'fit': refer('BoxFit.${node.fit!.name}'),
    });
  }

  Expression _emitDivider(DividerNode node, EmitContext context) {
    return refer('AppDivider').newInstance([], {
      if (node.thickness != null) 'thickness': literalNum(node.thickness!),
      if (node.indent != null) 'indent': literalNum(node.indent!),
      if (node.endIndent != null) 'endIndent': literalNum(node.endIndent!),
    });
  }

  Expression _emitCircularProgressIndicator(
      CircularProgressIndicatorNode node, EmitContext context) {
    return refer('AppProgressIndicator.circular').newInstance([], {
      if (node.value != null) 'value': literalNum(node.value!),
      if (node.strokeWidth != null)
        'strokeWidth': literalNum(node.strokeWidth!),
    });
  }

  Expression _emitSizedBox(SizedBoxNode node, EmitContext context) {
    return refer('SizedBox').newInstance([], {
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.child != null) 'child': context.emitChild(node.child!),
    });
  }

  Expression _emitExpanded(ExpandedNode node, EmitContext context) {
    return refer('Expanded').newInstance([], {
      'child': context.emitChild(node.child),
      if (node.flex != null) 'flex': literalNum(node.flex!),
    });
  }
}
