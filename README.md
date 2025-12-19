# Syntaxify ⚡

**AST-based Flutter UI Code Generator with Multi-Style Design System**

> Stop writing repetitive UI code. Define components once, render in any design system.

---

## ⭐ Quick Win: Generate Screens in Seconds

```dart
// Create meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(children: [
    AstNode.text(text: 'Welcome'),
    AstNode.textField(label: 'Email'),
    AstNode.button(label: 'Login', onPressed: 'handleLogin'),
  ]),
);
```

**Run:** `dart run syntaxify build`
**Get:** Complete Flutter screen in `lib/screens/login_screen.dart`

**No boilerplate. No repetition. Just results.** ✨

---

## 👀 See It In Action

**Check out the [example app](example/)** - A working Flutter app demonstrating all features with live style switching!

```bash
cd example && flutter run
```

## 🤔 Why Syntaxify?

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

Syntaxify delivers on Flutter's original promise: **"write once, run anywhere"** - but for design systems.

**With syntaxify:**

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

### What Makes Syntaxify Different

Most Flutter solutions offer partial fixes:

- ❌ **Widget libraries** - Still manual integration, not design-system-aware
- ❌ **Themes** - Only styling, not structure
- ❌ **Code generation** - Not multi-platform aware

**Syntaxify combines all three:**

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

### Real-World Example: Fintech App

Imagine building a fintech app with a team:

**Day 1:** Define components once

```dart
// meta/button.meta.dart
@SyntaxComponent()
class ButtonMeta {
  @Required() final String label;
  @Required() final VoidCallback onPressed;
  @Optional() final ButtonVariant variant;
}
```

**Week 1:** Build 50 screens using those components

```dart
AppButton(label: 'Transfer', onPressed: handleTransfer)
AppInput(label: 'Amount', onChanged: setAmount)
AppCard(child: TransactionList())
```

**Month 2:** Client says "we want iOS-style on iOS, Material on Android"

**With syntaxify:**

```dart
// Change one line
AppTheme(
  style: Platform.isIOS ? CupertinoStyle() : MaterialStyle(),
  child: MyApp(),
)
// Done! ✅ All 50 screens updated
```

**Without syntaxify:**

```dart
// Rewrite all 50 screens ❌
// Touch 1000+ component instances
// 2-3 weeks of work
// High risk of bugs and inconsistencies
```

**Month 6:** Designer wants custom brand styling

**With syntaxify:**

```dart
// Create NeoStyle renderer
class NeoStyle extends DesignStyle { ... }

// Switch to it
AppTheme(style: NeoStyle(), child: MyApp())
// All components now use brand design ✅
```

**The difference:** Weeks of work vs. minutes of configuration.

## 🎨 The Design System Architecture

### The Renderer Pattern

Syntaxify uses a unique **renderer pattern** that separates concerns:

**WHAT (Component Definition):**

```dart
AppButton.primary(
  label: 'Click Me',
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

### 🌟 Screen Generation from .screen.dart Files (Star Feature!)

**The fastest way to build Flutter screens:**

```dart
// meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(children: [
    AstNode.text(text: 'Welcome Back'),
    AstNode.textField(label: 'Email'),
    AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

**Run `syntaxify build` → Get a complete Flutter screen!**

- ✅ Generate entire screens from simple definitions
- ✅ Editable after generation (you own the code)
- ✅ Type-safe callbacks and imports
- ✅ Proper structure and scaffolding
- ✅ No boilerplate, no repetition

### ✅ Components with Full Renderer Pattern

These components work with Material, Cupertino, and Neo styles:

- **AppButton** - Buttons with variants (primary, secondary, outlined)
- **AppText** - Text with typography variants (display, headline, title, body, label)
- **AppInput** - Text fields with validation and keyboard types

### 🚧 Custom Components (Basic Support)

You can define custom components (e.g., Card, Badge, Avatar), and Syntaxify will:

- ✅ Generate the component class
- ✅ Create constructor and fields
- ⚠️ Generate basic Container widget (not full renderer pattern yet)

**Coming Soon:** Full renderer pattern for more components (Card, Badge, Avatar, Chip, etc.)

## 🚀 Complete Getting Started Guide

### Step 1: Install Syntaxify

**Option A: From pub.dev (Recommended)**

```yaml
# pubspec.yaml
dev_dependencies:
  syntaxify: ^0.1.0-alpha.1
```

Then run:

```bash
dart pub get
```

**Option B: From GitHub (Latest)**

```yaml
# pubspec.yaml
dev_dependencies:
  syntaxify:
    git:
      url: https://github.com/ihardk/syntaxify.git
      ref: v0.1.0
      path: generator
```

> ⚠️ **Alpha Release**: This package is in alpha. API may change. See [CHANGELOG](https://pub.dev/packages/syntaxify/changelog) for updates.

**Optional: Global Installation**

If you want `syntaxify` available system-wide (not just in your project):

```bash
dart pub global activate syntaxify
```

Then you can run `syntaxify` commands from anywhere. Otherwise, use `dart run syntaxify` in your project.

### Step 2: Initialize Your Project

```bash
cd your_flutter_project
dart run syntaxify init
```

This creates:

- `meta/` - Where you define component APIs
- `lib/syntaxify/design_system/` - Customizable design system

### Step 3: Define Components

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

### Step 4: Build

```bash
dart run syntaxify build
```

This generates:

- `lib/syntaxify/generated/components/app_button.dart` - The component
- `lib/syntaxify/design_system/` - Design system files (Material, Cupertino, Neo)
- `lib/syntaxify/index.dart` - Barrel export

### Step 5: Use in Your App

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

### Step 6: Generate Screens (Optional)

Create `meta/login.screen.dart`:

```dart
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(children: [
    AstNode.text(text: 'Welcome Back'),
    AstNode.textField(label: 'Email', keyboardType: KeyboardType.emailAddress),
    AstNode.textField(label: 'Password', obscureText: true),
    AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

Run `dart run syntaxify build` again - generates `lib/screens/login_screen.dart` (editable!)

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

## 📖 API Reference

### Component Usage

#### AppButton

**Named Constructors (Recommended):**

```dart
// Primary button (emphasized)
AppButton.primary(
  label: 'Submit',
  onPressed: () => submit(),
)

// Secondary button (less emphasis)
AppButton.secondary(
  label: 'Cancel',
  onPressed: () => cancel(),
)

// Outlined button (transparent background)
AppButton.outlined(
  label: 'Learn More',
  onPressed: () => learnMore(),
)
```

**With Variant Parameter:**

```dart
AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Clicked!'),
  isLoading: false,
  isDisabled: false,
)
```

**Available ButtonVariant Values:**

- `ButtonVariant.primary` - Filled, emphasized button
- `ButtonVariant.secondary` - Less prominent button
- `ButtonVariant.outlined` - Outlined, transparent background

#### AppText

```dart
// Display text (largest)
AppText(
  text: 'Hello World',
  variant: TextVariant.displayLarge,
)

// Headline
AppText(
  text: 'Section Title',
  variant: TextVariant.headlineMedium,
)

// Title
AppText(
  text: 'Card Title',
  variant: TextVariant.titleMedium,
)

// Body text (default)
AppText(
  text: 'This is body text for paragraphs.',
  variant: TextVariant.bodyLarge,
)

AppText(
  text: 'Smaller body text.',
  variant: TextVariant.bodyMedium,
)

// Label (smallest)
AppText(
  text: 'Helper text',
  variant: TextVariant.labelSmall,
)
```

**Available TextVariant Values:**

- `TextVariant.displayLarge` - Largest text (hero headings)
- `TextVariant.headlineMedium` - Section headings
- `TextVariant.titleMedium` - Card titles, list headers
- `TextVariant.bodyLarge` - Body text, paragraphs
- `TextVariant.bodyMedium` - Smaller body text
- `TextVariant.labelSmall` - Captions, helper text

#### AppInput

```dart
AppInput(
  label: 'Email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  hint: 'Enter your email',
  onChanged: (value) => print(value),
)

AppInput(
  label: 'Password',
  controller: passwordController,
  obscureText: true,
  errorText: 'Password is required',
)

AppInput(
  label: 'Phone',
  keyboardType: TextInputType.phone,
  prefixIcon: 'phone',
  enabled: true,
)
```

**Available TextInputType Values:**

- `TextInputType.text` - Default text input
- `TextInputType.emailAddress` - Email keyboard
- `TextInputType.phone` - Phone number keyboard
- `TextInputType.number` - Numeric keyboard
- `TextInputType.url` - URL keyboard
- `TextInputType.multiline` - Multiline text

### Design Styles

#### MaterialStyle

```dart
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)
```

Renders components using Material Design 3 widgets and tokens.

#### CupertinoStyle

```dart
AppTheme(
  style: CupertinoStyle(),
  child: MyApp(),
)
```

Renders components using iOS-style Cupertino widgets.

#### NeoStyle

```dart
AppTheme(
  style: NeoStyle(),
  child: MyApp(),
)
```

Renders components with modern neumorphic design.

### Imports

**Simple (Recommended):**

```dart
import 'package:your_app/syntaxify/index.dart';
```

This single import gives you access to all components and design system.

**Explicit (if needed):**

```dart
import 'package:your_app/syntaxify/index.dart';
import 'package:your_app/syntaxify/design_system/design_system.dart';
```

The second import is redundant (index.dart re-exports it), but shown for clarity.

**Generated Screens:**

```dart
import 'package:your_app/screens/login_screen.dart';
```

## 🔄 Development Workflow

1. **Define** - Edit `meta/*.meta.dart` to define component APIs
2. **Build** - Run `dart run syntaxify build` to generate implementations
3. **Use** - Import from `package:your_app/syntaxify/` and use
4. **Customize** - Edit design system tokens in `lib/syntaxify/design_system/`
5. **Switch Styles** - Change `AppTheme(style: ...)` to try different designs

### Understanding Generated Code

**Important: Two types of generated code with different lifecycles:**

#### Components (Regenerate Every Build)

**Location:** `lib/syntaxify/generated/components/`
**Behavior:** Regenerated on EVERY `syntaxify build`
**Rule:** ⚠️ **DO NOT EDIT** - Your changes will be lost!

```dart
// lib/syntaxify/generated/components/app_button.dart
// This file is REGENERATED on every build
class AppButton extends StatelessWidget {
  // Generated code - DO NOT MODIFY
}
```

#### Screens (Generate Once)

**Location:** `lib/screens/`
**Behavior:** Generated ONCE, then YOU own it
**Rule:** ✅ **FREELY EDIT** - Won't be overwritten

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

## 🎯 Real-World Example

### Before Syntaxify (Manual Approach)

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

### After Syntaxify

**One Definition:**

```dart
AppButton.primary(label: 'Submit', onPressed: handleSubmit)
```

**Three Renderings:**

- Wrap with `MaterialStyle()` → Material Design
- Wrap with `CupertinoStyle()` → iOS Design
- Wrap with `NeoStyle()` → Modern Design

**Result:** Consistent API, different visuals, easy to switch.

## 🛠️ Advanced Usage

### Creating Custom Design Styles

Implement `DesignStyle` interface:

```dart
class MyCustomStyle extends DesignStyle
    with MaterialButtonRenderer, MaterialInputRenderer {
  // Override tokens and rendering logic

  @override
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    // Your custom button rendering
    return CustomStyledButton(
      label: label,
      onPressed: onPressed,
      // Your custom styling
    );
  }
}
```

### Build Options

```bash
# Build everything (auto-detects paths)
dart run syntaxify build

# Build specific component
dart run syntaxify build --component=AppButton

# Custom paths
dart run syntaxify build --meta=specs --output=lib/gen

# Build for specific theme
dart run syntaxify build --theme=material
```

Run `dart run syntaxify build --help` for all options.

## 🐛 Troubleshooting

### Common Errors

#### Error: "Member not found: 'headline'"

**Cause:** Using outdated enum value from old examples.
**Fix:** Use correct TextVariant values:

```dart
// ❌ Wrong
variant: TextVariant.headline

// ✅ Correct
variant: TextVariant.headlineMedium
```

#### Error: "KeyboardType.email not found"

**Cause:** Using wrong enum type.
**Fix:** Use Flutter's TextInputType:

```dart
// ❌ Wrong
keyboardType: KeyboardType.email

// ✅ Correct
keyboardType: TextInputType.emailAddress
```

#### Error: "Could not find package syntaxify"

**Cause:** Dependency not installed or wrong path.
**Fix:** Run `dart pub get` after adding to pubspec.yaml

#### Error: Changes to component not reflected

**Cause:** Edited generated component file directly.
**Fix:**

1. Edit the `meta/*.meta.dart` file instead
2. Run `dart run syntaxify build` to regenerate
3. Remember: Components regenerate, screens don't

### Getting Help

- 📖 **Documentation:** [User Manual](docs/user_manual.md)
- 🔧 **Developer Guide:** [Developer Manual](docs/developer_manual.md)
- 🐛 **Report Issues:** [GitHub Issues](https://github.com/ihardk/syntaxify/issues)

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

## 🤝 Contributing

See [Developer Manual](docs/developer_manual.md) for architecture details and contribution guidelines.

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

**Built with ❤️ for Flutter developers who value consistency, productivity, and beautiful code**
