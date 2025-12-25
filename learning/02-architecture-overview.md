# Architecture Overview 🏗️

**Understanding how all the pieces fit together**

Now that you know *what* Syntaxify is, let's see *how* it's built.

---

## The Big Picture

Syntaxify has **two main phases**:

```
┌─────────────────────────────────────────────────────────────┐
│                    PHASE 1: BUILD TIME                      │
│                  (Code Generation)                          │
└─────────────────────────────────────────────────────────────┘
        You write meta files
               ↓
        Syntaxify CLI parses them
               ↓
        Generates Dart code
               ↓
        You get Flutter widgets

┌─────────────────────────────────────────────────────────────┐
│                    PHASE 2: RUNTIME                         │
│                  (Component Rendering)                      │
└─────────────────────────────────────────────────────────────┘
        Your app runs
               ↓
        AppButton.primary() is called
               ↓
        Gets current style from AppTheme
               ↓
        Style renders the button
               ↓
        User sees ElevatedButton (or CupertinoButton, etc.)
```

**Key insight:** Code generation happens ONCE (at build time), but rendering happens EVERY TIME a component is used (at runtime).

---

## Phase 1: Build Time (Code Generation)

### The Flow

```
┌─────────────────┐
│   Meta Files    │  You write these
│  *.meta.dart    │
│  *.screen.dart  │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│   CLI Command   │  $ dart run syntaxify build
│  lib/cli.dart   │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│   Use Cases     │  Orchestrates the work
│  generate_*.dart│
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│    Parsers      │  Reads meta files
│  meta_parser    │  Builds component definitions
│  screen_parser  │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│   Generators    │  Creates Dart code structure
│  *_generator    │  (using code_builder)
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│    Emitters     │  Converts AST to code
│  *_emitter      │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  Generated Code │  Final Dart files
│  lib/generated/ │
│  lib/screens/   │
└─────────────────┘
```

### Layer Responsibilities

**1. CLI Layer** (`lib/cli.dart`, `lib/commands/`)
- Entry point for all commands
- Handles user input
- Delegates to use cases

```dart
// Example: build_command.dart
class BuildCommand extends Command {
  @override
  Future<void> run() async {
    final useCase = GenerateComponentsUseCase();
    await useCase.execute();
  }
}
```

**2. Use Case Layer** (`lib/src/use_cases/`)
- Orchestrates the entire generation process
- Coordinates parsers and generators
- Handles file I/O

```dart
// Example: generate_component.dart
class GenerateComponentUseCase {
  Future<void> execute() async {
    // 1. Find meta files
    final metaFiles = _findMetaFiles();

    // 2. Parse them
    final components = _parseComponents(metaFiles);

    // 3. Generate code
    final code = _generateCode(components);

    // 4. Write to disk
    _writeFiles(code);
  }
}
```

**3. Parser Layer** (`lib/src/parser/`)
- Reads Dart meta files using `analyzer`
- Extracts component definitions
- Validates structure

```dart
// Example: meta_parser.dart
class MetaParser {
  ComponentDefinition parse(String filePath) {
    // Uses Dart analyzer to parse the file
    final ast = parseFile(path: filePath);

    // Extracts @SyntaxComponent annotation
    final annotation = _findAnnotation(ast);

    // Returns structured definition
    return ComponentDefinition(...);
  }
}
```

**4. Generator Layer** (`lib/src/generators/`)
- Creates Dart code structures
- Uses `code_builder` library
- Generates component classes, renderers, etc.

```dart
// Example: button_generator.dart
class ButtonGenerator {
  Library generate(ComponentDefinition component) {
    return Library((b) => b
      ..body.add(Class((c) => c
        ..name = 'AppButton'
        ..extend = refer('StatelessWidget')
        ..methods.add(_buildMethod())
      ))
    );
  }
}
```

**5. Emitter Layer** (`lib/src/emitters/`)
- Converts AST nodes to code
- Handles layout generation
- Produces Flutter widgets from App definitions

```dart
// Example: layout_emitter.dart
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

---

## Phase 2: Runtime (Component Rendering)

### The Flow

```
┌─────────────────┐
│   Your App      │
│   main.dart     │
└────────┬────────┘
         │
         │ Wraps with AppTheme
         ↓
┌─────────────────┐
│   AppTheme      │  InheritedWidget
│  style: Material│  Provides style to tree
└────────┬────────┘
         │
         │ Context propagation
         ↓
┌─────────────────┐
│  AppButton()    │  Component widget
└────────┬────────┘
         │
         │ build() called
         ↓
┌─────────────────┐
│  AppTheme.of()  │  Gets style from context
└────────┬────────┘
         │
         │ Returns MaterialStyle
         ↓
┌─────────────────┐
│  .renderButton()│  Style's render method
└────────┬────────┘
         │
         │ Delegates to renderer
         ↓
┌─────────────────┐
│ ElevatedButton  │  Material widget
│ (Flutter SDK)   │
└─────────────────┘
```

### Runtime Components

**1. AppTheme (InheritedWidget)**

Provides the current style to all descendants.

```dart
// generator/design_system/app_theme.dart
class AppTheme extends InheritedWidget {
  final DesignStyle style;

  static AppTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!;
  }
}
```

**Usage:**
```dart
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // <-- Sets the style
      child: MyApp(),
    ),
  );
}
```

**2. DesignStyle (Abstract Base Class)**

Defines the contract all styles must implement.

```dart
// generator/design_system/design_style.dart
sealed class DesignStyle {
  const DesignStyle();

  // Foundation tokens (single source of truth)
  FoundationTokens get foundation;

  // Token getters
  ButtonTokens buttonTokens(ButtonVariant variant);
  InputTokens get inputTokens;
  TextTokens textTokens(TextVariant variant);

  // Render methods
  Widget renderButton({required String label, ...});
  Widget renderText({required String text, ...});
  Widget renderInput({required TextEditingController? controller, ...});
}
```

**3. Concrete Styles (MaterialStyle, CupertinoStyle, NeoStyle)**

Implement the rendering for specific design systems.

```dart
// generator/design_system/material_style.dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer {
  // Mixins provide the implementations
}
```

**4. Renderer Mixins**

Provide rendering logic for each component.

```dart
// generator/design_system/styles/material/button_renderer.dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  Widget renderButton({...}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          buttonTokens.primaryBackgroundColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

**5. Generated Components**

Use the renderer pattern to delegate rendering.

```dart
// lib/generated/components/app_button.dart (generated)
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // DELEGATION: Get style and render
    return AppTheme.of(context).style.renderButton(
      label: label,
      onPressed: onPressed,
    );
  }
}
```

---

## Directory Structure

Here's what everything lives:

```
syntaxify/
├── generator/                    # The Syntaxify package
│   ├── lib/
│   │   ├── cli.dart             # CLI entry point
│   │   ├── syntaxify.dart       # Public API
│   │   └── src/
│   │       ├── annotations/     # @SyntaxComponent, etc.
│   │       ├── commands/        # CLI commands (build, init, etc.)
│   │       ├── use_cases/       # Business logic
│   │       ├── parser/          # Meta file parsing
│   │       ├── generators/      # Code generation
│   │       ├── emitters/        # AST to code conversion
│   │       ├── models/          # Data models (ComponentDefinition, etc.)
│   │       └── utils/           # Helpers
│   │
│   ├── design_system/           # Runtime design system
│   │   ├── design_system.dart   # Main export
│   │   ├── app_theme.dart       # InheritedWidget
│   │   ├── design_style.dart    # Abstract base
│   │   ├── tokens/              # Design tokens
│   │   │   ├── button_tokens.dart
│   │   │   ├── text_tokens.dart
│   │   │   └── ...
│   │   └── styles/              # Style implementations
│   │       ├── material/        # Material Design
│   │       │   ├── material_style.dart
│   │       │   ├── button_renderer.dart
│   │       │   └── ...
│   │       ├── cupertino/       # iOS Design
│   │       └── neo/             # Custom Design
│   │
│   └── example/                 # Example app
│       ├── meta/                # Meta definitions (INPUT)
│       │   ├── button.meta.dart
│       │   └── login.screen.dart
│       ├── lib/
│       │   ├── generated/       # Generated components (OUTPUT)
│       │   └── screens/         # Generated screens (OUTPUT)
│       └── main.dart
│
├── syntaxify/                   # Root package (re-exports)
└── learning/                    # Documentation (you are here!)
```

---

## Data Flow Diagram

### Build Time Flow

```
┌──────────────────────────────────────────────────────────────┐
│                      Developer Actions                       │
└──────────────────────────────────────────────────────────────┘
                              │
                              ↓
         ┌──────────────────────────────────────┐
         │  1. Write meta/button.meta.dart      │
         │                                      │
         │  @SyntaxComponent(name: 'AppButton') │
         │  class ButtonMeta {                  │
         │    final String label;               │
         │  }                                   │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  2. Run: dart run syntaxify build    │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  3. CLI → Use Case                   │
         │     GenerateComponentsUseCase        │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  4. Parser reads file                │
         │     Uses Dart analyzer               │
         │     Extracts @SyntaxComponent        │
         │     Creates ComponentDefinition      │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  5. Generator creates code           │
         │     Uses code_builder                │
         │     Generates AppButton class        │
         │     Generates renderers              │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  6. Files written to disk            │
         │     lib/generated/components/        │
         │     design_system/styles/material/   │
         │     design_system/styles/cupertino/  │
         └──────────────┬───────────────────────┘
                        │
                        ↓
┌──────────────────────────────────────────────────────────────┐
│               Generated Code (Ready to use!)                 │
└──────────────────────────────────────────────────────────────┘
```

### Runtime Flow

```
┌──────────────────────────────────────────────────────────────┐
│                      App Starts                              │
└──────────────────────────────────────────────────────────────┘
                              │
                              ↓
         ┌──────────────────────────────────────┐
         │  1. main() creates AppTheme          │
         │                                      │
         │  AppTheme(                           │
         │    style: MaterialStyle(),           │
         │    child: MyApp(),                   │
         │  )                                   │
         └──────────────┬───────────────────────┘
                        │
                        │ InheritedWidget propagation
                        ↓
         ┌──────────────────────────────────────┐
         │  2. Widget tree has access           │
         │     to MaterialStyle                 │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  3. AppButton() builds               │
         │                                      │
         │  @override                           │
         │  Widget build(BuildContext context)  │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  4. Gets style from context          │
         │                                      │
         │  AppTheme.of(context).style          │
         │  // Returns MaterialStyle            │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  5. Calls render method              │
         │                                      │
         │  style.renderButton(                 │
         │    label: 'Submit',                  │
         │    onPressed: handleSubmit,          │
         │  )                                   │
         └──────────────┬───────────────────────┘
                        │
                        ↓
         ┌──────────────────────────────────────┐
         │  6. MaterialButtonRenderer executes  │
         │                                      │
         │  return ElevatedButton(...)          │
         └──────────────┬───────────────────────┘
                        │
                        ↓
┌──────────────────────────────────────────────────────────────┐
│              User sees Material button!                      │
└──────────────────────────────────────────────────────────────┘
```

---

## Key Design Patterns

### 1. Strategy Pattern (Renderer Pattern)

Different rendering strategies (Material, Cupertino, Neo) for the same component.

```dart
// Same component
AppButton(label: 'Submit')

// Different strategies
MaterialStyle → ElevatedButton
CupertinoStyle → CupertinoButton.filled
NeoStyle → Custom gradient button
```

### 2. Visitor Pattern (AST Traversal)

Walking the AST tree to emit code.

```dart
node.map(
  structural: (n) => visitStructural(n),
  primitive: (n) => visitPrimitive(n),
  interactive: (n) => visitInteractive(n),
  custom: (n) => visitCustom(n),
  appBar: (n) => visitAppBar(n),
);
```

### 3. Builder Pattern (Code Generation)

Using `code_builder` to construct Dart code programmatically.

```dart
Class((b) => b
  ..name = 'AppButton'
  ..extend = refer('StatelessWidget')
  ..methods.add(...)
);
```

### 4. Mixin Pattern (Renderer Composition)

Composing styles from individual renderer mixins.

```dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer {
  // Style composed from mixins
}
```

### 5. Factory Pattern (App Creation)

Static factory methods for creating layout nodes.

```dart
App.button(label: 'Submit', onPressed: 'handleSubmit')
App.text(text: 'Hello')
App.column(children: [...])
```

---

## Component Lifecycle

### Build Time Lifecycle

```
1. Discovery
   ↓ Find all *.meta.dart files

2. Parsing
   ↓ Extract @SyntaxComponent annotations
   ↓ Build ComponentDefinition model

3. Validation
   ↓ Check required fields
   ↓ Validate types

4. Generation
   ↓ Generate component class
   ↓ Generate renderer methods
   ↓ Generate exports

5. Writing
   ↓ Write generated files to disk
   ↓ Update barrel files
```

### Runtime Lifecycle

```
1. App Start
   ↓ AppTheme created with style

2. Component Build
   ↓ AppButton.build() called

3. Style Lookup
   ↓ AppTheme.of(context) gets style

4. Rendering
   ↓ style.renderButton() called

5. Widget Creation
   ↓ ElevatedButton returned

6. Display
   ↓ Flutter renders to screen
```

---

## Important Files Reference

| File                                                 | Layer     | Purpose                            |
| ---------------------------------------------------- | --------- | ---------------------------------- |
| `lib/cli.dart`                                       | CLI       | Entry point, command registration  |
| `lib/src/commands/build_command.dart`                | CLI       | Build command implementation       |
| `lib/src/use_cases/generate_component.dart`          | Use Case  | Component generation orchestration |
| `lib/src/use_cases/generate_screen.dart`             | Use Case  | Screen generation orchestration    |
| `lib/src/parser/meta_parser.dart`                    | Parser    | Parse component meta files         |
| `lib/src/parser/screen_parser.dart`                  | Parser    | Parse screen definitions           |
| `lib/src/generators/component/button_generator.dart` | Generator | Generate button components         |
| `lib/src/generators/screen_generator.dart`           | Generator | Generate screens                   |
| `lib/src/emitters/layout_emitter.dart`               | Emitter   | Convert AST to layout code         |
| `lib/src/models/component_definition.dart`           | Model     | Component data model               |
| `lib/src/models/ast_node.dart`                       | Model     | AST node definitions               |
| `design_system/app_theme.dart`                       | Runtime   | Theme provider                     |
| `design_system/design_style.dart`                    | Runtime   | Style base class                   |
| `design_system/styles/material/material_style.dart`  | Runtime   | Material implementation            |

---

## Questions This Answers

**Q: Where do I add a new CLI command?**
A: Create a new class in `lib/src/commands/` extending `Command`, then register it in `lib/cli.dart`.

**Q: Where is the button rendering logic?**
A: In `design_system/styles/material/button_renderer.dart` (for Material), similar for other styles.

**Q: How do I add a new component type?**
A: You'll touch:
1. `lib/src/models/ast_node.dart` - Add new node type
2. `lib/src/generators/component/` - Add generator
3. `design_system/styles/*/` - Add renderers for each style

**Q: Where are components discovered?**
A: `lib/src/use_cases/generate_component.dart:_findMetaFiles()` scans the `meta/` directory.

**Q: How does AppTheme work?**
A: It's an `InheritedWidget` in `design_system/app_theme.dart` that propagates the style down the widget tree.

---

## Common Workflows

### Adding a New Component

```
1. Write meta file
   ↓ meta/card.meta.dart

2. Run build
   ↓ dart run syntaxify build

3. Component generated
   ↓ lib/generated/components/app_card.dart

4. Renderers generated
   ↓ design_system/styles/*/card_renderer.dart

5. Use component
   ↓ AppCard(title: 'Hello')
```

### Switching Styles

```
1. Open main.dart

2. Change style
   AppTheme(
     style: CupertinoStyle(),  // <-- Change this line
     child: MyApp(),
   )

3. Hot reload

4. Entire app updates! ✨
```

### Creating a Screen

```
1. Define screen
   ↓ meta/profile.screen.dart

2. Run build
   ↓ dart run syntaxify build

3. Screen generated
   ↓ lib/screens/profile_screen.dart

4. Use screen
   ↓ ProfileScreen(onLogout: handleLogout)
```

---

## Summary

**Build Time:**
- CLI → Use Cases → Parsers → Generators → Emitters → Files
- Happens ONCE when you run `dart run syntaxify build`
- Produces Dart code files

**Runtime:**
- AppTheme → Component → Style Lookup → Renderer → Widget
- Happens EVERY TIME a component renders
- No code generation at runtime

**Key Layers:**
1. **CLI** - User interface
2. **Use Cases** - Orchestration
3. **Parsers** - Read meta files
4. **Generators** - Create code structures
5. **Emitters** - Produce final code
6. **Runtime** - Style system and rendering

**Design Patterns:**
- Strategy (rendering)
- Visitor (AST)
- Builder (code generation)
- Mixin (renderer composition)
- Factory (AST nodes)

---

**Ready to dive deeper?**

➡️ **Next:** [03-ast-system.md](03-ast-system.md) - Understanding the AST

**Or jump to:**
- [04-renderer-pattern.md](04-renderer-pattern.md) - How rendering works
- [12-file-reference.md](12-file-reference.md) - What each file does
