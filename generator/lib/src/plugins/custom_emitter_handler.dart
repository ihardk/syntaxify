import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/custom/custom_node.dart';

/// Interface for handling the emission of custom layout nodes.
///
/// Plugins implement this to define how their custom nodes should be
/// instantiated in the generated screen code.
abstract class CustomEmitterHandler {
  /// Emits the Dart expression for a custom node.
  ///
  /// [node] The custom node to emit.
  /// [context] Context object (future extension) providing access to generic utilities.
  Expression emit(CustomNode node);
}
