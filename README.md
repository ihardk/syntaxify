# Syntax ⚡

**AST-based Flutter UI Code Generator**

Syntax generates production-ready Flutter widgets from declarative component definitions and screen layouts. Define your UI structure once, generate type-safe code for Material, Cupertino, and Neo design systems or create your own.

## 📚 Documentation

*   **[User Manual](docs/user_manual.md)**: Complete guide to using Syntax
*   **[Developer Manual](docs/developer_manual.md)**: Architecture and contribution guide

## 🚀 Quick Start

### 1. Install Syntax Globally

```bash
cd generator
dart pub get
dart pub global activate --source path .
```

### 2. Initialize Your Project

```bash
cd your_flutter_project
syntax init
```

This creates:
- `meta/` - Component definitions
- `lib/syntax/design_system/` - Customizable styles

### 3. Build

```bash
syntax build --meta=meta --design-system=lib/syntax/design_system --tokens=lib/syntax/design_system --output=lib/syntax
```

### 4. Use Generated Components

```dart
import 'package:your_app/syntax/index.dart';

AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Hello!'),
)
```

## ✨ Features

- **AST-Based** - Type-safe, declarative UI definitions
- **Multi-Style** - Material, Cupertino, and Neo design systems
- **Editable Screens** - Generated screens can be customized
- **Customizable Design** - Full control over styles and tokens
- **Git-Friendly** - Clean, readable generated code

## 📂 Project Structure

```
your_project/
├── meta/                      # Component definitions
└── lib/
    ├── screens/               # Generated screens (editable)
    └── syntax/
        ├── design_system/     # Styles & tokens (customizable)
        └── generated/         # Components (regenerated on build)
```

## 🎯 Example

**Define in `meta/button.meta.dart`:**
```dart
@SyntaxComponent(description: 'A customizable button')
class ButtonMeta {
  @Required()
  final String label;
  
  @Optional()
  final String? variant;
}
```

**Build:**
```bash
syntax build ...
```

**Use:**
```dart
AppButton(label: 'Submit', variant: 'primary')
```

## 📦 Installation Options

**Global (Recommended):**
```bash
dart pub global activate --source path generator/
```

**Project Dependency:**
```yaml
dev_dependencies:
  syntax:
    path: ../generator
```

## 🔄 Workflow

1. Edit `meta/*.meta.dart` files
2. Run `syntax build`
3. Components regenerated in `lib/syntax/generated/`
4. Screens generated once in `lib/screens/` (you can edit)
5. Design system in `lib/syntax/design_system/` (you can customize)

## 📖 Learn More

- [User Manual](docs/user_manual.md) - Complete usage guide
- [Developer Manual](docs/developer_manual.md) - Architecture details
- [Planning Docs](planning/) - Design decisions and roadmap

## 🤝 Contributing

See [Developer Manual](docs/developer_manual.md) for architecture details and contribution guidelines.

## 📄 License

MIT License - See LICENSE file for details
