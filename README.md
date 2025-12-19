# Syntax ⚡

**AST-based Flutter UI Code Generator with Multi-Style Design System**

> Stop writing repetitive UI code. Define components once, render in any design system.

## 👀 See It In Action

**Check out the [example app](example/)** - A working Flutter app demonstrating all features with live style switching!

```bash
cd example && flutter run
```

## 🤔 Why Syntax?

### The Problem: Flutter's Design System Scalability Crisis

Flutter developers face a fundamental dilemma when building production apps:

**The Multi-Platform UI Duplication Problem:**
- **Material Design** for Android
- **Cupertino** for iOS  
- **Custom designs** for brand identity

**Traditional approach means writing everything 3 times:**
```dart
// You write this for EVERY component!
Widget buildButton() {
  if (Platform.isIOS) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(label),
    );
  } else if (useCustom) {
    return CustomButton(
      onPressed: onPressed,
      label: label,
    );
  } else {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

**Real-World Impact:**
- 🏢 **Large Apps:** 100+ screens, 1000+ components
- 👥 **Team Scale:** Multiple developers, changing requirements
- 🔄 **Maintenance Nightmare:** "Change all buttons to rounded corners" = touching 500+ files
- 💸 **Cost:** "Switch from Material to Cupertino" = rewriting the entire app
- 🎨 **Design Changes:** "Our designer wants a custom look" = building everything from scratch

### The Solution: Separation of WHAT and HOW

Syntax delivers on Flutter's original promise: **"write once, run anywhere"** - but for design systems.

**With Syntax:**
```dart
// Write once
AppButton(label: 'Click Me', onPressed: ...)

// Renders appropriately everywhere
AppTheme(style: MaterialStyle())   // Material on Android
AppTheme(style: CupertinoStyle())  // iOS-native on iPhone  
AppTheme(style: NeoStyle())        // Custom brand design
```

**Change your entire app's design system in one line:**
```dart
// Before: Material Design
AppTheme(style: MaterialStyle(), child: MyApp())

// After: iOS-native Cupertino
AppTheme(style: CupertinoStyle(), child: MyApp())
// Zero component code changes needed!
```

### What Makes Syntax Different

Most Flutter solutions offer partial fixes:
- ❌ **Widget libraries** - Still manual integration, not design-system-aware
- ❌ **Themes** - Only styling, not structure
- ❌ **Code generation** - Not multi-platform aware

**Syntax combines all three:**
- ✅ **Code generation** - Eliminate boilerplate
- ✅ **Design system architecture** - WHAT vs HOW separation
- ✅ **Multi-platform rendering** - One component, any design
- ✅ **Type-safe APIs** - Compile-time safety

### Industry Impact

**Faster Development:**
- Build apps 3-5x faster with design system consistency
- Generate components instead of writing boilerplate

**Easier Maintenance:**
- Change design system in one place, not 1000 files
- Refactor UI patterns across entire codebase instantly

**Better Quality:**
- Generated code is consistent, tested, type-safe
- No manual platform checks or theme wiring

**True Cross-Platform:**
- Same code, native feel on each platform
- Support Material, Cupertino, and custom designs simultaneously

## 🎨 The Design System Architecture

### The Renderer Pattern

Syntax uses a unique **renderer pattern** that separates concerns:

**WHAT (Component Definition):**
```dart
AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Hello!'),
)
```

**HOW (Style Rendering):**
- **Material**: Renders as `ElevatedButton` with Material Design tokens
- **Cupertino**: Renders as `CupertinoButton` with iOS styling
- **Neo**: Renders with modern, neumorphic design

**The Magic:** Same component code, different visual output based on `AppTheme`:

```dart
AppTheme(
  style: MaterialStyle(),  // or CupertinoStyle() or NeoStyle()
  child: MaterialApp(home: YourApp()),
)
```

### Why This Matters

1. **Write Once, Render Anywhere** - One component definition works across all design systems
2. **Easy Theme Switching** - Change one line to switch your entire app's design
3. **Consistent Behavior** - Button logic stays the same, only visuals change
4. **Custom Styles** - Create your own design system by implementing `DesignStyle`

## 📦 What's Currently Available

### ✅ Components with Full Renderer Pattern

These components work with Material, Cupertino, and Neo styles:

- **AppButton** - Buttons with variants (primary, secondary, text, outlined)
- **AppText** - Text with typography variants (display, headline, body, label)
- **AppInput** - Text fields with validation and keyboard types

### 🚧 Custom Components (Basic Support)

You can define custom components (e.g., Card, Badge, Avatar), and Syntax will:
- ✅ Generate the component class
- ✅ Create constructor and fields
- ⚠️ Generate basic Container widget (not full renderer pattern yet)

**Coming Soon:** Full renderer pattern for more components (Card, Badge, Avatar, Chip, etc.)

### 🎯 Screen Generation

- ✅ Generate editable screen scaffolds from AST definitions
- ✅ Type-safe callbacks
- ✅ Proper imports and structure

## 🚀 Complete Getting Started Guide

### Step 1: Install Syntax

**Option A: From GitHub (Recommended)**
```yaml
# pubspec.yaml
dev_dependencies:
  syntax:
    git:
      url: https://github.com/ihardk/syntax.git
      ref: v0.1.0
      path: generator
```

**Option B: Global Installation**
```bash
cd generator
dart pub get
dart pub global activate --source path .
```

### Step 2: Initialize Your Project

```bash
cd your_flutter_project
syntax init
```

This creates:
- `meta/` - Where you define component APIs
- `lib/syntax/design_system/` - Customizable design system

### Step 3: Define Components

Edit `meta/button.meta.dart`:
```dart
import 'package:syntax/syntax.dart';

@SyntaxComponent(description: 'A customizable button')
class ButtonMeta {
  @Required()
  final String label;
  
  @Optional()
  final String? variant;
  
  @Optional()
  final VoidCallback? onPressed;
}
```

### Step 4: Build

```bash
syntax build
```

This generates:
- `lib/syntax/generated/components/app_button.dart` - The component
- `lib/syntax/design_system/` - Design system files (Material, Cupertino, Neo)
- `lib/syntax/index.dart` - Barrel export

### Step 5: Use in Your App

```dart
import 'package:flutter/material.dart';
import 'package:your_app/syntax/index.dart';
import 'package:your_app/syntax/design_system/design_system.dart';

void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // Try CupertinoStyle() or NeoStyle()!
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: AppButton(
              label: 'Click Me',
              variant: ButtonVariant.primary,
              onPressed: () => print('Hello from Syntax!'),
            ),
          ),
        ),
      ),
    ),
  );
}
```

### Step 6: Generate Screens (Optional)

Create `meta/login.screen.dart`:
```dart
import 'package:syntax/syntax.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(children: [
    AstNode.text(text: 'Welcome Back'),
    AstNode.textField(label: 'Email', keyboardType: KeyboardType.email),
    AstNode.textField(label: 'Password', obscureText: true),
    AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

Run `syntax build` again - generates `lib/screens/login_screen.dart` (editable!)

## 📂 Project Structure

```
your_project/
├── meta/                          # YOU EDIT: Component & screen definitions
│   ├── button.meta.dart
│   ├── input.meta.dart
│   ├── text.meta.dart
│   ├── login.screen.dart
│   └── app_icons.dart
│
└── lib/
    ├── screens/                   # EDITABLE: Generated screens
    │   └── login_screen.dart      # Generated once, then you own it
    │
    └── syntax/
        ├── design_system/         # CUSTOMIZABLE: Styles & tokens
        │   ├── design_system.dart
        │   ├── app_theme.dart
        │   ├── styles/
        │   │   ├── material_style.dart
        │   │   ├── cupertino_style.dart
        │   │   └── neo_style.dart
        │   └── tokens/
        │       ├── button_tokens.dart
        │       └── input_tokens.dart
        │
        ├── generated/             # DON'T EDIT: Auto-regenerated
        │   └── components/
        │       ├── app_button.dart
        │       ├── app_input.dart
        │       └── app_text.dart
        │
        └── index.dart             # Barrel export
```

## 🎯 Real-World Example

### Before Syntax (Manual Approach)

**Material Button:**
```dart
ElevatedButton(
  onPressed: onPressed,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.all(16),
  ),
  child: Text(label),
)
```

**Cupertino Button:**
```dart
CupertinoButton.filled(
  onPressed: onPressed,
  padding: EdgeInsets.all(16),
  child: Text(label),
)
```

**Custom Button:**
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(...),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(...)],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(label),
      ),
    ),
  ),
)
```

**Problem:** 3 different implementations, hard to maintain, inconsistent behavior.

### After Syntax

**One Definition:**
```dart
AppButton(label: 'Submit', onPressed: handleSubmit)
```

**Three Renderings:**
- Wrap with `MaterialStyle()` → Material Design
- Wrap with `CupertinoStyle()` → iOS Design
- Wrap with `NeoStyle()` → Modern Design

**Result:** Consistent API, different visuals, easy to switch.

## ✨ Features

- **AST-Based Generation** - Type-safe, declarative UI definitions
- **Renderer Pattern** - Separates WHAT (behavior) from HOW (rendering)
- **Multi-Style Support** - Material, Cupertino, Neo (3 components currently, more coming)
- **Smart Defaults** - Auto-detects project structure
- **Screen Generation** - Generate editable screen scaffolds
- **Design Tokens** - Centralized styling with tokens
- **Git-Friendly** - Clean, readable generated code
- **Extensible** - Create custom design styles by implementing `DesignStyle`

## 🗺️ Roadmap

**v0.1.0 (Current)**
- ✅ Core architecture with renderer pattern
- ✅ 3 components (Button, Text, Input)
- ✅ 3 design styles (Material, Cupertino, Neo)
- ✅ Screen generation
- ✅ Smart build defaults

**v0.2.0 (Next)**
- 🔄 More components with full renderer pattern:
  - Card, Badge, Avatar, Chip, Switch, Checkbox, Radio
- 🔄 Golden tests for visual regression
- 🔄 Better error messages

**v1.0.0 (Future)**
- 🔮 Complete component library
- 🔮 Theme editor UI
- 🔮 VS Code extension
- 🔮 Component marketplace

## 🔄 Development Workflow

1. **Define** - Edit `meta/*.meta.dart` to define component APIs
2. **Build** - Run `syntax build` to generate implementations
3. **Use** - Import from `package:your_app/syntax/` and use
4. **Customize** - Edit design system tokens in `lib/syntax/design_system/`
5. **Switch Styles** - Change `AppTheme(style: ...)` to try different designs

**Key Principle:** Components regenerate on every build. Screens generate once (you own them).

## �️ Advanced Usage

### Creating Custom Design Styles

Implement `DesignStyle` interface:
```dart
class MyCustomStyle extends DesignStyle 
    with MaterialButtonRenderer, MaterialInputRenderer {
  // Override tokens and rendering logic
}
```

### Build Options

```bash
# Build everything (auto-detects paths)
syntax build

# Build specific component
syntax build --component=AppButton

# Custom paths
syntax build --meta=specs --output=lib/gen

# Build for specific theme
syntax build --theme=material
```

Run `syntax build --help` for all options.

## �📖 Documentation

- **[User Manual](docs/user_manual.md)** - Complete usage guide
- **[Developer Manual](docs/developer_manual.md)** - Architecture & contributing

## 🤝 Contributing

See [Developer Manual](docs/developer_manual.md) for architecture details and contribution guidelines.

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

**Built with ❤️ for Flutter developers who value consistency, productivity, and beautiful code**
