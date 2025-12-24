# Code Generation Explained ⚙️

**How meta files become Dart code**

Code generation is the magic that turns your simple definitions into fully functional Flutter code. Let's see how it works!

---

## What is Code Generation?

**Code generation** = Writing code that writes code.

Instead of manually writing repetitive boilerplate, you define what you want, and Syntaxify generates the code for you.

### The Process

```
┌──────────────────────┐
│   You Write This     │
│   (5 lines)          │
│                      │
│  @SyntaxComponent(   │
│    name: 'AppButton' │
│  )                   │
│  class ButtonMeta {  │
│    String label;     │
│  }                   │
└──────────┬───────────┘
           │
           │ $ dart run syntaxify build
           ↓
┌──────────────────────┐
│  Syntaxify Generates │
│  (200+ lines)        │
│                      │
│  - AppButton class   │
│  - Material renderer │
│  - Cupertino renderer│
│  - Neo renderer      │
│  - Exports           │
│  - Documentation     │
└──────────────────────┘
```

**You write the essence, Syntaxify writes the boilerplate!**

---

## Why Code Generation?

### Without Code Generation

```dart
// You write this for Material
class MaterialButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

// You write this for Cupertino
class CupertinoButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

// You write this for Neo
class NeoButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(...),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Text(label),
      ),
    );
  }
}

// You write the orchestrator
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).style;
    return style.renderButton(label: label, onPressed: onPressed);
  }
}
```

**That's 100+ lines of boilerplate for ONE component!**

### With Code Generation

```dart
// You write this (5 lines)
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final VoidCallback? onPressed;
}
```

**Syntaxify generates all the boilerplate!**

---

## The Build Command

### Running the Generator

```bash
$ dart run syntaxify build
```

**What happens:**
1. Finds all `*.meta.dart` files
2. Parses component definitions
3. Generates component classes
4. Generates renderer mixins for each style
5. Writes files to disk
6. Updates barrel files

### Output

```
✓ Found 3 component definitions
  - ButtonMeta → AppButton
  - TextMeta → AppText
  - InputMeta → AppInput

✓ Generating components...
  - lib/generated/components/app_button.dart
  - lib/generated/components/app_text.dart
  - lib/generated/components/app_input.dart

✓ Generating renderers...
  - design_system/styles/material/button_renderer.dart
  - design_system/styles/material/text_renderer.dart
  - design_system/styles/material/input_renderer.dart
  - design_system/styles/cupertino/button_renderer.dart
  - design_system/styles/cupertino/text_renderer.dart
  - design_system/styles/cupertino/input_renderer.dart
  - design_system/styles/neo/button_renderer.dart
  - design_system/styles/neo/text_renderer.dart
  - design_system/styles/neo/input_renderer.dart

✓ Updating exports...
  - lib/generated/components.dart
  - design_system/styles/material.dart
  - design_system/styles/cupertino.dart
  - design_system/styles/neo.dart

Done! Generated 15 files in 1.2s
```

---

## How Code Generation Works

### The Pipeline

```
┌─────────────────────────────────────────────────────────┐
│  1. File Discovery                                      │
│     Find all *.meta.dart files in meta/ directory       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  2. Parsing                                             │
│     Use Dart analyzer to read files                     │
│     Extract @SyntaxComponent annotations                │
│     Build ComponentDefinition models                    │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  3. Validation                                          │
│     Check required fields                               │
│     Validate types                                      │
│     Check for conflicts                                 │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  4. Code Generation                                     │
│     Use code_builder to create code structures          │
│     Generate component classes                          │
│     Generate renderer mixins                            │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  5. Emission                                            │
│     Convert code_builder structures to strings          │
│     Format code with dart_style                         │
│     Add imports and documentation                       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  6. File Writing                                        │
│     Write generated files to disk                       │
│     Update barrel files                                 │
│     Preserve user edits (for screens)                   │
└─────────────────────────────────────────────────────────┘
```

---

## Step 1: File Discovery

**Code:** `lib/src/use_cases/generate_component.dart`

```dart
class GenerateComponentsUseCase {
  Future<void> execute() async {
    // Find all *.meta.dart files
    final metaFiles = _findMetaFiles();
    print('Found ${metaFiles.length} meta files');

    // ...
  }

  List<File> _findMetaFiles() {
    final metaDir = Directory('meta');
    if (!metaDir.existsSync()) {
      throw Exception('meta/ directory not found');
    }

    return metaDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.meta.dart'))
        .toList();
  }
}
```

**What it does:**
- Looks in the `meta/` directory
- Finds all files ending with `.meta.dart`
- Returns a list of files to process

---

## Step 2: Parsing

**Code:** `lib/src/parser/meta_parser.dart`

Uses the Dart `analyzer` package to read and parse Dart files.

```dart
class MetaParser {
  ComponentDefinition parse(String filePath) {
    // Parse the file using Dart analyzer
    final parseResult = parseFile(path: filePath);
    final unit = parseResult.unit;

    // Find the class with @SyntaxComponent annotation
    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration) {
        final annotation = _findSyntaxComponentAnnotation(declaration);

        if (annotation != null) {
          // Extract component definition
          return _buildComponentDefinition(
            classDeclaration: declaration,
            annotation: annotation,
          );
        }
      }
    }

    throw Exception('No @SyntaxComponent found in $filePath');
  }

  ComponentDefinition _buildComponentDefinition({
    required ClassDeclaration classDeclaration,
    required Annotation annotation,
  }) {
    // Extract class name
    final className = classDeclaration.name.lexeme;

    // Extract explicit name from annotation
    final explicitName = _extractAnnotationName(annotation);

    // Extract properties
    final properties = _extractProperties(classDeclaration);

    return ComponentDefinition(
      name: explicitName ?? className.replaceAll('Meta', ''),
      className: className,
      explicitName: explicitName,
      properties: properties,
      variants: _extractVariants(classDeclaration),
      description: _extractDescription(annotation),
    );
  }
}
```

**What it does:**
- Uses Dart's analyzer to parse the file into an AST
- Traverses the AST to find classes with `@SyntaxComponent`
- Extracts the class name, properties, and metadata
- Returns a structured `ComponentDefinition` model

### Example

**Input:**
```dart
@SyntaxComponent(name: 'AppButton', description: 'A button component')
class ButtonMeta {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
}
```

**Output:**
```dart
ComponentDefinition(
  name: 'AppButton',
  className: 'ButtonMeta',
  explicitName: 'AppButton',
  description: 'A button component',
  properties: [
    ComponentProp(name: 'label', type: 'String', isRequired: true),
    ComponentProp(name: 'onPressed', type: 'VoidCallback', isRequired: false),
    ComponentProp(name: 'variant', type: 'ButtonVariant', isRequired: true),
  ],
  variants: ['ButtonVariant'],
)
```

---

## Step 3: Validation

**Code:** `lib/src/generators/component/component_generator.dart`

```dart
void _validate(ComponentDefinition component) {
  // Check required fields
  if (component.name.isEmpty) {
    throw Exception('Component name cannot be empty');
  }

  // Check for reserved names
  if (_reservedNames.contains(component.name)) {
    throw Exception('${component.name} is a reserved name');
  }

  // Check property types
  for (final prop in component.properties) {
    if (!_isValidType(prop.type)) {
      throw Exception('Invalid type: ${prop.type}');
    }
  }
}
```

**What it validates:**
- Component has a name
- Name doesn't conflict with reserved words
- Properties have valid types
- No duplicate property names

---

## Step 4: Code Generation with code_builder

**The `code_builder` package:**

Instead of manually concatenating strings, we use `code_builder` to programmatically build Dart code structures.

### Why code_builder?

**Without code_builder (string manipulation):**
```dart
String generateClass(ComponentDefinition component) {
  return '''
class ${component.name} extends StatelessWidget {
  const ${component.name}({
    super.key,
${component.properties.map((p) => '    ${p.isRequired ? 'required ' : ''}this.${p.name},').join('\n')}
  });

${component.properties.map((p) => '  final ${p.type} ${p.name};').join('\n')}

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.render${component.type}(...);
  }
}
''';
}
```

**Problems:**
- ❌ Hard to maintain
- ❌ Easy to make syntax errors
- ❌ No type safety
- ❌ Hard to test
- ❌ Doesn't handle escaping
- ❌ Formatting issues

**With code_builder:**
```dart
Library generateClass(ComponentDefinition component) {
  return Library((lib) => lib
    ..body.add(
      Class((cls) => cls
        ..name = component.name
        ..extend = refer('StatelessWidget')
        ..constructors.add(_buildConstructor(component))
        ..fields.addAll(_buildFields(component))
        ..methods.add(_buildBuildMethod(component))
      )
    )
  );
}
```

**Benefits:**
- ✅ Type-safe
- ✅ Easier to maintain
- ✅ Handles formatting
- ✅ Handles escaping
- ✅ Testable
- ✅ Composable

### Example: Generating a Component Class

**Code:** `lib/src/generators/component/button_generator.dart`

```dart
class ButtonGenerator {
  Library generate(ComponentDefinition component) {
    return Library((lib) => lib
      ..comments.add('// Generated code - do not modify by hand')
      ..directives.addAll(_buildImports())
      ..body.add(_buildComponentClass(component))
    );
  }

  Class _buildComponentClass(ComponentDefinition component) {
    return Class((cls) => cls
      ..name = component.name
      ..extend = refer('StatelessWidget')
      ..docs.addAll(_buildDocs(component))
      ..constructors.add(_buildConstructor(component))
      ..fields.addAll(_buildFields(component))
      ..methods.add(_buildBuildMethod(component))
    );
  }

  Constructor _buildConstructor(ComponentDefinition component) {
    return Constructor((ctor) => ctor
      ..constant = true
      ..optionalParameters.add(
        Parameter((p) => p
          ..name = 'key'
          ..named = true
          ..toSuper = true
        ),
      )
      ..optionalParameters.addAll(
        component.properties.map((prop) =>
          Parameter((p) => p
            ..name = prop.name
            ..named = true
            ..required = prop.isRequired
            ..toThis = true
          ),
        ),
      )
    );
  }

  Method _buildBuildMethod(ComponentDefinition component) {
    return Method((method) => method
      ..name = 'build'
      ..returns = refer('Widget')
      ..annotations.add(refer('override'))
      ..requiredParameters.add(
        Parameter((p) => p
          ..name = 'context'
          ..type = refer('BuildContext')
        ),
      )
      ..body = Code('''
        return AppTheme.of(context).style.renderButton(
          ${component.properties.map((p) => '${p.name}: ${p.name},').join('\n          ')}
        );
      ''')
    );
  }
}
```

**This generates:**

```dart
// Generated code - do not modify by hand

import 'package:flutter/material.dart';
import 'package:syntaxify/design_system.dart';

/// A button component
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.onPressed,
  });

  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderButton(
      label: label,
      variant: variant,
      onPressed: onPressed,
    );
  }
}
```

---

## Step 5: Emission (Strategy Pattern)

**Code:** `lib/src/emitters/layout_emitter.dart`

The emission system uses the **Strategy Pattern** for maintainability. Instead of one large file, node emission is split into focused strategy classes:

```
lib/src/emitters/
├── layout_emitter.dart          # Main orchestrator
└── strategies/
    ├── node_emit_strategy.dart  # Base interface + EmitContext
    ├── structural_emitter.dart  # Column, Row, Container, etc.
    ├── primitive_emitter.dart   # Text, Icon, Image, etc.
    ├── interactive_emitter.dart # Button, TextField, etc.
    └── strategies.dart          # Barrel export
```

### Strategy Pattern

```dart
abstract class NodeEmitStrategy {
  Expression emit(dynamic node, EmitContext context);
}

class LayoutEmitter {
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

**Benefits:**
- ✅ Each strategy handles one category of nodes
- ✅ Easy to test strategies in isolation
- ✅ Easy to add new node types
- ✅ Strategies can be injected for testing

### EmitContext

Shared context for recursive emission:

```dart
class EmitContext {
  final Expression Function(App node) emitChild;  // Recursive
  final Map<String, String> controllerMap;        // TextControllers
  final Map<String, String> variableMap;          // Scoped variables
}
```

### Formatting

After emission, code is formatted with `dart_style`:

```dart
final formatter = DartFormatter();
return formatter.format(code);
```

---

## Step 6: File Writing

**Code:** `lib/src/use_cases/generate_component.dart`

```dart
void _writeFile(String path, String content) {
  final file = File(path);

  // Create directories if needed
  file.parent.createSync(recursive: true);

  // Write content
  file.writeAsStringSync(content);

  print('✓ Generated $path');
}

void _generateComponent(ComponentDefinition component) {
  // Generate component class
  final componentCode = ButtonGenerator().generate(component);
  final componentPath = 'lib/generated/components/${_getFileName(component)}.dart';
  _writeFile(componentPath, CodeEmitter().emit(componentCode));

  // Generate renderers for each style
  for (final style in ['material', 'cupertino', 'neo']) {
    final rendererCode = RendererGenerator(style).generate(component);
    final rendererPath = 'design_system/styles/$style/${_getFileName(component)}_renderer.dart';
    _writeFile(rendererPath, CodeEmitter().emit(rendererCode));
  }
}
```

---

## Screen Generation

Screens work similarly, but with a twist:

### Screen Definition

```dart
// meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: App.column(
    children: [
      App.text(text: 'Welcome'),
      App.button(label: 'Login', onPressed: 'handleLogin'),
    ],
  ),
);
```

### Generated Screen

```dart
// lib/screens/login_screen.dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.handleLogin,
  });

  final VoidCallback? handleLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppText(text: 'Welcome'),
          AppButton(label: 'Login', onPressed: handleLogin),
        ],
      ),
    );
  }
}
```

### The Difference

**Components:** ALWAYS regenerated (don't edit them)
**Screens:** Generated ONCE, then you can edit them

**How?**

```dart
void _generateScreen(ScreenDefinition screen) {
  final path = 'lib/screens/${screen.id}_screen.dart';
  final file = File(path);

  // Only generate if file doesn't exist
  if (!file.existsSync()) {
    final code = ScreenGenerator().generate(screen);
    _writeFile(path, code);
  } else {
    print('⊘ Skipping $path (already exists)');
  }
}
```

**Why?**

Screens often need custom logic (state management, API calls, etc.), so you edit them after generation. Components are purely presentational, so they're always regenerated.

---

## code_builder Deep Dive

### Core Concepts

**1. Library**

A Dart file.

```dart
Library((lib) => lib
  ..directives.add(Directive.import('package:flutter/material.dart'))
  ..body.add(Class(...))
);
```

**2. Class**

A class definition.

```dart
Class((cls) => cls
  ..name = 'MyClass'
  ..extend = refer('StatelessWidget')
  ..fields.add(Field(...))
  ..methods.add(Method(...))
);
```

**3. Method**

A method definition.

```dart
Method((method) => method
  ..name = 'build'
  ..returns = refer('Widget')
  ..requiredParameters.add(Parameter(...))
  ..body = Code('return Container();')
);
```

**4. Field**

A class field.

```dart
Field((field) => field
  ..name = 'label'
  ..type = refer('String')
  ..modifier = FieldModifier.final$
);
```

**5. Parameter**

A function/constructor parameter.

```dart
Parameter((p) => p
  ..name = 'label'
  ..type = refer('String')
  ..named = true
  ..required = true
);
```

**6. Reference**

A reference to a type or identifier.

```dart
refer('String')         // Type reference
refer('Colors.blue')    // Static reference
refer('myVariable')     // Variable reference
```

---

## Complete Example: Generating AppButton

### Input

```dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
}
```

### Code Generation

```dart
Library generateAppButton() {
  return Library((lib) => lib
    ..comments.add('// Generated code - do not modify by hand')
    ..directives.addAll([
      Directive.import('package:flutter/material.dart'),
      Directive.import('package:syntaxify/design_system.dart'),
    ])
    ..body.add(
      Class((cls) => cls
        ..name = 'AppButton'
        ..extend = refer('StatelessWidget')
        ..docs.add('/// A button component')
        ..constructors.add(
          Constructor((ctor) => ctor
            ..constant = true
            ..optionalParameters.addAll([
              Parameter((p) => p..name = 'key'..named = true..toSuper = true),
              Parameter((p) => p..name = 'label'..type = refer('String')..named = true..required = true..toThis = true),
              Parameter((p) => p..name = 'variant'..type = refer('ButtonVariant')..named = true..toThis = true),
              Parameter((p) => p..name = 'onPressed'..type = refer('VoidCallback?')..named = true..toThis = true),
            ])
          )
        )
        ..fields.addAll([
          Field((f) => f..name = 'label'..type = refer('String')..modifier = FieldModifier.final$),
          Field((f) => f..name = 'variant'..type = refer('ButtonVariant')..modifier = FieldModifier.final$),
          Field((f) => f..name = 'onPressed'..type = refer('VoidCallback?')..modifier = FieldModifier.final$),
        ])
        ..methods.add(
          Method((m) => m
            ..name = 'build'
            ..returns = refer('Widget')
            ..annotations.add(refer('override'))
            ..requiredParameters.add(Parameter((p) => p..name = 'context'..type = refer('BuildContext')))
            ..body = Code('''
              return AppTheme.of(context).style.renderButton(
                label: label,
                variant: variant,
                onPressed: onPressed,
              );
            ''')
          )
        )
      )
    )
  );
}
```

### Output

```dart
// Generated code - do not modify by hand

import 'package:flutter/material.dart';
import 'package:syntaxify/design_system.dart';

/// A button component
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.variant,
    this.onPressed,
  });

  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderButton(
      label: label,
      variant: variant,
      onPressed: onPressed,
    );
  }
}
```

---

## Key Takeaways

**Code Generation:**
- Writes code that writes code
- Reduces boilerplate
- Ensures consistency
- Type-safe with `code_builder`

**The Pipeline:**
1. Discovery - Find meta files
2. Parsing - Extract definitions
3. Validation - Check correctness
4. Generation - Build code structures
5. Emission - Convert to strings
6. Writing - Save to disk

**Tools:**
- `analyzer` - Parse Dart files
- `code_builder` - Build code structures
- `dart_style` - Format code

**Components vs Screens:**
- Components: Always regenerated
- Screens: Generated once, then editable

---

**Ready for a deeper dive?**

➡️ **Next:** [06-parser-deep-dive.md](06-parser-deep-dive.md) - How parsing works in detail

**Or jump to:**
- [07-generator-deep-dive.md](07-generator-deep-dive.md) - Generator internals
- [09-adding-new-component.md](09-adding-new-component.md) - Practical guide
