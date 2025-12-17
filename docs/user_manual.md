# Forge User Manual 🛠️

Welcome to **Forge**, the Meta-Framework for Flutter. Forge allows you to define your application's components and design system in high-level "Meta" files, automatically generating production-ready, scalable code.

## 🚀 Getting Started

### 1. Installation
Add `forge` to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  forge: ^0.0.1 # Or path dependency
```

### 2. Initialization
Initialize your project structure. This creates the `meta/` and `design_system/` directories.

```bash
dart run forge init
```

### 3. The Workflow
The Forge workflow is simple:
1.  **Define**: Edit `.meta.dart` files in `meta/` directory.
2.  **Style**: Customize renderers in `design_system/`.
3.  **Build**: Run the generator.

```bash
dart run forge build
```

The generated code lives in `lib/forge/`. You should treat this folder as read-only (mostly).

---

## 📂 Project Structure

*   `meta/`: Your Source of Truth.
    *   `button.meta.dart`: Defines button variants and properties.
    *   `input.meta.dart`: Defines input fields.
    *   `app_icons.dart`: Defines semantic icons.
*   `design_system/`: Your Implementation Details.
    *   `styles/`: Contains Renderers (Material, Cupertino, Neo).
    *   `tokens/`: Usage-specific tokens.
*   `lib/forge/`: The Generated Code.
    *   `generated/components/`: The Widgets you use in your app (`AppButton`, `AppInput`).
    *   `design_system/`: The Runtime configuration.

---

## 🎨 Design System

Forge uses a "Renderer Pattern". Changing the style doesn't require rewriting widgets.

### Switching Styles
In `lib/main.dart` (or wherever you init `AppTheme`):

```dart
final theme = AppTheme(
  style: NeoStyle(), // Switch to MaterialStyle() or CupertinoStyle()
);
```

### Customizing Renderers
Edit files in `design_system/styles/<style>/`.
For example, to change how a specific button looks in Material, edit `design_system/styles/material/button_renderer.dart`.

```dart
mixin MaterialButtonRenderer on ButtonTokens {
  Widget renderButton(BuildContext context, AppButton button) {
     // Your custom implementation
     return ElevatedButton(...);
  }
}
```

---

## 🧩 Components

### AppButton
Use the generated `AppButton` widget.

```dart
AppButton(
  label: 'Click Me',
  onPressed: () {},
  variant: ButtonVariant.primary,
)
```

### AppIcons
Define icons in `meta/app_icons.dart` using annotations. This is your **Single Source of Truth**.

**1. Define in `meta/app_icons.dart`:**
```dart
@IconRegistry()
class AppIcon {
  @IconMapping('Icons.search')
  static const search = 'search';
}
```

**2. Run Build:**
```bash
dart run forge build
```

**3. Use in Code:**
```dart
AppIcon.search // Type-safe string 'search'
```

The runtime will map this string to `Icons.search` automatically.

---

## ❓ Troubleshooting

**"Type not found" errors?**
Ensure you run `dart run forge build` after creating new meta files.

**"File not found"?**
Ensure `meta/` directory exists in your project root. Run `dart run forge init` to repair structure.
