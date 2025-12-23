# Getting Started with Syntaxify

This guide will walk you through installing Syntaxify and creating your first components.

## Installation

### Option A: From pub.dev (Recommended)

Add Syntaxify to your `pubspec.yaml`:

```yaml
dev_dependencies:
  syntaxify: ^0.1.0-alpha.1
```

Then run:

```bash
dart pub get
```

### Option B: From GitHub (Latest)

```yaml
dev_dependencies:
  syntaxify:
    git:
      url: https://github.com/ihardk/syntaxify.git
      ref: v0.1.0
      path: generator
```

> **Alpha Release**: This package is in alpha. API may change. See [CHANGELOG](https://pub.dev/packages/syntaxify/changelog) for updates.

### Optional: Global Installation

If you want `syntaxify` available system-wide (not just in your project):

```bash
dart pub global activate syntaxify
```

Then you can run `syntaxify` commands from anywhere. Otherwise, use `dart run syntaxify` in your project.

## Initialize Your Project

Navigate to your Flutter project and run:

```bash
cd your_flutter_project
dart run syntaxify init
```

This creates:

- `meta/` - Where you define component APIs
- `lib/syntaxify/design_system/` - Customizable design system
- `syntaxify.yaml` - Configuration file for build paths

## Define Your First Component

Edit `meta/button.meta.dart`:

```dart
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A customizable button')
class ButtonMeta {
  /// The button label text
  @Required()
  final String label;

  /// The action to trigger (e.g. 'action:login')
  @Optional()
  final String? onPressed;

  /// Button variant (filled, outlined, etc)
  @Optional()
  final String? variant;

  /// Button size (sm, md, lg)
  @Optional()
  final String? size;

  /// Whether the button shows loading state
  @Optional()
  @Default('false')
  final bool isLoading;

  /// Whether the button is disabled
  @Optional()
  @Default('false')
  final bool isDisabled;
}
```

## Build Components

Run the build command:

```bash
dart run syntaxify build
```

This generates:

- `lib/syntaxify/generated/components/app_button.dart` - The component
- `lib/syntaxify/design_system/` - Design system files (Material, Cupertino, Neo)
- `lib/syntaxify/index.dart` - Barrel export

## Use in Your App

```dart
import 'package:flutter/material.dart';
import 'package:your_app/syntaxify/index.dart';

void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // Try CupertinoStyle() or NeoStyle()!
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: AppButton.primary(
              label: 'Click Me',
              onPressed: () => print('Hello from Syntaxify!'),
            ),
          ),
        ),
      ),
    ),
  );
}
```

## Generate Screens

Create `meta/login.screen.dart`:

```dart
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: App.appBar(title: 'Login'),
  layout: App.column(
    children: [
      App.text(text: 'Welcome Back', variant: TextVariant.headlineLarge),
      App.spacer(size: SpacerSize.lg),
      App.textField(label: 'Email', keyboardType: KeyboardType.email),
      App.textField(label: 'Password', obscureText: true),
      App.spacer(size: SpacerSize.lg),
      App.button(
        label: 'Sign In',
        variant: ButtonVariant.filled,
        onPressed: 'handleLogin',  // Becomes VoidCallback? field
      ),
    ],
  ),
);
```

Run `dart run syntaxify build` - generates `lib/screens/login_screen.dart`.

> **Note**: Screens are only generated once. Your edits are preserved on rebuild!

## Project Structure

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
    └── syntaxify/
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

## Development Workflow

1. **Define** - Edit `meta/*.meta.dart` to define component APIs
2. **Build** - Run `dart run syntaxify build` to generate implementations
3. **Use** - Import from `package:your_app/syntaxify/` and use
4. **Customize** - Edit design system tokens in `lib/syntaxify/design_system/`
5. **Switch Styles** - Change `AppTheme(style: ...)` to try different designs

## Understanding Generated Code

**Important: Two types of generated code with different lifecycles:**

### Components (Regenerate Every Build)

**Location:** `lib/syntaxify/generated/components/`
**Behavior:** Regenerated on EVERY `syntaxify build`
**Rule:** **DO NOT EDIT** - Your changes will be lost!

```dart
// lib/syntaxify/generated/components/app_button.dart
// This file is REGENERATED on every build
class AppButton extends StatelessWidget {
  // Generated code - DO NOT MODIFY
}
```

### Screens (Generate Once)

**Location:** `lib/screens/`
**Behavior:** Generated ONCE, then YOU own it
**Rule:** **FREELY EDIT** - Won't be overwritten

```dart
// lib/screens/login_screen.dart
// Generated once, then it's yours to edit
class LoginScreen extends StatelessWidget {
  // Edit this freely - it won't be regenerated
}
```

**What happens when you rebuild?**

- Components: Completely regenerated from meta files
- Screens: Skipped (only generated if file doesn't exist)

## Next Steps

- [API Reference](api-reference.md) - Learn about all available components
- [Design System Guide](design-system.md) - Understand the renderer pattern
- [Troubleshooting](troubleshooting.md) - Common errors and solutions
- [User Manual](user_manual.md) - Comprehensive user guide
- [Developer Manual](developer_manual.md) - Architecture and contributing
