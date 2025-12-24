import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/strategies/node_parse_strategy.dart';

/// Strategy for parsing primitive display nodes: text, button.
class PrimitiveNodeStrategy implements NodeParseStrategy {
  static const _supportedNodes = {'text', 'button'};

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
      case 'text':
        return App.text(
          text: helpers.parseString(helpers.getArg(args, 'text')) ?? '',
          variant: helpers.parseIdentifier(helpers.tryGetArg(args, 'variant')),
        );

      case 'button':
        return App.button(
          label: helpers.parseString(helpers.getArg(args, 'label')) ?? '',
          variant: helpers.parseIdentifier(helpers.tryGetArg(args, 'variant')),
          size: helpers.parseButtonSize(helpers.tryGetArg(args, 'size')),
          icon: helpers.parseString(helpers.tryGetArg(args, 'icon')),
          onPressed: helpers.parseString(helpers.tryGetArg(args, 'onPressed')),
          isDisabled: helpers.parseBool(helpers.tryGetArg(args, 'isDisabled')),
        );

      default:
        return App.column(children: []);
    }
  }
}
