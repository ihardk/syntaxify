# Foundation Tokens - Developer Guide

**Version:** 0.2.0-beta
**Last Updated:** 2025-12-24

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Using Foundation Tokens](#using-foundation-tokens)
4. [Creating Custom Components](#creating-custom-components)
5. [Customizing Foundation Tokens](#customizing-foundation-tokens)
6. [Advanced Usage](#advanced-usage)
7. [Migration Guide](#migration-guide)
8. [Troubleshooting](#troubleshooting)

---

## Overview

Foundation tokens are the **single source of truth** for all design primitives in your Syntaxify app. Instead of hardcoding colors, typography, and spacing throughout your components, you reference centralized foundation values that cascade through the entire design system.

### What Problem Does This Solve?

**Before Foundation Tokens:**
```dart
// Scattered hardcoded values across 21 files
class MaterialButtonRenderer {
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return const ButtonTokens(
      bgColor: Colors.blue,      // Hardcoded
      textColor: Colors.white,   // Hardcoded
      radius: 8.0,               // Hardcoded
      borderWidth: 0.0,          // Hardcoded
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Hardcoded
    );
  }
}
```

**Problems:**
- 21 renderers × ~20 hardcoded values = 420+ magic numbers
- Changing primary color requires editing 21 files
- Inconsistent spacing/typography across components
- No single place to see design system values

**After Foundation Tokens:**
```dart
// Single source of truth
class MaterialButtonRenderer {
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return ButtonTokens.fromFoundation(foundation, variant: variant);
  }
}

// Foundation tokens define everything
const materialFoundation = FoundationTokens(
  colorPrimary: Color(0xFF6200EE),  // Change once, affects all
  bodyMedium: TextStyle(fontSize: 14, ...),
  spacingMd: 16.0,
  radiusMd: 8.0,
  // ...
);
```

**Benefits:**
- Change `colorPrimary` once → affects all 21 renderers
- Consistent design system across all components
- Self-documenting code (`foundation.colorPrimary` vs `Colors.blue`)
- Easy to create new design systems (just create new foundation)

---

## Architecture

### Foundation Token Layers

```
┌─────────────────────────────────────────┐
│  Foundation Tokens (54 primitives)     │  ← Single Source of Truth
│  - Colors (16)                          │
│  - Typography (15)                      │
│  - Spacing (7)                          │
│  - Radius (6), Elevation (6), etc.     │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│  Style Implementations                  │  ← 3 Design Systems
│  - Material Design 3                    │
│  - iOS HIG (Cupertino)                  │
│  - Neo-brutalism                        │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│  Component Tokens (7 components)        │  ← Derived from Foundation
│  - ButtonTokens.fromFoundation()        │
│  - TextTokens.fromFoundation()          │
│  - CheckboxTokens.fromFoundation()      │
│  - etc.                                 │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│  Renderers (21 files)                   │  ← Use Component Tokens
│  - MaterialButtonRenderer               │
│  - CupertinoTextRenderer                │
│  - NeoCheckboxRenderer                  │
│  - etc. (7 components × 3 styles)       │
└─────────────────────────────────────────┘
```

### File Structure

```
lib/syntaxify/design_system/
├── tokens/
│   ├── foundation/
│   │   ├── foundation_tokens.dart       # Base class (54 properties)
│   │   ├── material_foundation.dart     # Material Design 3 values
│   │   ├── cupertino_foundation.dart    # iOS HIG values
│   │   └── neo_foundation.dart          # Neo-brutalism values
│   ├── button_tokens.dart               # Derived from foundation
│   ├── text_tokens.dart                 # Derived from foundation
│   ├── checkbox_tokens.dart             # Derived from foundation
│   └── ...
├── components/
│   ├── button/
│   │   ├── material_renderer.dart       # Uses ButtonTokens.fromFoundation()
│   │   ├── cupertino_renderer.dart      # Uses ButtonTokens.fromFoundation()
│   │   └── neo_renderer.dart            # Uses ButtonTokens.fromFoundation()
│   └── ...
└── design_system.dart                   # Imports and exports everything
```

---

## Using Foundation Tokens

### Accessing Foundation in Your Code

Foundation tokens are available through the `AppTheme`:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foundation = AppTheme.of(context).style.foundation;

    return Container(
      padding: EdgeInsets.all(foundation.spacingMd),  // 16dp in Material
      decoration: BoxDecoration(
        color: foundation.colorPrimary,                // #6200EE in Material
        borderRadius: BorderRadius.circular(foundation.radiusMd), // 8dp in Material
      ),
      child: Text(
        'Hello World',
        style: foundation.bodyMedium,                  // 14px Roboto in Material
      ),
    );
  }
}
```

### Foundation Token Reference

#### Colors (16 tokens)

```dart
// Primary colors
foundation.colorPrimary          // Main brand color
foundation.colorOnPrimary        // Text/icons on primary
foundation.colorPrimaryContainer // Lighter primary variant
foundation.colorOnPrimaryContainer

// Secondary colors
foundation.colorSecondary        // Secondary brand color
foundation.colorOnSecondary
foundation.colorSecondaryContainer
foundation.colorOnSecondaryContainer

// Surface colors
foundation.colorSurface          // Background surfaces
foundation.colorOnSurface        // Text/icons on surfaces
foundation.colorSurfaceVariant   // Subtle surface variations
foundation.colorOnSurfaceVariant

// Semantic colors
foundation.colorError            // Error states
foundation.colorOnError
foundation.colorOutline          // Borders, dividers
foundation.colorOutlineVariant   // Subtle borders
```

#### Typography (15 tokens)

```dart
// Display (Large headings)
foundation.displayLarge          // 57px, light
foundation.displayMedium         // 45px, light
foundation.displaySmall          // 36px, light

// Headlines
foundation.headlineLarge         // 32px, regular
foundation.headlineMedium        // 28px, regular
foundation.headlineSmall         // 24px, regular

// Titles
foundation.titleLarge            // 22px, medium
foundation.titleMedium           // 16px, medium
foundation.titleSmall            // 14px, medium

// Body
foundation.bodyLarge             // 16px, regular
foundation.bodyMedium            // 14px, regular
foundation.bodySmall             // 12px, regular

// Labels
foundation.labelLarge            // 14px, medium
foundation.labelMedium           // 12px, medium
foundation.labelSmall            // 11px, medium
```

#### Spacing (7 tokens) - 8dp Grid

```dart
foundation.spacingXs            // 4dp  (0.25×)
foundation.spacingXxxs          // 4dp  (alias)
foundation.spacingSm            // 8dp  (0.5×)
foundation.spacingMd            // 16dp (1×)   [Base unit]
foundation.spacingLg            // 24dp (1.5×)
foundation.spacingXl            // 32dp (2×)
foundation.spacingXxl           // 48dp (3×)
foundation.spacingXxxl          // 64dp (4×)
```

#### Border Radius (6 tokens)

```dart
foundation.radiusNone           // 0dp   (sharp corners)
foundation.radiusSm             // 4dp   (subtle rounding)
foundation.radiusMd             // 8dp   (moderate rounding)
foundation.radiusLg             // 16dp  (rounded)
foundation.radiusXl             // 24dp  (very rounded)
foundation.radiusFull           // 9999dp (pill shape)
```

#### Elevation (6 tokens)

```dart
foundation.elevationLevel0      // 0dp  (flat)
foundation.elevationLevel1      // 1dp  (subtle lift)
foundation.elevationLevel2      // 3dp  (standard lift)
foundation.elevationLevel3      // 6dp  (prominent)
foundation.elevationLevel4      // 8dp  (very prominent)
foundation.elevationLevel5      // 12dp (maximum)
```

#### Border Width (4 tokens)

```dart
foundation.borderWidthNone      // 0dp  (no border)
foundation.borderWidthThin      // 1dp  (hairline)
foundation.borderWidthMedium    // 2dp  (standard)
foundation.borderWidthThick     // 4dp  (bold)
```

---

## Creating Custom Components

When you create a custom component, Syntaxify automatically generates tokens with foundation support.

### Example: Creating a Custom Card Component

**1. Define Component Meta File** (`meta/super_card.meta.dart`):

```dart
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A customizable card with advanced styling')
class SuperCardMeta {
  @Required()
  final String title;

  @Optional()
  final String? subtitle;

  @Optional()
  final Color? backgroundColor;

  @Optional()
  final Color? borderColor;

  @Optional()
  final double? borderWidth;

  @Optional()
  final double? borderRadius;

  @Optional()
  final EdgeInsets? padding;

  const SuperCardMeta({
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });
}
```

**2. Run Build**:

```bash
dart run syntaxify build
```

**3. Generated Token File** (`lib/syntaxify/design_system/tokens/super_card_tokens.dart`):

```dart
/// SuperCardTokens definition
///
/// Pure data class defining styling properties for the SuperCard component.
/// Used by DesignStyle implementations to provide style-specific tokens.
import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the SuperCard component
class SuperCardTokens {
  /// Background color for the card
  final Color backgroundColor;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  /// Border radius
  final double borderRadius;

  /// Padding inside the card
  final EdgeInsets padding;

  const SuperCardTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
  });

  /// Create SuperCardTokens from foundation design tokens
  factory SuperCardTokens.fromFoundation(FoundationTokens foundation) {
    return SuperCardTokens(
      backgroundColor: foundation.colorSurface,           // Smart mapping
      borderColor: foundation.colorOutline,               // Smart mapping
      borderWidth: foundation.borderWidthThin,            // Smart mapping
      borderRadius: foundation.radiusMd,                  // Smart mapping
      padding: EdgeInsets.symmetric(                      // Smart mapping
        horizontal: foundation.spacingMd,
        vertical: foundation.spacingSm,
      ),
    );
  }
}
```

**4. Generated Renderer Stub** (`lib/syntaxify/design_system/components/super_card/material_renderer.dart`):

```dart
part of '../../design_system.dart';

mixin MaterialSuperCardRenderer on DesignStyle {
  @override
  SuperCardTokens get superCardTokens => SuperCardTokens.fromFoundation(foundation);

  @override
  Widget renderSuperCard({
    required String title,
    String? subtitle,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsets? padding,
  }) {
    // STUB: Implement me!
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SuperCard (Material)', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(height: 8),
          Text('title: $title'),
          Text('subtitle: $subtitle'),
          // ... other properties
        ],
      ),
    );
  }
}
```

**5. Implement the Renderer** (replace stub):

```dart
@override
Widget renderSuperCard({
  required String title,
  String? subtitle,
  Color? backgroundColor,
  Color? borderColor,
  double? borderWidth,
  double? borderRadius,
  EdgeInsets? padding,
}) {
  final tokens = superCardTokens;

  return Container(
    padding: padding ?? tokens.padding,
    decoration: BoxDecoration(
      color: backgroundColor ?? tokens.backgroundColor,
      border: Border.all(
        color: borderColor ?? tokens.borderColor,
        width: borderWidth ?? tokens.borderWidth,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? tokens.borderRadius),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: foundation.titleMedium),  // Use foundation directly
        if (subtitle != null) ...[
          SizedBox(height: foundation.spacingXs),
          Text(subtitle, style: foundation.bodySmall),
        ],
      ],
    ),
  );
}
```

### Smart Property Mapping

The TokenGenerator uses intelligent mapping rules to select appropriate foundation tokens:

| Property Name Pattern | Foundation Token |
|----------------------|------------------|
| `activeColor` | `foundation.colorPrimary` |
| `inactiveColor` | `foundation.colorSurfaceVariant` |
| `backgroundColor` | `foundation.colorSurface` |
| `textColor` | `foundation.colorOnSurface` |
| `borderColor` | `foundation.colorOutline` |
| `errorColor` | `foundation.colorError` |
| `borderWidth` | `foundation.borderWidthMedium` |
| `borderRadius`, `radius` | `foundation.radiusMd` |
| `padding` | `EdgeInsets.symmetric(horizontal: spacingMd, vertical: spacingSm)` |
| `margin` | `EdgeInsets.all(spacingSm)` |
| `textStyle` | `foundation.bodyMedium.copyWith(...)` |
| `trackHeight` | `foundation.borderWidthMedium * 2` |
| `thumbRadius` | `foundation.spacingSm + 2` |

---

## Customizing Foundation Tokens

### Creating a Custom Design System

You can create your own design system by defining custom foundation values:

**1. Create Custom Foundation** (`lib/syntaxify/design_system/tokens/foundation/brand_foundation.dart`):

```dart
part of '../../design_system.dart';

/// Brand Design System - Custom foundation tokens
const brandFoundation = FoundationTokens(
  // Brand colors
  colorPrimary: Color(0xFF1E40AF),           // Brand blue
  colorOnPrimary: Color(0xFFFFFFFF),
  colorPrimaryContainer: Color(0xFFDBEAFE),
  colorOnPrimaryContainer: Color(0xFF1E3A8A),

  colorSecondary: Color(0xFFF59E0B),         // Brand amber
  colorOnSecondary: Color(0xFF000000),
  colorSecondaryContainer: Color(0xFFFEF3C7),
  colorOnSecondaryContainer: Color(0xFF78350F),

  // Surface colors
  colorSurface: Color(0xFFFAFAFA),
  colorOnSurface: Color(0xFF1F2937),
  colorSurfaceVariant: Color(0xFFF3F4F6),
  colorOnSurfaceVariant: Color(0xFF6B7280),

  // Semantic colors
  colorError: Color(0xFFDC2626),
  colorOnError: Color(0xFFFFFFFF),
  colorOutline: Color(0xFFD1D5DB),
  colorOutlineVariant: Color(0xFFE5E7EB),

  // Typography - Custom brand font
  displayLarge: TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',  // Custom font
    letterSpacing: -1.5,
  ),
  displayMedium: TextStyle(fontSize: 52, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
  displaySmall: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),

  headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
  headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
  headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),

  titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
  titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),

  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Inter'),

  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Inter'),

  // Spacing - 4dp grid (tighter than Material)
  spacingXxxs: 2.0,
  spacingXs: 4.0,
  spacingSm: 8.0,
  spacingMd: 12.0,   // 12dp instead of 16dp
  spacingLg: 20.0,
  spacingXl: 32.0,
  spacingXxl: 48.0,
  spacingXxxl: 64.0,

  // Border radius - More rounded
  radiusNone: 0.0,
  radiusSm: 6.0,
  radiusMd: 12.0,    // More rounded than Material
  radiusLg: 20.0,
  radiusXl: 32.0,
  radiusFull: 9999.0,

  // Elevation - Standard
  elevationLevel0: 0.0,
  elevationLevel1: 2.0,
  elevationLevel2: 4.0,
  elevationLevel3: 8.0,
  elevationLevel4: 12.0,
  elevationLevel5: 16.0,

  // Border width - Thinner
  borderWidthNone: 0.0,
  borderWidthThin: 0.5,
  borderWidthMedium: 1.5,
  borderWidthThick: 3.0,
);
```

**2. Create Custom Style Class** (`lib/syntaxify/design_system/styles/brand_style.dart`):

```dart
part of '../design_system.dart';

/// Brand Style
class BrandStyle extends DesignStyle
    with
        BrandButtonRenderer,
        BrandTextRenderer,
        BrandCheckboxRenderer,
        BrandToggleRenderer,
        BrandSliderRenderer,
        BrandRadioRenderer,
        BrandInputRenderer {
  const BrandStyle();

  @override
  FoundationTokens get foundation => brandFoundation;
}
```

**3. Implement Brand Renderers** (create `brand_renderer.dart` files for each component)

**4. Update AppTheme**:

```dart
AppTheme(
  style: BrandStyle(),  // Use your custom design system
  child: MyApp(),
)
```

### Dark Mode Support

Create dark mode foundations:

```dart
// lib/syntaxify/design_system/tokens/foundation/material_dark_foundation.dart
part of '../../design_system.dart';

const materialDarkFoundation = FoundationTokens(
  colorPrimary: Color(0xFFBB86FC),           // Purple 200
  colorOnPrimary: Color(0xFF000000),
  colorSurface: Color(0xFF121212),            // Dark surface
  colorOnSurface: Color(0xFFE1E1E1),
  // ... rest of dark theme
);

// Usage
class MaterialDarkStyle extends DesignStyle with ... {
  @override
  FoundationTokens get foundation => materialDarkFoundation;
}

// In app
AppTheme(
  style: Theme.of(context).brightness == Brightness.dark
      ? MaterialDarkStyle()
      : MaterialStyle(),
  child: MyApp(),
)
```

---

## Advanced Usage

### Accessing Foundation in Renderers

Renderers have direct access to foundation:

```dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  Widget renderButton({required String label, ...}) {
    // Access foundation directly
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(foundation.colorPrimary),
        foregroundColor: WidgetStateProperty.all(foundation.colorOnPrimary),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingMd,
          ),
        ),
        elevation: WidgetStateProperty.all(foundation.elevationLevel2),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(foundation.radiusMd),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: foundation.labelLarge),
    );
  }
}
```

### Overriding Specific Tokens

You can override specific tokens while deriving others from foundation:

```dart
factory ButtonTokens.fromFoundation(
  FoundationTokens foundation, {
  required ButtonVariant variant,
}) {
  final baseTokens = ButtonTokens(
    bgColor: foundation.colorPrimary,
    textColor: foundation.colorOnPrimary,
    radius: foundation.radiusMd,
    borderWidth: foundation.borderWidthNone,
    padding: EdgeInsets.symmetric(
      horizontal: foundation.spacingLg,
      vertical: foundation.spacingSm,
    ),
  );

  // Override specific properties for variants
  switch (variant) {
    case ButtonVariant.outlined:
      return baseTokens.copyWith(
        bgColor: Colors.transparent,
        textColor: foundation.colorPrimary,
        borderWidth: foundation.borderWidthMedium,  // Add border
      );
    case ButtonVariant.text:
      return baseTokens.copyWith(
        bgColor: Colors.transparent,
        textColor: foundation.colorPrimary,
        elevation: 0.0,  // No elevation
      );
    default:
      return baseTokens;
  }
}
```

---

## Migration Guide

### Migrating Existing Components to Foundation

If you have existing custom components without foundation support:

**Before:**
```dart
// Custom token file
class MyComponentTokens {
  final Color bgColor;
  final double radius;

  const MyComponentTokens({
    required this.bgColor,
    required this.radius,
  });
}

// Renderer
mixin MaterialMyComponentRenderer on DesignStyle {
  MyComponentTokens get myComponentTokens => const MyComponentTokens(
    bgColor: Colors.blue,   // Hardcoded
    radius: 8.0,            // Hardcoded
  );
}
```

**After:**
```dart
// Updated token file
import 'foundation/foundation_tokens.dart';

class MyComponentTokens {
  final Color bgColor;
  final double radius;

  const MyComponentTokens({
    required this.bgColor,
    required this.radius,
  });

  // Add factory
  factory MyComponentTokens.fromFoundation(FoundationTokens foundation) {
    return MyComponentTokens(
      bgColor: foundation.colorPrimary,  // Use foundation
      radius: foundation.radiusMd,       // Use foundation
    );
  }
}

// Updated renderer
mixin MaterialMyComponentRenderer on DesignStyle {
  MyComponentTokens get myComponentTokens =>
      MyComponentTokens.fromFoundation(foundation);  // Use foundation
}
```

---

## Troubleshooting

### Foundation Tokens Not Available

**Symptom:** `foundation` getter not found on `DesignStyle`

**Cause:** Using old generated files

**Fix:**
```bash
dart run syntaxify clean
dart run syntaxify build
```

### Custom Foundation Not Working

**Symptom:** Changes to foundation don't reflect in app

**Cause:** Foundation file not included in design_system.dart

**Fix:** Add to `lib/syntaxify/design_system/design_system.dart`:
```dart
part 'tokens/foundation/your_custom_foundation.dart';
```

### Token Mapping Issues

**Symptom:** Generated token uses wrong foundation property

**Fix:** Override the factory method manually:
```dart
factory MyTokens.fromFoundation(FoundationTokens foundation) {
  return MyTokens(
    myColor: foundation.colorSecondary,  // Manually specify
    mySize: foundation.spacingXl,        // Manually specify
  );
}
```

---

## Best Practices

1. **Always Use Foundation** - Reference foundation tokens, don't hardcode values
2. **Semantic Naming** - Use semantic colors (`colorPrimary`) not literal (`colorBlue`)
3. **Consistent Spacing** - Stick to the spacing scale (4dp, 8dp, 16dp, etc.)
4. **Document Custom Foundations** - Explain why you deviated from defaults
5. **Test All Styles** - Verify your components work with Material, Cupertino, and Neo
6. **Keep Foundations Minimal** - Don't add component-specific tokens to foundation

---

## Resources

- **Implementation Progress:** `FOUNDATION_TOKEN_PROGRESS.md`
- **Session Summary:** `SESSION_SUMMARY.md`
- **Architecture Docs:** `docs/design-system.md`
- **Troubleshooting:** `docs/troubleshooting.md`

---

**Questions?** Check the [troubleshooting guide](docs/troubleshooting.md) or file an issue on GitHub.
