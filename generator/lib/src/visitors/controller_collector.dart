import 'package:syntaxify/src/models/ast/nodes.dart';
import 'ast_visitor.dart';

/// Info about a TextEditingController to be generated.
class ControllerInfo {
  /// Label of the input field
  final String inputLabel;

  /// State field name (e.g., '_emailController')
  final String fieldName;

  const ControllerInfo({
    required this.inputLabel,
    required this.fieldName,
  });
}

/// Collects TextEditingController requirements from TextField nodes.
///
/// Traverses the AST and collects [ControllerInfo] for text input nodes.
class ControllerCollector extends AstVisitor<List<ControllerInfo>>
    with RecursiveVisitor<ControllerInfo> {
  int _controllerCount = 0;

  @override
  List<ControllerInfo> visitStructural(StructuralApp node) {
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
  List<ControllerInfo> visitInteractive(InteractiveApp node) {
    return node.node.map(
      button: (_) => [],
      textField: (n) {
        final label = n.label ?? 'input${_controllerCount++}';
        final fieldName = '_${_toCamelCase(label)}Controller';
        return [
          ControllerInfo(
            inputLabel: label,
            fieldName: fieldName,
          ),
        ];
      },
      checkbox: (_) => [],
      switchNode: (_) => [],
      iconButton: (_) => [],
      dropdown: (_) => [],
      radio: (_) => [],
      slider: (_) => [],
    );
  }

  @override
  List<ControllerInfo> visitPrimitive(PrimitiveApp node) {
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
  List<ControllerInfo> visitCustom(CustomApp node) => [];

  @override
  List<ControllerInfo> visitAppBar(AppBarNode node) => [];

  String _toCamelCase(String input) {
    if (input.isEmpty) return input;
    final words = input.split(RegExp(r'[\s_-]+'));
    return words.first.toLowerCase() +
        words
            .skip(1)
            .map((w) => w.isEmpty
                ? ''
                : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
            .join('');
  }
}
