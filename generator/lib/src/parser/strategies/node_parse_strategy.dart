import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/ast/nodes.dart';

/// Base strategy interface for parsing AST nodes into App layout nodes.
///
/// Each strategy handles a specific category of nodes (structural, primitive,
/// interactive) following the Strategy pattern for extensibility.
abstract class NodeParseStrategy {
  /// Returns true if this strategy can parse the given constructor name.
  bool canParse(String? constructorName);

  /// Parses the node and returns an App layout node.
  ///
  /// [constructorName] - The constructor being parsed (e.g., 'column', 'button')
  /// [args] - The argument list from the AST
  /// [helpers] - Helper methods for parsing children and extracting arguments
  App parse(
    String? constructorName,
    analyzer.ArgumentList args,
    ParseHelpers helpers,
  );
}

/// Helper methods provided to strategies for common parsing operations.
abstract class ParseHelpers {
  /// Parses a list of child expressions into App nodes.
  List<App> parseChildren(analyzer.Expression? expression);

  /// Tries to get an optional named argument from the argument list.
  analyzer.Expression? tryGetArg(analyzer.ArgumentList args, String name);

  /// Gets a required named argument, throws if missing.
  analyzer.Expression getArg(analyzer.ArgumentList args, String name);

  /// Parses a string literal expression.
  String? parseString(analyzer.Expression? exp);

  /// Parses a boolean literal expression.
  bool? parseBool(analyzer.Expression? exp);

  /// Parses a double literal expression (handles both double and int).
  double? parseDouble(analyzer.Expression? exp);

  /// Parses an integer literal expression.
  int? parseInt(analyzer.Expression? exp);

  /// Parses an enum-like identifier (e.g., TextVariant.headlineMedium).
  String? parseIdentifier(analyzer.Expression? exp);

  /// Parses a ButtonSize enum value.
  ButtonSize? parseButtonSize(analyzer.Expression? exp);

  /// Parses a KeyboardType enum value.
  KeyboardType? parseKeyboardType(analyzer.Expression? exp);
}
