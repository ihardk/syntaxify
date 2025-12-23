# Node Reference

> Complete AST Node Reference for Syntaxify UI Compiler
> Includes all Priority Tiers (P0-P3) with strict Enum typing.

---

## 1. Enums

```dart
// Layout
enum MainAxisAlignment { start, center, end, spaceBetween, spaceAround, spaceEvenly }
enum CrossAxisAlignment { start, center, end, stretch }
enum StackAlignment { topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight }
enum Axis { horizontal, vertical }
enum WrapAlignment { start, center, end }
enum FlexFit { loose, tight }

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
enum ProgressVariant { linear, circular }
enum BadgeSemantic { error, info, success }
enum SnackbarSemantic { info, success, warning, error }
```

---

## 2. Priority Tiers

| Tier   | Nodes                                                                                            | Stage     |
| ------ | ------------------------------------------------------------------------------------------------ | --------- |
| **P0** | ScreenDefinition, ColumnNode, RowNode, TextNode, ButtonNode, TextFieldNode, IconNode, SpacerNode | Stage 2-3 |
| **P1** | StackNode, ListNode, CardNode, ContainerNode, ImageNode, ToggleNode, CheckboxNode, AppBarNode    | Stage 3   |
| **P2** | GridNode, RadioGroupNode, SelectNode, SliderNode, ChipGroupNode, BadgeNode, ProgressNode         | Stage 4   |
| **P3** | DialogNode, BottomSheetNode, SnackbarNode, TabBarNode, AccordionNode                             | Future    |

---

## 3. Base Node

```dart
abstract class App {
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
  final App layout;
  final AppBarNode? appBar;
  final String? padding;      // Token
}
```

### AppBarNode [P1]

```dart
class AppBarNode extends App {
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
class ColumnNode extends App {
  final List<App> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing; // Token
}
```

### RowNode [P0]

```dart
class RowNode extends App {
  final List<App> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? spacing;
}
```

### StackNode [P1]

```dart
class StackNode extends App {
  final List<App> children;
  final StackAlignment? alignment;
}
```

### ListNode [P1]

```dart
class ListNode extends App {
  final App itemTemplate;
  final String itemsBinding;
  final Axis? direction;
  final String? spacing;
  final App? emptyState;
}
```

### GridNode [P2]

```dart
class GridNode extends App {
  final App itemTemplate;
  final String itemsBinding;
  final int crossAxisCount;
  final String? spacing;
}
```

### ScrollNode [P1]

```dart
class ScrollNode extends App {
  final App child;
  final Axis? direction;
}
```

### ExpandedNode [P1]

```dart
class ExpandedNode extends App {
  final App child;
  final int? flex;
}
```

### CenterNode [P1]

```dart
class CenterNode extends App {
  final App child;
}
```

---

## 6. Primitive Nodes

### TextNode [P0]

```dart
class TextNode extends App {
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
}
```

### ButtonNode [P0]

```dart
class ButtonNode extends App {
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
class IconButtonNode extends App {
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
class TextFieldNode extends App {
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
class IconNode extends App {
  final String name;
  final IconSize? size;
  final ColorSemantic? semantic;
}
```

### ImageNode [P1]

```dart
class ImageNode extends App {
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
class SpacerNode extends App {
  final SpacerSize? size;
  final int? flex;
}
```

### DividerNode [P1]

```dart
class DividerNode extends App {
  final Axis? direction;
}
```

### ToggleNode [P1]

```dart
class ToggleNode extends App {
  final String binding;
  final String? onChanged;
  final String? label;
  final bool? isDisabled;
}
```

### CheckboxNode [P1]

```dart
class CheckboxNode extends App {
  final String binding;
  final String? onChanged;
  final String? label;
  final bool? isDisabled;
}
```

### RadioGroupNode [P2]

```dart
class RadioGroupNode extends App {
  final String binding;
  final List<RadioOption> options;
  final Axis? direction;
  final String? label;
  final String? onChanged;
}

class RadioOption {
  final String value;
  final String label;
}
```

### SelectNode [P2]

```dart
class SelectNode extends App {
  final String binding;
  final List<SelectOption> options;
  final String? label;
  final String? hint;
  final String? onChanged;
  final String? errorText;
}

class SelectOption {
  final String value;
  final String label;
}
```

### SliderNode [P2]

```dart
class SliderNode extends App {
  final String binding;
  final double min;
  final double max;
  final double? step;
  final String? label;
  final String? onChanged;
}
```

### DatePickerNode [P2]

```dart
class DatePickerNode extends App {
  final String binding;
  final String? label;
  final String? hint;
  final String? onChanged;
}
```

### ChipGroupNode [P2]

```dart
class ChipGroupNode extends App {
  final String binding;
  final List<ChipOption> options;
  final bool? multiSelect;
  final String? onChanged;
}

class ChipOption {
  final String value;
  final String label;
}
```

### BadgeNode [P2]

```dart
class BadgeNode extends App {
  final App child;
  final String? count;
  final BadgeSemantic? semantic;
}
```

### ProgressNode [P2]

```dart
class ProgressNode extends App {
  final String? value;
  final ProgressVariant? variant;
  final String? size;
  final bool? indeterminate;
}
```

### AvatarNode [P2]

```dart
class AvatarNode extends App {
  final String? imageSource;
  final String? initials;
  final String? size;
  final String? onPressed;
}
```

---

## 7. Container Nodes

### CardNode [P1]

```dart
class CardNode extends App {
  final App child;
  final CardVariant? variant;
  final String? onPressed;
  final String? padding;
}
```

### ContainerNode [P1]

```dart
class ContainerNode extends App {
  final App child;
  final String? padding;
  final String? margin;
  final ContainerSemantic? semantic;
}
```

### ExpansionNode [P2]

```dart
class ExpansionNode extends App {
  final App header;
  final App content;
  final String? expandedBinding;
  final bool? initiallyExpanded;
}
```

### TabBarNode [P3]

```dart
class TabBarNode extends App {
  final String binding;
  final List<TabItem> tabs;
  final String? onChanged;
}

class TabItem {
  final String label;
  final String? icon;
  final App content;
}
```

### DialogNode [P3]

```dart
class DialogNode extends App {
  final App content;
  final String? title;
  final String? visibleBinding;
  final List<DialogAction>? actions;
  final bool? isDismissible;
}

class DialogAction {
  final String label;
  final String onPressed;
  final ButtonVariant? variant;
}
```

### BottomSheetNode [P3]

```dart
class BottomSheetNode extends App {
  final App content;
  final String? visibleBinding;
}
```

### SnackbarNode [P3]

```dart
class SnackbarNode extends App {
  final String message;
  final String? actionLabel;
  final String? onAction;
  final SnackbarSemantic? semantic;
}
```

---

## 8. Gesture Nodes

### TappableNode [P1]

```dart
class TappableNode extends App {
  final App child;
  final String onPressed;
}
```

---

## 9. Conditional Nodes

### ConditionalNode [P1]

```dart
class ConditionalNode extends App {
  final String condition;
  final App whenTrue;
  final App? whenFalse;
}
```
