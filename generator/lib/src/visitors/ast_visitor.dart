import 'package:syntaxify/src/models/ast/nodes.dart';

/// Base visitor interface for traversing AST nodes.
///
/// Implements the Visitor pattern for type-safe, extensible node processing.
/// Each visitor collects specific information from the node tree without
/// modifying the node classes themselves.
///
/// Usage:
/// ```dart
/// final collector = BindingCollector();
/// final bindings = collector.visit(screenLayout);
/// ```
abstract class AstVisitor<T> {
  /// Visit any App node, dispatching to the appropriate typed visitor.
  T visit(App node) {
    return node.map(
      structural: visitStructural,
      interactive: visitInteractive,
      primitive: visitPrimitive,
      custom: visitCustom,
      appBar: visitAppBar,
    );
  }

  /// Visit a structural node (Column, Row, Container, etc.)
  T visitStructural(StructuralApp node);

  /// Visit an interactive node (Button, TextField, Checkbox, etc.)
  T visitInteractive(InteractiveApp node);

  /// Visit a primitive node (Text, Icon, Spacer, etc.)
  T visitPrimitive(PrimitiveApp node);

  /// Visit a custom node
  T visitCustom(CustomApp node);

  /// Visit an appBar node
  T visitAppBar(AppBarNode node);
}

/// Mixin that provides recursive traversal for list-returning visitors.
///
/// Use this when your visitor needs to traverse child nodes and combine results.
mixin RecursiveVisitor<T> on AstVisitor<List<T>> {
  /// Visit all children of a structural node and combine results.
  List<T> visitChildren(List<App> children) {
    return children.expand((child) => visit(child)).toList();
  }
}
