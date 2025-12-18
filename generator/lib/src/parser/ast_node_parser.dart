import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntax/src/models/ast/nodes.dart';

/// Helper class to parse Dart AST expressions into Syntax AST nodes.
class AstNodeParser {
  const AstNodeParser();

  ScreenDefinition parseScreenFromExpression(
      analyzer.Expression expression, String varName) {
    String? id;
    AstNode? layout;
    AppBarNode? appBar;

    analyzer.ArgumentList? argumentList;
    if (expression is analyzer.InstanceCreationExpression) {
      argumentList = expression.argumentList;
    } else if (expression is analyzer.MethodInvocation) {
      argumentList = expression.argumentList;
    }

    if (argumentList == null) throw 'Invalid screen definition';

    final args = argumentList.arguments;

    for (final arg in args) {
      if (arg is analyzer.NamedExpression) {
        final name = arg.name.label.name;
        final exp = arg.expression;

        if (name == 'id') {
          id = (exp as analyzer.StringLiteral).stringValue;
        } else if (name == 'layout') {
          layout = parseAstNode(exp);
        } else if (name == 'appBar') {
          appBar = parseAppBar(exp);
        }
      }
    }

    return ScreenDefinition(
      id: id ?? varName,
      layout: layout ?? AstNode.column(children: []),
      appBar: appBar,
    );
  }

  AstNode parseAstNode(analyzer.Expression expression) {
    String? typeName;
    String? constructorName;
    analyzer.ArgumentList? argumentList;

    if (expression is analyzer.InstanceCreationExpression) {
      typeName = expression.constructorName.type.name2.lexeme;
      constructorName = expression.constructorName.name?.name;
      argumentList = expression.argumentList;
    } else if (expression is analyzer.MethodInvocation) {
      final target = expression.target;
      if (target is analyzer.SimpleIdentifier) {
        typeName = target.name;
      }
      constructorName = expression.methodName.name;
      argumentList = expression.argumentList;
    }

    if (typeName == 'AstNode' && argumentList != null) {
      analyzer.Expression? getArg(String name) {
        return argumentList!.arguments
            .whereType<analyzer.NamedExpression>()
            .firstWhere((e) => e.name.label.name == name,
                orElse: () => throw 'Missing arg $name')
            .expression;
      }

      if (constructorName == 'column') {
        return AstNode.column(children: _parseChildren(getArg('children')));
      } else if (constructorName == 'row') {
        return AstNode.row(children: _parseChildren(getArg('children')));
      } else if (constructorName == 'text') {
        final textExp = getArg('text');
        final text =
            (textExp is analyzer.StringLiteral) ? textExp.stringValue : '';

        final variantExp = tryGetArg(argumentList, 'variant');
        final variant = _parseTextVariant(variantExp);

        return AstNode.text(text: text ?? '', variant: variant);
      } else if (constructorName == 'button') {
        // P0 Properties Implementation
        final labelExp = getArg('label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : '';

        // Added parsing for new properties
        final variantExp = tryGetArg(argumentList, 'variant');
        final variant = _parseButtonVariant(variantExp);

        final sizeExp = tryGetArg(argumentList, 'size');
        final size = _parseButtonSize(sizeExp);

        final iconExp = tryGetArg(argumentList, 'icon');
        final icon =
            (iconExp is analyzer.StringLiteral) ? iconExp.stringValue : null;

        final onPressedExp = tryGetArg(argumentList, 'onPressed');
        final onPressed = (onPressedExp is analyzer.StringLiteral)
            ? onPressedExp.stringValue
            : null;

        final isDisabledExp = tryGetArg(argumentList, 'isDisabled');
        final isDisabled = (isDisabledExp is analyzer.BooleanLiteral)
            ? isDisabledExp.value
            : null;

        return AstNode.button(
          label: label ?? '',
          variant: variant,
          size: size,
          icon: icon,
          onPressed: onPressed,
          isDisabled: isDisabled,
        );
      } else if (constructorName == 'textField') {
        final labelExp = getArg('label');
        // Added parsing for new properties
        final hintExp = tryGetArg(argumentList, 'hint');
        final obscureExp = tryGetArg(argumentList, 'obscureText');
        final inputTypeExp = tryGetArg(argumentList, 'keyboardType');

        return AstNode.textField(
          label: (labelExp as analyzer.StringLiteral).stringValue ?? '',
          hint:
              (hintExp is analyzer.StringLiteral) ? hintExp.stringValue : null,
          obscureText:
              (obscureExp is analyzer.BooleanLiteral) ? obscureExp.value : null,
          keyboardType: _parseKeyboardType(inputTypeExp),
        );
      } else if (constructorName == 'spacer') {
        // Added parsing for flex
        final flexExp = tryGetArg(argumentList, 'flex');
        final flex =
            (flexExp is analyzer.IntegerLiteral) ? flexExp.value : null;
        return AstNode.spacer(flex: flex);
      }
    }

    return AstNode.column(children: []);
  }

  analyzer.Expression? tryGetArg(analyzer.ArgumentList args, String name) {
    final arg = args.arguments
        .whereType<analyzer.NamedExpression>()
        .where((e) => e.name.label.name == name)
        .firstOrNull;
    return arg?.expression;
  }

  // Enum Parsers

  TextVariant _parseTextVariant(analyzer.Expression? exp) {
    return _parseEnum(
        exp, 'TextVariant', TextVariant.values, TextVariant.bodyMedium);
  }

  ButtonVariant _parseButtonVariant(analyzer.Expression? exp) {
    return _parseEnum(
        exp, 'ButtonVariant', ButtonVariant.values, ButtonVariant.filled);
  }

  ButtonSize? _parseButtonSize(analyzer.Expression? exp) {
    if (exp == null) return null;
    return _parseEnum(exp, 'ButtonSize', ButtonSize.values,
        ButtonSize.md); // heuristic default
  }

  KeyboardType? _parseKeyboardType(analyzer.Expression? exp) {
    if (exp == null) return null;
    return _parseEnum(
        exp, 'KeyboardType', KeyboardType.values, KeyboardType.text);
  }

  T _parseEnum<T extends Enum>(
      analyzer.Expression? exp, String prefix, List<T> values, T defaultValue) {
    if (exp is analyzer.PrefixedIdentifier) {
      if (exp.prefix.name == prefix) {
        final name = exp.identifier.name;
        return values.firstWhere((e) => e.name == name,
            orElse: () => defaultValue);
      }
    }
    return defaultValue;
  }

  List<AstNode> _parseChildren(analyzer.Expression? expression) {
    if (expression is analyzer.ListLiteral) {
      return expression.elements
          .map((e) {
            if (e is analyzer.Expression) return parseAstNode(e);
            return null;
          })
          .whereType<AstNode>()
          .toList();
    }
    return [];
  }

  AppBarNode parseAppBar(analyzer.Expression expression) {
    analyzer.ArgumentList? argumentList;
    if (expression is analyzer.InstanceCreationExpression) {
      argumentList = expression.argumentList;
    } else if (expression is analyzer.MethodInvocation) {
      argumentList = expression.argumentList;
    }

    final args = argumentList?.arguments ?? [];
    String? title;
    for (final arg in args) {
      if (arg is analyzer.NamedExpression && arg.name.label.name == 'title') {
        title = (arg.expression as analyzer.StringLiteral).stringValue;
      }
    }
    return AppBarNode(
      title: title ?? '',
    );
  }
}
