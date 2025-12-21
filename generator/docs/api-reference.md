# API Reference

Complete reference for Syntaxify components and design styles.

## Components

### AppButton

Adaptive button component that renders according to the active design style.

#### Named Constructors (Recommended)

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

#### With Variant Parameter

```dart
AppButton(
  label: 'Click Me',
  variant: ButtonVariant.primary,
  onPressed: () => print('Clicked!'),
  isLoading: false,
  isDisabled: false,
)
```

#### ButtonVariant Values

| Variant                   | Description                      |
| ------------------------- | -------------------------------- |
| `ButtonVariant.primary`   | Filled, emphasized button        |
| `ButtonVariant.secondary` | Less prominent button            |
| `ButtonVariant.outlined`  | Outlined, transparent background |

---

### AppText

Typography component with multiple text style variants.

```dart
// Display text (largest)
AppText(text: 'Hello World', variant: TextVariant.displayLarge)

// Headline
AppText(text: 'Section Title', variant: TextVariant.headlineMedium)

// Title
AppText(text: 'Card Title', variant: TextVariant.titleMedium)

// Body text (default)
AppText(text: 'Paragraph text.', variant: TextVariant.bodyLarge)

// Label (smallest)
AppText(text: 'Helper text', variant: TextVariant.labelSmall)
```

#### TextVariant Values

| Variant          | Use Case                      |
| ---------------- | ----------------------------- |
| `displayLarge`   | Hero headings, splash screens |
| `headlineMedium` | Section headings              |
| `titleMedium`    | Card titles, list headers     |
| `bodyLarge`      | Body text, paragraphs         |
| `bodyMedium`     | Smaller body text             |
| `labelSmall`     | Captions, helper text         |

---

### AppInput

Text input field with keyboard type and validation support.

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

#### TextInputType Values

| Type                         | Description           |
| ---------------------------- | --------------------- |
| `TextInputType.text`         | Default text input    |
| `TextInputType.emailAddress` | Email keyboard        |
| `TextInputType.phone`        | Phone number keyboard |
| `TextInputType.number`       | Numeric keyboard      |
| `TextInputType.url`          | URL keyboard          |
| `TextInputType.multiline`    | Multiline text        |

## AST Nodes (Screen Generation)

Define screens using AST nodes that compile to Flutter code.

### Layout Nodes

```dart
// Vertical layout
AstNode.column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    AstNode.text(text: 'Title'),
    AstNode.button(label: 'Click'),
  ],
)

// Horizontal layout
AstNode.row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    AstNode.text(text: 'Left'),
    AstNode.text(text: 'Right'),
  ],
)
```

### Component Nodes

```dart
// Text with variant
AstNode.text(
  text: 'Welcome!',
  variant: TextVariant.headlineLarge,
)

// Button with action callback
AstNode.button(
  label: 'Submit',
  variant: ButtonVariant.filled,
  onPressed: 'handleSubmit', // Becomes VoidCallback? field
)

// Text input field
AstNode.textField(
  label: 'Email',
  hint: 'Enter email',
  keyboardType: KeyboardType.email,
  obscureText: false,
)

// Spacing
AstNode.spacer(size: SpacerSize.lg)
```

### Screen Definition

```dart
final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: AstNode.appBar(title: 'Login'),
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Welcome Back', variant: TextVariant.headlineLarge),
      AstNode.textField(label: 'Email', keyboardType: KeyboardType.email),
      AstNode.textField(label: 'Password', obscureText: true),
      AstNode.spacer(size: SpacerSize.lg),
      AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
    ],
  ),
);
```

### Available Node Types

| Node                | Purpose           | Key Properties                                 |
| ------------------- | ----------------- | ---------------------------------------------- |
| `AstNode.column`    | Vertical layout   | `children`, `mainAxisAlignment`                |
| `AstNode.row`       | Horizontal layout | `children`, `mainAxisAlignment`                |
| `AstNode.text`      | Text display      | `text`, `variant`                              |
| `AstNode.button`    | Button            | `label`, `variant`, `onPressed`                |
| `AstNode.textField` | Input field       | `label`, `hint`, `keyboardType`, `obscureText` |
| `AstNode.spacer`    | Spacing           | `size`, `flex`                                 |
| `AstNode.appBar`    | App bar           | `title`                                        |
| `AstNode.icon`      | Icon display      | `name`, `size`, `semantic`                     |

---

## Design Styles

### MaterialStyle

Renders components using Material Design 3 widgets and tokens.

```dart
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)
```

### CupertinoStyle

Renders components using iOS-style Cupertino widgets.

```dart
AppTheme(
  style: CupertinoStyle(),
  child: MyApp(),
)
```

### NeoStyle

Renders components with modern neumorphic design.

```dart
AppTheme(
  style: NeoStyle(),
  child: MyApp(),
)
```

---

## Imports

### Simple (Recommended)

```dart
import 'package:your_app/syntaxify/index.dart';
```

This single import gives you access to all components and design system.

### Generated Screens

```dart
import 'package:your_app/screens/login_screen.dart';
import 'package:your_app/screens/register_screen.dart';
import 'package:your_app/screens/home_screen.dart';
```

---

## Build Options

### Configuration File

Syntaxify supports a `syntaxify.yaml` config file in your project root:

```yaml
# syntaxify.yaml
meta: meta                           # Source directory
output: lib/syntaxify                # Output directory
design_system: lib/syntaxify/design_system
tokens: lib/syntaxify/design_system

generate:
  screens: true
  components: true
```

Run `syntaxify init` to create this file automatically.

### CLI Commands

```bash
# Initialize project (creates syntaxify.yaml)
dart run syntaxify init

# Build everything (uses syntaxify.yaml if present)
dart run syntaxify build

# Watch mode - rebuild on file changes
dart run syntaxify build --watch

# Dry run - preview what would be generated
dart run syntaxify build --dry-run

# Build specific component
dart run syntaxify build --component=AppButton

# Custom paths (override config file)
dart run syntaxify build --meta=specs --output=lib/gen

# Build for specific theme
dart run syntaxify build --theme=material
```

### CLI Options

| Flag              | Short | Description                                 |
| ----------------- | ----- | ------------------------------------------- |
| `--watch`         | `-w`  | Watch for changes and rebuild automatically |
| `--dry-run`       |       | Preview files without writing               |
| `--component`     | `-c`  | Build specific component only               |
| `--theme`         | `-t`  | Build for specific theme only               |
| `--meta`          | `-m`  | Meta directory (default: `meta`)            |
| `--output`        | `-o`  | Output directory (default: `lib/syntaxify`) |
| `--design-system` |       | Design system directory                     |
| `--tokens`        |       | Tokens directory                            |

Run `dart run syntaxify build --help` for all options.

---

## Project Structure

```
your_project/
├── meta/                          # Component & screen definitions
│   ├── button.meta.dart           # Component: AppButton
│   ├── input.meta.dart            # Component: AppInput
│   ├── text.meta.dart             # Component: AppText
│   ├── login.screen.dart          # Screen: LoginScreen
│   ├── register.screen.dart       # Screen: RegisterScreen
│   └── home.screen.dart           # Screen: HomeScreen
│
└── lib/
    ├── screens/                   # Generated screens (editable)
    │   ├── login_screen.dart
    │   ├── register_screen.dart
    │   └── home_screen.dart
    │
    └── syntaxify/
        ├── design_system/         # Customizable styles & tokens
        │   ├── styles/
        │   │   ├── material_style.dart
        │   │   ├── cupertino_style.dart
        │   │   └── neo_style.dart
        │   └── tokens/
        │
        ├── generated/             # Auto-regenerated (don't edit)
        │   └── components/
        │       ├── app_button.dart
        │       ├── app_input.dart
        │       └── app_text.dart
        │
        └── index.dart             # Barrel export
```

---

## See Also

- [Getting Started](getting_started.md)
- [Design System](design-system.md)
- [Troubleshooting](troubleshooting.md)

