# Syntax ⚡

**AST-based Flutter UI Code Generator**

> Stop writing repetitive UI code. Define components once, generate for any design system.

## 🤔 Why Syntax?

**The Problem:**
- Writing the same button/input/card code for Material, Cupertino, and custom designs
- Maintaining consistency across hundreds of components
- Refactoring UI patterns across entire codebases
- Keeping design tokens in sync with implementation

**The Solution:**
Syntax generates production-ready Flutter widgets from declarative definitions. Write your UI structure once as data, generate type-safe code for any design system.

## 🚀 Quick Start

```bash
# Install
cd generator && dart pub global activate --source path .

# Initialize
cd your_flutter_project
syntax init

# Build
syntax build

# Use
import 'package:your_app/syntax/index.dart';
AppButton(label: 'Click Me', onPressed: () => print('Hello!'))
```

## ✨ Features

- **AST-Based** - Type-safe, declarative UI definitions
- **Multi-Style** - Material, Cupertino, Neo (or create your own)
- **Smart Defaults** - Auto-detects project structure
- **Editable Screens** - Generated screens you can customize
- **Git-Friendly** - Clean, readable generated code

## 📂 Architecture

```
your_project/
├── meta/                      # Define components here
└── lib/
    ├── screens/               # Editable generated screens
    └── syntax/
        ├── design_system/     # Customize styles
        └── generated/         # Auto-generated components
```

## 🎯 Example

### Component Generation

**Define once:**
```dart
@SyntaxComponent()
class ButtonMeta {
  @Required() final String label;
  @Optional() final String? variant;
}
```

**Get three implementations:**
- Material Design button
- Cupertino button  
- Neo (modern) button

**Use anywhere:**
```dart
AppButton(label: 'Submit', variant: ButtonVariant.primary)
```

### Screen Generation

**Before (Manual):**
```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          ElevatedButton(
            onPressed: handleLogin,
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
```

**After (Syntax):**
```dart
// meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(children: [
    AstNode.text(text: 'Welcome Back'),
    AstNode.textField(label: 'Email', keyboardType: KeyboardType.email),
    AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

**Result:** Generates `lib/screens/login_screen.dart` with proper imports, type-safe callbacks, and design system integration. Edit the generated file as needed!

## 📦 Installation

**From GitHub:**
```yaml
dev_dependencies:
  syntax:
    git:
      url: https://github.com/ihardk/syntax.git
      ref: v0.1.0
      path: generator
```

**Global:**
```bash
dart pub global activate --source path generator/
```

## 🔄 Workflow

1. Edit `meta/*.meta.dart` - Define component APIs
2. Run `syntax build` - Generate implementations
3. Use in your app - Import from `package:your_app/syntax/`

Components regenerate on build. Screens generate once (you own them).

## 📖 Documentation

- **[User Manual](docs/user_manual.md)** - Complete usage guide
- **[Developer Manual](docs/developer_manual.md)** - Architecture & contributing

## 🤝 Contributing

See [Developer Manual](docs/developer_manual.md) for details.

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

**Built with ❤️ for Flutter developers who value consistency and productivity**
