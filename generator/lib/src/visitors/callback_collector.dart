import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/visitors/ast_visitor.dart';

/// Collected callback information.
class CallbackInfo {
  const CallbackInfo({
    required this.name,
    required this.reference,
  });

  /// The callback name (e.g., 'handleLogin').
  final String name;

  /// The code_builder reference for generating the callback.
  final Reference reference;
}

/// Visitor that collects callback references from interactive and custom nodes.
///
/// This replaces the manual `_collectCallbacks` traversal in ScreenGenerator.
class CallbackCollector extends AstVisitor<List<CallbackInfo>>
    with RecursiveVisitor<CallbackInfo> {
  @override
  List<CallbackInfo> visitStructural(StructuralApp node) {
    // Recursively visit children of structural nodes
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
  List<CallbackInfo> visitPrimitive(PrimitiveApp node) {
    // Primitive nodes can have children (sizedBox, expanded)
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
  List<CallbackInfo> visitInteractive(InteractiveApp node) {
    final callbacks = <CallbackInfo>[];

    node.node.map(
      button: (n) {
        if (n.onPressed != null) {
          callbacks.add(CallbackInfo(
            name: n.onPressed!,
            reference: refer('VoidCallback?'),
          ));
        }
      },
      textField: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<String>?'),
          ));
        }
        if (n.onSubmitted != null) {
          callbacks.add(CallbackInfo(
            name: n.onSubmitted!,
            reference: refer('ValueChanged<String>?'),
          ));
        }
      },
      checkbox: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<bool?>?'),
          ));
        }
      },
      toggleNode: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<bool>?'),
          ));
        }
      },
      iconButton: (n) {
        if (n.onPressed != null) {
          callbacks.add(CallbackInfo(
            name: n.onPressed!,
            reference: refer('VoidCallback?'),
          ));
        }
      },
      dropdown: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<String?>?'),
          ));
        }
      },
      radio: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<String?>?'),
          ));
        }
      },
      slider: (n) {
        if (n.onChanged != null) {
          callbacks.add(CallbackInfo(
            name: n.onChanged!,
            reference: refer('ValueChanged<double>?'),
          ));
        }
      },
    );

    return callbacks;
  }

  @override
  List<CallbackInfo> visitCustom(CustomApp node) {
    // Custom nodes may have callbacks in the future
    // Currently return empty list
    return [];
  }

  @override
  List<CallbackInfo> visitAppBar(AppBarNode node) {
    // AppBar actions could have callbacks - extend as needed
    return [];
  }
}
