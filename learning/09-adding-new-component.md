# Adding a New Component ✨

**Step-by-step guide to adding a new UI component**

This is a practical, hands-on guide. Follow these steps to add your own component to Syntaxify!

---

## Overview

We'll add a **Card** component that displays content in a styled container.

**What we'll build:**

```dart
// Usage
AppCard(
  title: 'My Card',
  subtitle: 'Card description',
  child: Text('Card content'),
)
```

**Rendered as:**
- **Material:** Card widget with elevation
- **Cupertino:** Container with iOS-style border
- **Neo:** Container with gradient background

---

## Prerequisites

- ✅ You've read [01-what-is-syntaxify.md](01-what-is-syntaxify.md)
- ✅ You've read [04-renderer-pattern.md](04-renderer-pattern.md)
- ✅ Syntaxify project is set up locally

**Time required:** ~30 minutes

---

## Step 1: Define the Component Metadata

Create the meta file that defines what properties your component has.

### Create File

```bash
# In generator/meta/ directory
touch meta/card.meta.dart
```

### Write Definition

```dart
// generator/meta/card.meta.dart
import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// Card component for displaying content in a container
@SyntaxComponent(
  name: 'AppCard',
  description: 'A card component for displaying content with optional title and subtitle',
)
class CardMeta {
  /// The card title
  final String? title;

  /// The card subtitle
  final String? subtitle;

  /// The main content of the card
  final Widget? child;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Callback when card is tapped
  final VoidCallback? onTap;
}
```

**Explanation:**
- `@SyntaxComponent` - Marks this as a component definition
- `name: 'AppCard'` - Explicit component name (optional, defaults to class name without "Meta")
- `description` - Shown in generated docs
- Properties define the component's API
- Use `?` for optional properties
- Use Flutter types (`Widget`, `EdgeInsetsGeometry`, etc.)

---

## Step 2: Add to AST System

If you want this component usable in screen definitions, add it to the AST.

### Update AstNode

```dart
// generator/lib/src/models/ast/layout_node.dart

@freezed
sealed class LayoutNode with _$LayoutNode {
  // ... existing nodes

  /// Card component node
  const factory LayoutNode.card({
    String? title,
    String? subtitle,
    @Default([]) List<LayoutNode> children,
  }) = CardNode;
}
```

### Regenerate Freezed

```bash
cd generator
dart run build_runner build --delete-conflicting-outputs
```

---

## Step 3: Create Design Tokens

Define the design values for the card.

### Create Token Class

```dart
// generator/design_system/tokens/card_tokens.dart
part of '../design_system.dart';

/// Design tokens for card components
class CardTokens {
  const CardTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.elevation,
    this.shadowColor,
  });

  /// Background color of the card
  final Color backgroundColor;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  /// Border radius
  final double borderRadius;

  /// Internal padding
  final EdgeInsetsGeometry padding;

  /// Card elevation (shadow depth)
  final double elevation;

  /// Shadow color (optional)
  final Color? shadowColor;
}
```

### Add to DesignStyle

```dart
// generator/design_system/design_style.dart

abstract class DesignStyle {
  // ... existing token getters

  /// Card component tokens
  CardTokens get cardTokens;

  // ... existing render methods

  /// Render a card component
  Widget renderCard({
    String? title,
    String? subtitle,
    Widget? child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  });
}
```

---

## Step 4: Implement Material Renderer

Create the Material Design implementation.

### Create Renderer File

```dart
// generator/design_system/styles/material/card_renderer.dart
part of '../../design_system.dart';

mixin MaterialCardRenderer on DesignStyle {
  @override
  CardTokens get cardTokens => const CardTokens(
    backgroundColor: Colors.white,
    borderColor: Colors.transparent,
    borderWidth: 0,
    borderRadius: 12,
    padding: EdgeInsets.all(16),
    elevation: 2,
    shadowColor: Colors.black26,
  );

  @override
  Widget renderCard({
    String? title,
    String? subtitle,
    Widget? child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final tokens = cardTokens;

    Widget cardContent = Container(
      padding: padding ?? tokens.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (title != null && subtitle != null)
            const SizedBox(height: 4),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          if ((title != null || subtitle != null) && child != null)
            const SizedBox(height: 12),
          if (child != null) child,
        ],
      ),
    );

    return Card(
      elevation: tokens.elevation,
      shadowColor: tokens.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      color: tokens.backgroundColor,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(tokens.borderRadius),
              child: cardContent,
            )
          : cardContent,
    );
  }
}
```

### Add Mixin to MaterialStyle

```dart
// generator/design_system/material_style.dart

class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer,
         MaterialInputRenderer,
         MaterialAppBarRenderer,
         MaterialCardRenderer {  // <-- Add this
  const MaterialStyle();
}
```

---

## Step 5: Implement Cupertino Renderer

Create the iOS Design implementation.

```dart
// generator/design_system/styles/cupertino/card_renderer.dart
part of '../../design_system.dart';

mixin CupertinoCardRenderer on DesignStyle {
  @override
  CardTokens get cardTokens => const CardTokens(
    backgroundColor: CupertinoColors.systemBackground,
    borderColor: CupertinoColors.separator,
    borderWidth: 1,
    borderRadius: 10,
    padding: EdgeInsets.all(16),
    elevation: 0,  // iOS doesn't use elevation
  );

  @override
  Widget renderCard({
    String? title,
    String? subtitle,
    Widget? child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final tokens = cardTokens;

    Widget cardContent = Container(
      padding: padding ?? tokens.padding,
      decoration: BoxDecoration(
        color: tokens.backgroundColor,
        border: Border.all(
          color: tokens.borderColor,
          width: tokens.borderWidth,
        ),
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (title != null && subtitle != null)
            const SizedBox(height: 4),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          if ((title != null || subtitle != null) && child != null)
            const SizedBox(height: 12),
          if (child != null) child,
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
```

### Add Mixin to CupertinoStyle

```dart
// generator/design_system/cupertino_style.dart

class CupertinoStyle extends DesignStyle
    with CupertinoButtonRenderer,
         CupertinoTextRenderer,
         CupertinoInputRenderer,
         CupertinoAppBarRenderer,
         CupertinoCardRenderer {  // <-- Add this
  const CupertinoStyle();
}
```

---

## Step 6: Implement Neo Renderer

Create the custom Neo style implementation.

```dart
// generator/design_system/styles/neo/card_renderer.dart
part of '../../design_system.dart';

mixin NeoCardRenderer on DesignStyle {
  @override
  CardTokens get cardTokens => const CardTokens(
    backgroundColor: Color(0xFF1A1A2E),
    borderColor: Color(0xFF6C5CE7),
    borderWidth: 2,
    borderRadius: 16,
    padding: EdgeInsets.all(20),
    elevation: 0,
  );

  @override
  Widget renderCard({
    String? title,
    String? subtitle,
    Widget? child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final tokens = cardTokens;

    Widget cardContent = Container(
      padding: padding ?? tokens.padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
        ),
        border: Border.all(
          color: tokens.borderColor,
          width: tokens.borderWidth,
        ),
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        boxShadow: [
          BoxShadow(
            color: tokens.borderColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (title != null && subtitle != null)
            const SizedBox(height: 6),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFB0B3B8),
              ),
            ),
          if ((title != null || subtitle != null) && child != null)
            const SizedBox(height: 16),
          if (child != null) child,
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
```

### Add Mixin to NeoStyle

```dart
// generator/design_system/neo_style.dart

class NeoStyle extends DesignStyle
    with NeoButtonRenderer,
         NeoTextRenderer,
         NeoInputRenderer,
         NeoAppBarRenderer,
         NeoCardRenderer {  // <-- Add this
  const NeoStyle();
}
```

---

## Step 7: Generate the Component

Now run the build command to generate the component class.

```bash
cd generator
dart run syntaxify build
```

**Output:**
```
✓ Found 4 component definitions
  - ButtonMeta → AppButton
  - TextMeta → AppText
  - InputMeta → AppInput
  - CardMeta → AppCard  ← New!

✓ Generating components...
  - lib/generated/components/app_card.dart  ← New!

✓ Done!
```

**Generated file:**

```dart
// generator/lib/generated/components/app_card.dart
// Generated code - do not modify by hand

import 'package:flutter/material.dart';
import 'package:syntaxify/design_system.dart';

/// A card component for displaying content with optional title and subtitle
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.padding,
    this.onTap,
  });

  /// The card title
  final String? title;

  /// The card subtitle
  final String? subtitle;

  /// The main content of the card
  final Widget? child;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderCard(
      title: title,
      subtitle: subtitle,
      child: child,
      padding: padding,
      onTap: onTap,
    );
  }
}
```

---

## Step 8: Update Exports

Make sure the component is exported.

### Update Components Barrel File

```dart
// generator/lib/generated/components.dart

export 'components/app_button.dart';
export 'components/app_text.dart';
export 'components/app_input.dart';
export 'components/app_card.dart';  // <-- Add this
```

### Update Design System Export

```dart
// generator/design_system/design_system.dart

// Tokens
part 'tokens/button_tokens.dart';
part 'tokens/text_tokens.dart';
part 'tokens/input_tokens.dart';
part 'tokens/card_tokens.dart';  // <-- Add this

// Material renderers
part 'styles/material/button_renderer.dart';
part 'styles/material/text_renderer.dart';
part 'styles/material/input_renderer.dart';
part 'styles/material/card_renderer.dart';  // <-- Add this

// Cupertino renderers
part 'styles/cupertino/button_renderer.dart';
part 'styles/cupertino/text_renderer.dart';
part 'styles/cupertino/input_renderer.dart';
part 'styles/cupertino/card_renderer.dart';  // <-- Add this

// Neo renderers
part 'styles/neo/button_renderer.dart';
part 'styles/neo/text_renderer.dart';
part 'styles/neo/input_renderer.dart';
part 'styles/neo/card_renderer.dart';  // <-- Add this
```

---

## Step 9: Test the Component

Create a test screen to see your component in action.

### Create Test Screen

```dart
// generator/example/lib/screens/card_test_screen.dart
import 'package:flutter/material.dart';
import 'package:syntaxify/generated/components.dart';

class CardTestScreen extends StatelessWidget {
  const CardTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppCard(
              title: 'Simple Card',
              subtitle: 'This is a subtitle',
            ),
            const SizedBox(height: 16),
            AppCard(
              title: 'Card with Content',
              subtitle: 'Has a child widget',
              child: const Text('This is the card content'),
            ),
            const SizedBox(height: 16),
            AppCard(
              title: 'Tappable Card',
              subtitle: 'Tap me!',
              onTap: () {
                print('Card tapped!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### Run the Example

```bash
cd generator/example
flutter run
```

### Test Different Styles

```dart
// In example/lib/main.dart

// Try Material
AppTheme(
  style: MaterialStyle(),
  child: MyApp(),
)

// Try Cupertino
AppTheme(
  style: CupertinoStyle(),
  child: MyApp(),
)

// Try Neo
AppTheme(
  style: NeoStyle(),
  child: MyApp(),
)
```

**Hot reload and see the card change!** 🎉

---

## Step 10: Add to Layout Emitter (Optional)

If you added the component to AST, update the emitter.

```dart
// generator/lib/src/emitters/layout_emitter.dart

class LayoutEmitter {
  Expression emit(AstNode node) {
    return node.map(
      // ... existing nodes

      card: (n) => refer('AppCard').newInstance([], {
        if (n.title != null) 'title': literalString(n.title!),
        if (n.subtitle != null) 'subtitle': literalString(n.subtitle!),
        if (n.children.isNotEmpty)
          'child': refer('Column').newInstance([], {
            'children': literalList(n.children.map(emit).toList()),
          }),
      }),
    );
  }
}
```

Now you can use it in screen definitions:

```dart
// meta/profile.screen.dart
final profileScreen = ScreenDefinition(
  id: 'profile',
  layout: LayoutNode.column(
    children: [
      LayoutNode.card(
        title: 'Profile',
        subtitle: 'User information',
        children: [
          LayoutNode.text(text: 'John Doe'),
          LayoutNode.text(text: 'john@example.com'),
        ],
      ),
    ],
  ),
);
```

---

## Checklist ✅

Before submitting your component:

- [ ] Created meta file with `@SyntaxComponent`
- [ ] Added to AST (if needed)
- [ ] Created token class
- [ ] Added token getter to `DesignStyle`
- [ ] Added render method to `DesignStyle`
- [ ] Implemented Material renderer
- [ ] Implemented Cupertino renderer
- [ ] Implemented Neo renderer
- [ ] Added mixins to style classes
- [ ] Ran `dart run syntaxify build` successfully
- [ ] Updated exports
- [ ] Tested with all three styles
- [ ] Added to layout emitter (if needed)
- [ ] Wrote documentation
- [ ] Wrote tests (see [11-debugging-guide.md](11-debugging-guide.md))

---

## Common Pitfalls ⚠️

### 1. Forgetting to Add Mixin

```dart
// ❌ WRONG
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,
         MaterialTextRenderer {
  // Forgot MaterialCardRenderer!
}
```

**Error:** `Missing concrete implementation of 'DesignStyle.renderCard'`

**Fix:** Add the mixin!

### 2. Wrong Part Declaration

```dart
// ❌ WRONG
// card_renderer.dart
import '../../design_system.dart';  // Wrong!

// ✅ CORRECT
part of '../../design_system.dart';  // Correct!
```

### 3. Not Exporting Token Class

```dart
// ❌ WRONG - Forgot to add part directive
// design_system.dart
part 'tokens/button_tokens.dart';
part 'tokens/text_tokens.dart';
// Forgot card_tokens!

// ✅ CORRECT
part 'tokens/card_tokens.dart';
```

### 4. Inconsistent Naming

```dart
// ❌ WRONG - Name mismatch
@SyntaxComponent(name: 'AppCard')
class CardComponentMeta { ... }

// ✅ CORRECT - Consistent naming
@SyntaxComponent(name: 'AppCard')
class CardMeta { ... }
```

---

## Next Steps

**Congratulations!** 🎉 You've added a new component to Syntaxify.

**What's next:**
- Add more variants (e.g., `CardVariant.outlined`, `CardVariant.filled`)
- Add more properties (e.g., `elevation`, `shadowColor`)
- Write tests (see [11-debugging-guide.md](11-debugging-guide.md))
- Submit a PR (see [14-contributing.md](14-contributing.md))

**Want to add a custom style instead?**

➡️ **See:** [10-adding-new-style.md](10-adding-new-style.md) - Create a custom design style

**Want to understand how generators work internally?**

➡️ **See:** [07-generator-deep-dive.md](07-generator-deep-dive.md) - Generator internals
