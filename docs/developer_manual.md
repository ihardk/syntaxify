# Syntax Developer Manual 🔧

This guide is for developers contributing to the Syntax core (the Generator package).

## 🚀 Getting Started

### 1. Repository Setup
Syntax is a standard Dart package.

```bash
git clone <repo>
cd generator
dart pub get
```

### 2. Debugging
To debug the generator while running it against the example project:

1.  Open `generator/` in VSCode.
2.  Create a `.vscode/launch.json`:
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "name": "Debug Build (Example)",
          "request": "launch",
          "type": "dart",
          "program": "bin/syntax.dart",
          "args": ["build", "--verbose"],
          "cwd": "${workspaceFolder}/../example"
        }
      ]
    }
    ```
3.  Set breakpoints in `lib/src/generators/`.
4.  Run "Debug Build (Example)".

---

## 🏗️ Architecture

Syntax follows **Clean Architecture** principles to separate concerns.

```mermaid
graph TD
    CLI[Presentation (CLI)] --> UseCase[Use Cases]
    UseCase --> Models[Domain Models]
    UseCase --> Parser[Infrastructure: Parsers]
    UseCase --> Gen[Infrastructure: Generators]
    
    subgraph Infrastructure
        Parser --> Analyzer[package:analyzer]
        Gen --> CodeBuilder[package:code_builder]
    end
```

### Layers
1.  **Presentation (`lib/src/cli/`)**:
    *   `InitCommand`: Scaffolding logic.
    *   `BuildCommand`: Argument parsing, invoking Use Cases.
2.  **Use Case (`lib/src/use_cases/`)**:
    *   `BuildAllUseCase`: Orchestrator. Handles FS I/O, loops through components, manages the pipeline.
    *   `GenerateComponentUseCase`: Single component logic.
3.  **Domain (`lib/src/models/`)**:
    *   `MetaComponent`: A generic representation of a parsed `.meta.dart` file.
    *   `RegistryDefinition`: Parsed icon/token definitions.
4.  **Infrastructure**:
    *   **Parsers (`lib/src/parser/`)**: `MetaParser` (reads Classes), `RegistryParser` (reads Annotations).
    *   **Generators (`lib/src/generators/`)**: `ComponentGenerator` implementations (`ButtonGenerator`, `TextGenerator`, `InputGenerator`).

### The Renderer Pattern

Syntax uses a **renderer pattern** to separate WHAT (component definition) from HOW (visual rendering):

- **WHAT**: Components like `AppButton`, `AppText`, `AppInput` define behavior
- **HOW**: `DesignStyle` implementations (Material, Cupertino, Neo) handle rendering
- **Result**: Same component code works across multiple design systems

**Current Components (v0.1.0):**
- `AppButton` - Buttons with variants (primary, secondary, outlined, text)
- `AppText` - Text with typography variants
- `AppInput` - Text fields with validation

---

## 🛠️ How to Add a New Component

Example: Adding `AppCard`.

### Step 1: Define the Meta Contract
Decide what configuration the user provides.
Create a template in `meta/card.meta.dart`:

```dart
import 'package:syntax/syntax.dart';

@SyntaxComponent(description: 'A container card')
class CardMeta {
  @Required()
  final String title;

  @Optional()
  final String? variant;

  const CardMeta({
    required this.title,
    this.variant,
  });
}
```

### Step 2: Implement the Generator
Create `lib/src/generators/component/card_generator.dart`.
Implement `ComponentGenerator`. Use `code_builder` to define the output Widget class.

```dart
class CardGenerator implements ComponentGenerator {
  @override
  Spec build(MetaComponent component, TokenDefinition? tokens) {
    return Class((c) => c
      ..name = 'AppCard'
      ..extend = refer('StatelessWidget', 'package:flutter/material.dart')
      ..methods.add(_buildMethod(component))
    );
  }
}
```

### Step 3: Register the Generator
In `lib/src/generators/generator_registry.dart`:

```dart
class GeneratorRegistry {
  GeneratorRegistry() {
    _generators['button'] = ButtonGenerator();
    _generators['input'] = InputGenerator();
    _generators['card'] = CardGenerator(); // <-- Add this
  }
}
```

### Step 4: Add Renderer Support (Optional but Recommended)
If your component supports styling (Themes):
1.  Define a `CardRenderer` mixin in `design_system/styles/material/card_renderer.dart`.
2.  Add `renderCard()` to `DesignStyle` abstract class.
3.  Update logic in `CardGenerator` to call `style.renderCard(this)`.

---

## 🧪 Testing

### Running Tests
```bash
dart test
```

### Writing Tests
*   **Unit Tests**: Test Parsers and Generators in isolation.
*   **Integration Tests**: `test/build_test.dart` runs the full build against sample inputs.

---

## 🤖 Agent OS Reference
See `.agent-os/` for decision records.
*   `architecture_alignment_plan.md`: History of refactors.
*   `solid_refactoring_plan.md`: Dependency Injection setup.
