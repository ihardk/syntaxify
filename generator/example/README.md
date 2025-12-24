# Syntaxify Example App ⚡

**Live demonstration of Syntaxify's multi-style design system**

Experience the power of "write once, render anywhere" with live style switching!

## 🎬 Quick Start

```bash
cd example
flutter pub get
flutter run
```

## 🎯 What's Inside

### 4-Tab Interactive Demo

| Tab          | Description                                  |
| ------------ | -------------------------------------------- |
| **Overview** | Live style switcher + component showcase     |
| **Buttons**  | All button variants with interactive counter |
| **Inputs**   | Text fields with different keyboard types    |
| **Screens**  | Generated screen from `.screen.dart`         |

### Live Style Switching

Toggle between **3 design styles** in real-time:

- **Material** - Google's Material Design 3
- **Cupertino** - Apple's iOS design language
- **Neo** - Modern neumorphic design

**Same components, completely different look!**

## 📂 Project Structure

```
example/
├── lib/
│   ├── main.dart              # Demo app with style switcher
│   ├── overview_tab.dart      # Overview tab content
│   ├── screens/
│   │   └── login_screen.dart  # Generated from login.screen.dart
│   └── syntaxify/             # Generated design system
│       ├── generated/         # Auto-generated components
│       └── design_system/     # Customizable styles & tokens
│
├── meta/                      # Component definitions
│   ├── button.meta.dart
│   ├── input.meta.dart
│   ├── text.meta.dart
│   ├── login.screen.dart      # Screen definition
│   └── app_icons.dart
│
└── pubspec.yaml
```

## 🔄 How It Works

### 1. Define Components

```dart
// meta/button.meta.dart
@SyntaxComponent()
class ButtonMeta {
  @Required() final String label;
  @Optional() final VoidCallback? onPressed;
}
```

### 2. Define Screens

```dart
// meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: App.column(children: [
    App.text(text: 'Welcome Back'),
    App.textField(label: 'Email'),
    App.button(label: 'Sign In', onPressed: 'handleLogin'),
  ]),
);
```

### 3. Generate

```bash
dart run syntaxify build
```

### 4. Use with Any Style

```dart
AppTheme(
  style: MaterialStyle(),  // Toggle to CupertinoStyle() or NeoStyle()
  child: MaterialApp(home: YourApp()),
)
```

## 🔧 Regenerating Components

From the example directory:

```bash
dart run syntaxify build
```

Or with custom paths:

```bash
dart run syntaxify build --meta=meta --output=lib/syntaxify
```

## 💡 Key Takeaways

| Feature             | Benefit                               |
| ------------------- | ------------------------------------- |
| **One Definition**  | Components defined once in `meta/`    |
| **Multiple Styles** | Same component, 3 different designs   |
| **Type-Safe**       | Generated code is fully type-safe     |
| **Editable**        | Customize tokens without regenerating |
| **Screen Gen**      | Full screens from simple definitions  |

---

**This example demonstrates Syntaxify v0.1.0**

[← Back to main README](../README.md) • [📚 Documentation](../docs/)
