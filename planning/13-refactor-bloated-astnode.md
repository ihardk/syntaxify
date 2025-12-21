# Issue #13: Refactor Bloated LayoutNode Class

## Status: ❌ NEEDS REFACTORING (Medium-High Priority)

## Problem Analysis

**Current State:**
- **Source file:** 117 lines (`ast_node.dart`)
- **Generated file:** **1,938 lines** (`ast_node.freezed.dart`)
- **Node types:** 8 variants in single sealed class
- **Parameters:** 50+ total parameters across all variants

**What Makes It Bloated:**

### 1. Monolithic Union Type

All node types in one sealed class:
```dart
@freezed
sealed class LayoutNode with _$LayoutNode {
  const factory LayoutNode.column(...) = ColumnNode;      // 6 params
  const factory LayoutNode.row(...) = RowNode;            // 6 params
  const factory LayoutNode.text(...) = TextNode;          // 7 params
  const factory LayoutNode.button(...) = ButtonNode;      // 11 params
  const factory LayoutNode.textField(...) = TextFieldNode; // 15 params
  const factory LayoutNode.icon(...) = IconNode;          // 5 params
  const factory LayoutNode.spacer(...) = SpacerNode;      // 4 params
  const factory LayoutNode.appBar(...) = AppBarNode;      // 6 params
}
```

**Problems:**
- Every addition creates 200+ lines of generated code
- Freezed generates exhaustive pattern matching for all variants
- Type grows unbounded as more widgets are added
- All node types coupled together

### 2. Repeated Common Fields

Every node has same base fields:
```dart
String? id,           // Repeated 8 times
String? visibleWhen,  // Repeated 8 times
```

**Problem:** No inheritance or composition, just copy-paste

### 3. Too Many Optional Parameters

**TextField has 15 parameters!**
```dart
const factory LayoutNode.textField({
  String? id,
  String? visibleWhen,
  String? label,
  String? hint,
  String? helperText,
  String? binding,
  String? onChanged,
  String? onSubmitted,
  String? prefixIcon,
  String? suffixIcon,
  KeyboardType? keyboardType,
  TextInputAction? textInputAction,
  bool? obscureText,
  String? errorText,
  int? maxLines,
  int? maxLength,
  TextFieldVariant? variant,
}) = TextFieldNode;
```

**Problems:**
- Hard to remember parameter order
- Long constructor calls
- Related properties not grouped
- Unclear which params are related

### 4. Will Scale Poorly

**When adding more widgets:**
- Card, Badge, Avatar, Chip, Switch, Checkbox, Radio, Slider, etc.
- Each adds ~250 lines to freezed file
- Pattern matching becomes unwieldy
- Emitter switches become massive

**Projected growth:**
| Widgets | Freezed Lines | Parameters |
| ------- | ------------- | ---------- |
| 8 (now) | 1,938         | 50+        |
| 20      | ~5,000        | 150+       |
| 50      | ~12,000       | 400+       |

### 5. No Semantic Grouping

All nodes treated the same, but they have different roles:

- **Layout:** Column, Row
- **Primitives:** Text, Icon, Spacer
- **Interactive:** Button, TextField
- **Structural:** AppBar

**Problem:** No type hierarchy reflects these semantics

---

## Proposed Solutions

### Option 1: Hierarchical Node Types (Recommended)

Split into focused, smaller classes:

```dart
// Base node with common properties
@freezed
sealed class LayoutNode with _$LayoutNode {
  const factory LayoutNode.layout(LayoutNode node) = LayoutLayoutNode;
  const factory LayoutNode.primitive(PrimitiveNode node) = PrimitiveLayoutNode;
  const factory LayoutNode.interactive(InteractiveNode node) = InteractiveLayoutNode;
}

// Layout nodes (separate file)
@freezed
sealed class LayoutNode with _$LayoutNode {
  const factory LayoutNode.column({
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) = ColumnLayout;

  const factory LayoutNode.row({
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) = RowLayout;
}

// Primitive nodes (separate file)
@freezed
sealed class PrimitiveNode with _$PrimitiveNode {
  const factory PrimitiveNode.text({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) = TextPrimitive;

  const factory PrimitiveNode.icon({
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) = IconPrimitive;

  const factory PrimitiveNode.spacer({
    SpacerSize? size,
    int? flex,
  }) = SpacerPrimitive;
}

// Interactive nodes (separate file)
@freezed
sealed class InteractiveNode with _$InteractiveNode {
  const factory InteractiveNode.button({
    required String label,
    String? onPressed,
    ButtonProps? props,
  }) = ButtonInteractive;

  const factory InteractiveNode.textField({
    String? label,
    TextFieldProps? props,
  }) = TextFieldInteractive;
}
```

**Benefits:**
- ✅ Smaller files (each ~400 lines instead of 1,938)
- ✅ Semantic grouping
- ✅ Easier to add new widgets (only modify relevant file)
- ✅ Common properties handled at top level

**Drawbacks:**
- ❌ More files to manage
- ❌ Breaking change (migration needed)
- ❌ Nested pattern matching: `node.when(layout: (l) => l.when(...))`

---

### Option 2: Props Objects

Group related parameters:

```dart
@freezed
class ButtonProps with _$ButtonProps {
  const factory ButtonProps({
    ButtonVariant? variant,
    ButtonSize? size,
    String? icon,
    IconPosition? iconPosition,
    @Default(false) bool isLoading,
    @Default(false) bool isDisabled,
    @Default(false) bool fullWidth,
  }) = _ButtonProps;
}

@freezed
sealed class LayoutNode with _$LayoutNode {
  const factory LayoutNode.button({
    String? id,
    String? visibleWhen,
    required String label,
    String? onPressed,
    ButtonProps? props,
  }) = ButtonNode;
}
```

**Benefits:**
- ✅ Fewer constructor parameters
- ✅ Related props grouped
- ✅ Easier to extend (add to props object)
- ✅ Partial breaking change (can keep old constructors)

**Drawbacks:**
- ❌ More verbose: `LayoutNode.button(label: 'X', props: ButtonProps(variant: ...))`
- ❌ Adds indirection

---

### Option 3: Builder Pattern

Fluent API for complex nodes:

```dart
// Simple nodes - direct construction
LayoutNode.text(text: 'Hello');

// Complex nodes - builder
LayoutNode.button('Click Me')
  .onPressed('handleClick')
  .variant(ButtonVariant.primary)
  .icon('arrow_forward')
  .loading(true)
  .build();

// Implementation
class ButtonBuilder {
  String _label;
  String? _onPressed;
  ButtonVariant _variant = ButtonVariant.primary;
  bool _isLoading = false;

  ButtonBuilder(this._label);

  ButtonBuilder onPressed(String callback) {
    _onPressed = callback;
    return this;
  }

  ButtonBuilder variant(ButtonVariant v) {
    _variant = v;
    return this;
  }

  ButtonBuilder loading(bool loading) {
    _isLoading = loading;
    return this;
  }

  ButtonNode build() {
    return ButtonNode(
      label: _label,
      onPressed: _onPressed,
      variant: _variant,
      isLoading: _isLoading,
    );
  }
}

// Extension on LayoutNode
extension LayoutNodeBuilders on LayoutNode {
  static ButtonBuilder button(String label) => ButtonBuilder(label);
}
```

**Benefits:**
- ✅ Fluent, readable API
- ✅ Optional parameters without bloat
- ✅ Can provide smart defaults
- ✅ Chainable

**Drawbacks:**
- ❌ More code to maintain
- ❌ Loses const constructors
- ❌ Doesn't reduce freezed file size

---

### Option 4: Separate Files + Common Base

**File structure:**
```
lib/src/models/ast/
├── ast_node.dart              # Base sealed class (tiny)
├── common/
│   └── node_metadata.dart     # Common id, visibleWhen
├── layout/
│   ├── column_node.dart
│   └── row_node.dart
├── primitive/
│   ├── text_node.dart
│   ├── icon_node.dart
│   └── spacer_node.dart
├── interactive/
│   ├── button_node.dart
│   └── text_field_node.dart
└── structural/
    └── app_bar_node.dart
```

**ast_node.dart (base):**
```dart
@freezed
sealed class AstNode with _$AstNode {
  // Reference to separate files
  const factory AstNode.column(ColumnNode node) = _ColumnAstNode;
  const factory AstNode.row(RowNode node) = _RowAstNode;
  const factory AstNode.text(TextNode node) = _TextAstNode;
  const factory AstNode.button(ButtonNode node) = _ButtonAstNode;
  const factory AstNode.textField(TextFieldNode node) = _TextFieldAstNode;
  // etc.
}
```

**button_node.dart:**
```dart
@freezed
class ButtonNode with _$ButtonNode {
  const factory ButtonNode({
    required String label,
    String? onPressed,
    ButtonVariant? variant,
    ButtonSize? size,
    // ... etc
  }) = _ButtonNode;
}
```

**Benefits:**
- ✅ Organized file structure
- ✅ Each node in own file
- ✅ Easier to find specific nodes
- ✅ Can still use `AstNode.button(...)`

**Drawbacks:**
- ❌ Still generates large freezed file
- ❌ Many imports needed

---

## Recommended Approach

**Combination: Option 1 + Option 2**

1. **Hierarchical types** for semantic grouping
2. **Props objects** for complex nodes (button, textField)
3. **Separate files** for organization

### New Structure

```
lib/src/models/ast/
├── ast_node.dart                    # Top-level union (3 variants)
├── common/
│   ├── node_metadata.dart           # id, visibleWhen mixin
│   └── node_props.dart              # ButtonProps, TextFieldProps
├── layout/
│   └── layout_node.dart             # LayoutNode union (column, row)
├── primitive/
│   └── primitive_node.dart          # PrimitiveNode union (text, icon, spacer)
└── interactive/
    └── interactive_node.dart        # InteractiveNode union (button, textField)
```

### Implementation

**ast_node.dart (12 lines):**
```dart
@freezed
sealed class AstNode with _$AstNode, NodeMetadata {
  const factory AstNode.layout(LayoutNode node, NodeMetadata meta) = LayoutAstNode;
  const factory AstNode.primitive(PrimitiveNode node, NodeMetadata meta) = PrimitiveAstNode;
  const factory AstNode.interactive(InteractiveNode node, NodeMetadata meta) = InteractiveAstNode;
}

// Mixin for common fields
mixin NodeMetadata {
  String? get id;
  String? get visibleWhen;
}
```

**layout_node.dart (~30 lines):**
```dart
@freezed
sealed class LayoutNode with _$LayoutNode {
  const factory LayoutNode.column({
    required List<AstNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = ColumnLayout;

  const factory LayoutNode.row({
    required List<AstNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = RowLayout;
}
```

**interactive_node.dart (~40 lines):**
```dart
@freezed
class ButtonProps with _$ButtonProps {
  const factory ButtonProps({
    ButtonVariant? variant,
    ButtonSize? size,
    String? icon,
    IconPosition? iconPosition,
    @Default(false) bool isLoading,
    @Default(false) bool isDisabled,
    @Default(false) bool fullWidth,
  }) = _ButtonProps;
}

@freezed
sealed class InteractiveNode with _$InteractiveNode {
  const factory InteractiveNode.button({
    required String label,
    String? onPressed,
    ButtonProps? props,
  }) = ButtonInteractive;

  const factory InteractiveNode.textField({
    String? label,
    TextFieldProps? props,
  }) = TextFieldInteractive;
}
```

### Usage Comparison

**Before (bloated):**
```dart
AstNode.button(
  id: 'submit-btn',
  visibleWhen: 'isLoggedIn',
  label: 'Submit',
  onPressed: 'handleSubmit',
  variant: ButtonVariant.primary,
  size: ButtonSize.large,
  icon: 'arrow_forward',
  iconPosition: IconPosition.end,
  isLoading: false,
  isDisabled: false,
  fullWidth: true,
);
```

**After (clean):**
```dart
AstNode.interactive(
  InteractiveNode.button(
    label: 'Submit',
    onPressed: 'handleSubmit',
    props: ButtonProps(
      variant: ButtonVariant.primary,
      size: ButtonSize.large,
      icon: 'arrow_forward',
      fullWidth: true,
    ),
  ),
  NodeMetadata(
    id: 'submit-btn',
    visibleWhen: 'isLoggedIn',
  ),
);
```

**Or with extension methods:**
```dart
InteractiveNode.button(
  label: 'Submit',
  onPressed: 'handleSubmit',
  props: ButtonProps(variant: ButtonVariant.primary),
).withId('submit-btn').toAstNode();
```

---

## Migration Strategy

### Phase 1: Add New Structure (Non-Breaking)

1. Create new node classes alongside existing
2. Add factory methods that delegate to old structure
3. Update generators to support both

```dart
// New API
AstNode.layout(LayoutNode.column(...));

// Internally delegates to old API
AstNode.column(...);
```

### Phase 2: Deprecate Old API

```dart
@Deprecated('Use AstNode.layout(LayoutNode.column(...)) instead')
const factory AstNode.column(...);
```

### Phase 3: Remove Old API (Breaking)

Remove deprecated constructors in next major version.

---

## Benefits Summary

### Maintainability
- ✅ Smaller files (~400 lines each vs 1,938)
- ✅ Easier to navigate
- ✅ Related code together

### Scalability
- ✅ Adding new widgets doesn't bloat one file
- ✅ Clear where to add new node types
- ✅ Freezed generation faster (smaller unions)

### Type Safety
- ✅ Semantic grouping enforced by types
- ✅ Can't put interactive node where layout expected
- ✅ Better IDE autocomplete

### Code Quality
- ✅ Related properties grouped (ButtonProps)
- ✅ Common properties abstracted (NodeMetadata)
- ✅ Separation of concerns

---

## Implementation Effort

### Phase 1: New Structure (15-20 hours)
- Create hierarchical node types
- Create props objects
- Split into separate files
- Update emitters to work with new structure
- Add backward compatibility

### Phase 2: Migration (5-8 hours)
- Update all example screens
- Add deprecation warnings
- Update documentation
- Create migration guide

### Phase 3: Cleanup (2-3 hours)
- Remove old API
- Clean up tests
- Final documentation

**Total: 22-31 hours**

---

## Comparison: Before vs After

| Metric          | Before       | After        | Improvement         |
| --------------- | ------------ | ------------ | ------------------- |
| Lines (freezed) | 1,938        | ~600         | 69% reduction       |
| Files           | 1            | 6            | Better organization |
| Largest union   | 8 variants   | 3 variants   | 62% smaller         |
| Max params      | 15           | 5 + props    | 67% fewer           |
| Add new widget  | Touch 1 file | Touch 1 file | Same                |
| Generated code  | 1,938 lines  | ~600 lines   | 69% less            |

---

## Alternative: Keep Current, Add Helpers

If full refactor is too much, consider lightweight improvements:

### 1. Add Extension Methods

```dart
extension AstNodeExtensions on AstNode {
  AstNode withId(String id) {
    return map(
      column: (n) => n.copyWith(id: id),
      button: (n) => n.copyWith(id: id),
      // etc.
    );
  }

  AstNode when(String condition) {
    return map(
      column: (n) => n.copyWith(visibleWhen: condition),
      button: (n) => n.copyWith(visibleWhen: condition),
      // etc.
    );
  }
}

// Usage
AstNode.button(label: 'Submit')
  .withId('submit-btn')
  .when('isLoggedIn');
```

### 2. Add Named Constructor Groups

```dart
extension ButtonConstructors on AstNode {
  static AstNode primaryButton(String label, String onPressed) {
    return AstNode.button(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.primary,
    );
  }

  static AstNode loadingButton(String label) {
    return AstNode.button(
      label: label,
      isLoading: true,
      isDisabled: true,
    );
  }
}

// Usage
AstNode.primaryButton('Submit', 'handleSubmit');
```

**Effort:** 3-4 hours
**Benefit:** Convenience without breaking changes

---

## Conclusion

**Status:** NEEDS REFACTORING

**Priority:** Medium-High
- Not critical (current code works)
- But scales poorly (50+ widgets = unmaintainable)
- Affects future development velocity

**Recommended:** Full refactor (Option 1 + 2)
- 22-31 hours effort
- Significant long-term benefits
- Cleaner API
- Better scalability

**Alternative:** Extension methods (quick win)
- 3-4 hours
- Improves ergonomics
- Doesn't fix underlying bloat

---

## Files to Create/Modify

**New:**
1. `lib/src/models/ast/common/node_metadata.dart`
2. `lib/src/models/ast/common/node_props.dart`
3. `lib/src/models/ast/layout/layout_node.dart`
4. `lib/src/models/ast/primitive/primitive_node.dart`
5. `lib/src/models/ast/interactive/interactive_node.dart`
6. `docs/migration-guide-ast-refactor.md`

**Modified:**
7. `lib/src/models/ast/ast_node.dart` - New structure
8. `lib/src/emitters/layout_emitter.dart` - Support new types
9. `lib/src/validation/ast_validator.dart` - Validate new structure
10. `example/meta/*.screen.dart` - Update to new API

**Deleted (eventually):**
11. Old AstNode variants
