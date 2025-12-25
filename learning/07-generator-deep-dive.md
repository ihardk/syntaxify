# Generator Deep Dive 🏗️

**Understanding how Syntaxify generates code**

This guide explains the code generation system that transforms parsed component definitions and screen layouts into Dart code files.

---

## Overview

The generator system converts parsed data models into Dart source code:

```
ComponentDefinition → app_button.dart, app_text.dart, etc.
ScreenDefinition    → login_screen.dart, home_screen.dart, etc.
ComponentEnum       → button_variant.dart, text_variant.dart, etc.
```

### Key Classes

| Class                   | Purpose                                            |
| ----------------------- | -------------------------------------------------- |
| `ComponentGenerator`    | Generates component widget classes                 |
| `ScreenGenerator`       | Generates screen widget classes                    |
| `DesignSystemGenerator` | Generates design_system.dart and design_style.dart |
| `TokenGenerator`        | Generates token classes with `.fromFoundation()`   |
| `EnumGenerator`         | Generates variant enum files                       |
| `LayoutEmitter`         | Converts AST nodes to code expressions             |

---

## Architecture

```
Generators                         Emitters
    │                                  │
ComponentGenerator ──────┐             │
ScreenGenerator ─────────┼──→ LayoutEmitter (AST → Code)
DesignSystemGenerator ───┤             │
TokenGenerator ──────────┤             │
EnumGenerator ───────────┘             │
    │                                  │
    └────────→ code_builder ←──────────┘
                    │
                    ↓
              Dart Source Files
```

### File Structure

```
lib/src/generators/
├── component/
│   └── component_generator.dart
├── screen_generator.dart
├── design_system_generator.dart
├── token_generator.dart
├── enum_generator.dart
└── registry/
    └── registry_generator.dart

lib/src/emitters/
├── layout_emitter.dart
├── emit_context.dart
└── strategies/
    ├── interactive_emitter.dart   # Button, Checkbox, Toggle, etc.
    ├── primitive_emitter.dart     # Text, Icon, Image, etc.
    ├── structural_emitter.dart    # Column, Row, Container, etc.
    ├── node_emit_strategy.dart
    └── strategies.dart
```

---

## Component Generator

Generates component widget classes from `ComponentDefinition`:

```dart
class ComponentGenerator {
  final _formatter = DartFormatter();
  final _emitter = DartEmitter(useNullSafetySyntax: true);

  String? generate(ComponentDefinition component) {
    final library = Library((lib) => lib
      ..directives.addAll(_generateImports())
      ..body.add(_generateComponentClass(component))
    );

    final code = library.accept(_emitter).toString();
    return _formatter.format(code);
  }

  Class _generateComponentClass(ComponentDefinition component) {
    return Class((cls) => cls
      ..name = component.name
      ..docs.add('/// ${component.description}')
      ..extend = refer('StatelessWidget')
      ..constructors.add(_generateConstructor(component))
      ..fields.addAll(_generateFields(component))
      ..methods.add(_generateBuildMethod(component))
    );
  }
}
```

### Generated Output

**Input:** `button.meta.dart`
```dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
}
```

**Output:** `app_button.dart`
```dart
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderButton(
      label: label,
      onPressed: onPressed,
      variant: variant,
    );
  }
}
```

---

## Screen Generator

Generates screen widgets from `ScreenDefinition`:

```dart
class ScreenGenerator {
  final LayoutEmitter _layoutEmitter;

  String generate(ScreenDefinition screen) {
    // Collect callbacks from layout
    final callbacks = _collectCallbacks(screen.layout);

    final library = Library((lib) => lib
      ..body.add(_generateScreenClass(screen, callbacks))
    );

    return _formatter.format(library.accept(_emitter).toString());
  }

  Class _generateScreenClass(ScreenDefinition screen, List<String> callbacks) {
    return Class((cls) => cls
      ..name = '${screen.id.pascalCase}Screen'
      ..extend = refer('StatelessWidget')
      ..constructors.add(_generateConstructor(callbacks))
      ..fields.addAll(_generateCallbackFields(callbacks))
      ..methods.add(_generateBuildMethod(screen))
    );
  }
}
```

---

## Token Generator

Generates token classes with Foundation support:

```dart
class TokenGenerator {
  String? generate(ComponentDefinition component) {
    // Infer token properties from component
    final tokenProperties = _inferTokenProperties(component);
    
    if (tokenProperties.isEmpty) return null;

    final library = Library((lib) => lib
      ..body.add(_generateTokenClass(
        className: '${component.name}Tokens',
        properties: tokenProperties,
      ))
    );

    return _formatter.format(library.accept(_emitter).toString());
  }

  /// Smart property mapping
  String _mapToFoundation(String propName) {
    if (propName.contains('backgroundColor'))
      return 'foundation.colorSurface';
    if (propName.contains('borderRadius'))
      return 'foundation.radiusMd';
    // ... more mappings
  }
}
```

---

## Layout Emitter

Converts AST nodes to `code_builder` expressions using category-based strategies:

```dart
class LayoutEmitter {
  LayoutEmitter({
    this.registry,
    this.controllerMap = const {},
    StructuralEmitStrategy? structuralStrategy,
    PrimitiveEmitStrategy? primitiveStrategy,
    InteractiveEmitStrategy? interactiveStrategy,
  })  : _structuralStrategy = structuralStrategy ?? StructuralEmitStrategy(),
        _primitiveStrategy = primitiveStrategy ?? PrimitiveEmitStrategy(),
        _interactiveStrategy = interactiveStrategy ?? InteractiveEmitStrategy();

  final StructuralEmitStrategy _structuralStrategy;
  final PrimitiveEmitStrategy _primitiveStrategy;
  final InteractiveEmitStrategy _interactiveStrategy;

  Expression emit(App node) {
    final context = EmitContext(
      emitChild: emit,
      controllerMap: controllerMap,
    );

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

### Emit Strategies by Category

The emitter uses three category strategies, each handling multiple node types:

**StructuralEmitStrategy** - Column, Row, Container, Card, ListView, Stack
**PrimitiveEmitStrategy** - Text, Icon, Image, Divider, Spacer  
**InteractiveEmitStrategy** - Button, TextField, Checkbox, Toggle, Slider

```dart
class InteractiveEmitStrategy {
  Expression emit(InteractiveNode node, EmitContext context) {
    return switch (node) {
      ButtonNode() => _emitButton(node, context),
      CheckboxNode() => _emitCheckbox(node, context),
      ToggleNode() => _emitToggle(node, context),
      // ... etc
    };
  }

  Expression _emitButton(ButtonNode node, EmitContext context) {
    return refer('AppButton').newInstance([], {
      'label': literalString(node.label),
      if (node.onPressed != null)
        'onPressed': refer(node.onPressed!),
    });
  }
}
```

### EmitContext

Tracks state during emission:

```dart
class EmitContext {
  EmitContext({
    required this.emitChild,
    this.controllerMap = const {},
    this.variableMap = const {},
  });

  final Expression Function(App) emitChild;
  final Map<String, String> controllerMap;
  final Map<String, String> variableMap;
}
```

---

## Design System Generator

Generates `design_system.dart` and `design_style.dart`:

```dart
class DesignSystemGenerator {
  void generate(List<ComponentDefinition> components) {
    // Generate design_system.dart (exports)
    _generateDesignSystem(components);

    // Generate design_style.dart (abstract class)
    _generateDesignStyle(components);
  }

  void _generateDesignStyle(List<ComponentDefinition> components) {
    // Creates sealed class with:
    // - Foundation getter
    // - Token getters for each component
    // - Render methods for each component
  }
}
```

---

## Using code_builder

All generators use the `code_builder` package for AST construction:

### Common Patterns

```dart
// Create a class
Class((cls) => cls
  ..name = 'MyClass'
  ..extend = refer('BaseClass')
  ..fields.add(Field((f) => f
    ..name = 'myField'
    ..type = refer('String')
    ..modifier = FieldModifier.final$
  ))
);

// Create a method
Method((m) => m
  ..name = 'myMethod'
  ..returns = refer('Widget')
  ..body = Code('return Container();')
);

// Create an expression
refer('MyWidget').newInstance([], {
  'param1': literalString('value'),
  'param2': refer('callback'),
});
```

---

## Adding New Generation Features

### Adding a New Component Property

1. **Update ComponentGenerator:**
```dart
Method _generateBuildMethod(ComponentDefinition component) {
  // Add new property to render call
  return Method((m) => m
    ..body = refer('style.renderButton').call([], {
      // ... existing properties
      'newProp': refer('newProp'),
    }).code
  );
}
```

### Adding a New Layout Node

1. **Create emit strategy:**
```dart
class NewNodeEmitStrategy implements EmitStrategy<NewNode> {
  @override
  Expression emit(NewNode node, EmitContext context) {
    return refer('AppNewNode').newInstance([], {
      'prop': literalString(node.prop),
    });
  }
}
```

2. **Register in LayoutEmitter:**
```dart
final _strategies = {
  // ... existing strategies
  'newNode': NewNodeEmitStrategy(),
};
```

---

## Debugging Generation

### Print Generated Code

```dart
final library = Library((lib) => ...);
print(library.accept(DartEmitter()).toString());
```

### Skip Formatting (for debugging)

```dart
// Don't format - see raw output
final code = library.accept(_emitter).toString();
print(code);  // Before formatting
```

### Common Issues

| Issue                  | Cause                      | Fix                         |
| ---------------------- | -------------------------- | --------------------------- |
| Syntax error in output | Invalid code_builder usage | Check method/field builders |
| Missing import         | Import not added           | Add to `_generateImports()` |
| Type error             | Wrong refer() usage        | Check type references       |

---

## Related Docs

- **[05-code-generation.md](05-code-generation.md)** - High-level code gen overview
- **[06-parser-deep-dive.md](06-parser-deep-dive.md)** - How parsing works
- **[08-design-system-deep-dive.md](08-design-system-deep-dive.md)** - Token generation
- **[12-file-reference.md](12-file-reference.md)** - Generator file descriptions
