import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/strategies/node_parse_strategy.dart';

/// Strategy for parsing structural layout nodes: column, row, card, spacer.
class StructuralNodeStrategy implements NodeParseStrategy {
  static const _supportedNodes = {'column', 'row', 'card', 'spacer'};

  @override
  bool canParse(String? constructorName) =>
      _supportedNodes.contains(constructorName);

  @override
  App parse(
    String? constructorName,
    analyzer.ArgumentList args,
    ParseHelpers helpers,
  ) {
    switch (constructorName) {
      case 'column':
        return App.column(
          children: helpers.parseChildren(helpers.getArg(args, 'children')),
        );

      case 'row':
        return App.row(
          children: helpers.parseChildren(helpers.getArg(args, 'children')),
        );

      case 'card':
        return App.card(
          children: helpers.parseChildren(helpers.getArg(args, 'children')),
          variant: helpers.parseIdentifier(helpers.tryGetArg(args, 'variant')),
          padding: helpers.parseString(helpers.tryGetArg(args, 'padding')),
          elevation: helpers.parseDouble(helpers.tryGetArg(args, 'elevation')),
        );

      case 'spacer':
        return App.spacer(
          flex: helpers.parseInt(helpers.tryGetArg(args, 'flex')),
        );

      default:
        return App.column(children: []);
    }
  }
}
