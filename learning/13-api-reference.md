# API Reference 📚

**Complete reference for Syntaxify APIs**

This document provides a comprehensive reference for all public APIs in Syntaxify.

---

## Table of Contents

1. [Annotations](#annotations)
2. [AST Nodes](#ast-nodes)
3. [Screen Definitions](#screen-definitions)
4. [Design System](#design-system)
5. [Design Tokens](#design-tokens)
6. [Enums](#enums)
7. [CLI Commands](#cli-commands)

---

## Annotations

### @SyntaxComponent

Marks a class as a component definition.

**Signature:**
```dart
class SyntaxComponent {
  const SyntaxComponent({
    this.name,
    this.description,
  });

  final String? name;
  final String? description;
}
```

**Parameters:**
- `name` (String?, optional) - Explicit component name. If not provided, uses class name with "Meta" suffix removed.
- `description` (String?, optional) - Component description for documentation.

**Usage:**
```dart
@SyntaxComponent(name: 'AppButton', description: 'A button component')
class ButtonMeta {
  final String label;
  final VoidCallback? onPressed;
}
```

**Generated component name:**
- With explicit name: `AppButton`
- Without explicit name (class = `ButtonMeta`): `Button`
- Without explicit name (class = `AppButtonMeta`): `AppButton`

---

## AST Nodes

All AST nodes are created using `AstNode` factory constructors.

### AstNode.column

Creates a vertical layout.

**Signature:**
```dart
const factory AstNode.column({
  @Default([]) List<AstNode> children,
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
}) = ColumnNode;
```

**Parameters:**
- `children` (List\<AstNode\>) - Child nodes. Default: `[]`
- `mainAxisAlignment` (MainAxisAlignment?) - Vertical alignment. Default: `MainAxisAlignment.start`
- `crossAxisAlignment` (CrossAxisAlignment?) - Horizontal alignment. Default: `CrossAxisAlignment.center`

**Example:**
```dart
AstNode.column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    AstNode.text(text: 'Title'),
    AstNode.text(text: 'Subtitle'),
  ],
)
```

**Generates:**
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    AppText(text: 'Title'),
    AppText(text: 'Subtitle'),
  ],
)
```

---

### AstNode.row

Creates a horizontal layout.

**Signature:**
```dart
const factory AstNode.row({
  @Default([]) List<AstNode> children,
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
}) = RowNode;
```

**Parameters:**
- `children` (List\<AstNode\>) - Child nodes. Default: `[]`
- `mainAxisAlignment` (MainAxisAlignment?) - Horizontal alignment. Default: `MainAxisAlignment.start`
- `crossAxisAlignment` (CrossAxisAlignment?) - Vertical alignment. Default: `CrossAxisAlignment.center`

**Example:**
```dart
AstNode.row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    AstNode.text(text: 'Left'),
    AstNode.text(text: 'Right'),
  ],
)
```

---

### AstNode.text

Creates a text display.

**Signature:**
```dart
const factory AstNode.text({
  required String text,
  TextVariant? variant,
  TextAlign? align,
  int? maxLines,
  TextOverflow? overflow,
}) = TextNode;
```

**Parameters:**
- `text` (String, required) - Text to display
- `variant` (TextVariant?) - Text style variant. Default: `null` (uses default style)
- `align` (TextAlign?) - Text alignment. Default: `null`
- `maxLines` (int?) - Maximum lines. Default: `null` (unlimited)
- `overflow` (TextOverflow?) - Overflow behavior. Default: `null`

**Example:**
```dart
AstNode.text(
  text: 'Welcome Back!',
  variant: TextVariant.headlineMedium,
  align: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

**Generates:**
```dart
AppText(
  text: 'Welcome Back!',
  variant: TextVariant.headlineMedium,
  align: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

---

### AstNode.button

Creates a button.

**Signature:**
```dart
const factory AstNode.button({
  required String label,
  String? onPressed,
  ButtonVariant? variant,
}) = ButtonNode;
```

**Parameters:**
- `label` (String, required) - Button text
- `onPressed` (String?) - Callback name. Default: `null`
- `variant` (ButtonVariant?) - Button style variant. Default: `ButtonVariant.primary`

**Example:**
```dart
AstNode.button(
  label: 'Sign In',
  onPressed: 'handleLogin',
  variant: ButtonVariant.primary,
)
```

**Generates:**
```dart
AppButton(
  label: 'Sign In',
  onPressed: handleLogin,  // Parameter added to screen class
  variant: ButtonVariant.primary,
)
```

**Note:** The callback name becomes a parameter in the generated screen class.

---

### AstNode.textField

Creates a text input field.

**Signature:**
```dart
const factory AstNode.textField({
  required String label,
  String? placeholder,
  @Default(false) bool obscureText,
  KeyboardType? keyboardType,
  String? onChanged,
}) = TextFieldNode;
```

**Parameters:**
- `label` (String, required) - Field label
- `placeholder` (String?) - Placeholder text. Default: `null`
- `obscureText` (bool) - Hide text (for passwords). Default: `false`
- `keyboardType` (KeyboardType?) - Keyboard type. Default: `KeyboardType.text`
- `onChanged` (String?) - Callback name for text changes. Default: `null`

**Example:**
```dart
AstNode.textField(
  label: 'Email',
  placeholder: 'you@example.com',
  keyboardType: KeyboardType.email,
  onChanged: 'handleEmailChanged',
)
```

---

### AstNode.appBar

Creates an app bar.

**Signature:**
```dart
const factory AstNode.appBar({
  required String title,
  List<AppBarAction>? actions,
}) = AppBarNode;
```

**Parameters:**
- `title` (String, required) - App bar title
- `actions` (List\<AppBarAction\>?) - Action buttons. Default: `null`

**Example:**
```dart
AstNode.appBar(
  title: 'Profile',
  actions: [
    AppBarAction(icon: 'settings', onPressed: 'handleSettings'),
    AppBarAction(icon: 'logout', onPressed: 'handleLogout'),
  ],
)
```

---

### AstNode.image

Creates an image display.

**Signature:**
```dart
const factory AstNode.image({
  required String path,
  double? width,
  double? height,
  BoxFit? fit,
}) = ImageNode;
```

**Parameters:**
- `path` (String, required) - Image asset path
- `width` (double?) - Image width. Default: `null`
- `height` (double?) - Image height. Default: `null`
- `fit` (BoxFit?) - How image fits its box. Default: `null`

**Example:**
```dart
AstNode.image(
  path: 'assets/logo.png',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)
```

---

### AstNode.spacer

Creates spacing.

**Signature:**
```dart
const factory AstNode.spacer({
  double? height,
  double? width,
}) = SpacerNode;
```

**Parameters:**
- `height` (double?) - Vertical spacing. Default: `null`
- `width` (double?) - Horizontal spacing. Default: `null`

**Example:**
```dart
AstNode.spacer(height: 24)  // Vertical spacing
AstNode.spacer(width: 16)   // Horizontal spacing
```

**Generates:**
```dart
SizedBox(height: 24)
SizedBox(width: 16)
```

---

## Screen Definitions

### ScreenDefinition

Defines a screen layout.

**Signature:**
```dart
class ScreenDefinition {
  const ScreenDefinition({
    required this.id,
    required this.layout,
    this.appBar,
  });

  final String id;
  final AstNode layout;
  final AppBarNode? appBar;
}
```

**Parameters:**
- `id` (String, required) - Screen identifier (used for file name)
- `layout` (AstNode, required) - Root layout node
- `appBar` (AppBarNode?) - Optional app bar. Default: `null`

**Example:**
```dart
final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: AstNode.appBar(title: 'Login'),
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Welcome'),
      AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
    ],
  ),
);
```

**Generates:**
- File: `lib/screens/login_screen.dart`
- Class: `LoginScreen`

---

## Design System

### AppTheme

Provides the design style to the widget tree.

**Signature:**
```dart
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final DesignStyle style;

  static AppTheme of(BuildContext context);
}
```

**Usage:**
```dart
// Wrap your app
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),
      child: MyApp(),
    ),
  );
}

// Access in widgets
final style = AppTheme.of(context).style;
```

---

### DesignStyle

Abstract base class for all design styles.

**Signature:**
```dart
abstract class DesignStyle {
  // Token getters
  ButtonTokens get buttonTokens;
  TextTokens get textTokens;
  InputTokens get inputTokens;
  AppBarTokens get appBarTokens;

  // Render methods
  Widget renderButton({
    required String label,
    ButtonVariant? variant,
    VoidCallback? onPressed,
  });

  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  });

  Widget renderInput({
    required String label,
    String? placeholder,
    bool obscureText = false,
    KeyboardType? keyboardType,
    ValueChanged<String>? onChanged,
  });

  PreferredSizeWidget renderAppBar({
    required String title,
    List<AppBarAction>? actions,
  });
}
```

**Implementations:**
- `MaterialStyle` - Material Design
- `CupertinoStyle` - iOS Design
- `NeoStyle` - Custom Design

---

### MaterialStyle

Material Design implementation.

**Signature:**
```dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer,
         MaterialAppBarRenderer {
  const MaterialStyle();
}
```

**Usage:**
```dart
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)
```

---

### CupertinoStyle

iOS Design implementation.

**Signature:**
```dart
class CupertinoStyle extends DesignStyle
    with CupertinoButtonRenderer,
         CupertinoTextRenderer,
         CupertinoInputRenderer,
         CupertinoAppBarRenderer {
  const CupertinoStyle();
}
```

**Usage:**
```dart
AppTheme(
  style: CupertinoStyle(),
  child: MyApp(),
)
```

---

### NeoStyle

Custom Neo design implementation.

**Signature:**
```dart
class NeoStyle extends DesignStyle
    with NeoButtonRenderer,
         NeoTextRenderer,
         NeoInputRenderer,
         NeoAppBarRenderer {
  const NeoStyle();
}
```

**Usage:**
```dart
AppTheme(
  style: NeoStyle(),
  child: MyApp(),
)
```

---

## Design Tokens

### ButtonTokens

Design values for buttons.

**Signature:**
```dart
class ButtonTokens {
  const ButtonTokens({
    required this.primaryBackgroundColor,
    required this.secondaryBackgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  final Color primaryBackgroundColor;
  final Color secondaryBackgroundColor;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
}
```

**Access:**
```dart
final tokens = AppTheme.of(context).style.buttonTokens;
final color = tokens.primaryBackgroundColor;
```

---

### TextTokens

Design values for text.

**Signature:**
```dart
class TextTokens {
  const TextTokens({
    required this.displayLarge,
    required this.headlineMedium,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.labelSmall,
  });

  final TextStyle displayLarge;      // ~57px
  final TextStyle headlineMedium;    // ~28px
  final TextStyle titleMedium;       // ~16px
  final TextStyle bodyLarge;         // ~16px
  final TextStyle bodyMedium;        // ~14px
  final TextStyle labelSmall;        // ~11px
}
```

---

### InputTokens

Design values for text inputs.

**Signature:**
```dart
class InputTokens {
  const InputTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.textColor,
    required this.hintColor,
    required this.borderRadius,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final Color hintColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
}
```

---

### AppBarTokens

Design values for app bars.

**Signature:**
```dart
class AppBarTokens {
  const AppBarTokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.elevation,
    required this.height,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final double height;
}
```

---

## Enums

### ButtonVariant

Button style variants.

**Values:**
```dart
enum ButtonVariant {
  primary,      // Main action button
  secondary,    // Secondary action button
  text,         // Text-only button
}
```

**Usage:**
```dart
AppButton(
  label: 'Submit',
  variant: ButtonVariant.primary,
)
```

---

### TextVariant

Text style variants.

**Values:**
```dart
enum TextVariant {
  displayLarge,      // Huge display text (~57px)
  headlineMedium,    // Large headline (~28px)
  titleMedium,       // Medium title (~16px)
  bodyLarge,         // Large body text (~16px)
  bodyMedium,        // Regular body text (~14px)
  labelSmall,        // Small label (~11px)
}
```

**Usage:**
```dart
AppText(
  text: 'Welcome',
  variant: TextVariant.headlineMedium,
)
```

---

### KeyboardType

Keyboard type for text inputs.

**Values:**
```dart
enum KeyboardType {
  text,     // Standard text keyboard
  email,    // Email keyboard (@, .)
  number,   // Numeric keyboard
  phone,    // Phone number keyboard
  url,      // URL keyboard (/, .)
}
```

**Usage:**
```dart
AppInput(
  label: 'Email',
  keyboardType: KeyboardType.email,
)
```

---

## CLI Commands

### build

Generates components and screens.

**Usage:**
```bash
dart run syntaxify build
```

**What it does:**
1. Finds all `*.meta.dart` files
2. Parses component definitions
3. Generates component classes
4. Generates renderer mixins
5. Finds all `*.screen.dart` files
6. Generates screen classes (once only)

**Options:**
- None currently

---

### init

Scaffolds a new Syntaxify project.

**Usage:**
```bash
dart run syntaxify init
```

**What it does:**
1. Creates `meta/` directory
2. Creates example component
3. Creates example screen
4. Creates directory structure

**Options:**
- None currently

---

### clean

Removes generated files.

**Usage:**
```bash
dart run syntaxify clean
```

**What it does:**
1. Removes `lib/generated/` directory
2. Removes generated renderer files
3. Keeps user-edited screens

**Options:**
- None currently

---

## Generated Components

All generated components follow this pattern:

### AppButton

**Generated from:**
```dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final ButtonVariant? variant;
  final VoidCallback? onPressed;
}
```

**Usage:**
```dart
AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Clicked!'),
)
```

**Properties:**
- `label` (String) - Button text
- `variant` (ButtonVariant?) - Style variant
- `onPressed` (VoidCallback?) - Tap callback

---

### AppText

**Usage:**
```dart
AppText(
  text: 'Hello World',
  variant: TextVariant.headlineMedium,
  align: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

**Properties:**
- `text` (String) - Text to display
- `variant` (TextVariant?) - Style variant
- `align` (TextAlign?) - Text alignment
- `maxLines` (int?) - Max lines
- `overflow` (TextOverflow?) - Overflow behavior

---

### AppInput

**Usage:**
```dart
AppInput(
  label: 'Email',
  placeholder: 'you@example.com',
  keyboardType: KeyboardType.email,
  onChanged: (value) => print('Email: $value'),
)
```

**Properties:**
- `label` (String) - Field label
- `placeholder` (String?) - Placeholder text
- `obscureText` (bool) - Hide input
- `keyboardType` (KeyboardType?) - Keyboard type
- `onChanged` (ValueChanged\<String\>?) - Change callback

---

## Quick Reference

### Common Patterns

**Creating a screen:**
```dart
final myScreen = ScreenDefinition(
  id: 'my_screen',
  layout: AstNode.column(
    children: [/* nodes */],
  ),
);
```

**Using a style:**
```dart
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)
```

**Accessing tokens:**
```dart
final tokens = AppTheme.of(context).style.buttonTokens;
```

**Creating a component:**
```dart
@SyntaxComponent(name: 'AppCard')
class CardMeta {
  final String title;
  final Widget? child;
}
```

---

## Version

This API reference is for **Syntaxify 0.1.0-alpha.8**.

For the latest documentation, see: https://github.com/ihardk/syntaxify

---

**Need more details?**

➡️ **See:**
- [01-what-is-syntaxify.md](01-what-is-syntaxify.md) - Introduction
- [04-renderer-pattern.md](04-renderer-pattern.md) - How rendering works
- [09-adding-new-component.md](09-adding-new-component.md) - Add components
- [10-adding-new-style.md](10-adding-new-style.md) - Add styles
