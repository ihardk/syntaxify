# Design System Architecture

Understanding Syntaxify's renderer pattern and how to create custom design styles.

## The Renderer Pattern

Syntaxify uses a unique **renderer pattern** that separates concerns:

### WHAT (Component Definition)

```dart
AppButton.primary(
  label: 'Click Me',
  onPressed: () => print('Hello!'),
)
```

This defines **what** you want - a primary button with a label and action.

### HOW (Style Rendering)

The **same component** renders differently based on the active `AppTheme`:

| Style              | Renders As                                   |
| ------------------ | -------------------------------------------- |
| **MaterialStyle**  | `ElevatedButton` with Material Design tokens |
| **CupertinoStyle** | `CupertinoButton` with iOS styling           |
| **NeoStyle**       | Custom neumorphic design                     |

### Switching Styles

```dart
AppTheme(
  style: MaterialStyle(),  // or CupertinoStyle() or NeoStyle()
  child: MaterialApp(home: YourApp()),
)
```

**Change one line → entire app switches design!**

---

## Why This Matters

1. **Write Once, Render Anywhere** - One component definition works across all design systems
2. **Easy Theme Switching** - Change one line to switch your entire app's design
3. **Consistent Behavior** - Button logic stays the same, only visuals change
4. **Custom Styles** - Create your own design system by implementing `DesignStyle`

---

## Real-World Impact

### Before Syntaxify

```dart
// You write this for EVERY button
Widget buildButton() {
  if (Platform.isIOS) {
    return CupertinoButton(onPressed: onPressed, child: Text(label));
  } else if (useCustom) {
    return CustomButton(onPressed: onPressed, label: label);
  } else {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
```

**Problem:** 3 implementations × 100 buttons = 300 code paths to maintain.

### After Syntaxify

```dart
AppButton.primary(label: 'Submit', onPressed: handleSubmit)
```

**One line. Three styles. Zero duplication.**

---

## Creating Custom Design Styles

Implement the `DesignStyle` interface to create your own design system:

```dart
class MyCustomStyle extends DesignStyle
    with MaterialButtonRenderer, MaterialInputRenderer {
  
  @override
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomStyledButton(
      label: label,
      onPressed: onPressed,
      // Your custom styling
    );
  }
}
```

### Using Your Custom Style

```dart
AppTheme(
  style: MyCustomStyle(),
  child: MyApp(),
)
```

---

## Creating Custom Components (NEW in v0.2.0)

You can create **any custom component** that fully integrates with the design system.

### Step 1: Define the Meta

Create `meta/profile_card.meta.dart`:

```dart
@SyntaxComponent(
  name: 'ProfileCard',
  description: 'A card showing user profile info',
  variants: ['compact', 'expanded'],
)
class ProfileCardMeta {
  final String userName;     // Required (non-nullable)
  final String? avatarUrl;   // Optional (nullable)
  final Widget? trailing;    // Optional child widget
}
```

### Step 2: Build

```bash
dart run syntaxify build
```

This generates:
- `lib/syntaxify/generated/components/app_profile_card.dart` - The widget
- `lib/syntaxify/design_system/components/profile_card/material_renderer.dart` - Stub renderer
- Updates `DesignStyle` with `Widget renderProfileCard(...)`

### Step 3: Implement the Renderer (Optional)

The generated stub works out of the box with placeholder UI. To customize:

```dart
// lib/syntaxify/design_system/components/profile_card/material_renderer.dart
mixin MaterialProfileCardRenderer on DesignStyle {
  @override
  Widget renderProfileCard({
    required String userName,
    String? avatarUrl,
    Widget? trailing,
    ProfileCardVariant variant = ProfileCardVariant.compact,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null),
        title: Text(userName),
        trailing: trailing,
      ),
    );
  }
}
```

### Step 4: Use It

```dart
AppProfileCard(
  userName: 'Hardik',
  avatarUrl: 'https://...',
)
// or with variant convenience constructors:
AppProfileCard.compact(userName: 'Hardik')
AppProfileCard.expanded(userName: 'Hardik')
```

**Your custom component now renders with Material, Cupertino, or Neo style automatically!**

---

## Design Tokens

Syntaxify uses design tokens for consistent styling across components.

### Button Tokens

Located in `lib/syntaxify/design_system/tokens/button_tokens.dart`:

- Colors (primary, secondary, surface)
- Padding and spacing
- Border radius
- Typography

### Input Tokens

Located in `lib/syntaxify/design_system/tokens/input_tokens.dart`:

- Border colors and widths
- Focus states
- Error states
- Hint text styling

### Customizing Tokens

Edit the token files to customize the design system without creating a new style:

```dart
// button_tokens.dart
class ButtonTokens {
  static const primaryColor = Color(0xFF6200EE);
  static const borderRadius = 12.0;
  static const padding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);
}
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Your Application                      │
├─────────────────────────────────────────────────────────┤
│  AppTheme(style: MaterialStyle())                       │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  AppButton   │  │   AppText    │  │   AppInput   │  │
│  │  (Component) │  │  (Component) │  │  (Component) │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  │
│         │                 │                 │           │
│         ▼                 ▼                 ▼           │
│  ┌─────────────────────────────────────────────────┐   │
│  │              DesignStyle (Interface)             │   │
│  │  - renderButton()                                │   │
│  │  - renderText()                                  │   │
│  │  - renderInput()                                 │   │
│  └─────────────────────────────────────────────────┘   │
│         │                 │                 │           │
│         ▼                 ▼                 ▼           │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐    │
│  │ Material  │     │ Cupertino │     │    Neo    │    │
│  │  Style    │     │   Style   │     │   Style   │    │
│  └───────────┘     └───────────┘     └───────────┘    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## See Also

- [API Reference](api-reference.md) - Component usage
- [Getting Started](getting_started.md) - Quick setup guide
- [Developer Manual](developer_manual.md) - Contributing & architecture
