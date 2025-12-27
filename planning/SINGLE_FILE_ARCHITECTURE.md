# Single-File Architecture (Freezed Pattern)

Complete architecture for Syntaxify using the Freezed pattern: **one file per component + one generated file**.

---

## Core Principle

**Like Freezed:**
- `text.dart` - Single editable file with ALL implementation
- `text.generated.dart` - Single generated file with ALL generated code

**Simple mental model:**
```
Write text.dart → Run syntaxify build → Get text.generated.dart
```

---

## File Structure

```
lib/syntaxify/
├── foundation.dart              # ✏️ Foundation tokens (all 3 design systems)
├── foundation.generated.dart    # 🤖 Generated helpers
│
├── text.dart                    # ✏️ Meta + Tokens + Renderers
├── text.generated.dart          # 🤖 Variant enum + AppText wrapper
│
├── button.dart                  # ✏️ Meta + Tokens + Renderers
├── button.generated.dart        # 🤖 Variant enum + AppButton wrapper
│
├── card.dart
├── card.generated.dart
│
└── design_system.generated.dart # 🤖 Integration (styles, theme, exports)
```

---

## Component File Structure: `text.dart`

```dart
// lib/syntaxify/text.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syntaxify/syntaxify.dart';

part 'text.generated.dart';

// ==================== 1. META (Component Definition) ====================
@SyntaxComponent(
  description: 'A customizable text component',
  variants: ['displayLarge', 'headlineMedium', 'titleMedium',
             'bodyLarge', 'bodyMedium', 'labelMedium', 'labelSmall'],
)
class TextMeta {
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}

// ==================== 2. TOKENS (Design Tokens) ====================
class TextTokens {
  final TextStyle style;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double? height;

  const TextTokens({
    required this.style,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.letterSpacing = 0.0,
    this.height,
  });

  /// Maps variant to foundation tokens
  factory TextTokens.fromFoundation(
    FoundationTokens foundation, {
    required TextVariant variant,
  }) {
    final TextStyle baseStyle;
    switch (variant) {
      case TextVariant.displayLarge:
        baseStyle = foundation.displayLarge;
        break;
      case TextVariant.headlineMedium:
        baseStyle = foundation.headlineMedium;
        break;
      case TextVariant.titleMedium:
        baseStyle = foundation.titleMedium;
        break;
      case TextVariant.bodyMedium:
        baseStyle = foundation.bodyMedium;
        break;
      case TextVariant.bodyLarge:
        baseStyle = foundation.bodyLarge;
        break;
      case TextVariant.labelMedium:
        baseStyle = foundation.labelMedium;
        break;
      case TextVariant.labelSmall:
        baseStyle = foundation.labelSmall;
        break;
    }

    return TextTokens(
      style: baseStyle.copyWith(color: foundation.colorOnSurface),
      color: foundation.colorOnSurface,
      fontSize: baseStyle.fontSize ?? 14,
      fontWeight: baseStyle.fontWeight ?? FontWeight.normal,
      letterSpacing: baseStyle.letterSpacing ?? 0.0,
      height: baseStyle.height,
    );
  }
}

// ==================== 3. RENDERERS (Visual Implementation) ====================

/// Material Design implementation
mixin MaterialTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    return TextTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final effectiveVariant = variant ?? TextVariant.bodyMedium;
    final tokens = textTokens(effectiveVariant);

    return Text(
      text,
      style: tokens.style.copyWith(
        color: tokens.color,
        letterSpacing: tokens.letterSpacing,
        height: tokens.height,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Cupertino (iOS) implementation
mixin CupertinoTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    return TextTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final effectiveVariant = variant ?? TextVariant.bodyMedium;
    final tokens = textTokens(effectiveVariant);

    return CupertinoText(
      text,
      style: tokens.style.copyWith(
        color: tokens.color,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Neo (Custom) implementation
mixin NeoTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    return TextTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final effectiveVariant = variant ?? TextVariant.bodyMedium;
    final tokens = textTokens(effectiveVariant);

    // Neo: Bold borders and shadows
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: tokens.color.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: tokens.style.copyWith(
          color: tokens.color,
          fontWeight: FontWeight.w600,
        ),
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
```

---

## Generated File: `text.generated.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated by Syntaxify v0.3.0

part of 'text.dart';

// ==================== VARIANT ENUM ====================
/// Variants for Text component.
///
/// Generated from @SyntaxComponent(variants: [...])
enum TextVariant {
  displayLarge,
  headlineMedium,
  titleMedium,
  bodyLarge,
  bodyMedium,
  labelMedium,
  labelSmall,
}

// ==================== COMPONENT WRAPPER ====================
/// A design-system-aware Text component.
///
/// Delegates rendering to [DesignStyle.renderText].
class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });

  /// Creates a displayLarge text.
  const AppText.displayLarge({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.displayLarge;

  /// Creates a headlineMedium text.
  const AppText.headlineMedium({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.headlineMedium;

  /// Creates a titleMedium text.
  const AppText.titleMedium({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.titleMedium;

  /// Creates a bodyLarge text.
  const AppText.bodyLarge({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.bodyLarge;

  /// Creates a bodyMedium text.
  const AppText.bodyMedium({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.bodyMedium;

  /// Creates a labelMedium text.
  const AppText.labelMedium({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.labelMedium;

  /// Creates a labelSmall text.
  const AppText.labelSmall({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
  }) : variant = TextVariant.labelSmall;

  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderText(
      text: text,
      variant: variant,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
```

---

## Foundation File: `foundation.dart`

**Single file with all 3 design systems:**

```dart
// lib/syntaxify/foundation.dart

import 'package:flutter/material.dart';

part 'foundation.generated.dart';

// ==================== FOUNDATION TOKENS ====================
class FoundationTokens {
  // Colors
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorSurface;
  final Color colorOnSurface;
  final Color colorError;
  final Color colorOnError;

  // Typography
  final TextStyle displayLarge;
  final TextStyle headlineMedium;
  final TextStyle titleMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  // Spacing
  final double spacingXs;
  final double spacingSm;
  final double spacingMd;
  final double spacingLg;

  // Radius
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  // Elevation
  final double elevationSm;
  final double elevationMd;
  final double elevationLg;

  const FoundationTokens({
    required this.colorPrimary,
    required this.colorOnPrimary,
    required this.colorSurface,
    required this.colorOnSurface,
    required this.colorError,
    required this.colorOnError,
    required this.displayLarge,
    required this.headlineMedium,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.labelMedium,
    required this.labelSmall,
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.elevationSm,
    required this.elevationMd,
    required this.elevationLg,
  });
}

// ==================== MATERIAL FOUNDATION ====================
final materialFoundation = FoundationTokens(
  // Material Design 3 colors
  colorPrimary: Color(0xFF6750A4),
  colorOnPrimary: Color(0xFFFFFFFF),
  colorSurface: Color(0xFFFFFBFE),
  colorOnSurface: Color(0xFF1C1B1F),
  colorError: Color(0xFFB3261E),
  colorOnError: Color(0xFFFFFFFF),

  // Material Design 3 typography
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),

  // Material spacing (8dp grid)
  spacingXs: 4,
  spacingSm: 8,
  spacingMd: 16,
  spacingLg: 24,

  // Material radius
  radiusSm: 4,
  radiusMd: 8,
  radiusLg: 16,

  // Material elevation
  elevationSm: 1,
  elevationMd: 3,
  elevationLg: 6,
);

// ==================== CUPERTINO FOUNDATION ====================
final cupertinoFoundation = FoundationTokens(
  // iOS colors
  colorPrimary: Color(0xFF007AFF),
  colorOnPrimary: Color(0xFFFFFFFF),
  colorSurface: Color(0xFFFFFFFF),
  colorOnSurface: Color(0xFF000000),
  colorError: Color(0xFFFF3B30),
  colorOnError: Color(0xFFFFFFFF),

  // iOS typography (SF Pro)
  displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
  headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),

  // iOS spacing (tighter)
  spacingXs: 4,
  spacingSm: 8,
  spacingMd: 12,
  spacingLg: 20,

  // iOS radius
  radiusSm: 8,
  radiusMd: 10,
  radiusLg: 14,

  // iOS elevation (subtle)
  elevationSm: 0.5,
  elevationMd: 1,
  elevationLg: 2,
);

// ==================== NEO FOUNDATION ====================
final neoFoundation = FoundationTokens(
  // Neo colors (bold, vibrant)
  colorPrimary: Color(0xFF00D9FF),
  colorOnPrimary: Color(0xFF000000),
  colorSurface: Color(0xFF0A0E27),
  colorOnSurface: Color(0xFFFFFFFF),
  colorError: Color(0xFFFF1744),
  colorOnError: Color(0xFFFFFFFF),

  // Neo typography (bold)
  displayLarge: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
  headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),

  // Neo spacing (generous)
  spacingXs: 8,
  spacingSm: 12,
  spacingMd: 20,
  spacingLg: 32,

  // Neo radius (sharp)
  radiusSm: 2,
  radiusMd: 4,
  radiusLg: 8,

  // Neo elevation (dramatic)
  elevationSm: 4,
  elevationMd: 8,
  elevationLg: 16,
);
```

---

## Main Integration: `design_system.generated.dart`

**Auto-generated from all component files:**

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated by Syntaxify v0.3.0

library design_system;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Import all components
import 'foundation.dart';
import 'text.dart';
import 'button.dart';
import 'card.dart';
// ... all components

// Export all component wrappers
export 'text.dart' show AppText, TextVariant, TextTokens;
export 'button.dart' show AppButton, ButtonVariant, ButtonTokens;
export 'card.dart' show AppCard, CardVariant, CardTokens;
// ... all components

// ==================== DESIGN STYLE ====================
sealed class DesignStyle {
  const DesignStyle();

  String get name => runtimeType.toString().replaceAll('Style', '').toLowerCase();

  FoundationTokens get foundation;

  // Abstract methods (implemented by renderer mixins)
  TextTokens textTokens(TextVariant variant);
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  });

  ButtonTokens buttonTokens(ButtonVariant variant);
  Widget renderButton({
    required String label,
    ButtonVariant? variant,
    VoidCallback? onPressed,
    bool? isLoading,
  });

  CardTokens cardTokens(CardVariant variant);
  Widget renderCard({
    required Widget child,
    CardVariant? variant,
    EdgeInsets? padding,
  });

  // ... all component methods
}

// ==================== MATERIAL STYLE ====================
class MaterialStyle extends DesignStyle
    with
        MaterialTextRenderer,
        MaterialButtonRenderer,
        MaterialCardRenderer {
  const MaterialStyle();

  @override
  FoundationTokens get foundation => materialFoundation;
}

// ==================== CUPERTINO STYLE ====================
class CupertinoStyle extends DesignStyle
    with
        CupertinoTextRenderer,
        CupertinoButtonRenderer,
        CupertinoCardRenderer {
  const CupertinoStyle();

  @override
  FoundationTokens get foundation => cupertinoFoundation;
}

// ==================== NEO STYLE ====================
class NeoStyle extends DesignStyle
    with
        NeoTextRenderer,
        NeoButtonRenderer,
        NeoCardRenderer {
  const NeoStyle();

  @override
  FoundationTokens get foundation => neoFoundation;
}

// ==================== APP THEME ====================
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final DesignStyle style;

  static DesignStyle of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.style;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => style != oldWidget.style;
}
```

---

## Screen Generation

### Input: `login.screen.dart`

```dart
// meta/login.screen.dart

import 'package:syntaxify/syntaxify.dart';

@SyntaxScreen(name: 'LoginScreen')
final loginScreen = App.column([
  App.text(
    'Welcome Back',
    variant: TextVariant.displayLarge,
  ),
  App.input(
    label: 'Email',
    hint: 'you@example.com',
  ),
  App.input(
    label: 'Password',
    isPassword: true,
  ),
  App.button(
    'Sign In',
    variant: ButtonVariant.primary,
    onPressed: () {},
  ),
]);
```

### Output: `login_screen.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppText.displayLarge(
            text: 'Welcome Back',
          ),
          AppInput(
            label: 'Email',
            hint: 'you@example.com',
          ),
          AppInput(
            label: 'Password',
            isPassword: true,
          ),
          AppButton.primary(
            label: 'Sign In',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
```

**Works seamlessly** because:
- `AppText`, `AppInput`, `AppButton` are exported from `design_system.generated.dart`
- All components use the same pattern
- Screen code is clean and readable

---

## Adding a New Design System (Fluent)

### Scenario: Add Windows Fluent Design

**3 steps:**

#### Step 1: Add Foundation Tokens

Edit `foundation.dart`:

```dart
// lib/syntaxify/foundation.dart

// ... existing material, cupertino, neo

// ==================== FLUENT FOUNDATION ====================
final fluentFoundation = FoundationTokens(
  // Fluent colors
  colorPrimary: Color(0xFF0078D4),
  colorOnPrimary: Color(0xFFFFFFFF),
  colorSurface: Color(0xFFFFFFFF),
  colorOnSurface: Color(0xFF323130),
  colorError: Color(0xFFA4262C),
  colorOnError: Color(0xFFFFFFFF),

  // Fluent typography (Segoe UI)
  displayLarge: TextStyle(fontSize: 46, fontWeight: FontWeight.w600),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),

  // Fluent spacing
  spacingXs: 4,
  spacingSm: 8,
  spacingMd: 12,
  spacingLg: 20,

  // Fluent radius (subtle)
  radiusSm: 2,
  radiusMd: 4,
  radiusLg: 8,

  // Fluent elevation (acrylic)
  elevationSm: 8,
  elevationMd: 16,
  elevationLg: 32,
);
```

#### Step 2: Add Renderer Mixins to Each Component

Edit `text.dart`:

```dart
// lib/syntaxify/text.dart

// ... existing MaterialTextRenderer, CupertinoTextRenderer, NeoTextRenderer

// ==================== FLUENT RENDERER ====================
mixin FluentTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    return TextTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final effectiveVariant = variant ?? TextVariant.bodyMedium;
    final tokens = textTokens(effectiveVariant);

    // Fluent: Clean, subtle shadows
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        text,
        style: tokens.style.copyWith(
          color: tokens.color,
          fontFamily: 'Segoe UI',
        ),
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
```

Edit `button.dart`:

```dart
// lib/syntaxify/button.dart

// Add FluentButtonRenderer mixin
mixin FluentButtonRenderer on DesignStyle {
  // ... Fluent button implementation
}
```

Edit all other component files...

#### Step 3: Run Build

```bash
$ syntaxify build
```

**Auto-generates in `design_system.generated.dart`:**

```dart
// ==================== FLUENT STYLE ====================
class FluentStyle extends DesignStyle
    with
        FluentTextRenderer,        // ← Auto-detected!
        FluentButtonRenderer,      // ← Auto-detected!
        FluentCardRenderer,        // ← Auto-detected!
  {
  const FluentStyle();

  @override
  FoundationTokens get foundation => fluentFoundation;
}
```

**Usage:**

```dart
AppTheme(
  style: const FluentStyle(),  // ← New design system ready!
  child: MyApp(),
)
```

---

## How Build Detection Works

**The generator scans all component files:**

1. Finds all `*Renderer` mixins:
   ```
   MaterialTextRenderer
   CupertinoTextRenderer
   NeoTextRenderer
   FluentTextRenderer  ← New!
   ```

2. Extracts design system names:
   ```
   Material, Cupertino, Neo, Fluent
   ```

3. Generates a style class for each:
   ```dart
   class MaterialStyle extends DesignStyle with MaterialTextRenderer, MaterialButtonRenderer, ...
   class CupertinoStyle extends DesignStyle with CupertinoTextRenderer, CupertinoButtonRenderer, ...
   class NeoStyle extends DesignStyle with NeoTextRenderer, NeoButtonRenderer, ...
   class FluentStyle extends DesignStyle with FluentTextRenderer, FluentButtonRenderer, ...
   ```

**Convention:** `{DesignSystem}{Component}Renderer` pattern

---

## Adding New Component

### Example: Add Dropdown Component

#### Step 1: Create `dropdown.dart`

```dart
// lib/syntaxify/dropdown.dart

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

part 'dropdown.generated.dart';

// Meta
@SyntaxComponent(
  description: 'A dropdown selector',
  variants: ['standard', 'outlined', 'underlined'],
)
class DropdownMeta<T> {
  final T? value;
  final List<DropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;

  const DropdownMeta({
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
  });
}

// Model
class DropdownItem<T> {
  final T value;
  final String label;

  const DropdownItem({required this.value, required this.label});
}

// Tokens
class DropdownTokens {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const DropdownTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
  });

  factory DropdownTokens.fromFoundation(
    FoundationTokens foundation, {
    required DropdownVariant variant,
  }) {
    switch (variant) {
      case DropdownVariant.standard:
        return DropdownTokens(
          backgroundColor: foundation.colorSurface,
          borderColor: foundation.colorOnSurface.withOpacity(0.12),
          borderWidth: 1,
          borderRadius: foundation.radiusMd,
        );
      case DropdownVariant.outlined:
        return DropdownTokens(
          backgroundColor: Colors.transparent,
          borderColor: foundation.colorPrimary,
          borderWidth: 2,
          borderRadius: foundation.radiusMd,
        );
      case DropdownVariant.underlined:
        return DropdownTokens(
          backgroundColor: Colors.transparent,
          borderColor: foundation.colorOnSurface.withOpacity(0.42),
          borderWidth: 1,
          borderRadius: 0,
        );
    }
  }
}

// Renderers (all 3 design systems)
mixin MaterialDropdownRenderer on DesignStyle {
  @override
  DropdownTokens dropdownTokens(DropdownVariant variant) {
    return DropdownTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderDropdown<T>({
    required T? value,
    required List<DropdownItem<T>> items,
    required ValueChanged<T?>? onChanged,
    String? label,
    DropdownVariant? variant,
  }) {
    final effectiveVariant = variant ?? DropdownVariant.standard;
    final tokens = dropdownTokens(effectiveVariant);

    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: tokens.backgroundColor != Colors.transparent,
        fillColor: tokens.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
          borderSide: BorderSide(
            color: tokens.borderColor,
            width: tokens.borderWidth,
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item.value,
                child: Text(item.label),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}

mixin CupertinoDropdownRenderer on DesignStyle {
  // Cupertino implementation...
}

mixin NeoDropdownRenderer on DesignStyle {
  // Neo implementation...
}

mixin FluentDropdownRenderer on DesignStyle {
  // Fluent implementation...
}
```

#### Step 2: Run Build

```bash
$ syntaxify build
```

#### Step 3: Auto-Generated Files

**`dropdown.generated.dart`:**
```dart
part of 'dropdown.dart';

enum DropdownVariant { standard, outlined, underlined }

class AppDropdown<T> extends StatelessWidget {
  // ... generated wrapper
}
```

**`design_system.generated.dart` (updated):**
```dart
import 'dropdown.dart';
export 'dropdown.dart' show AppDropdown, DropdownVariant, DropdownTokens;

sealed class DesignStyle {
  // ... existing methods

  DropdownTokens dropdownTokens(DropdownVariant variant);  // ← Added
  Widget renderDropdown<T>({...});                          // ← Added
}

class MaterialStyle extends DesignStyle
    with
        MaterialTextRenderer,
        MaterialButtonRenderer,
        MaterialDropdownRenderer,  // ← Added
        // ...

class FluentStyle extends DesignStyle
    with
        FluentTextRenderer,
        FluentButtonRenderer,
        FluentDropdownRenderer,    // ← Added
        // ...
```

**Done! Dropdown works in all 4 design systems.**

---

## Benefits

### ✅ 1. Minimal Files
- Text component: `text.dart` + `text.generated.dart` = **2 files**
- Not: 10+ files scattered across folders

### ✅ 2. Clear Mental Model
- `.dart` = Your code (edit freely)
- `.generated.dart` = Generated code (don't touch)

### ✅ 3. Familiar Pattern
- Like Freezed, json_serializable, built_value
- Developers already understand this

### ✅ 4. Easy to Add Design Systems
1. Add foundation tokens
2. Add renderer mixins to each component
3. Run build
4. New style class auto-generated

### ✅ 5. Easy to Add Components
1. Create `component.dart` (meta + tokens + renderers)
2. Run build
3. Get `component.generated.dart` + integration

### ✅ 6. Screen Generation Works Seamlessly
- Screens import from `design_system.generated.dart`
- All components exported and available

### ✅ 7. Single Source of Truth
- Everything about Text is in `text.dart`
- No hunting through folders

---

## File Count Comparison

### Before (Scattered)
```
Text component:
- meta/text.meta.dart
- design_system/variants/text_variant.dart
- design_system/tokens/text_tokens.dart
- design_system/components/text/material_renderer.dart
- design_system/components/text/cupertino_renderer.dart
- design_system/components/text/neo_renderer.dart
- generated/components/app_text.dart
- design_system/design_system.dart (shared)
- design_system/design_style.dart (shared)
- design_system/styles/material_style.dart (shared)
- design_system/styles/cupertino_style.dart (shared)
- design_system/styles/neo_style.dart (shared)

Total: 12 files for one component
```

### After (Single-File)
```
Text component:
- text.dart (meta + tokens + renderers in ONE file)
- text.generated.dart (variant + wrapper)

Shared:
- foundation.dart (all foundations)
- design_system.generated.dart (integration)

Total: 2 files per component + 2 shared files
```

**For 20 components:**
- Before: ~240 files
- After: **42 files** (20 components × 2 + 2 shared)

---

## Summary

**Single-file architecture like Freezed:**
- One editable file per component (meta + tokens + renderers)
- One generated file per component (variant enum + wrapper)
- One shared foundation file
- One generated integration file

**Adding new design system:**
1. Add foundation tokens
2. Add renderer mixins to each component (convention: `{System}{Component}Renderer`)
3. Run build → Style class auto-generated

**Adding new component:**
1. Create `component.dart` with meta + tokens + renderers
2. Run build → Get `component.generated.dart` + integration updates

**Clean, simple, familiar pattern.**
