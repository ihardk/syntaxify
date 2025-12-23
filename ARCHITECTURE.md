# Syntaxify Architecture: The UI Compiler

Syntaxify is not just a code generator. It is a **UI Compiler** for Flutter development, acting as an intelligent transformation engine for your design system.

## 🏗️ The UI Compiler Concept

Traditional development often maps 1:1 (One Code → One Outcome). Syntaxify maps **1:N** (One Definition → Many Outcomes).

| Layer        | Technology    | Role                                                                                        |
| :----------- | :------------ | :------------------------------------------------------------------------------------------ |
| **Compiler** | **Syntaxify** | **The Transformation Engine.** Compiles *intent* (What) into highly optimized Flutter code. |
| **Runtime**  | Flutter       | **The Rendering Engine.** Renders pixels (How) using Widgets and RenderObjects.             |
| **Source**   | Dart          | **The Input Language.** The raw syntax used for definitions.                                |

---

## 🧩 Core Architecture

### 1. The Compiler Pipeline

Syntaxify functions like a compiler for your UI:

```mermaid
flowchart LR
    A[Meta Files\n(.meta.dart)] --> B(AST Parser)
    B --> C{Layout Compiler}
    C --> D[Flutter Widgets]
    C --> E[Design System\nDelegates]
    D --> F[Final App Code]
    E --> F
```

1.  **Source Parsing**: Reads `.screen.dart` files to understand *intent* (e.g., "I need a primary button").
2.  **AST Transformation**: Converts raw definitions into a structured Abstract Syntax Tree (`App`).
3.  **Code Emission**: The `LayoutEmitter` walks the AST and emits valid Dart code using `package:code_builder`.

### 2. The Renderer Pattern (Separation of Concerns)

This is the architectural heart of Syntaxify. It separates the **Component Definition** from its **Visual Implementation**.

#### The Contract (`DesignStyle`)
An abstract interface that every design style must implement. It forces strict adherence to the design system.

```dart
sealed class DesignStyle {
  Widget renderButton({...});
  Widget renderInput({...});
  Widget renderCheckbox({...});
  // ...
}
```

#### The Implementation (Runtime Injection)
Styles are injected at the root of the app, allowing global, instant re-theming.

```dart
// The generated component just delegates:
class AppButton extends StatelessWidget {
  build(context) {
    // "Hey current style, please render a button for me"
    return AppTheme.of(context).style.renderButton(...);
  }
}
```

---

## 📦 System Components

### 1. The Generator (`package:syntaxify`)
The CLI tool that runs during development.
- **Commands**: `init`, `build`, `watch`, `clean`.
- **Responsibility**: Scaffolding, Parsing, AST processing, File writing.

### 2. The Runtime (`lib/syntaxify/`)
The code that lives in your app.
- **`components/`**: The public API (e.g., `AppButton`).
- **`design_system/`**: The style implementations (Material, Cupertino, Neo).
- **`tokens/`**: Constant values (Colors, Spacing, Typography).

---

## 🚀 Key Innovations

### Compile-Time Safety, Runtime Flexibility
Most generators enforce decisions at compile time. Syntaxify enforces **structure** at compile time but allows **styling** decisions at runtime.

### The "UI Operating System"
Syntaxify dictates:
- **Project Structure**: Where files live (`meta/` vs `lib/`).
- **Data Flow**: How properties map to widgets.
- **Conventions**: Naming, file organization, export structures.

This standardization solves the "Blank Canvas Paralysis" and ensures scaling teams maintain consistency.
