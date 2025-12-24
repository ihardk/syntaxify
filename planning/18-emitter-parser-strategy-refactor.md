# Emitter & Parser Strategy Pattern Refactoring

**Date:** December 2025  
**Status:** ✅ Completed  
**Related Commits:** `a775f6cbc`, `cc093f34a`, `e99118d42`

## Summary

Refactored the large emitter and parser files into smaller, focused strategy classes following the Strategy Pattern. This improves maintainability, testability, and separation of concerns.

## Problem: Bloated Files

Before this refactoring:

- **Layout Emitter**: Single large file with all node emission logic (~500+ lines)
- **Parser**: Single large file handling all AST node types
- **Issues**:
  - Hard to navigate and understand
  - Changes in one area could affect others
  - Difficult to test individual components
  - Hard to add new node types

## Solution: Strategy Pattern

Split the monolithic files into smaller, focused strategy classes.

### Emitter Architecture

```
lib/src/emitters/
├── layout_emitter.dart          # Main orchestrator (~90 lines)
└── strategies/
    ├── node_emit_strategy.dart  # Base interface + EmitContext
    ├── structural_emitter.dart  # Column, Row, Container, Card, Stack, etc.
    ├── primitive_emitter.dart   # Text, Icon, Image, Divider, Spacer
    ├── interactive_emitter.dart # Button, TextField, Checkbox, Toggle
    └── strategies.dart          # Barrel export
```

**Key Classes:**

```dart
abstract class NodeEmitStrategy {
  Expression emit(dynamic node, EmitContext context);
}

class LayoutEmitter {
  final StructuralEmitStrategy _structuralStrategy;
  final PrimitiveEmitStrategy _primitiveStrategy;
  final InteractiveEmitStrategy _interactiveStrategy;

  Expression emit(App node) {
    return node.map(
      structural: (n) => _structuralStrategy.emit(n.node, context),
      primitive: (n) => _primitiveStrategy.emit(n.node, context),
      interactive: (n) => _interactiveStrategy.emit(n.node, context),
      custom: (n) => _emitCustom(n.node),
      appBar: (n) => _emitAppBar(n),
    );
  }
}
```

### Parser Architecture

```
lib/src/parser/
├── meta_parser.dart             # Component meta parsing
├── layout_node_parser.dart      # Layout AST parsing
├── token_parser.dart            # Token definitions
├── registry_parser.dart         # Icon registry
├── extractors/                  # Property extraction helpers
│   └── (4 files)
└── strategies/
    ├── node_parse_strategy.dart   # Base interface
    ├── structural_strategy.dart   # Column, Row, etc.
    ├── primitive_strategy.dart    # Text, Icon, etc.
    ├── interactive_strategy.dart  # Button, Input, etc.
    └── strategies.dart            # Barrel export
```

## Benefits

### 1. Single Responsibility
Each strategy handles ONE category of nodes:
- `StructuralEmitStrategy` → Layout containers only
- `PrimitiveEmitStrategy` → Display-only widgets only
- `InteractiveEmitStrategy` → User interaction widgets only

### 2. Easy to Test
```dart
// Before: Had to test entire emitter
test('emits Column correctly', () {
  final emitter = LayoutEmitter();
  // Complex setup to test one case
});

// After: Test strategies in isolation
test('emits Column correctly', () {
  final strategy = StructuralEmitStrategy();
  final result = strategy.emit(columnNode, context);
  expect(result, isA<InvokeExpression>());
});
```

### 3. Easy to Extend
Adding a new node type only requires:
1. Add the node type to the appropriate strategy
2. Add the case to the switch statement
3. No changes to LayoutEmitter orchestrator

### 4. Dependency Injection
Strategies can be injected for testing:
```dart
LayoutEmitter(
  structuralStrategy: MockStructuralStrategy(),
  primitiveStrategy: MockPrimitiveStrategy(),
);
```

## Node Categories

### Structural Nodes (Containers)
- `ColumnNode`, `RowNode`
- `ContainerNode`, `CardNode`
- `ListViewNode`, `ScrollViewNode`
- `StackNode`, `CenterNode`, `PaddingNode`
- `AspectRatioNode`, `ExpandedNode`

### Primitive Nodes (Display)
- `TextNode`, `IconNode`
- `ImageNode`, `DividerNode`
- `SpacerNode`, `SizedBoxNode`

### Interactive Nodes (User Input)
- `ButtonNode`, `TextFieldNode`
- `CheckboxNode`, `ToggleNode`
- `SliderNode`, `RadioNode`

## EmitContext

Shared context passed to all strategies:
```dart
class EmitContext {
  final Expression Function(App node) emitChild;  // Recursive emit
  final Map<String, String> controllerMap;        // For TextControllers
  final Map<String, String> variableMap;          // For scoped variables
}
```

## Files Changed

### Emitters
- **MOVED** bloated emit logic → `strategies/*.dart`
- **SIMPLIFIED** `layout_emitter.dart` to ~90 lines
- **ADDED** `node_emit_strategy.dart` interface

### Parsers  
- **MOVED** parse logic → `strategies/*.dart`
- **ADDED** `extractors/` for property extraction
- **ADDED** `node_parse_strategy.dart` interface

## Impact on Learning Docs

The following learning docs should reference the new architecture:

1. **`05-code-generation.md`** - Step 5 Emission section needs update
2. **`07-generator-deep-dive.md`** - Emitter sections need update
3. **`08-design-system-deep-dive.md`** - May reference emitters

## Key Takeaway

> **Large files → Split by responsibility using Strategy Pattern**

Each strategy handles one "family" of related nodes. The orchestrator (`LayoutEmitter`) delegates to the appropriate strategy based on node type.
