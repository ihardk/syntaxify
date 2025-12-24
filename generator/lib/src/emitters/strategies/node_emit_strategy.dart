import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';

/// Base interface for node emitter strategies.
///
/// Each strategy handles emitting code_builder expressions for
/// a specific category of AST nodes.
abstract class NodeEmitStrategy {
  /// Emits a Flutter widget expression from the given node.
  Expression emit(
    dynamic node,
    EmitContext context,
  );
}

/// Context passed to emitters for accessing shared resources.
class EmitContext {
  const EmitContext({
    required this.emitChild,
    this.controllerMap = const {},
    this.variableMap = const {},
  });

  /// Callback to emit child nodes recursively.
  final Expression Function(App node) emitChild;

  /// Map of input labels to controller field names.
  final Map<String, String> controllerMap;

  /// Map of variable names to their scoped reference.
  final Map<String, String> variableMap;
}
