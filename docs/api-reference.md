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
```

---

## Build Options

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

---

## Project Structure

```
your_project/
├── meta/                          # Component & screen definitions
│   ├── button.meta.dart
│   ├── input.meta.dart
│   ├── text.meta.dart
│   └── login.screen.dart
│
└── lib/
    ├── screens/                   # Generated screens (editable)
    │   └── login_screen.dart
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
        │
        └── index.dart             # Barrel export
```

---

## See Also

- [Getting Started](getting_started.md)
- [Design System](design-system.md)
- [Troubleshooting](troubleshooting.md)
