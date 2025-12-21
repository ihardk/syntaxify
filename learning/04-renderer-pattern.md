# The Renderer Pattern 🎨

**How Syntaxify separates WHAT from HOW**

This is the secret sauce that makes Syntaxify so powerful. Let's understand the renderer pattern and how it enables style switching.

---

## The Core Problem

**Traditional Approach:**

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LOCKED to Material Design!
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

**Problems:**
- ❌ Hardcoded to `ElevatedButton`
- ❌ Can't switch to `CupertinoButton`
- ❌ Can't customize for your brand
- ❌ Need to rewrite the entire widget

**What if we could...**
- ✅ Define the button ONCE
- ✅ Render it differently based on a "style"
- ✅ Switch styles with ONE line of code

**That's what the renderer pattern solves!**

---

## The Solution: Renderer Pattern

### Concept

**Separate WHAT from HOW:**

```
┌─────────────────────────────────────────────────────────┐
│                    WHAT                                 │
│  "I want a primary button labeled 'Submit'"            │
│                                                         │
│  AppButton(                                             │
│    label: 'Submit',                                     │
│    variant: ButtonVariant.primary,                      │
│  )                                                      │
└────────────────────┬────────────────────────────────────┘
                     │
                     │ Delegates to...
                     ↓
┌─────────────────────────────────────────────────────────┐
│                    HOW                                  │
│  "Here's how to render it in Material Design"          │
│                                                         │
│  MaterialStyle.renderButton(                            │
│    label: 'Submit',                                     │
│    variant: ButtonVariant.primary,                      │
│  ) → ElevatedButton(...)                                │
└─────────────────────────────────────────────────────────┘
```

**Change the HOW, and the WHAT stays the same!**

---

## How It Works

### 1. Component (WHAT)

The component defines **what** you want, not **how** it looks.

```dart
// lib/generated/components/app_button.dart (generated)
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.onPressed,
  });

  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // DELEGATION: Ask the style how to render
    return AppTheme.of(context).style.renderButton(
      label: label,
      variant: variant,
      onPressed: onPressed,
    );
  }
}
```

**Key points:**
- `AppButton` doesn't know about Material or Cupertino
- It just delegates to `style.renderButton()`
- The style decides how to render

### 2. AppTheme (Provides the Style)

`AppTheme` is an `InheritedWidget` that provides the current style to all descendants.

```dart
// generator/design_system/app_theme.dart
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final DesignStyle style;

  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(
      theme != null,
      'No AppTheme found in context. Wrap your app with AppTheme.',
    );
    return theme!;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return style.runtimeType != oldWidget.style.runtimeType;
  }
}
```

**Usage:**
```dart
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // <-- Choose the style here
      child: MyApp(),
    ),
  );
}
```

### 3. DesignStyle (Abstract Contract)

Defines what every style MUST implement.

```dart
// generator/design_system/design_style.dart
sealed class DesignStyle {
  // Token getters (colors, spacing, etc.)
  ButtonTokens buttonTokens(ButtonVariant variant);
  InputTokens get inputTokens;
  TextTokens get textTokens;

  // Render methods (7 components)
  Widget renderButton({...});     // Buttons with variants
  Widget renderInput({...});      // Text fields
  Widget renderText({...});       // Typography
  Widget renderCheckbox({...});   // Checkboxes
  Widget renderSwitch({...});     // Toggles
  Widget renderSlider({...});     // Range sliders
  Widget renderRadio<T>({...});   // Radio buttons
}
```

**This is the contract:**
- Every style MUST provide these tokens
- Every style MUST implement all 7 render methods

### 4. Concrete Styles (HOW)

Each style implements the contract differently.

#### MaterialStyle

```dart
// generator/design_system/material_style.dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer,
         MaterialAppBarRenderer {
  // Mixins provide the implementations
}
```

#### CupertinoStyle

```dart
// generator/design_system/cupertino_style.dart
class CupertinoStyle extends DesignStyle
    with CupertinoButtonRenderer,
         CupertinoTextRenderer,
         CupertinoInputRenderer,
         CupertinoAppBarRenderer {
  // Mixins provide the implementations
}
```

#### NeoStyle

```dart
// generator/design_system/neo_style.dart
class NeoStyle extends DesignStyle
    with NeoButtonRenderer,
         NeoTextRenderer,
         NeoInputRenderer,
         NeoAppBarRenderer {
  // Mixins provide the implementations
}
```

### 5. Renderer Mixins (Implementation Details)

Each mixin implements rendering for one component in one style.

**MaterialButtonRenderer:**
```dart
// generator/design_system/styles/material/button_renderer.dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: Colors.blue,
    secondaryBackgroundColor: Colors.grey,
    textColor: Colors.white,
    borderRadius: 8,
    paddingVertical: 16,
    paddingHorizontal: 24,
  );

  @override
  Widget renderButton({
    required String label,
    ButtonVariant? variant,
    VoidCallback? onPressed,
  }) {
    final tokens = buttonTokens;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          variant == ButtonVariant.primary
              ? tokens.primaryBackgroundColor
              : tokens.secondaryBackgroundColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.borderRadius),
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            vertical: tokens.paddingVertical,
            horizontal: tokens.paddingHorizontal,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: tokens.textColor)),
    );
  }
}
```

**CupertinoButtonRenderer:**
```dart
// generator/design_system/styles/cupertino/button_renderer.dart
mixin CupertinoButtonRenderer on DesignStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: CupertinoColors.activeBlue,
    secondaryBackgroundColor: CupertinoColors.systemGrey,
    textColor: CupertinoColors.white,
    borderRadius: 100,  // Pill shape!
    paddingVertical: 14,
    paddingHorizontal: 20,
  );

  @override
  Widget renderButton({
    required String label,
    ButtonVariant? variant,
    VoidCallback? onPressed,
  }) {
    final tokens = buttonTokens;

    return CupertinoButton.filled(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      padding: EdgeInsets.symmetric(
        vertical: tokens.paddingVertical,
        horizontal: tokens.paddingHorizontal,
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: tokens.textColor)),
    );
  }
}
```

---

## The Full Flow

Let's trace what happens when you use `AppButton(label: 'Submit')`:

```
┌─────────────────────────────────────────────────────────┐
│  Step 1: User code                                      │
│  AppButton(label: 'Submit')                             │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  Step 2: AppButton.build() is called                    │
│                                                         │
│  @override                                              │
│  Widget build(BuildContext context) {                   │
│    return AppTheme.of(context).style.renderButton(...); │
│  }                                                      │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  Step 3: AppTheme.of(context) finds the style           │
│                                                         │
│  Returns: MaterialStyle (or CupertinoStyle, etc.)       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  Step 4: MaterialStyle.renderButton() is called         │
│                                                         │
│  mixin MaterialButtonRenderer on DesignStyle {          │
│    Widget renderButton(...) {                           │
│      return ElevatedButton(...);                        │
│    }                                                    │
│  }                                                      │
└────────────────────┬────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────┐
│  Step 5: ElevatedButton is returned and rendered        │
│                                                         │
│  User sees a Material Design button                     │
└─────────────────────────────────────────────────────────┘
```

**If you change `MaterialStyle()` to `CupertinoStyle()`:**
- Step 3 returns `CupertinoStyle`
- Step 4 calls `CupertinoButtonRenderer.renderButton()`
- Step 5 returns `CupertinoButton.filled`
- User sees an iOS-style button

**Same component, different rendering!** 🎉

---

## Design Tokens

### What Are Tokens?

**Design tokens** are the values that define how things look:
- Colors
- Spacing
- Border radius
- Font sizes
- Padding
- Shadows
- etc.

### Token Classes

```dart
// generator/design_system/tokens/button_tokens.dart
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

### Tokens in Styles

Each style provides its own token values:

**Material tokens:**
```dart
@override
ButtonTokens get buttonTokens => const ButtonTokens(
  primaryBackgroundColor: Colors.blue,
  secondaryBackgroundColor: Colors.grey,
  textColor: Colors.white,
  borderRadius: 8,         // Rounded corners
  paddingVertical: 16,
  paddingHorizontal: 24,
);
```

**Cupertino tokens:**
```dart
@override
ButtonTokens get buttonTokens => const ButtonTokens(
  primaryBackgroundColor: CupertinoColors.activeBlue,
  secondaryBackgroundColor: CupertinoColors.systemGrey,
  textColor: CupertinoColors.white,
  borderRadius: 100,       // Pill shape!
  paddingVertical: 14,
  paddingHorizontal: 20,
);
```

**Neo tokens:**
```dart
@override
ButtonTokens get buttonTokens => const ButtonTokens(
  primaryBackgroundColor: Color(0xFF6C5CE7),  // Purple gradient start
  secondaryBackgroundColor: Color(0xFFA29BFE), // Purple gradient end
  textColor: Colors.white,
  borderRadius: 12,        // More rounded
  paddingVertical: 18,
  paddingHorizontal: 28,
);
```

**Same component, different tokens, different look!**

---

## Switching Styles

### At App Level

Change ONE line, entire app changes:

```dart
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),  // <-- Change this
      child: MyApp(),
    ),
  );
}
```

**Try each style:**
```dart
// Material Design
AppTheme(style: MaterialStyle(), ...)

// iOS Design
AppTheme(style: CupertinoStyle(), ...)

// Custom Design
AppTheme(style: NeoStyle(), ...)
```

### At Screen Level

You can even use different styles in different parts of the app:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),  // Uses MaterialStyle
      routes: {
        '/settings': (context) => AppTheme(
          style: CupertinoStyle(),  // Settings uses iOS style!
          child: SettingsScreen(),
        ),
      },
    );
  }
}
```

### Dynamic Switching

Switch styles at runtime:

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DesignStyle _currentStyle = MaterialStyle();

  void _switchToMaterial() => setState(() => _currentStyle = MaterialStyle());
  void _switchToCupertino() => setState(() => _currentStyle = CupertinoStyle());
  void _switchToNeo() => setState(() => _currentStyle = NeoStyle());

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      style: _currentStyle,  // Current style
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ElevatedButton(
                onPressed: _switchToMaterial,
                child: Text('Material'),
              ),
              ElevatedButton(
                onPressed: _switchToCupertino,
                child: Text('Cupertino'),
              ),
              ElevatedButton(
                onPressed: _switchToNeo,
                child: Text('Neo'),
              ),
              AppButton(label: 'Test Button'),  // This button changes!
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Creating a Custom Style

Want your company's design system? Create a custom style!

### Step 1: Create Your Style Class

```dart
// lib/my_company_style.dart
import 'package:syntaxify/design_system.dart';

class MyCompanyStyle extends DesignStyle
    with MyCompanyButtonRenderer,
         MyCompanyTextRenderer,
         MyCompanyInputRenderer {
  // Your custom style!
}
```

### Step 2: Create Renderer Mixins

```dart
// lib/renderers/my_company_button_renderer.dart
mixin MyCompanyButtonRenderer on DesignStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: Color(0xFFFF6B6B),  // Your brand color
    secondaryBackgroundColor: Color(0xFFFFD93D),
    textColor: Colors.white,
    borderRadius: 16,
    paddingVertical: 20,
    paddingHorizontal: 32,
  );

  @override
  Widget renderButton({
    required String label,
    ButtonVariant? variant,
    VoidCallback? onPressed,
  }) {
    final tokens = buttonTokens;

    // Your custom button design!
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tokens.primaryBackgroundColor,
            tokens.secondaryBackgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        boxShadow: [
          BoxShadow(
            color: tokens.primaryBackgroundColor.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: tokens.paddingVertical,
              horizontal: tokens.paddingHorizontal,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: tokens.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Step 3: Use Your Style

```dart
void main() {
  runApp(
    AppTheme(
      style: MyCompanyStyle(),  // Your custom style!
      child: MyApp(),
    ),
  );
}
```

**Now all components use YOUR design!** 🎨

---

## Benefits of the Renderer Pattern

### 1. Single Source of Truth

Change tokens ONCE, all components update:

```dart
ButtonTokens get buttonTokens => const ButtonTokens(
  borderRadius: 12,  // Change from 8 to 12
  // All buttons in the app now have 12px radius!
);
```

### 2. Easy Theming

Create light/dark themes:

```dart
class MaterialLightStyle extends MaterialStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: Colors.blue,
    textColor: Colors.white,
    // ... light theme tokens
  );
}

class MaterialDarkStyle extends MaterialStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: Colors.blue[700]!,
    textColor: Colors.white,
    // ... dark theme tokens
  );
}
```

### 3. Platform-Specific UX

Give Android users Material, iOS users Cupertino:

```dart
void main() {
  final style = Platform.isIOS
      ? CupertinoStyle()
      : MaterialStyle();

  runApp(
    AppTheme(
      style: style,
      child: MyApp(),
    ),
  );
}
```

### 4. White-Label Apps

Same app, different brands:

```dart
// For Client A
AppTheme(style: ClientAStyle(), child: MyApp())

// For Client B
AppTheme(style: ClientBStyle(), child: MyApp())
```

### 5. Easy A/B Testing

Test different designs:

```dart
final style = experimentGroup == 'A'
    ? MaterialStyle()
    : NeoStyle();
```

---

## Advanced: Variant Rendering

Variants allow different versions of the same component.

### Button Variants

```dart
enum ButtonVariant {
  primary,    // Main action
  secondary,  // Secondary action
  text,       // Text-only button
}
```

**Usage:**
```dart
AppButton(
  label: 'Submit',
  variant: ButtonVariant.primary,  // Blue, filled
)

AppButton(
  label: 'Cancel',
  variant: ButtonVariant.secondary,  // Grey, filled
)

AppButton(
  label: 'Learn More',
  variant: ButtonVariant.text,  // No background
)
```

**Rendering:**
```dart
Widget renderButton({...}) {
  if (variant == ButtonVariant.primary) {
    return ElevatedButton(...);  // Filled
  } else if (variant == ButtonVariant.secondary) {
    return OutlinedButton(...);  // Outlined
  } else {
    return TextButton(...);  // Text only
  }
}
```

---

## Key Files

| File                                    | Purpose                         |
| --------------------------------------- | ------------------------------- |
| `design_system/app_theme.dart`          | InheritedWidget providing style |
| `design_system/design_style.dart`       | Abstract base class for styles  |
| `design_system/material_style.dart`     | Material Design implementation  |
| `design_system/cupertino_style.dart`    | iOS Design implementation       |
| `design_system/neo_style.dart`          | Custom Design implementation    |
| `design_system/tokens/*.dart`           | Token definitions               |
| `design_system/styles/material/*.dart`  | Material renderers              |
| `design_system/styles/cupertino/*.dart` | Cupertino renderers             |
| `design_system/styles/neo/*.dart`       | Neo renderers                   |

---

## Summary

**The Renderer Pattern:**
- Separates WHAT (component) from HOW (rendering)
- Uses delegation: components delegate to styles
- Uses InheritedWidget (AppTheme) to provide style

**Key Parts:**
1. **Component** - Defines WHAT (`AppButton`)
2. **AppTheme** - Provides the style (InheritedWidget)
3. **DesignStyle** - Abstract contract
4. **Concrete Styles** - Implementations (Material, Cupertino, Neo)
5. **Renderer Mixins** - Actual rendering logic
6. **Tokens** - Design values (colors, spacing, etc.)

**Benefits:**
- ✅ Switch entire app design in 1 line
- ✅ Consistent design across all components
- ✅ Easy to create custom styles
- ✅ Platform-specific UX
- ✅ White-label apps
- ✅ A/B testing

**Pattern:**
```
Component → AppTheme → Style → Renderer → Widget
```

---

**Ready to learn how code gets generated?**

➡️ **Next:** [05-code-generation.md](05-code-generation.md) - How meta files become Dart code

**Or jump to:**
- [10-adding-new-style.md](10-adding-new-style.md) - Create your custom style
- [08-design-system-deep-dive.md](08-design-system-deep-dive.md) - More on tokens and styles
