# Design System Deep Dive 🎨

**Understanding Foundation Tokens and the Token Generation System**

This guide covers the design system architecture including Foundation Tokens, TokenGenerator, and how components derive their styling from centralized primitives.

---

## Overview

Syntaxify uses a **Foundation Token** system as the single source of truth for design primitives. Instead of hardcoding colors, typography, and spacing throughout components, all values are derived from centralized foundation tokens.

### Why Foundation Tokens?

**Before:**
```dart
// 21 renderers × 20 hardcoded values = 420+ magic numbers
class MaterialButtonRenderer {
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return const ButtonTokens(
      bgColor: Colors.blue,      // Hardcoded
      radius: 8.0,               // Hardcoded
    );
  }
}
```

**After:**
```dart
// Single source of truth
class MaterialButtonRenderer {
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return ButtonTokens.fromFoundation(foundation, variant: variant);
  }
}
```

**Benefits:**
- Change `colorPrimary` once → affects all 21 renderers
- Consistent design across all components
- Self-documenting code (`foundation.colorPrimary` vs `Colors.blue`)
- Easy to create new design systems

---

## Architecture

### Token Layers

```
┌─────────────────────────────────────┐
│  Foundation Tokens (54 primitives)  │  ← Single Source of Truth
│  - Colors (16)                      │
│  - Typography (15)                  │
│  - Spacing (7), Radius (6), etc.    │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│  Style Implementations              │  ← 3 Design Systems
│  - Material Design 3                │
│  - iOS HIG (Cupertino)              │
│  - Neo-brutalism                    │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│  Component Tokens                   │  ← Derived from Foundation
│  - ButtonTokens.fromFoundation()    │
│  - TextTokens.fromFoundation()      │
│  - etc.                             │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│  Renderers (21 files)               │  ← Use Component Tokens
│  - MaterialButtonRenderer           │
│  - CupertinoTextRenderer            │
│  - etc.                             │
└─────────────────────────────────────┘
```

### File Structure

```
lib/syntaxify/design_system/
├── tokens/
│   ├── foundation/
│   │   ├── foundation_tokens.dart     # Base class (54 properties)
│   │   ├── material_foundation.dart   # Material Design 3 values
│   │   ├── cupertino_foundation.dart  # iOS HIG values
│   │   └── neo_foundation.dart        # Neo-brutalism values
│   ├── button_tokens.dart             # Derived from foundation
│   └── text_tokens.dart               # Derived from foundation
├── components/
│   └── button/
│       ├── material_renderer.dart     # Uses ButtonTokens.fromFoundation()
│       ├── cupertino_renderer.dart
│       └── neo_renderer.dart
└── design_system.dart
```

---

## Foundation Token Reference

### Colors (16 tokens)

```dart
// Primary
foundation.colorPrimary           // Main brand color
foundation.colorOnPrimary         // Text/icons on primary
foundation.colorPrimaryContainer  // Lighter primary variant

// Surface  
foundation.colorSurface           // Background surfaces
foundation.colorOnSurface         // Text/icons on surfaces
foundation.colorSurfaceVariant    // Subtle variations

// Semantic
foundation.colorError             // Error states
foundation.colorOutline           // Borders, dividers
```

### Typography (15 tokens)

```dart
foundation.displayLarge    // 57px, light
foundation.headlineMedium  // 28px, regular
foundation.titleMedium     // 16px, medium
foundation.bodyMedium      // 14px, regular
foundation.labelSmall      // 11px, medium
```

### Spacing (7 tokens) - 8dp Grid

```dart
foundation.spacingXs   // 4dp
foundation.spacingSm   // 8dp
foundation.spacingMd   // 16dp (base unit)
foundation.spacingLg   // 24dp
foundation.spacingXl   // 32dp
```

### Border Radius (6 tokens)

```dart
foundation.radiusNone  // 0dp (sharp)
foundation.radiusSm    // 4dp
foundation.radiusMd    // 8dp
foundation.radiusLg    // 16dp
foundation.radiusFull  // 9999dp (pill)
```

---

## TokenGenerator

The `TokenGenerator` automatically creates token classes for components.

### How It Works

1. **Parses component meta** - Reads property definitions
2. **Filters token-worthy properties** - Colors, sizes, padding, etc.
3. **Generates token class** - With `.fromFoundation()` factory
4. **Smart property mapping** - Maps names to foundation tokens

### Smart Property Mapping

| Property Pattern  | Foundation Token                                                   |
| ----------------- | ------------------------------------------------------------------ |
| `inactiveColor`   | `colorSurfaceVariant`                                              |
| `activeColor`     | `colorPrimary`                                                     |
| `checkColor`      | `colorOnPrimary`                                                   |
| `thumbColor`      | `colorOnPrimary`                                                   |
| `borderColor`     | `colorOutline`                                                     |
| `trackColor`      | `colorPrimary` (inactive: `colorSurfaceVariant`)                   |
| `textColor`       | `colorOnSurface`                                                   |
| `backgroundColor` | `colorSurface`                                                     |
| `errorColor`      | `colorError`                                                       |
| `focusColor`      | `colorPrimary`                                                     |
| `borderWidth`     | `borderWidthMedium`                                                |
| `borderRadius`    | `radiusSm`                                                         |
| `trackHeight`     | `borderWidthMedium * 2`                                            |
| `thumbRadius`     | `spacingSm + 2`                                                    |
| `padding`         | `EdgeInsets.symmetric(horizontal: spacingMd, vertical: spacingSm)` |
| `textStyle`       | `bodyMedium.copyWith(color: colorOnSurface)`                       |
| `hintStyle`       | `bodyMedium.copyWith(color: colorOnSurfaceVariant)`                |

### Example Generated Token

For a component with `backgroundColor`, `borderRadius`, and `padding`:

```dart
class CardTokens {
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  const CardTokens({
    required this.backgroundColor,
    required this.borderRadius,
    required this.padding,
  });

  /// Create from foundation tokens
  factory CardTokens.fromFoundation(FoundationTokens foundation) {
    return CardTokens(
      backgroundColor: foundation.colorSurface,
      borderRadius: foundation.radiusMd,
      padding: EdgeInsets.symmetric(
        horizontal: foundation.spacingMd,
        vertical: foundation.spacingSm,
      ),
    );
  }
}
```

---

## Using Foundation in Code

### In Widgets

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foundation = AppTheme.of(context).style.foundation;

    return Container(
      padding: EdgeInsets.all(foundation.spacingMd),
      decoration: BoxDecoration(
        color: foundation.colorPrimary,
        borderRadius: BorderRadius.circular(foundation.radiusMd),
      ),
      child: Text('Hello', style: foundation.bodyMedium),
    );
  }
}
```

### In Renderers

```dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return ButtonTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderButton({required String label, ...}) {
    final tokens = buttonTokens(variant);
    // Use tokens.bgColor, tokens.radius, etc.
  }
}
```

---

## Creating Custom Design Systems

### 1. Define Custom Foundation

```dart
const brandFoundation = FoundationTokens(
  colorPrimary: Color(0xFF1E40AF),     // Brand blue
  colorOnPrimary: Color(0xFFFFFFFF),
  colorSurface: Color(0xFFFAFAFA),
  
  spacingMd: 12.0,   // Tighter spacing
  radiusMd: 12.0,    // More rounded
  
  bodyMedium: TextStyle(
    fontFamily: 'Poppins',  // Custom font
    fontSize: 14,
  ),
  // ... rest of properties
);
```

### 2. Create Custom Style

```dart
class BrandStyle extends DesignStyle
    with BrandButtonRenderer, BrandTextRenderer, ... {
  const BrandStyle();

  @override
  FoundationTokens get foundation => brandFoundation;
}
```

### 3. Use in App

```dart
AppTheme(
  style: BrandStyle(),
  child: MyApp(),
)
```

---

## Design System Values by Style

### Material Design 3

| Token          | Value                   |
| -------------- | ----------------------- |
| `colorPrimary` | `#6200EE` (Deep Purple) |
| `radiusMd`     | `8dp`                   |
| `spacingMd`    | `16dp`                  |
| `bodyMedium`   | Roboto 14px             |

### Cupertino (iOS)

| Token          | Value                |
| -------------- | -------------------- |
| `colorPrimary` | `#007AFF` (iOS Blue) |
| `radiusMd`     | `8dp`                |
| `spacingMd`    | `16dp`               |
| `bodyMedium`   | SF Pro 14px          |

### Neo-brutalism

| Token              | Value                  |
| ------------------ | ---------------------- |
| `colorPrimary`     | `#FFD60A` (Yellow)     |
| `radiusMd`         | `0dp` (Sharp)          |
| `borderWidthThick` | `4dp`                  |
| `bodyMedium`       | Inter 14px, Weight 900 |

---

## Known Issues & Resolutions

These issues have been identified and resolved. Documented here for reference.

### Issue: `foundation_tokens.dart` Uses `part of` Instead of `import`

**Problem:** The file declared `part of '../../design_system.dart';` but was being imported directly, causing "Undefined class 'Color'" errors.

**Resolution:** Changed to `import 'package:flutter/material.dart';` so it can be imported as a standalone file.

---

### Issue: Fresh Project Missing Foundation Tokens

**Problem:** On first build, `designSystemDir/tokens/foundation/` doesn't exist, causing "Foundation token directory not found" warning.

**Resolution:** Added fallback to generator package's bundled `design_system/tokens/foundation/` using `_getPackageBundledFoundationDir()` in `build_all.dart`.

---

### Issue: Custom Components Don't Get Token Files

**Problem:** TokenGenerator returned `null` when no properties matched token patterns (color, size, shadow), so custom components like SuperCard got no token file.

**Resolution:** Changed `TokenGenerator.generate()` to always return a stub token file, even with empty properties. This provides a scaffold users can fill in.

---

### Issue: Windows Path Separators

**Problem:** `entity.path` on Windows uses backslashes, but `p.posix.join()` uses forward slashes, causing malformed paths.

**Resolution:** Added path normalization (`path.replaceAll('\\', '/')`) in `LocalFileSystem` and `build_all.dart`.

---

## Related Resources

- **[FOUNDATION_TOKENS_README.md](file:///d:/Workspace/syntaxify/generator/FOUNDATION_TOKENS_README.md)** - Complete implementation guide
- **[FOUNDATION_TOKENS_QUICK_REF.md](file:///d:/Workspace/syntaxify/generator/FOUNDATION_TOKENS_QUICK_REF.md)** - Cheat sheet
- **[ISSUES.md](file:///d:/Workspace/syntaxify/generator/docs/ISSUES.md)** - Documented bug fixes
- **[04-renderer-pattern.md](04-renderer-pattern.md)** - WHAT vs HOW separation
- **[05-code-generation.md](05-code-generation.md)** - Code generation pipeline

---

## Next Steps

- **[09-adding-new-component.md](09-adding-new-component.md)** - Create a component using Foundation
- **[10-adding-new-style.md](10-adding-new-style.md)** - Create a custom design system
