import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/strategies/strategies.dart';

/// Helper class to parse Dart AST expressions into Syntaxify layout nodes.
///
/// Uses the Strategy pattern to delegate parsing to specialized strategies
/// for different node categories (structural, primitive, interactive).
class AppParser implements ParseHelpers {
  AppParser({List<NodeParseStrategy>? strategies})
      : _strategies = strategies ??
            [
              StructuralNodeStrategy(),
              PrimitiveNodeStrategy(),
              InteractiveNodeStrategy(),
            ];

  final List<NodeParseStrategy> _strategies;

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
      // Strategy pattern: dispatch to appropriate strategy
      for (final strategy in _strategies) {
        if (strategy.canParse(constructorName)) {
          return strategy.parse(constructorName, argumentList, this);
        }
      }
    }

    return App.column(children: []);
  }

  // ─────────────────────────────────────────────────────────────────────
  // ParseHelpers Implementation
  // ─────────────────────────────────────────────────────────────────────

  @override
  List<App> parseChildren(analyzer.Expression? expression) {
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

  @override
  analyzer.Expression? tryGetArg(analyzer.ArgumentList args, String name) {
    final arg = args.arguments
        .whereType<analyzer.NamedExpression>()
        .where((e) => e.name.label.name == name)
        .firstOrNull;
    return arg?.expression;
  }

  @override
  analyzer.Expression getArg(analyzer.ArgumentList args, String name) {
    return args.arguments
        .whereType<analyzer.NamedExpression>()
        .firstWhere((e) => e.name.label.name == name,
            orElse: () => throw 'Missing arg $name')
        .expression;
  }

  @override
  String? parseString(analyzer.Expression? exp) {
    if (exp is analyzer.StringLiteral) {
      return exp.stringValue;
    }
    return null;
  }

  @override
  bool? parseBool(analyzer.Expression? exp) {
    if (exp is analyzer.BooleanLiteral) {
      return exp.value;
    }
    return null;
  }

  @override
  double? parseDouble(analyzer.Expression? exp) {
    if (exp is analyzer.DoubleLiteral) {
      return exp.value;
    } else if (exp is analyzer.IntegerLiteral) {
      return exp.value?.toDouble();
    }
    return null;
  }

  @override
  int? parseInt(analyzer.Expression? exp) {
    if (exp is analyzer.IntegerLiteral) {
      return exp.value;
    }
    return null;
  }

  @override
  String? parseIdentifier(analyzer.Expression? exp) {
    if (exp is analyzer.PrefixedIdentifier) {
      return exp.identifier.name;
    } else if (exp is analyzer.SimpleIdentifier) {
      return exp.name;
    } else if (exp is analyzer.StringLiteral) {
      return exp.stringValue;
    }
    return null;
  }

  @override
  ButtonSize? parseButtonSize(analyzer.Expression? exp) {
    if (exp == null) return null;
    return _parseEnum(exp, 'ButtonSize', ButtonSize.values, ButtonSize.md);
  }

  @override
  KeyboardType? parseKeyboardType(analyzer.Expression? exp) {
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

  // ─────────────────────────────────────────────────────────────────────
  // AppBar Parsing (kept in parser as it's a separate concern)
  // ─────────────────────────────────────────────────────────────────────

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
