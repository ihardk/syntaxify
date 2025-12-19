# Technical Specification

> AST Nodes for Syntaxify UI Compiler (Stage 2 & 3 Focus)
> Version: 2.1 (P0 & P1 Nodes Only)

Full reference including P2/P3 nodes: `node-reference.md`

---

## 1. Enums (Partial Subset)

```dart
// Layout
enum MainAxisAlignment { start, center, end, spaceBetween, spaceAround, spaceEvenly }
enum CrossAxisAlignment { start, center, end, stretch }
enum StackAlignment { topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight }
enum Axis { horizontal, vertical }

// Primitives
enum TextVariant { displayLarge, headlineMedium, titleMedium, bodyLarge, bodyMedium, labelSmall }
enum TextAlign { left, center, right, justify }
enum TextOverflow { clip, ellipsis, fade }

enum ButtonVariant { filled, outlined, text, elevated, filledTonal }
enum ButtonSize { sm, md, lg }
enum IconPosition { leading, trailing, only }

enum TextFieldVariant { outlined, filled }
enum KeyboardType { text, email, number, phone, url, multiline }
enum TextInputAction { done, next, search, send, go }

enum ColorSemantic { primary, secondary, tertiary, error, warning, success, info, surface, onSurface }
enum IconSize { xs, sm, md, lg, xl }

enum ImageFit { cover, contain, fill, fitWidth, fitHeight, none }

enum SpacerSize { xs, sm, md, lg, xl, flex }

// Container
enum CardVariant { elevated, outlined, filled }
enum ContainerSemantic { surface, primaryContainer, secondaryContainer }
```

---

## 2. Priority Tiers (This Document)

| Tier   | Nodes                                                                                            | Stage     |
| ------ | ------------------------------------------------------------------------------------------------ | --------- |
| **P0** | ScreenDefinition, ColumnNode, RowNode, TextNode, ButtonNode, TextFieldNode, IconNode, SpacerNode | Stage 2-3 |
| **P1** | StackNode, ListNode, CardNode, ContainerNode, ImageNode, ToggleNode, CheckboxNode, AppBarNode    | Stage 3   |

---

## 3. Base Node

```dart
abstract class AstNode {
  final String? id;           // Unique identifier
  final String? visibleWhen;  // Binding: 'isLoggedIn'
}
```

---

## 4. Screen Root [P0]

### ScreenDefinition

```dart
class ScreenDefinition {
  final String id;
  final AstNode layout;
  final AppBarNode? appBar;
  final String? padding;      // Token
}
```

### AppBarNode [P1]

```dart
class AppBarNode extends AstNode {
  final String? title;
  final String? leadingIcon;
  final String? leadingAction;
  final List<AppBarAction>? actions;
}

class AppBarAction {
  final String icon;
  final String onPressed;
  final String? tooltip;
}
```

---

## 5. Layout Nodes

### ColumnNode [P0]

```dart
class ColumnNode extends AstNode {
  final List<AstNode> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing; // Token
}
```

### RowNode [P0]

```dart
class RowNode extends AstNode {
  final List<AstNode> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing;
}
```

### StackNode [P1]

```dart
class StackNode extends AstNode {
  final List<AstNode> children;
  final StackAlignment? alignment;
}
```

### ListNode [P1]

```dart
class ListNode extends AstNode {
  final AstNode itemTemplate;
  final String itemsBinding;
  final Axis? direction;
  final String? spacing;
  final AstNode? emptyState;
}
```

### ScrollNode [P1]

```dart
class ScrollNode extends AstNode {
  final AstNode child;
  final Axis? direction;
}
```

### ExpandedNode [P1]

```dart
class ExpandedNode extends AstNode {
  final AstNode child;
  final int? flex;
}
```

### CenterNode [P1]

```dart
class CenterNode extends AstNode {
  final AstNode child;
}
```

---

## 6. Primitive Nodes

### TextNode [P0]

```dart
class TextNode extends AstNode {
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
}
```

### ButtonNode [P0]

```dart
class ButtonNode extends AstNode {
  final String label;
  final String? onPressed;
  final ButtonVariant? variant;
  final ButtonSize? size;
  final String? icon;
  final IconPosition? iconPosition;
  final bool? isLoading;
  final bool? isDisabled;
  final bool? fullWidth;
}
```

### IconButtonNode [P1]

```dart
class IconButtonNode extends AstNode {
  final String icon;
  final String? onPressed;
  final ButtonVariant? variant;
  final ButtonSize? size;
  final String? tooltip;
  final bool? isDisabled;
}
```

### TextFieldNode [P0]

```dart
class TextFieldNode extends AstNode {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? binding;
  final String? onChanged;
  final String? onSubmitted;
  final String? prefixIcon;
  final String? suffixIcon;
  final KeyboardType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final TextFieldVariant? variant;
}
```

### IconNode [P0]

```dart
class IconNode extends AstNode {
  final String name;
  final IconSize? size;
  final ColorSemantic? semantic;
}
```

### ImageNode [P1]

```dart
class ImageNode extends AstNode {
  final String source;
  final ImageFit? fit;
  final String? size;        // 'sm', 'md', 'full' (token)
  final String? aspectRatio; // '16:9'
  final String? placeholder;
  final String? alt;
}
```

### SpacerNode [P0]

```dart
class SpacerNode extends AstNode {
  final SpacerSize? size;
  final int? flex;
}
```

### DividerNode [P1]

```dart
class DividerNode extends AstNode {
  final Axis? direction;
}
```

### ToggleNode [P1]

```dart
class ToggleNode extends AstNode {
  final String binding;
  final String? onChanged;
  final String? label;
  final bool? isDisabled;
}
```

### CheckboxNode [P1]

```dart
class CheckboxNode extends AstNode {
  final String binding;
  final String? onChanged;
  final String? label;
  final bool? isDisabled;
}
```

---

## 7. Container Nodes

### CardNode [P1]

```dart
class CardNode extends AstNode {
  final AstNode child;
  final CardVariant? variant;
  final String? onPressed;
  final String? padding;
}
```

### ContainerNode [P1]

```dart
class ContainerNode extends AstNode {
  final AstNode child;
  final String? padding;
  final String? margin;
  final ContainerSemantic? semantic;
}
```

---

## 8. Gesture Nodes

### TappableNode [P1]

```dart
class TappableNode extends AstNode {
  final AstNode child;
  final String onPressed;
}
```

---

## 9. Conditional Nodes

### ConditionalNode [P1]

```dart
class ConditionalNode extends AstNode {
  final String condition;
  final AstNode whenTrue;
  final AstNode? whenFalse;
}
```

---

## 10. Conventions

- **Actions:** `action:save`, `nav:home`
- **Bindings:** `{count}`, `{user.name}`
- **Enums:** Use strongly typed enums for all static variants.
