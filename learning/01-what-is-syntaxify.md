# What is Syntaxify? 🤔

**Learn what Syntaxify is and why it exists in 10 minutes**

---

## The Problem

Imagine you're building a Flutter app that needs to work on:
- 📱 **Android** (Material Design)
- 🍎 **iOS** (Cupertino Design)
- 🎨 **Custom Brand** (Your company's design system)

### Traditional Approach (The Pain) 😰

You'd write the SAME button **three times**:

**For Android (Material):**
```dart
Widget buildButton() {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      )),
    ),
    child: Text('Submit'),
  );
}
```

**For iOS (Cupertino):**
```dart
Widget buildButton() {
  return CupertinoButton.filled(
    onPressed: onPressed,
    borderRadius: BorderRadius.circular(100),
    child: Text('Submit'),
  );
}
```

**For Custom Brand:**
```dart
Widget buildButton() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D)],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(...)],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Submit'),
        ),
      ),
    ),
  );
}
```

**Now imagine:**
- 📊 100+ screens
- 🔘 1000+ buttons
- 📝 Making changes to all of them

**This is a NIGHTMARE!** 💀

---

## The Syntaxify Solution ✨

**Write once, render everywhere:**

```dart
AppButton.primary(
  label: 'Submit',
  onPressed: handleSubmit,
)
```

That's it! This same code works with:
- ✅ Material Design (Android)
- ✅ Cupertino Design (iOS)
- ✅ Custom Design (Your brand)

### How to Toggle Styles

**Material Design (Android):**
```dart
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)
```

**Cupertino Design (iOS):**
```dart
AppTheme(
  style: CupertinoStyle(),
  child: MyApp(),
)
```

**Custom Design:**
```dart
AppTheme(
  style: NeoStyle(),  // Or your own custom style!
  child: MyApp(),
)
```

**Change ONE line, entire app changes design!** 🎉

---

## Core Idea: WHAT vs HOW

Syntaxify separates **WHAT you want** from **HOW it looks**.

```
┌─────────────────────────┐
│  WHAT (Component)       │
│  "I want a button"      │
│  AppButton.primary()    │
└───────────┬─────────────┘
            │
            ↓
┌─────────────────────────┐
│  HOW (Style)            │
│  "Render it Material"   │
│  MaterialStyle()        │
└─────────────────────────┘
```

### Example: Login Screen

**WHAT you define:**
```dart
// meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: App.column(children: [
    App.text(text: 'Welcome Back'),
    App.textField(label: 'Email'),
    App.textField(label: 'Password', obscureText: true),
    App.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

**Syntaxify generates:**
```dart
// lib/screens/login_screen.dart (generated)
class LoginScreen extends StatelessWidget {
  final VoidCallback? handleLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppText(text: 'Welcome Back'),
          AppInput(label: 'Email'),
          AppInput(label: 'Password', obscureText: true),
          AppButton(label: 'Sign In', onPressed: handleLogin),
        ],
      ),
    );
  }
}
```

**Then HOW it renders depends on style:**

| Style     | Email Input                | Button                              |
| --------- | -------------------------- | ----------------------------------- |
| Material  | `TextField` with underline | `ElevatedButton` rounded            |
| Cupertino | `CupertinoTextField`       | `CupertinoButton.filled` pill shape |
| Neo       | Custom gradient border     | Custom gradient button              |

**Same screen, three looks!**

---

## Two Main Features

### Feature 1: Screen Generation 📝

**You write:** Simple declarative definitions

```dart
// meta/profile.screen.dart
final profileScreen = ScreenDefinition(
  id: 'profile',
  appBar: App.appBar(title: 'Profile'),
  layout: App.column(children: [
    App.text(text: 'John Doe', variant: TextVariant.headlineMedium),
    App.button(label: 'Edit Profile', onPressed: 'handleEdit'),
  ]),
);
```

**Syntaxify generates:** Full Flutter screen (once, then you can edit it)

```bash
$ dart run syntaxify build
✓ Generated lib/screens/profile_screen.dart
```

### Feature 2: Design System Components 🎨

**You define:** Component APIs

```dart
// meta/button.meta.dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  @Required()
  final String label;

  @Optional()
  final String? onPressed;
}
```

**Syntaxify generates:** Multi-style components

```bash
$ dart run syntaxify build
✓ Generated lib/generated/components/app_button.dart
✓ Generated design_system/styles/material/button_renderer.dart
✓ Generated design_system/styles/cupertino/button_renderer.dart
✓ Generated design_system/styles/neo/button_renderer.dart
```

---

## Real-World Benefits

### 1. Write Less Code ✍️

**Before Syntaxify:**
```
100 screens × 3 platforms = 300 screen files 😱
```

**With Syntaxify:**
```
100 screen definitions = 100 generated screens ✨
Toggle style in 1 line!
```

### 2. Consistent Design 🎯

All components follow the same design automatically.

**Problem without Syntaxify:**
- Some buttons have 8dp radius
- Other buttons have 12dp radius
- Inconsistent padding everywhere

**With Syntaxify:**
- All buttons use style's tokens
- Change tokens once, all buttons update

### 3. Easy Design Changes 🔄

**Change entire app from Material → Cupertino:**

```diff
AppTheme(
-  style: MaterialStyle(),
+  style: CupertinoStyle(),
  child: MyApp(),
)
```

**That's it!** Every component changes.

### 4. Custom Brand Designs 🎨

Create your company's design system:

```dart
class MyCompanyStyle extends DesignStyle {
  @override
  Widget renderButton(...) {
    return /* Your custom button design */;
  }
}
```

Now use it:
```dart
AppTheme(style: MyCompanyStyle(), child: MyApp())
```

---

## How It Works (High Level)

```
┌──────────────────────┐
│   1. You Write       │
│   Meta Definitions   │
│   (meta/*.dart)      │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   2. Syntaxify       │
│   Parses & Validates │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   3. Code Generator  │
│   Creates Dart Code  │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   4. Generated       │
│   Components         │
│   (lib/generated/)   │
└──────────────────────┘
```

**Then at runtime:**

```
┌──────────────────────┐
│   AppButton.primary  │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   AppTheme.of()      │
│   Gets current style │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   MaterialStyle      │
│   .renderButton()    │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│   ElevatedButton     │
│   (Material Widget)  │
└──────────────────────┘
```

---

## Key Concepts

### 🎯 Concept 1: Renderer Pattern

Components don't render themselves. They delegate to the current style.

```dart
class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DELEGATE to current style
    return AppTheme.of(context).style.renderButton(
      label: label,
      variant: variant,
      onPressed: onPressed,
    );
  }
}
```

### 🎯 Concept 2: AST (Abstract Syntax Tree)

Screen layouts are defined as a tree of nodes.

```dart
App.column(children: [
  App.text(text: 'Title'),      // Node 1
  App.button(label: 'Submit'),  // Node 2
])
```

This becomes:
```
Column
  ├─ Text('Title')
  └─ Button('Submit')
```

### 🎯 Concept 3: Code Generation

Meta files are converted to real Dart code at build time (NOT runtime).

```
button.meta.dart  ──> [Syntaxify] ──> app_button.dart
```

### 🎯 Concept 4: Design Tokens

Styles define values like colors, spacing, radius.

```dart
ButtonTokens(
  bgColor: Colors.blue,
  radius: 8,
  padding: EdgeInsets.all(16),
)
```

---

## Example Walkthrough

Let's build a simple login screen from scratch!

### Step 1: Define the Screen

```dart
// meta/login.screen.dart
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: App.appBar(title: 'Login'),
  layout: App.column(
    children: [
      App.text(
        text: 'Welcome Back!',
        variant: TextVariant.headlineMedium,
      ),
      App.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      App.textField(
        label: 'Password',
        obscureText: true,
      ),
      App.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
```

### Step 2: Generate the Screen

```bash
$ dart run syntaxify build
✓ Generated lib/screens/login_screen.dart
```

### Step 3: Use It

```dart
// lib/main.dart
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // Try CupertinoStyle() too!
      child: MaterialApp(
        home: LoginScreen(
          handleLogin: () {
            print('Logging in...');
          },
        ),
      ),
    ),
  );
}
```

### Step 4: Toggle Styles

```dart
// Change to iOS style
AppTheme(style: CupertinoStyle(), child: ...)

// Change to custom style
AppTheme(style: NeoStyle(), child: ...)
```

**Same screen, different looks!** 🎉

---

## When to Use Syntaxify

### ✅ Good For:

- **Multi-platform apps** (Android + iOS with different designs)
- **White-label apps** (same app, different brands)
- **Design system enforcement** (consistent look across team)
- **Rapid prototyping** (generate screens fast)
- **Large apps** (100+ screens, 1000+ components)

### ❌ Not Ideal For:

- **Simple apps** (5-10 screens, just use regular Flutter)
- **One-off designs** (every screen is completely unique)
- **Highly animated apps** (need fine control over every pixel)
- **Learning Flutter** (learn Flutter basics first)

---

## What You'll Learn Next

Now that you understand WHAT Syntaxify is, let's dive into HOW it works:

**Next:** [02-architecture-overview.md](02-architecture-overview.md) - See the big picture

**Or jump to:**
- [03-ast-system.md](03-ast-system.md) - Understanding screen definitions
- [04-renderer-pattern.md](04-renderer-pattern.md) - How styles work
- [09-adding-new-component.md](09-adding-new-component.md) - Practical guide

---

## Quick Reference

### Common Commands

```bash
# Initialize new project
dart run syntaxify init

# Generate components and screens
dart run syntaxify build

# Clean generated files
dart run syntaxify clean

# Build specific component
dart run syntaxify build --component=AppButton
```

### Key Files

| File                           | Purpose                      |
| ------------------------------ | ---------------------------- |
| `meta/*.meta.dart`             | Component definitions        |
| `meta/*.screen.dart`           | Screen definitions           |
| `lib/generated/components/`    | Generated components         |
| `lib/screens/`                 | Generated screens (editable) |
| `lib/syntaxify/design_system/` | Styles and tokens            |

---

## Summary

**Syntaxify = Write once, render anywhere**

- ✅ Define screens declaratively
- ✅ Generate Flutter code
- ✅ Toggle design styles easily
- ✅ Consistent, maintainable UI

**Core ideas:**
1. **WHAT vs HOW** separation
2. **Renderer pattern** for styles
3. **Code generation** from meta files
4. **AST** for screen structure

**Ready to see how it's all connected?**

➡️ **Next:** [02-architecture-overview.md](02-architecture-overview.md)
