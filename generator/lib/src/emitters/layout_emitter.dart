import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/emitters/strategies/strategies.dart';

/// Emits Flutter widget code from AST layout nodes.
///
/// The [LayoutEmitter] is the core transformation engine that converts
/// Syntaxify's declarative AST nodes into Flutter widget expressions using
/// `package:code_builder`.
///
/// ## Supported Node Types
///
/// - **Structural**: Column, Row, Container, Card, ListView, Stack, etc.
/// - **Primitive**: Text, Icon, Image, Divider, Spacer, etc.
/// - **Interactive**: Button, TextField, Checkbox, Toggle, Slider, etc.
/// - **Custom**: Plugin-provided nodes via [GeneratorRegistry]
///
/// ## Design System Integration
///
/// Interactive nodes emit App wrapper components (`AppCheckbox`, `AppToggle`,
/// etc.) that delegate rendering to the active design style (Material,
/// Cupertino, or Neo).
///
/// ## Usage
///
/// ```dart
/// final emitter = LayoutEmitter();
/// final expression = emitter.emit(app);
/// final dartCode = expression.accept(DartEmitter()).toString();
/// ```
class LayoutEmitter {
  LayoutEmitter({
    this.registry,
    this.controllerMap = const {},
    this.variableMap = const {},
    StructuralEmitStrategy? structuralStrategy,
    PrimitiveEmitStrategy? primitiveStrategy,
    InteractiveEmitStrategy? interactiveStrategy,
  })  : _structuralStrategy = structuralStrategy ?? StructuralEmitStrategy(),
        _primitiveStrategy = primitiveStrategy ?? PrimitiveEmitStrategy(),
        _interactiveStrategy = interactiveStrategy ?? InteractiveEmitStrategy();

  /// Optional generator registry for custom node handling.
  final GeneratorRegistry? registry;

  /// Map of input labels to controller field names for StatefulWidget screens.
  final Map<String, String> controllerMap;

  /// Map of variable names to their scoped reference.
  final Map<String, String> variableMap;

  final StructuralEmitStrategy _structuralStrategy;
  final PrimitiveEmitStrategy _primitiveStrategy;
  final InteractiveEmitStrategy _interactiveStrategy;

  /// Converts a [App] into a [Spec] (Expression).
  Expression emit(App node) {
    final context = EmitContext(
      emitChild: emit,
      controllerMap: controllerMap,
      variableMap: variableMap,
    );

    return node.map(
      structural: (n) => _structuralStrategy.emit(n.node, context),
      primitive: (n) => _primitiveStrategy.emit(n.node, context),
      interactive: (n) => _interactiveStrategy.emit(n.node, context),
      custom: (n) => _emitCustom(n.node),
      appBar: (n) => _emitAppBar(n),
    );
  }

  Expression _emitCustom(CustomNode node) {
    final handler = registry?.getCustomEmitter(node.type);
    if (handler != null) {
      return handler.emit(node);
    }
    return refer('Placeholder').newInstance([], {
      'child':
          literalString('Custom Component (Missing Handler): ${node.type}'),
    });
  }

  Expression _emitAppBar(AppBarNode node) {
    return refer('AppBar').newInstance([], {
      if (node.title != null)
        'title': refer('AppText')
            .newInstance([], {'text': literalString(node.title!)})
    });
  }
}
