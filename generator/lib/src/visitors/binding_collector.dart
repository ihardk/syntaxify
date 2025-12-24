import 'package:syntaxify/src/models/ast/nodes.dart';
import 'ast_visitor.dart';

/// Info about a state binding to be generated.
class BindingInfo {
  /// Original binding name from AST (e.g., 'rememberMe')
  final String bindingName;

  /// State field name (e.g., '_rememberMe')
  final String fieldName;

  /// Dart type (e.g., 'bool', 'double')
  final String type;

  /// Default value (e.g., 'false', '0.0')
  final String defaultValue;

  const BindingInfo({
    required this.bindingName,
    required this.fieldName,
    required this.type,
    required this.defaultValue,
  });
}

/// Collects state bindings from interactive nodes.
///
/// Traverses the AST and collects [BindingInfo] for nodes that require
/// state management (checkbox, switch, slider, radio, dropdown).
class BindingCollector extends AstVisitor<List<BindingInfo>>
    with RecursiveVisitor<BindingInfo> {
  @override
  List<BindingInfo> visitStructural(StructuralApp node) {
    return node.node.map(
      column: (n) => visitChildren(n.children),
      row: (n) => visitChildren(n.children),
      container: (n) => n.child != null ? visit(n.child!) : [],
      card: (n) => visitChildren(n.children),
      listView: (n) => visitChildren(n.children),
      stack: (n) => visitChildren(n.children),
      gridView: (n) => visitChildren(n.children),
      padding: (n) => visit(n.child),
      center: (n) => visit(n.child),
    );
  }

  @override
  List<BindingInfo> visitInteractive(InteractiveApp node) {
    return node.node.map(
      button: (_) => [],
      textField: (_) => [],
      checkbox: (n) => [
        BindingInfo(
          bindingName: n.binding,
          fieldName: '_${n.binding}',
          type: 'bool',
          defaultValue: 'false',
        ),
      ],
      switchNode: (n) => [
        BindingInfo(
          bindingName: n.binding,
          fieldName: '_${n.binding}',
          type: 'bool',
          defaultValue: 'false',
        ),
      ],
      iconButton: (_) => [],
      dropdown: (n) => [
        BindingInfo(
          bindingName: n.binding,
          fieldName: '_${n.binding}',
          type: 'String?',
          defaultValue: 'null',
        ),
      ],
      radio: (n) => [
        BindingInfo(
          bindingName: n.binding,
          fieldName: '_${n.binding}',
          type: 'String?',
          defaultValue: 'null',
        ),
      ],
      slider: (n) => [
        BindingInfo(
          bindingName: n.binding,
          fieldName: '_${n.binding}',
          type: 'double',
          defaultValue: '${n.min ?? 0.0}',
        ),
      ],
    );
  }

  @override
  List<BindingInfo> visitPrimitive(PrimitiveApp node) {
    return node.node.map(
      text: (_) => [],
      icon: (_) => [],
      spacer: (_) => [],
      image: (_) => [],
      divider: (_) => [],
      circularProgressIndicator: (_) => [],
      sizedBox: (n) => n.child != null ? visit(n.child!) : [],
      expanded: (n) => visit(n.child),
    );
  }

  @override
  List<BindingInfo> visitCustom(CustomApp node) => [];

  @override
  List<BindingInfo> visitAppBar(AppBarNode node) => [];
}
