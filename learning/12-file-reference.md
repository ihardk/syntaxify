# File Reference 📁

**Every important file explained**

This document explains what each important file does, when you should modify it, and how it fits into the system.

---

## Directory Structure Overview

```
syntaxify/
├── generator/                          # Main Syntaxify package
│   ├── lib/                           # Core library code
│   ├── design_system/                 # Runtime design system
│   ├── meta/                          # Component definitions (INPUT)
│   ├── example/                       # Example app
│   └── test/                          # Tests
├── syntaxify/                         # Root package (re-exports)
└── learning/                          # Documentation
```

---

## Core Library (`generator/lib/`)

### Entry Points

#### `lib/cli.dart`

**What it is:**
- Entry point for the Syntaxify CLI
- Registers all commands
- Handles command-line arguments

**When to modify:**
- Adding a new CLI command
- Changing CLI behavior
- Adding global CLI options

**Example:**
```dart
void main(List<String> arguments) async {
  final runner = CommandRunner(
    'syntaxify',
    'Generate cross-platform Flutter UI components',
  );

  runner
    ..addCommand(BuildCommand())
    ..addCommand(InitCommand())
    ..addCommand(CleanCommand());  // Add new command here

  await runner.run(arguments);
}
```

#### `lib/syntaxify.dart`

**What it is:**
- Public API for the package
- Exports everything users need
- Barrel file for public interfaces

**When to modify:**
- Adding new public APIs
- Changing what's exposed to users
- Adding new annotations or models

**Example:**
```dart
library syntaxify;

export 'src/annotations/syntax_annotations.dart';
export 'src/models/ast_node.dart';
export 'src/models/screen_definition.dart';
// Add new exports here
```

---

### Commands (`lib/src/commands/`)

#### `build_command.dart`

**What it is:**
- Implements `dart run syntaxify build`
- Orchestrates component and screen generation
- Main command users run

**When to modify:**
- Adding build options
- Changing build behavior
- Adding new generation features

**Key methods:**
```dart
class BuildCommand extends Command {
  @override
  String get description => 'Generate components and screens';

  @override
  Future<void> run() async {
    // Add custom build logic here
  }
}
```

#### `init_command.dart`

**What it is:**
- Implements `dart run syntaxify init`
- Scaffolds new Syntaxify projects
- Creates directory structure and example files

**When to modify:**
- Changing initial project structure
- Adding example files
- Updating scaffolding templates

#### `clean_command.dart`

**What it is:**
- Implements `dart run syntaxify clean`
- Removes generated files
- Cleans build artifacts

**When to modify:**
- Changing what files get cleaned
- Adding new generated file patterns
- Updating cleanup logic

---

### Use Cases (`lib/src/use_cases/`)

#### `generate_component.dart`

**What it is:**
- Business logic for component generation
- Finds meta files
- Orchestrates parsing and generation
- Writes generated files

**When to modify:**
- Changing component generation flow
- Adding file discovery logic
- Modifying output paths

**Key methods:**
```dart
class GenerateComponentsUseCase {
  Future<void> execute() async {
    final metaFiles = _findMetaFiles();

    for (final file in metaFiles) {
      final component = _parseComponent(file);
      final code = _generateComponent(component);
      _writeFile(code);
    }
  }
}
```

#### `generate_screen.dart`

**What it is:**
- Business logic for screen generation
- Finds screen definitions
- Generates screen files (once only)
- Preserves user edits

**When to modify:**
- Changing screen generation flow
- Adding screen discovery logic
- Modifying screen templates

---

### Parser (`lib/src/parser/`)

#### `meta_parser.dart`

**What it is:**
- Parses `*.meta.dart` files
- Extracts `@SyntaxComponent` annotations
- Builds `ComponentDefinition` models
- Uses Dart analyzer

**When to modify:**
- Adding new annotation parameters
- Extracting additional metadata
- Changing parsing logic
- Supporting new property types

**Key methods:**
```dart
class MetaParser {
  ComponentDefinition parse(String filePath) {
    // Uses analyzer to parse Dart file
    final unit = parseFile(path: filePath).unit;

    // Find @SyntaxComponent
    final annotation = _findAnnotation(unit);

    // Extract definition
    return _buildDefinition(annotation);
  }
}
```

#### `screen_parser.dart`

**What it is:**
- Parses `*.screen.dart` files
- Extracts `ScreenDefinition` instances
- Validates screen structure
- Collects callbacks

**When to modify:**
- Adding screen-level features
- Changing screen validation
- Supporting new screen properties

---

### Generators (`lib/src/generators/`)

#### `component/button_generator.dart`

**What it is:**
- Generates `AppButton` component class
- Uses `code_builder`
- Creates component structure

**When to modify:**
- Changing generated component structure
- Adding component-level features
- Modifying builder methods

**Similar files:**
- `text_generator.dart` - Generates `AppText`
- `input_generator.dart` - Generates `AppInput`

**Pattern:**
```dart
class ButtonGenerator {
  Library generate(ComponentDefinition component) {
    return Library((lib) => lib
      ..body.add(_buildComponentClass(component))
    );
  }

  Class _buildComponentClass(ComponentDefinition component) {
    return Class((cls) => cls
      ..name = component.name
      ..extend = refer('StatelessWidget')
      ..constructors.add(_buildConstructor(component))
      ..methods.add(_buildBuildMethod(component))
    );
  }
}
```

#### `screen_generator.dart`

**What it is:**
- Generates screen classes from AST
- Uses `LayoutEmitter` to convert AST to code
- Collects callbacks from layout
- Creates screen structure

**When to modify:**
- Changing generated screen structure
- Adding screen-level features
- Modifying callback collection

**Key methods:**
```dart
class ScreenGenerator {
  Library generate(ScreenDefinition screen) {
    final callbacks = _collectCallbacks(screen.layout);

    return Library((lib) => lib
      ..body.add(_buildScreenClass(screen, callbacks))
    );
  }
}
```

#### `renderer_generator.dart`

**What it is:**
- Generates renderer mixins for each style
- Creates Material, Cupertino, Neo renderers
- Implements render methods

**When to modify:**
- Adding new styles
- Changing renderer structure
- Modifying render method signatures

---

### Emitters (`lib/src/emitters/`)

#### `layout_emitter.dart`

**What it is:**
- Converts AST nodes to `code_builder` expressions
- Traverses AST tree recursively
- Generates layout code

**When to modify:**
- Adding new AST node types
- Changing how nodes are emitted
- Modifying widget generation

**Key method:**
```dart
class LayoutEmitter {
  Expression emit(AstNode node) {
    return node.map(
      column: (n) => _emitColumn(n),
      row: (n) => _emitRow(n),
      button: (n) => _emitButton(n),
      text: (n) => _emitText(n),
      // Add new node types here
    );
  }
}
```

---

### Models (`lib/src/models/`)

#### `ast_node.dart`

**What it is:**
- Defines all AST node types
- Uses `freezed` for immutable models
- Union type for different nodes

**When to modify:**
- Adding new UI component types
- Adding properties to existing nodes
- Changing node structure

**Pattern:**
```dart
@freezed
sealed class AstNode with _$AstNode {
  const factory AstNode.button({
    required String label,
    String? onPressed,
    ButtonVariant? variant,
  }) = ButtonNode;

  // Add new node types here
}
```

**After modifying:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

#### `component_definition.dart`

**What it is:**
- Model for parsed component metadata
- Contains component name, properties, variants
- Used throughout generation pipeline

**When to modify:**
- Adding component-level metadata
- Changing what gets extracted from meta files
- Adding new component features

```dart
@freezed
class ComponentDefinition with _$ComponentDefinition {
  const factory ComponentDefinition({
    required String name,
    required String className,
    String? explicitName,
    required List<ComponentProp> properties,
    required List<String> variants,
    String? description,
  }) = _ComponentDefinition;
}
```

#### `screen_definition.dart`

**What it is:**
- Model for screen definitions
- Contains screen ID, layout, app bar
- Used in screen generation

**When to modify:**
- Adding screen-level properties
- Adding screen metadata
- Supporting new screen features

```dart
class ScreenDefinition {
  final String id;
  final AstNode layout;
  final AppBarNode? appBar;
}
```

---

### Annotations (`lib/src/annotations/`)

#### `syntax_annotations.dart`

**What it is:**
- Defines `@SyntaxComponent` annotation
- Used to mark component meta classes
- Provides component metadata

**When to modify:**
- Adding annotation parameters
- Adding new annotations
- Changing component metadata

**Current:**
```dart
class SyntaxComponent {
  final String? name;
  final String? description;

  const SyntaxComponent({this.name, this.description});
}
```

**To add a parameter:**
```dart
class SyntaxComponent {
  final String? name;
  final String? description;
  final String? category;  // NEW

  const SyntaxComponent({this.name, this.description, this.category});
}
```

---

### Utils (`lib/src/utils/`)

#### `component_naming.dart`

**What it is:**
- Utilities for component naming
- Handles explicit vs implicit names
- Generates file names

**When to modify:**
- Changing naming conventions
- Adding naming rules
- Modifying file name generation

```dart
class ComponentNaming {
  static String getComponentName(ComponentDefinition component) {
    return component.explicitName ?? component.className.replaceAll('Meta', '');
  }
}
```

---

## Design System (`generator/design_system/`)

### Core Files

#### `design_system.dart`

**What it is:**
- Main export file for design system
- Uses `part` directives for all files
- Single library for runtime system

**When to modify:**
- Adding new tokens
- Adding new renderers
- Adding new styles

**Structure:**
```dart
library design_system;

import 'package:flutter/material.dart';

// Core
part 'app_theme.dart';
part 'design_style.dart';

// Tokens
part 'tokens/button_tokens.dart';
part 'tokens/text_tokens.dart';
// Add new tokens here

// Styles
part 'material_style.dart';
part 'cupertino_style.dart';
part 'neo_style.dart';
// Add new styles here

// Material renderers
part 'styles/material/button_renderer.dart';
// Add new renderers here
```

#### `app_theme.dart`

**What it is:**
- `InheritedWidget` for providing style
- Propagates style down widget tree
- Accessed via `AppTheme.of(context)`

**When to modify:**
- Rarely! This is stable
- Only if changing theme mechanism
- Adding theme-level features

```dart
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final DesignStyle style;

  static AppTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!;
  }
}
```

#### `design_style.dart`

**What it is:**
- Abstract base class for all styles
- Defines contract all styles must implement
- Declares token getters and render methods

**When to modify:**
- Adding new component types
- Adding new token types
- Changing style contract

**Pattern:**
```dart
abstract class DesignStyle {
  // Token getters
  ButtonTokens get buttonTokens;
  TextTokens get textTokens;
  // Add new token getters here

  // Render methods
  Widget renderButton({...});
  Widget renderText({...});
  // Add new render methods here
}
```

---

### Tokens (`design_system/tokens/`)

#### Pattern: `*_tokens.dart`

**What it is:**
- Design values for a component
- Colors, spacing, sizes, etc.
- Style-agnostic data classes

**When to modify:**
- Adding new token properties
- Creating tokens for new components

**Example:**
```dart
// button_tokens.dart
class ButtonTokens {
  const ButtonTokens({
    required this.primaryBackgroundColor,
    required this.borderRadius,
    required this.paddingVertical,
    // Add new properties here
  });

  final Color primaryBackgroundColor;
  final double borderRadius;
  final double paddingVertical;
}
```

---

### Styles

#### `material_style.dart`

**What it is:**
- Material Design implementation
- Composes renderer mixins
- Provides Material look and feel

**When to modify:**
- Adding new component renderers
- Changing Material-specific behavior

```dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer {
  // Add new mixins here
}
```

#### `cupertino_style.dart`

**What it is:**
- iOS Design implementation
- Composes renderer mixins
- Provides iOS look and feel

**When to modify:**
- Adding new component renderers
- Changing iOS-specific behavior

#### `neo_style.dart`

**What it is:**
- Custom Neo design implementation
- Composes renderer mixins
- Provides custom look and feel

**When to modify:**
- Adding new component renderers
- Changing Neo-specific styling

---

### Renderers (`design_system/styles/*/`)

#### Pattern: `*_renderer.dart`

**What it is:**
- Mixin that implements rendering for one component
- Provides tokens and render method
- Style-specific implementation

**When to modify:**
- Changing how a component renders
- Updating design tokens
- Fixing rendering bugs

**Pattern:**
```dart
// styles/material/button_renderer.dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    // Material-specific values
  );

  @override
  Widget renderButton({...}) {
    // Material-specific rendering
    return ElevatedButton(...);
  }
}
```

---

## Meta Files (`generator/meta/`)

#### Pattern: `*.meta.dart`

**What it is:**
- Component definitions (INPUT)
- Describes component API
- Processed by generator

**When to modify:**
- Creating new components
- Changing component APIs
- Adding component properties

**Example:**
```dart
// button.meta.dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final ButtonVariant? variant;
  final VoidCallback? onPressed;
}
```

#### Pattern: `*.screen.dart`

**What it is:**
- Screen definitions (INPUT)
- Describes screen layout using AST
- Processed by generator

**When to modify:**
- Creating new screens
- Defining screen layouts
- Testing layouts

**Example:**
```dart
// login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Welcome'),
      AstNode.button(label: 'Login', onPressed: 'handleLogin'),
    ],
  ),
);
```

---

## Generated Files (`generator/lib/generated/`)

### ⚠️ DO NOT EDIT THESE FILES

These files are generated by Syntaxify. Your edits will be overwritten on next build.

#### `components/*.dart`

**What it is:**
- Generated component classes
- Delegate to style renderers
- Auto-generated from meta files

**Regenerate:**
```bash
dart run syntaxify build
```

#### `components.dart`

**What it is:**
- Barrel file exporting all components
- Auto-updated when components are generated

---

## Example App (`generator/example/`)

#### `lib/main.dart`

**What it is:**
- Example app entry point
- Shows how to use Syntaxify
- Used for testing

**When to modify:**
- Testing new components
- Demonstrating features
- Trying different styles

#### `lib/screens/*.dart`

**What it is:**
- Generated screens (editable after first generation)
- You CAN edit these
- Won't be overwritten

**When to modify:**
- Adding business logic
- Implementing callbacks
- Customizing screens

---

## Tests (`generator/test/`)

#### `parser/meta_parser_test.dart`

**What it is:**
- Tests for meta file parsing
- Ensures correct extraction of metadata

**When to modify:**
- Adding parser features
- Fixing parser bugs
- Adding test cases

#### `generators/*_test.dart`

**What it is:**
- Tests for code generators
- Ensures correct code generation

**When to modify:**
- Adding generator features
- Changing generated code structure
- Adding test cases

---

## Quick Reference Table

| File | Modify When | Regenerate |
|------|-------------|------------|
| `cli.dart` | Adding CLI commands | No |
| `*_command.dart` | Adding command logic | No |
| `*_parser.dart` | Changing parsing logic | No |
| `*_generator.dart` | Changing code generation | No |
| `layout_emitter.dart` | Adding AST nodes | No |
| `ast_node.dart` | Adding component types | Yes (build_runner) |
| `*_definition.dart` | Adding metadata | Yes (build_runner) |
| `design_style.dart` | Adding components | No |
| `*_style.dart` | Adding renderers | No |
| `*_tokens.dart` | Adding token properties | No |
| `*_renderer.dart` | Changing rendering | No |
| `*.meta.dart` | Defining components | Yes (syntaxify build) |
| `*.screen.dart` | Defining screens | Yes (syntaxify build) |
| `generated/**` | NEVER | Auto-generated |

---

## File Dependencies

```
ast_node.dart
    ↓ (used by)
layout_emitter.dart
    ↓ (used by)
screen_generator.dart
    ↓ (used by)
generate_screen.dart
    ↓ (used by)
build_command.dart


*.meta.dart
    ↓ (parsed by)
meta_parser.dart
    ↓ (outputs)
component_definition.dart
    ↓ (used by)
*_generator.dart
    ↓ (used by)
generate_component.dart
    ↓ (used by)
build_command.dart


design_style.dart
    ← (implements)
material_style.dart
    ← (uses)
material_*_renderer.dart
    ← (renders)
AppButton, AppText, etc.
```

---

## Summary

**Core Flow:**
1. User writes `*.meta.dart` or `*.screen.dart`
2. CLI command parses files
3. Generators create code structures
4. Emitters convert to strings
5. Files written to disk
6. User imports and uses generated components

**Key Rules:**
- ✅ EDIT: `lib/src/**`, `design_system/**`, `meta/**`
- ❌ DON'T EDIT: `lib/generated/**`
- 🔄 REGENERATE: After modifying `ast_node.dart` or `*_definition.dart`
- 🏗️ BUILD: After modifying `*.meta.dart` or `*.screen.dart`

---

**Need to understand a specific concept?**

➡️ **See:**
- [02-architecture-overview.md](02-architecture-overview.md) - How it all connects
- [05-code-generation.md](05-code-generation.md) - How code is generated
- [09-adding-new-component.md](09-adding-new-component.md) - Practical guide
