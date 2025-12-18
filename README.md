# Syntax ⚡

**AST-based Flutter UI Code Generator**

Syntax allows you to define your application's components and screens using declarative AST definitions, automatically generating production-ready, type-safe Flutter code with multi-style design system support.

## 📚 Documentation

*   **[User Manual](docs/user_manual.md)**: Getting started, initialization, and usage guide.
*   **[Developer Manual](docs/developer_manual.md)**: Architecture details and guide for contributing to Syntax core.

## 📂 Repository Structure

*   `generator/`: The core Syntax generator package.
*   `docs/`: Detailed documentation.
*   `.agent-os/`: Architectural decisions and product specs (Agent Consultations).
*   `planning/`: Project planning documents.

## 🚀 Quick Start

1.  Clone this repository.
2.  Navigate to `generator/`.
3.  Install: `dart pub get`.
4.  Run Example: `cd example && dart run syntax build`.

For more details, see the [User Manual](docs/user_manual.md).

## ✨ Features

- **AST-Based**: Type-safe, declarative UI definitions
- **Multi-Style**: Material, Cupertino, and Neo design systems
- **Code Generation**: Clean, idiomatic Flutter code
- **Design System**: Token-based theming with renderer pattern
- **Developer-Focused**: Git-friendly, CI/CD ready

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  syntax:
    path: ../generator  # or git/pub.dev when published
```

## 🎯 Usage

```dart
// Define a screen
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Welcome'),
      AstNode.button(label: 'Sign In'),
    ],
  ),
);
```

Then run:
```bash
dart run syntax build
```

See the [User Manual](docs/user_manual.md) for complete documentation.
