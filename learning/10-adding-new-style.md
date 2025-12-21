# Adding a New Style 🎭

**Step-by-step guide to creating a custom design style**

Want to create your own design system for Syntaxify? This guide will show you how!

---

## Overview

We'll create a **Glassmorphism** style - a modern design with frosted glass effects.

**What we'll build:**

A complete design style that renders all components with:
- Frosted glass backgrounds
- Backdrop blur effects
- Subtle borders and shadows
- Modern aesthetic

---

## Prerequisites

- ✅ You've read [04-renderer-pattern.md](04-renderer-pattern.md)
- ✅ Understanding of design tokens
- ✅ Familiarity with Flutter widgets

**Time required:** ~1 hour

---

## Step 1: Create the Style Class

### Create Style File

```bash
# In generator/design_system/ directory
touch glassmorphism_style.dart
```

### Define the Style

```dart
// generator/design_system/glassmorphism_style.dart
part of 'design_system.dart';

/// Glassmorphism design style with frosted glass effects.
///
/// Features:
/// - Frosted glass backgrounds
/// - Backdrop blur
/// - Subtle borders
/// - Modern shadows
class GlassmorphismStyle extends DesignStyle
    with GlassmorphismButtonRenderer,
         GlassmorphismTextRenderer,
         GlassmorphismInputRenderer,
         GlassmorphismAppBarRenderer {
  const GlassmorphismStyle();
}
```

**Note:** We'll create the renderer mixins next.

---

## Step 2: Create Button Renderer

### Create Renderer File

```bash
mkdir -p design_system/styles/glassmorphism
touch design_system/styles/glassmorphism/button_renderer.dart
```

### Implement Button Renderer

```dart
// generator/design_system/styles/glassmorphism/button_renderer.dart
part of '../../design_system.dart';

mixin GlassmorphismButtonRenderer on DesignStyle {
  @override
  ButtonTokens get buttonTokens => const ButtonTokens(
    primaryBackgroundColor: Color(0x40FFFFFF),  // 25% white
    secondaryBackgroundColor: Color(0x20FFFFFF),  // 12% white
    textColor: Colors.white,
    borderRadius: 16,
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
    final backgroundColor = variant == ButtonVariant.primary
        ? tokens.primaryBackgroundColor
        : tokens.secondaryBackgroundColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(tokens.borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(tokens.borderRadius),
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.white.withOpacity(0.05),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
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

**Import required:**
```dart
import 'dart:ui';  // For ImageFilter
```

---

## Step 3: Create Text Renderer

```dart
// generator/design_system/styles/glassmorphism/text_renderer.dart
part of '../../design_system.dart';

mixin GlassmorphismTextRenderer on DesignStyle {
  @override
  TextTokens get textTokens => const TextTokens(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.25,
      height: 1.12,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.50,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
      color: Color(0xFFE0E0E0),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
      color: Color(0xFFBDBDBD),
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
      color: Color(0xFF9E9E9E),
    ),
  );

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    TextStyle? style;
    if (variant != null) {
      switch (variant) {
        case TextVariant.displayLarge:
          style = textTokens.displayLarge;
          break;
        case TextVariant.headlineMedium:
          style = textTokens.headlineMedium;
          break;
        case TextVariant.titleMedium:
          style = textTokens.titleMedium;
          break;
        case TextVariant.bodyLarge:
          style = textTokens.bodyLarge;
          break;
        case TextVariant.bodyMedium:
          style = textTokens.bodyMedium;
          break;
        case TextVariant.labelSmall:
          style = textTokens.labelSmall;
          break;
      }
    }

    return Text(
      text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
```

---

## Step 4: Create Input Renderer

```dart
// generator/design_system/styles/glassmorphism/input_renderer.dart
part of '../../design_system.dart';

mixin GlassmorphismInputRenderer on DesignStyle {
  @override
  InputTokens get inputTokens => const InputTokens(
    backgroundColor: Color(0x20FFFFFF),
    borderColor: Color(0x40FFFFFF),
    focusedBorderColor: Color(0x80FFFFFF),
    textColor: Colors.white,
    hintColor: Color(0x60FFFFFF),
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 16,
  );

  @override
  Widget renderInput({
    required String label,
    String? placeholder,
    bool obscureText = false,
    KeyboardType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    final tokens = inputTokens;

    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: tokens.backgroundColor,
            borderRadius: BorderRadius.circular(tokens.borderRadius),
            border: Border.all(
              color: tokens.borderColor,
              width: 1,
            ),
          ),
          child: TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            keyboardType: _mapKeyboardType(keyboardType),
            style: TextStyle(
              color: tokens.textColor,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              labelText: label,
              hintText: placeholder,
              labelStyle: TextStyle(
                color: tokens.hintColor,
                fontSize: 14,
              ),
              hintStyle: TextStyle(
                color: tokens.hintColor,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: tokens.paddingVertical,
                horizontal: tokens.paddingHorizontal,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(tokens.borderRadius),
                borderSide: BorderSide(
                  color: tokens.focusedBorderColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextInputType? _mapKeyboardType(KeyboardType? type) {
    if (type == null) return null;

    switch (type) {
      case KeyboardType.text:
        return TextInputType.text;
      case KeyboardType.email:
        return TextInputType.emailAddress;
      case KeyboardType.number:
        return TextInputType.number;
      case KeyboardType.phone:
        return TextInputType.phone;
      case KeyboardType.url:
        return TextInputType.url;
    }
  }
}
```

---

## Step 5: Create AppBar Renderer

```dart
// generator/design_system/styles/glassmorphism/app_bar_renderer.dart
part of '../../design_system.dart';

mixin GlassmorphismAppBarRenderer on DesignStyle {
  @override
  AppBarTokens get appBarTokens => const AppBarTokens(
    backgroundColor: Color(0x40FFFFFF),
    foregroundColor: Colors.white,
    elevation: 0,
    height: 56,
  );

  @override
  PreferredSizeWidget renderAppBar({
    required String title,
    List<AppBarAction>? actions,
  }) {
    final tokens = appBarTokens;

    return PreferredSize(
      preferredSize: Size.fromHeight(tokens.height),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            title: Text(
              title,
              style: TextStyle(
                color: tokens.foregroundColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: tokens.backgroundColor,
            elevation: tokens.elevation,
            iconTheme: IconThemeData(
              color: tokens.foregroundColor,
            ),
            actions: actions
                ?.map((action) => IconButton(
                      icon: Icon(_getIcon(action.icon)),
                      onPressed: action.onPressed,
                      color: tokens.foregroundColor,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    // Map icon names to IconData
    switch (iconName) {
      case 'settings':
        return Icons.settings;
      case 'search':
        return Icons.search;
      case 'menu':
        return Icons.menu;
      default:
        return Icons.more_vert;
    }
  }
}
```

---

## Step 6: Update Design System Export

Add the new style to the main design system file.

```dart
// generator/design_system/design_system.dart

library design_system;

import 'dart:ui';
import 'package:flutter/material.dart';

// Core
part 'app_theme.dart';
part 'design_style.dart';

// Tokens
part 'tokens/button_tokens.dart';
part 'tokens/text_tokens.dart';
part 'tokens/input_tokens.dart';
part 'tokens/app_bar_tokens.dart';

// Styles
part 'material_style.dart';
part 'cupertino_style.dart';
part 'neo_style.dart';
part 'glassmorphism_style.dart';  // <-- Add this

// Material renderers
part 'styles/material/button_renderer.dart';
part 'styles/material/text_renderer.dart';
part 'styles/material/input_renderer.dart';
part 'styles/material/app_bar_renderer.dart';

// Cupertino renderers
part 'styles/cupertino/button_renderer.dart';
part 'styles/cupertino/text_renderer.dart';
part 'styles/cupertino/input_renderer.dart';
part 'styles/cupertino/app_bar_renderer.dart';

// Neo renderers
part 'styles/neo/button_renderer.dart';
part 'styles/neo/text_renderer.dart';
part 'styles/neo/input_renderer.dart';
part 'styles/neo/app_bar_renderer.dart';

// Glassmorphism renderers
part 'styles/glassmorphism/button_renderer.dart';  // <-- Add these
part 'styles/glassmorphism/text_renderer.dart';
part 'styles/glassmorphism/input_renderer.dart';
part 'styles/glassmorphism/app_bar_renderer.dart';

// ... rest of the file
```

---

## Step 7: Use the New Style

Now you can use your custom style!

```dart
// In main.dart
import 'package:syntaxify/design_system.dart';

void main() {
  runApp(
    AppTheme(
      style: GlassmorphismStyle(),  // Your new style!
      child: MyApp(),
    ),
  );
}
```

**For better effect, use a gradient background:**

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Glassmorphism')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'Beautiful Glass',
                  variant: TextVariant.headlineMedium,
                ),
                SizedBox(height: 24),
                AppButton(
                  label: 'Click Me',
                  variant: ButtonVariant.primary,
                  onPressed: () => print('Clicked!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Step 8: Customization

### Token Customization

Tweak the design by modifying tokens:

```dart
@override
ButtonTokens get buttonTokens => const ButtonTokens(
  primaryBackgroundColor: Color(0x60FFFFFF),  // More opaque
  borderRadius: 24,  // More rounded
  paddingVertical: 20,  // More padding
  // ...
);
```

### Adding Variants

Support different button variants:

```dart
@override
Widget renderButton({...}) {
  final tokens = buttonTokens;

  Color backgroundColor;
  Color borderColor;

  switch (variant ?? ButtonVariant.primary) {
    case ButtonVariant.primary:
      backgroundColor = tokens.primaryBackgroundColor;
      borderColor = Colors.white.withOpacity(0.3);
      break;
    case ButtonVariant.secondary:
      backgroundColor = tokens.secondaryBackgroundColor;
      borderColor = Colors.white.withOpacity(0.2);
      break;
    case ButtonVariant.text:
      backgroundColor = Colors.transparent;
      borderColor = Colors.transparent;
      break;
  }

  // Use backgroundColor and borderColor in rendering
}
```

---

## Step 9: Adding More Components

To support additional components (Card, Image, etc.):

### 1. Create Renderer

```bash
touch design_system/styles/glassmorphism/card_renderer.dart
```

### 2. Implement Renderer

```dart
mixin GlassmorphismCardRenderer on DesignStyle {
  @override
  CardTokens get cardTokens => const CardTokens(
    backgroundColor: Color(0x30FFFFFF),
    borderColor: Color(0x40FFFFFF),
    borderWidth: 1,
    borderRadius: 20,
    padding: EdgeInsets.all(20),
    elevation: 0,
  );

  @override
  Widget renderCard({...}) {
    final tokens = cardTokens;

    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? tokens.padding,
          decoration: BoxDecoration(
            color: tokens.backgroundColor,
            borderRadius: BorderRadius.circular(tokens.borderRadius),
            border: Border.all(
              color: tokens.borderColor,
              width: tokens.borderWidth,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              if (child != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: child!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3. Add to Style Class

```dart
class GlassmorphismStyle extends DesignStyle
    with GlassmorphismButtonRenderer,
         GlassmorphismTextRenderer,
         GlassmorphismInputRenderer,
         GlassmorphismAppBarRenderer,
         GlassmorphismCardRenderer {  // <-- Add this
  const GlassmorphismStyle();
}
```

---

## Advanced: Dynamic Blur Intensity

Add a configurable blur intensity:

```dart
class GlassmorphismStyle extends DesignStyle
    with GlassmorphismButtonRenderer,
         GlassmorphismTextRenderer,
         GlassmorphismInputRenderer,
         GlassmorphismAppBarRenderer {
  const GlassmorphismStyle({
    this.blurIntensity = 10.0,
    this.opacity = 0.25,
  });

  final double blurIntensity;
  final double opacity;
}
```

**Use in renderers:**

```dart
mixin GlassmorphismButtonRenderer on DesignStyle {
  @override
  Widget renderButton({...}) {
    final style = this as GlassmorphismStyle;
    final blurSigma = style.blurIntensity;
    final opacity = style.opacity;

    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            // ...
          ),
          // ...
        ),
      ),
    );
  }
}
```

**Usage:**

```dart
AppTheme(
  style: GlassmorphismStyle(
    blurIntensity: 15.0,  // More blur
    opacity: 0.3,         // More opaque
  ),
  child: MyApp(),
)
```

---

## Checklist ✅

Before publishing your style:

- [ ] Created style class
- [ ] Implemented all required renderers (Button, Text, Input, AppBar)
- [ ] Added token classes
- [ ] Updated design_system.dart exports
- [ ] Tested with all components
- [ ] Tested on different screen sizes
- [ ] Tested with different content
- [ ] Added documentation
- [ ] Created example usage
- [ ] Tested hot reload
- [ ] Checked performance
- [ ] Verified accessibility (contrast ratios, etc.)

---

## Tips & Best Practices

### 1. Keep Tokens Consistent

```dart
// ✅ GOOD - Consistent spacing
const spacing8 = 8.0;
const spacing16 = 16.0;
const spacing24 = 24.0;

// ❌ BAD - Random values
const padding1 = 7.0;
const padding2 = 13.0;
const padding3 = 22.0;
```

### 2. Use Color Opacity

```dart
// ✅ GOOD - Clear opacity
Color(0x40FFFFFF)  // 25% white

// ❌ BAD - Magic numbers
Color(0x3FFFFFFF)  // What opacity is this?
```

### 3. Add Documentation

```dart
/// Glassmorphism button with frosted glass effect.
///
/// Features:
/// - Backdrop blur
/// - Transparent background
/// - Subtle border
///
/// Best used on gradient or image backgrounds.
@override
Widget renderButton({...}) {
  // ...
}
```

### 4. Consider Performance

```dart
// BackdropFilter can be expensive
// Use sparingly, especially for lists

// ✅ GOOD - Limited use
SingleChildScrollView(
  child: Column(
    children: [
      AppButton(...),  // Has BackdropFilter
      AppButton(...),  // Has BackdropFilter
    ],
  ),
)

// ⚠️ WARNING - Many blurred items
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) => AppButton(...),  // 100 BackdropFilters!
);
```

### 5. Test Accessibility

```dart
// Check color contrast ratios
// WCAG AA: 4.5:1 for normal text
// WCAG AAA: 7:1 for normal text

// Use contrast checker:
// https://webaim.org/resources/contrastchecker/
```

---

## Publishing Your Style

### 1. Create Package

```bash
flutter create --template=package glassmorphism_style
```

### 2. Add Dependencies

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  syntaxify: ^0.1.0
```

### 3. Export Style

```dart
// lib/glassmorphism_style.dart
library glassmorphism_style;

export 'src/glassmorphism_style.dart';
export 'src/renderers/button_renderer.dart';
// ...
```

### 4. Publish

```bash
flutter pub publish
```

---

## Summary

**Created a custom style:**
1. ✅ Created style class
2. ✅ Implemented renderer mixins
3. ✅ Defined tokens
4. ✅ Updated exports
5. ✅ Tested and used

**Key concepts:**
- Styles compose renderer mixins
- Each renderer implements one component
- Tokens define design values
- BackdropFilter creates glass effect

**Next:**
- Add more components
- Create variants
- Publish as package
- Share with community!

---

**Congratulations!** 🎉 You've created a custom design style!

➡️ **See also:**
- [08-design-system-deep-dive.md](08-design-system-deep-dive.md) - More on design systems
- [04-renderer-pattern.md](04-renderer-pattern.md) - How rendering works
