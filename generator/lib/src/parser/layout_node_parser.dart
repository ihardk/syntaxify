import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';

/// Helper class to parse Dart AST expressions into Syntaxify layout nodes.
class AppParser {
  const AppParser();

  ScreenDefinition parseScreenFromExpression(
      analyzer.Expression expression, String varName) {
    String? id;
    App? layout;
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
          layout = parseApp(exp);
        } else if (name == 'appBar') {
          appBar = parseAppBar(exp);
        }
      }
    }

    return ScreenDefinition(
      id: id ?? varName,
      layout: layout ?? App.column(children: []),
      appBar: appBar,
    );
  }

  App parseApp(analyzer.Expression expression) {
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

    if (typeName == 'App' && argumentList != null) {
      analyzer.Expression? getArg(String name) {
        return argumentList!.arguments
            .whereType<analyzer.NamedExpression>()
            .firstWhere((e) => e.name.label.name == name,
                orElse: () => throw 'Missing arg $name')
            .expression;
      }

      if (constructorName == 'column') {
        return App.column(children: _parseChildren(getArg('children')));
      } else if (constructorName == 'row') {
        return App.row(children: _parseChildren(getArg('children')));
      } else if (constructorName == 'text') {
        final textExp = getArg('text');
        final text =
            (textExp is analyzer.StringLiteral) ? textExp.stringValue : '';

        final variantExp = tryGetArg(argumentList, 'variant');
        final variant = _parseTextVariant(variantExp);

        return App.text(text: text ?? '', variant: variant);
      } else if (constructorName == 'button') {
        // P0 Properties Implementation
        final labelExp = getArg('label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : '';

        // Added parsing for new properties
        final variantExp = tryGetArg(argumentList, 'variant');
        String? variant;
        if (variantExp is analyzer.PrefixedIdentifier) {
          variant = variantExp.identifier.name;
        } else if (variantExp is analyzer.SimpleIdentifier) {
          variant = variantExp.name;
        }

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

        return App.button(
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

        // Added parsing for variant
        final variantExp = tryGetArg(argumentList, 'variant');
        String? variant;
        if (variantExp is analyzer.PrefixedIdentifier) {
          variant = variantExp.identifier.name;
        } else if (variantExp is analyzer.SimpleIdentifier) {
          variant = variantExp.name;
        } else if (variantExp is analyzer.StringLiteral) {
          variant = variantExp.stringValue;
        }

        return App.textField(
          label: (labelExp as analyzer.StringLiteral).stringValue ?? '',
          hint:
              (hintExp is analyzer.StringLiteral) ? hintExp.stringValue : null,
          obscureText:
              (obscureExp is analyzer.BooleanLiteral) ? obscureExp.value : null,
          keyboardType: _parseKeyboardType(inputTypeExp),
          variant: variant,
        );
      } else if (constructorName == 'card') {
        final variantExp = tryGetArg(argumentList, 'variant');
        String? variant;
        if (variantExp is analyzer.PrefixedIdentifier) {
          variant = variantExp.identifier.name;
        } else if (variantExp is analyzer.SimpleIdentifier) {
          variant = variantExp.name;
        } else if (variantExp is analyzer.StringLiteral) {
          variant = variantExp.stringValue;
        }

        final paddingExp = tryGetArg(argumentList, 'padding');
        final padding = (paddingExp is analyzer.StringLiteral)
            ? paddingExp.stringValue
            : null;

        final elevationExp = tryGetArg(argumentList, 'elevation');
        final elevation = (elevationExp is analyzer.DoubleLiteral)
            ? elevationExp.value
            : (elevationExp is analyzer.IntegerLiteral)
                ? elevationExp.value?.toDouble()
                : null;

        return App.card(
          children: _parseChildren(getArg('children')),
          variant: variant,
          padding: padding,
          elevation: elevation,
        );
      } else if (constructorName == 'spacer') {
        // Added parsing for flex
        final flexExp = tryGetArg(argumentList, 'flex');
        final flex =
            (flexExp is analyzer.IntegerLiteral) ? flexExp.value : null;
        return App.spacer(flex: flex);
      } else if (constructorName == 'checkbox') {
        final bindingExp = getArg('binding');
        final binding = (bindingExp is analyzer.StringLiteral)
            ? bindingExp.stringValue
            : '';
        final labelExp = tryGetArg(argumentList, 'label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : null;
        final onChangedExp = tryGetArg(argumentList, 'onChanged');
        final onChanged = (onChangedExp is analyzer.StringLiteral)
            ? onChangedExp.stringValue
            : null;
        return App.checkbox(
          binding: binding ?? '',
          label: label,
          onChanged: onChanged,
        );
      } else if (constructorName == 'switchWidget') {
        final bindingExp = getArg('binding');
        final binding = (bindingExp is analyzer.StringLiteral)
            ? bindingExp.stringValue
            : '';
        final labelExp = tryGetArg(argumentList, 'label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : null;
        final onChangedExp = tryGetArg(argumentList, 'onChanged');
        final onChanged = (onChangedExp is analyzer.StringLiteral)
            ? onChangedExp.stringValue
            : null;
        return App.switchWidget(
          binding: binding ?? '',
          label: label,
          onChanged: onChanged,
        );
      } else if (constructorName == 'slider') {
        final bindingExp = getArg('binding');
        final binding = (bindingExp is analyzer.StringLiteral)
            ? bindingExp.stringValue
            : '';
        final minExp = tryGetArg(argumentList, 'min');
        final min = (minExp is analyzer.DoubleLiteral)
            ? minExp.value
            : (minExp is analyzer.IntegerLiteral)
                ? minExp.value?.toDouble()
                : null;
        final maxExp = tryGetArg(argumentList, 'max');
        final max = (maxExp is analyzer.DoubleLiteral)
            ? maxExp.value
            : (maxExp is analyzer.IntegerLiteral)
                ? maxExp.value?.toDouble()
                : null;
        final labelExp = tryGetArg(argumentList, 'label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : null;
        return App.slider(
          binding: binding ?? '',
          min: min,
          max: max,
          label: label,
        );
      } else if (constructorName == 'radio') {
        final bindingExp = getArg('binding');
        final binding = (bindingExp is analyzer.StringLiteral)
            ? bindingExp.stringValue
            : '';
        final valueExp = getArg('value');
        final value =
            (valueExp is analyzer.StringLiteral) ? valueExp.stringValue : '';
        final labelExp = tryGetArg(argumentList, 'label');
        final label =
            (labelExp is analyzer.StringLiteral) ? labelExp.stringValue : null;
        return App.radio(
          binding: binding ?? '',
          value: value ?? '',
          label: label,
        );
      }
    }

    return App.column(children: []);
  }

  analyzer.Expression? tryGetArg(analyzer.ArgumentList args, String name) {
    final arg = args.arguments
        .whereType<analyzer.NamedExpression>()
        .where((e) => e.name.label.name == name)
        .firstOrNull;
    return arg?.expression;
  }

  // Enum Parsers

  String? _parseTextVariant(analyzer.Expression? exp) {
    if (exp == null) return null;
    if (exp is analyzer.PrefixedIdentifier) {
      return exp.identifier.name;
    } else if (exp is analyzer.SimpleIdentifier) {
      return exp.name;
    } else if (exp is analyzer.StringLiteral) {
      return exp.stringValue;
    }
    return null;
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

  List<App> _parseChildren(analyzer.Expression? expression) {
    if (expression is analyzer.ListLiteral) {
      return expression.elements
          .map((e) {
            if (e is analyzer.Expression) return parseApp(e);
            return null;
          })
          .whereType<App>()
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
