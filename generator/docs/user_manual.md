# Syntaxify User Manual 🛠️

**AST-based Flutter UI Code Generator**

Syntaxify generates production-ready Flutter widgets from declarative component definitions and screen layouts.

## 🚀 Getting Started

### 1. Installation

**From pub.dev (Recommended):**
```yaml
# pubspec.yaml
dev_dependencies:
  syntaxify: ^0.1.0-alpha.1
```

**From GitHub (Latest):**
```yaml
dev_dependencies:
  syntaxify:
    git:
      url: https://github.com/ihardk/syntaxify.git
      ref: v0.1.0
      path: generator
```

> ⚠️ **Alpha Release**: API may change. See [pub.dev](https://pub.dev/packages/syntaxify) for updates.

### 2. Initialize Your Project

Create the required directory structure:

```bash
syntaxify init
```

This creates:
- `meta/` - Component definitions
- `lib/syntaxify/design_system/` - Customizable design system

### 3. The Workflow

1. **Define** - Edit component specs in `meta/`
2. **Build** - Generate code
3. **Use** - Import and use generated components

```bash
syntaxify build
```

---

## 📂 Project Structure

After running `syntaxify init` and `syntaxify build`:

```
your_project/
├── meta/                          # Component definitions (edit these)
│   ├── button.meta.dart
│   ├── input.meta.dart
│   ├── text.meta.dart
│   └── app_icons.dart
│
└── lib/
    ├── screens/                   # Generated screens (EDITABLE ✏️)
    │   └── login_screen.dart      # You can modify these
    │
    └── syntaxify/
        ├── design_system/         # Design system (CUSTOMIZABLE 🎨)
        │   ├── styles/            # Material, Cupertino, Neo
        │   └── tokens/            # Design tokens
        │
        └── generated/             # Generated components (DON'T EDIT 🔒)
            ├── components/
            │   ├── app_button.dart
            │   ├── app_input.dart
            │   └── app_text.dart
            └── index.dart
```

**Key Principles:**
- **Screens** (`lib/screens/`) - Generated once, then you own them
- **Design System** (`lib/syntaxify/design_system/`) - Customize styles and tokens
- **Components** (`lib/syntaxify/generated/`) - Regenerated on every build

---

## 🎨 Design System

Syntaxify supports three design styles out of the box.

### Switching Styles

Wrap your app with `AppTheme` and pass a `DesignStyle`:

```dart
import 'package:flutter/material.dart';
import 'package:your_app/syntaxify/design_system/design_system.dart';

void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // or CupertinoStyle() or NeoStyle()
      child: MaterialApp(
        home: YourHomePage(),
      ),
    ),
  );
}
```

Access the theme in your widgets:

```dart
final theme = AppTheme.of(context);
final buttonStyle = theme.style.button;  // Access style-specific tokens
```

### Customizing Styles

Edit files in `lib/syntaxify/design_system/styles/<style>/`:

**Example:** Customize Material button
```dart
// lib/syntaxify/design_system/styles/material/button_renderer.dart

mixin MaterialButtonRenderer on ButtonTokens {
  Widget renderButton(BuildContext context, AppButton button) {
    final tokens = buttonTokens(button.variant);
    
    return ElevatedButton(
      onPressed: button.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tokens.bgColor,
        // Your customizations here
      ),
      child: Text(button.label),
    );
  }
}
```

---

## 🧩 Using Components

### AppButton

```dart
import 'package:your_app/syntaxify/index.dart';

AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Clicked!'),
)
```

### AppInput

```dart
AppInput(
  label: 'Email',
  hint: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) => print(value),
)
```

### AppText

```dart
AppText(
  text: 'Hello World',
  variant: 'headlineMedium',
)
```

---

## 🎯 Icons

Define semantic icons in `meta/app_icons.dart`:

```dart
import 'package:syntaxify/syntaxify.dart';

@IconRegistry()
class AppIcon {
  @IconMapping('Icons.search')
  static const search = 'search';
  
  @IconMapping('Icons.person')
  static const user = 'user';
}
```

After running `syntaxify build`, use them:

```dart
AppInput(
  prefixIcon: AppIcon.search,  // Type-safe string
)
```

The runtime maps `'search'` → `Icons.search` automatically.

---

## 📱 Screens

Screens are generated to `lib/screens/` and are **editable**.

**Define a screen in `meta/login.screen.dart`:**
```dart
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  layout: App.column(
    children: [
      App.text(text: 'Welcome Back'),
      App.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      App.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
```

**Run build:**
```bash
syntaxify build ...
```

**Generated `lib/screens/login_screen.dart`:**
```dart
import 'package:flutter/material.dart';
import 'package:your_app/syntaxify/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppText(text: 'Welcome Back'),
          AppInput(label: 'Email', keyboardType: TextInputType.emailAddress),
          AppButton(label: 'Sign In', onPressed: handleLogin),
        ],
      ),
    );
  }
  
  void handleLogin() {
    // TODO: Add your logic here
  }
}
```

**You can now edit this file freely!**

---

## ❓ Troubleshooting

**"Type not found" errors?**
- Run `syntaxify build` after creating new meta files
- Check that imports point to `package:your_app/syntaxify/index.dart`

**"File not found"?**
- Ensure `meta/` exists: run `syntaxify init`
- Check paths in build command

**Screens not generating?**
- Ensure screen files end with `.screen.dart`
- Check that `ScreenDefinition` is properly defined

**Components look wrong?**
- Check which `DesignStyle` is active in `AppTheme`
- Customize renderers in `lib/syntaxify/design_system/styles/`

---

## 🔄 Rebuild Workflow

When you change component definitions:

1. Edit `meta/*.meta.dart` files

### 4. Build Your Components

Generate components and screens:

```bash
syntaxify build
```

**Common Options:**
```bash
# Build everything (auto-detects paths)
syntaxify build

# Watch mode - auto-rebuild on changes
syntaxify build --watch

# Dry run - preview without writing
syntaxify build --dry-run

# Build specific component
syntaxify build --component=AppButton

# Custom paths
syntaxify build --meta=specs --output=lib/gen
```

**All Options:**
- `-w, --watch` - Watch for file changes and rebuild
- `--dry-run` - Preview files without writing
- `-m, --meta` - Meta directory (default: `meta`)
- `-o, --output` - Output directory (default: `lib/syntaxify`)
- `--design-system` - Design system directory (auto-detects `lib/syntaxify/design_system`)
- `--tokens` - Tokens directory (auto-detects `lib/syntaxify/design_system`)
- `-c, --component` - Build specific component only
- `-t, --theme` - Build for specific theme only

**Tip:** Run `syntaxify build --help` for full documentation.
2. Run `syntaxify build ...`
3. Components in `lib/syntaxify/generated/` are regenerated
4. Screens in `lib/screens/` are **not** overwritten
5. Design system in `lib/syntaxify/design_system/` is **not** overwritten

**Safe to edit:**
- ✅ `lib/screens/*` - Your screens
- ✅ `lib/syntaxify/design_system/*` - Your styles

**Don't edit (will be overwritten):**
- ❌ `lib/syntaxify/generated/*` - Regenerated on build
