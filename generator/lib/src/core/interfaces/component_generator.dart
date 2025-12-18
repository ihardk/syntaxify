import 'package:forge/src/models/ast_node.dart';
import 'package:forge/src/models/token_definition.dart';

/// Abstract interface for component code generators.
///
/// Following SOLID principles:
/// - S: Each generator generates code for ONE component type
/// - O: New components extend by creating new generators
/// - L: All generators are interchangeable
/// - I: Focused interface with single responsibility
/// - D: Clients depend on this abstraction
abstract class ComponentGenerator {
  /// The component type this generator handles (e.g., 'button', 'input')
  String get componentType;

  /// Generate Flutter widget code for the given component.
  ///
  /// Returns formatted Dart source code string.
  String generate({
    required AstNode node,
    TokenDefinition? tokens,
  });

  /// Whether this generator can handle the given component.
  bool canHandle(AstNode node);
}
