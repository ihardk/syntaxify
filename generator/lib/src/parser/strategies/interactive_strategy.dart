import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/strategies/node_parse_strategy.dart';

/// Strategy for parsing interactive input nodes: textField, checkbox,
/// switch, slider, radio.
class InteractiveNodeStrategy implements NodeParseStrategy {
  static const _supportedNodes = {
    'textField',
    'checkbox',
    'toggle',
    'slider',
    'radio',
  };

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
      case 'textField':
        return App.textField(
          label: helpers.parseString(helpers.getArg(args, 'label')) ?? '',
          hint: helpers.parseString(helpers.tryGetArg(args, 'hint')),
          obscureText:
              helpers.parseBool(helpers.tryGetArg(args, 'obscureText')),
          keyboardType: helpers
              .parseKeyboardType(helpers.tryGetArg(args, 'keyboardType')),
          variant: helpers.parseIdentifier(helpers.tryGetArg(args, 'variant')),
          onChanged: helpers.parseString(helpers.tryGetArg(args, 'onChanged')),
        );

      case 'checkbox':
        return App.checkbox(
          binding: helpers.parseString(helpers.getArg(args, 'binding')) ?? '',
          label: helpers.parseString(helpers.tryGetArg(args, 'label')),
          onChanged: helpers.parseString(helpers.tryGetArg(args, 'onChanged')),
        );

      case 'toggle':
        return App.toggle(
          binding: helpers.parseString(helpers.getArg(args, 'binding')) ?? '',
          label: helpers.parseString(helpers.tryGetArg(args, 'label')),
          onChanged: helpers.parseString(helpers.tryGetArg(args, 'onChanged')),
        );

      case 'slider':
        return App.slider(
          binding: helpers.parseString(helpers.getArg(args, 'binding')) ?? '',
          min: helpers.parseDouble(helpers.tryGetArg(args, 'min')),
          max: helpers.parseDouble(helpers.tryGetArg(args, 'max')),
          label: helpers.parseString(helpers.tryGetArg(args, 'label')),
        );

      case 'radio':
        return App.radio(
          binding: helpers.parseString(helpers.getArg(args, 'binding')) ?? '',
          value: helpers.parseString(helpers.getArg(args, 'value')) ?? '',
          label: helpers.parseString(helpers.tryGetArg(args, 'label')),
        );

      default:
        return App.column(children: []);
    }
  }
}
