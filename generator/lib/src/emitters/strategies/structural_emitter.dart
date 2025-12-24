import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/node_emit_strategy.dart';

/// Emitter strategy for structural layout nodes.
///
/// Handles: Column, Row, Container, Card, ListView, Stack, GridView,
/// Padding, Center.
class StructuralEmitStrategy implements NodeEmitStrategy {
  @override
  Expression emit(dynamic node, EmitContext context) {
    if (node is StructuralNode) {
      return node.map(
        column: (n) => _emitColumn(n, context),
        row: (n) => _emitRow(n, context),
        container: (n) => _emitContainer(n, context),
        card: (n) => _emitCard(n, context),
        listView: (n) => _emitListView(n, context),
        stack: (n) => _emitStack(n, context),
        gridView: (n) => _emitGridView(n, context),
        padding: (n) => _emitPadding(n, context),
        center: (n) => _emitCenter(n, context),
      );
    }
    throw ArgumentError('Expected StructuralNode, got ${node.runtimeType}');
  }

  Expression _emitColumn(ColumnNode node, EmitContext context) {
    List<Expression> children = node.children.map(context.emitChild).toList();

    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox')
                .newInstance([], {'height': literalNum(spacingValue)}),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('Column').newInstance([], {
      'children': literalList(children),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitRow(RowNode node, EmitContext context) {
    List<Expression> children = node.children.map(context.emitChild).toList();

    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox')
                .newInstance([], {'width': literalNum(spacingValue)}),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('Row').newInstance([], {
      'children': literalList(children),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitContainer(ContainerNode node, EmitContext context) {
    final hasColor = node.color != null;
    final hasBorderRadius = node.borderRadius != null;
    final needsDecoration = hasColor || hasBorderRadius;

    final containerArgs = <String, Expression>{
      if (node.child != null) 'child': context.emitChild(node.child!),
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.padding != null) 'padding': _parseEdgeInsets(node.padding!),
      if (node.margin != null) 'margin': _parseEdgeInsets(node.margin!),
    };

    if (needsDecoration) {
      final decorationArgs = <String, Expression>{};
      if (hasColor) {
        decorationArgs['color'] = _emitColorSemantic(node.color!);
      }
      if (hasBorderRadius) {
        decorationArgs['borderRadius'] = refer('BorderRadius')
            .property('circular')
            .call([literalNum(node.borderRadius!)]);
      }
      containerArgs['decoration'] =
          refer('BoxDecoration').newInstance([], decorationArgs);
    }

    return refer('Container').newInstance([], containerArgs);
  }

  Expression _emitCard(CardNode node, EmitContext context) {
    final columnChild = refer('Column').newInstance([], {
      'children': literalList(node.children.map(context.emitChild).toList()),
    });

    return refer('Card').newInstance([], {
      'child': node.padding != null
          ? refer('Padding').newInstance([], {
              'padding': _parseEdgeInsets(node.padding!),
              'child': columnChild,
            })
          : columnChild,
      if (node.elevation != null) 'elevation': literalNum(node.elevation!),
    });
  }

  Expression _emitListView(ListViewNode node, EmitContext context) {
    List<Expression> children = node.children.map(context.emitChild).toList();

    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final isHorizontal = node.scrollDirection == SyntaxAxis.horizontal;

      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox').newInstance([], {
              if (isHorizontal)
                'width': literalNum(spacingValue)
              else
                'height': literalNum(spacingValue),
            }),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('ListView').newInstance([], {
      'children': literalList(children),
      if (node.scrollDirection != null &&
          node.scrollDirection != SyntaxAxis.vertical)
        'scrollDirection': refer('Axis.${node.scrollDirection!.name}'),
      if (node.shrinkWrap == true) 'shrinkWrap': literalTrue,
    });
  }

  Expression _emitStack(StackNode node, EmitContext context) {
    return refer('Stack').newInstance([], {
      'children': literalList(node.children.map(context.emitChild).toList()),
      if (node.fit != null) 'fit': refer('StackFit.${node.fit!.name}'),
      if (node.alignment != null) 'alignment': _emitAlignment(node.alignment!),
    });
  }

  Expression _emitGridView(GridViewNode node, EmitContext context) {
    List<Expression> children = node.children.map(context.emitChild).toList();

    final mainAxisSpacing =
        node.spacing != null ? (double.tryParse(node.spacing!) ?? 16.0) : 16.0;
    final crossAxisSpacing = node.crossAxisSpacing != null
        ? (double.tryParse(node.crossAxisSpacing!) ?? 16.0)
        : 16.0;

    return refer('GridView').property('count').call([], {
      'crossAxisCount': literalNum(node.crossAxisCount),
      'children': literalList(children),
      'mainAxisSpacing': literalNum(mainAxisSpacing),
      'crossAxisSpacing': literalNum(crossAxisSpacing),
      if (node.childAspectRatio != null)
        'childAspectRatio': literalNum(node.childAspectRatio!),
      if (node.shrinkWrap == true) 'shrinkWrap': literalTrue,
    });
  }

  Expression _emitPadding(PaddingNode node, EmitContext context) {
    return refer('Padding').newInstance([], {
      'padding': _parseEdgeInsets(node.padding),
      'child': context.emitChild(node.child),
    });
  }

  Expression _emitCenter(CenterNode node, EmitContext context) {
    return refer('Center').newInstance([], {
      'child': context.emitChild(node.child),
    });
  }

  // --- Helper Methods ---

  Expression _emitColorSemantic(ColorSemantic semantic) {
    return refer('AppColors').property(semantic.name);
  }

  Expression _emitAlignment(AlignmentEnum alignment) {
    return refer('Alignment').property(alignment.name);
  }

  Expression _parseEdgeInsets(String value) {
    final parts =
        value.split(',').map((s) => double.tryParse(s.trim()) ?? 0).toList();
    if (parts.length == 1) {
      return refer('EdgeInsets').property('all').call([literalNum(parts[0])]);
    } else if (parts.length == 2) {
      return refer('EdgeInsets').property('symmetric').call([], {
        'horizontal': literalNum(parts[0]),
        'vertical': literalNum(parts[1]),
      });
    } else if (parts.length == 4) {
      return refer('EdgeInsets').property('fromLTRB').call([
        literalNum(parts[0]),
        literalNum(parts[1]),
        literalNum(parts[2]),
        literalNum(parts[3]),
      ]);
    }
    return refer('EdgeInsets').property('zero');
  }
}
