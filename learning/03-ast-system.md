# The LayoutNode System 📝

**Understanding how screen definitions work**

Syntaxify uses a tree structure called LayoutNode to represent UI layouts. This document explains what that means and how to use it.

> **Note:** LayoutNode was previously called AstNode (Abstract Syntax Tree Node). We renamed it in v0.1.0-alpha.8 to make the API more approachable for developers unfamiliar with compiler terminology.

---

## What is a LayoutNode? 🤔

**LayoutNode = A node in your UI layout tree**

It's a tree structure that represents your UI layout **before** it becomes actual Flutter widgets. Think of it as the blueprint for your UI.

### Analogy: Recipe vs Meal

```
Recipe (LayoutNode)       →        Meal (Widgets)
─────────────────────────          ──────────────────────
"Column:                           Column(
  - Text 'Hello'                     children: [
  - Button 'Submit'                    Text('Hello'),
"                                      ElevatedButton(...),
                                     ]
                                   )
```

**The Recipe (LayoutNode):**
- Describes WHAT you want
- Platform-independent
- Simple data structure
- Can be stored, modified, analyzed

**The Meal (Widgets):**
- Actual Flutter widgets
- Rendered on screen
- Style-dependent (Material, Cupertino, etc.)

---

## Why Use LayoutNode?

### Problem Without LayoutNode

Directly write Flutter code:

```dart
// Locked to Material Design!
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Hello', style: TextStyle(fontSize: 24)),
      ElevatedButton(
        onPressed: handleSubmit,
        child: Text('Submit'),
      ),
    ],
  );
}
```

**Issues:**
- ❌ Hardcoded to Material widgets
- ❌ Can't switch styles easily
- ❌ Repetitive code for similar screens
- ❌ Hard to analyze or modify

### Solution With LayoutNode

Define structure separately:

```dart
// Platform-independent description!
final layout = LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Hello', variant: TextVariant.headlineMedium),
    LayoutNode.button(label: 'Submit', onPressed: 'handleSubmit'),
  ],
);
```

**Benefits:**
- ✅ No mention of Material or Cupertino
- ✅ Can switch styles easily
- ✅ Can generate from this definition
- ✅ Can analyze or transform

---

## LayoutNode Types

Syntaxify has these layout node types:

```dart
// lib/src/models/layout_node.dart
@freezed
sealed class LayoutNode with _$LayoutNode {
  // Layout nodes
  const factory LayoutNode.column({...}) = ColumnNode;
  const factory LayoutNode.row({...}) = RowNode;

  // UI component nodes
  const factory LayoutNode.text({...}) = TextNode;
  const factory LayoutNode.button({...}) = ButtonNode;
  const factory LayoutNode.textField({...}) = TextFieldNode;
  const factory LayoutNode.appBar({...}) = AppBarNode;
  const factory LayoutNode.image({...}) = ImageNode;
  const factory LayoutNode.spacer({...}) = SpacerNode;

  // More node types can be added...
}
```

Each node type has specific properties.

---

## Node Details

### ColumnNode

Vertical layout (like Flutter's `Column`).

```dart
LayoutNode.column({
  List<LayoutNode> children = const [],
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
})
```

**Example:**
```dart
LayoutNode.column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    LayoutNode.text(text: 'Title'),
    LayoutNode.text(text: 'Subtitle'),
  ],
)
```

**Becomes:**
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    AppText(text: 'Title'),
    AppText(text: 'Subtitle'),
  ],
)
```

### RowNode

Horizontal layout (like Flutter's `Row`).

```dart
LayoutNode.row({
  List<LayoutNode> children = const [],
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
})
```

**Example:**
```dart
LayoutNode.row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    LayoutNode.text(text: 'Left'),
    LayoutNode.text(text: 'Right'),
  ],
)
```

### TextNode

Displays text.

```dart
LayoutNode.text({
  required String text,
  TextVariant? variant,
  TextAlign? align,
  int? maxLines,
  TextOverflow? overflow,
})
```

**Text Variants:**
```dart
enum TextVariant {
  displayLarge,      // Huge text (57px in Material)
  headlineMedium,    // Big heading (28px in Material)
  titleMedium,       // Medium title (16px in Material)
  bodyLarge,         // Large body text (16px in Material)
  bodyMedium,        // Regular body text (14px in Material)
  labelSmall,        // Small label (11px in Material)
}
```

**Example:**
```dart
LayoutNode.text(
  text: 'Welcome Back!',
  variant: TextVariant.headlineMedium,
  align: TextAlign.center,
)
```

### ButtonNode

Clickable button.

```dart
LayoutNode.button({
  required String label,
  String? onPressed,     // Callback name
  ButtonVariant? variant,
})
```

**Button Variants:**
```dart
enum ButtonVariant {
  primary,      // Main action button
  secondary,    // Secondary action button
  text,         // Text-only button
}
```

**Example:**
```dart
LayoutNode.button(
  label: 'Sign In',
  onPressed: 'handleLogin',
  variant: ButtonVariant.primary,
)
```

**Note:** `onPressed` is a **string** (callback name), not a function! The generated screen will have a parameter for this callback.

### TextFieldNode

Text input field.

```dart
LayoutNode.textField({
  required String label,
  String? placeholder,
  bool obscureText = false,
  KeyboardType? keyboardType,
  String? onChanged,
})
```

**Keyboard Types:**
```dart
enum KeyboardType {
  text,
  email,
  number,
  phone,
  url,
}
```

**Example:**
```dart
LayoutNode.textField(
  label: 'Email',
  placeholder: 'you@example.com',
  keyboardType: KeyboardType.email,
)
```

### AppBarNode

Top app bar.

```dart
LayoutNode.appBar({
  required String title,
  List<AppBarAction>? actions,
})
```

**Example:**
```dart
LayoutNode.appBar(
  title: 'Profile',
  actions: [
    AppBarAction(icon: 'settings', onPressed: 'handleSettings'),
  ],
)
```

### ImageNode

Display an image.

```dart
LayoutNode.image({
  required String path,
  double? width,
  double? height,
  BoxFit? fit,
})
```

**Example:**
```dart
LayoutNode.image(
  path: 'assets/logo.png',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)
```

### SpacerNode

Adds spacing.

```dart
LayoutNode.spacer({
  double? height,
  double? width,
})
```

**Example:**
```dart
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'First'),
    LayoutNode.spacer(height: 20),
    LayoutNode.text(text: 'Second'),
  ],
)
```

---

## Creating Screen Definitions

### Basic Structure

```dart
// meta/my_screen.screen.dart
import 'package:syntaxify/syntaxify.dart';

final myScreen = ScreenDefinition(
  id: 'my_screen',              // Unique ID
  appBar: LayoutNode.appBar(...),  // Optional app bar
  layout: LayoutNode.column(...),  // Root layout node
);
```

### Example: Login Screen

```dart
// meta/login.screen.dart
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: LayoutNode.appBar(title: 'Login'),
  layout: LayoutNode.column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      LayoutNode.text(
        text: 'Welcome Back!',
        variant: TextVariant.headlineMedium,
      ),
      LayoutNode.spacer(height: 32),
      LayoutNode.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      LayoutNode.spacer(height: 16),
      LayoutNode.textField(
        label: 'Password',
        obscureText: true,
      ),
      LayoutNode.spacer(height: 32),
      LayoutNode.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
```

### What Gets Generated

```bash
$ dart run syntaxify build
✓ Generated lib/screens/login_screen.dart
```

```dart
// lib/screens/login_screen.dart (generated)
import 'package:flutter/material.dart';
import 'package:syntaxify/design_system.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.handleLogin,
  });

  final VoidCallback? handleLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: 'Welcome Back!',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 32),
          AppInput(
            label: 'Email',
            keyboardType: KeyboardType.email,
          ),
          const SizedBox(height: 16),
          AppInput(
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 32),
          AppButton(
            label: 'Sign In',
            onPressed: handleLogin,
          ),
        ],
      ),
    );
  }
}
```

**Notice:**
- `LayoutNode.column` → `Column`
- `LayoutNode.text` → `AppText`
- `LayoutNode.button` → `AppButton`
- `LayoutNode.spacer` → `SizedBox`
- `onPressed: 'handleLogin'` → Parameter `VoidCallback? handleLogin`

---

## LayoutNode Tree Visualization

### Definition

```dart
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Title'),
    LayoutNode.row(
      children: [
        LayoutNode.button(label: 'Cancel', onPressed: 'onCancel'),
        LayoutNode.button(label: 'OK', onPressed: 'onOk'),
      ],
    ),
  ],
)
```

### Tree Structure

```
ColumnNode
  ├─ TextNode (text: 'Title')
  └─ RowNode
      ├─ ButtonNode (label: 'Cancel')
      └─ ButtonNode (label: 'OK')
```

### Generated Code

```dart
Column(
  children: [
    AppText(text: 'Title'),
    Row(
      children: [
        AppButton(label: 'Cancel', onPressed: onCancel),
        AppButton(label: 'OK', onPressed: onOk),
      ],
    ),
  ],
)
```

---

## How LayoutNode Becomes Code

### The Process

```
┌─────────────────────┐
│   ScreenDefinition  │
│   (Your input)      │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│   Parser            │
│   Reads definition  │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│   AST Tree          │
│   In-memory model   │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│   Layout Emitter    │
│   Traverses tree    │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│   Code Builder      │
│   Builds Dart code  │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│   Generated File    │
│   login_screen.dart │
└─────────────────────┘
```

### Layout Emitter (The Magic)

```dart
// lib/src/emitters/layout_emitter.dart
class LayoutEmitter {
  Expression emit(LayoutNode node) {
    return node.map(
      // Column node → Column widget
      column: (n) => refer('Column').newInstance([], {
        'mainAxisAlignment': _emitAlignment(n.mainAxisAlignment),
        'children': literalList(n.children.map(emit).toList()),
      }),

      // Button node → AppButton widget
      button: (n) => refer('AppButton').newInstance([], {
        'label': literalString(n.label),
        'onPressed': refer(n.onPressed ?? 'null'),
      }),

      // Text node → AppText widget
      text: (n) => refer('AppText').newInstance([], {
        'text': literalString(n.text),
        if (n.variant != null)
          'variant': refer('TextVariant.${n.variant!.name}'),
      }),

      // ... more node types
    );
  }
}
```

**This is the key transformation!**

Each AST node type is converted to a corresponding widget using `code_builder`.

---

## Working with Callbacks

### Problem

LayoutNode nodes are **data**, not functions. How do we handle callbacks?

### Solution

Use **string references** to callback names.

**In the definition:**
```dart
LayoutNode.button(
  label: 'Submit',
  onPressed: 'handleSubmit',  // String, not function!
)
```

**Generator discovers callbacks:**
```dart
// lib/src/generators/screen_generator.dart
Set<String> _collectCallbacks(LayoutNode node) {
  final callbacks = <String>{};
  node.map(
    button: (n) {
      if (n.onPressed != null) {
        callbacks.add(n.onPressed!);
      }
    },
    // ... check other nodes
  );
  return callbacks;
}
```

**Generated class has parameters:**
```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.handleSubmit,  // Callback added as parameter!
  });

  final VoidCallback? handleSubmit;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: 'Submit',
      onPressed: handleSubmit,  // Reference the parameter
    );
  }
}
```

**Usage:**
```dart
LoginScreen(
  handleSubmit: () {
    print('Submitted!');
  },
)
```

---

## Nested Layouts

You can nest layouts as deep as you want.

### Example: Complex Layout

```dart
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Header'),
    LayoutNode.row(
      children: [
        LayoutNode.column(
          children: [
            LayoutNode.text(text: 'Left Top'),
            LayoutNode.text(text: 'Left Bottom'),
          ],
        ),
        LayoutNode.column(
          children: [
            LayoutNode.text(text: 'Right Top'),
            LayoutNode.text(text: 'Right Bottom'),
          ],
        ),
      ],
    ),
    LayoutNode.button(label: 'Footer Button'),
  ],
)
```

### Tree

```
Column
  ├─ Text ('Header')
  ├─ Row
  │   ├─ Column
  │   │   ├─ Text ('Left Top')
  │   │   └─ Text ('Left Bottom')
  │   └─ Column
  │       ├─ Text ('Right Top')
  │       └─ Text ('Right Bottom')
  └─ Button ('Footer Button')
```

---

## Style Independence

The beauty of LayoutNode: **no mention of Material, Cupertino, or any style!**

```dart
// This definition works with ANY style
LayoutNode.button(label: 'Submit', onPressed: 'handleSubmit')
```

**With MaterialStyle:**
```dart
ElevatedButton(
  onPressed: handleSubmit,
  child: Text('Submit'),
)
```

**With CupertinoStyle:**
```dart
CupertinoButton.filled(
  onPressed: handleSubmit,
  child: Text('Submit'),
)
```

**With NeoStyle:**
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(...),
  ),
  child: InkWell(
    onTap: handleSubmit,
    child: Text('Submit'),
  ),
)
```

**Same LayoutNode definition, different rendering!** That's the power.

---

## Adding a New Node Type

Want to add a new UI element? Follow these steps.

### Step 1: Add to LayoutNode

```dart
// lib/src/models/layout_node.dart
@freezed
sealed class LayoutNode with _$LayoutNode {
  // ... existing nodes

  // NEW: Card node
  const factory LayoutNode.card({
    required String title,
    String? subtitle,
    List<LayoutNode>? children,
  }) = CardNode;
}
```

### Step 2: Update Emitter

```dart
// lib/src/emitters/layout_emitter.dart
Expression emit(LayoutNode node) {
  return node.map(
    // ... existing nodes

    // NEW: Handle card
    card: (n) => refer('AppCard').newInstance([], {
      'title': literalString(n.title),
      if (n.subtitle != null) 'subtitle': literalString(n.subtitle!),
      if (n.children != null)
        'children': literalList(n.children!.map(emit).toList()),
    }),
  );
}
```

### Step 3: Create Component

```dart
// meta/card.meta.dart
@SyntaxComponent(name: 'AppCard')
class CardMeta {
  final String title;
  final String? subtitle;
  final List<Widget>? children;
}
```

### Step 4: Build

```bash
$ dart run syntaxify build
✓ Generated lib/generated/components/app_card.dart
✓ Generated renderers for all styles
```

### Step 5: Use It

```dart
LayoutNode.card(
  title: 'My Card',
  subtitle: 'Subtitle text',
  children: [
    LayoutNode.text(text: 'Card content'),
  ],
)
```

---

## Best Practices

### ✅ DO

**Use semantic variants:**
```dart
LayoutNode.text(
  text: 'Title',
  variant: TextVariant.headlineMedium,  // Good!
)
```

**Group related content:**
```dart
LayoutNode.column(
  children: [
    // Header section
    LayoutNode.text(text: 'Header'),

    // Content section
    LayoutNode.text(text: 'Content'),

    // Footer section
    LayoutNode.button(label: 'Action'),
  ],
)
```

**Use spacers for spacing:**
```dart
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'First'),
    LayoutNode.spacer(height: 16),  // Explicit spacing
    LayoutNode.text(text: 'Second'),
  ],
)
```

### ❌ DON'T

**Don't hardcode styles in LayoutNode:**
```dart
// BAD: No way to specify colors/sizes in AST
LayoutNode.text(text: 'Title')  // ✓ Good, style comes from design tokens
```

**Don't mix responsibilities:**
```dart
// BAD: Don't put business logic in LayoutNode definitions
final screen = ScreenDefinition(
  id: 'login',
  layout: someComplexFunction(),  // ✗ Bad
);

// GOOD: Keep it declarative
final screen = ScreenDefinition(
  id: 'login',
  layout: LayoutNode.column(...),  // ✓ Good
);
```

---

## Common Patterns

### Pattern 1: Form Layout

```dart
LayoutNode.column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    LayoutNode.text(text: 'Form Title', variant: TextVariant.headlineMedium),
    LayoutNode.spacer(height: 24),
    LayoutNode.textField(label: 'Field 1'),
    LayoutNode.spacer(height: 16),
    LayoutNode.textField(label: 'Field 2'),
    LayoutNode.spacer(height: 16),
    LayoutNode.textField(label: 'Field 3'),
    LayoutNode.spacer(height: 32),
    LayoutNode.button(label: 'Submit', onPressed: 'handleSubmit'),
  ],
)
```

### Pattern 2: List Item

```dart
LayoutNode.row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    LayoutNode.column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutNode.text(text: 'Title', variant: TextVariant.titleMedium),
        LayoutNode.text(text: 'Subtitle', variant: TextVariant.bodyMedium),
      ],
    ),
    LayoutNode.button(
      label: 'Action',
      variant: ButtonVariant.text,
      onPressed: 'handleAction',
    ),
  ],
)
```

### Pattern 3: Header + Content

```dart
LayoutNode.column(
  children: [
    // Header
    LayoutNode.row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LayoutNode.text(text: 'Screen Title', variant: TextVariant.headlineMedium),
        LayoutNode.button(label: 'Settings', onPressed: 'onSettings'),
      ],
    ),
    LayoutNode.spacer(height: 24),
    // Content
    LayoutNode.text(text: 'Content goes here'),
  ],
)
```

---

## Summary

**LayoutNode = UI Layout Tree Node**
- Platform-independent UI description
- Tree structure of nodes
- Gets converted to Flutter widgets

**Node Types:**
- Layout: `column`, `row`
- UI: `text`, `button`, `textField`, `appBar`, `image`, `spacer`

**Process:**
1. Define screen with LayoutNode nodes
2. Run `dart run syntaxify build`
3. Syntaxify generates Flutter code
4. Use generated screen in your app

**Benefits:**
- ✅ Style-independent
- ✅ Declarative
- ✅ Analyzable
- ✅ Transformable
- ✅ Reusable

**Key Files:**
- `lib/src/models/layout_node.dart` - Node definitions
- `lib/src/emitters/layout_emitter.dart` - LayoutNode → code conversion
- `meta/*.screen.dart` - Your screen definitions

---

**Ready to learn how rendering works?**

➡️ **Next:** [04-renderer-pattern.md](04-renderer-pattern.md) - How styles render components

**Or jump to:**
- [09-adding-new-component.md](09-adding-new-component.md) - Practical guide
- [06-parser-deep-dive.md](06-parser-deep-dive.md) - How parsing works
