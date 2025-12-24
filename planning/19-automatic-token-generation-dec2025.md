# Automatic Token Generation System

**Date:** December 24, 2025
**Status:** ✅ Implemented
**Related Files**: `token_generator.dart`, `design_system_generator.dart`

## Summary

Implemented automatic token generation for all components. When a new component is created via `.meta.dart` files, the build system now automatically:
1. Generates a `*_tokens.dart` file
2. Adds token imports/exports to `design_system.dart`
3. Adds token getter methods to `DesignStyle` base class
4. Enables consistent theming across all components

## Problem

Previously, adding tokens for new components required manual steps:
1. Manually create `component_tokens.dart` file
2. Manually add imports to `design_system.dart`
3. Manually add exports to `design_system.dart`
4. Manually add token getter to `DesignStyle`
5. Manually implement getters in each style (Material, Cupertino, Neo)

**Result**: Inconsistent token coverage, easy to forget steps, error-prone.

## Solution: Automatic Token Generation

### Architecture

```
Component Meta (.meta.dart)
        ↓
ComponentExtractor → ComponentDefinition
        ↓
TokenGenerator → Infers token properties
        ↓
Generate *_tokens.dart file
        ↓
DesignSystemGenerator → Dynamic imports/exports
        ↓
DesignStyle with token getters
```

### Token Property Inference

The `TokenGenerator` automatically infers which component properties should become tokens:

#### Inferred as Tokens:
- **Color properties**: `activeColor`, `backgroundColor`, etc.
- **Size/dimension properties**: `width`, `height`, `radius`, `spacing`, `padding`, `margin`
- **Visual effects**: `shadow`, `blur`, `opacity`, `border`, `elevation`
- **Explicit types**: `BoxShadow`, `EdgeInsets`, `Border`, `Color`

#### Excluded from Tokens:
- **Callbacks**: `VoidCallback`, `ValueChanged`, `onPressed`, `onChanged`
- **State**: `value`, `enabled`, `controller`, `label`, `text`
- **Configuration**: `min`, `max`, `divisions`, `keyboardType`

### Example: Checkbox Component

**Input** (`checkbox.meta.dart`):
```dart
@SyntaxComponent()
class CheckboxMeta {
  final bool value;                  // ❌ State (not a token)
  final ValueChanged<bool>? onChanged; // ❌ Callback (not a token)
  final Color? activeColor;          // ✅ Token!
  final Color? checkColor;           // ✅ Token!
  final double borderWidth;          // ✅ Token!
  final double borderRadius;         // ✅ Token!
}
```

**Generated** (`checkbox_tokens.dart`):
```dart
/// Design tokens for the Checkbox component
class CheckboxTokens {
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color? inactiveColor;
  final BoxShadow? shadow;

  const CheckboxTokens({
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.borderWidth,
    this.borderRadius = 4.0,
    this.inactiveColor,
    this.shadow,
  });
}
```

**Generated in `DesignStyle`**:
```dart
sealed class DesignStyle {
  /// Get tokens for Checkbox component
  CheckboxTokens get checkboxTokens;

  /// Render a checkbox widget
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });
}
```

**Implementation in `MaterialCheckboxRenderer`**:
```dart
mixin MaterialCheckboxRenderer on DesignStyle {
  @override
  CheckboxTokens get checkboxTokens => const CheckboxTokens(
    activeColor: Colors.blue,
    checkColor: Colors.white,
    borderColor: Colors.grey,
    borderWidth: 2.0,
    borderRadius: 4.0,
  );

  @override
  Widget renderCheckbox(...) {
    final tokens = checkboxTokens;
    return Checkbox(
      activeColor: tokens.activeColor,
      checkColor: tokens.checkColor,
      // ... use all token values
    );
  }
}
```

## Implementation Details

### 1. TokenGenerator Class

**Location**: `lib/src/generators/token_generator.dart`

**Key Methods**:
- `generate(ComponentDefinition)`: Generates token file or returns null if no tokens needed
- `_inferTokenProperties()`: Analyzes component properties to determine tokens
- `_isTokenProperty()`: Checks if a property should be a token
- `_inferTokenType()`: Infers proper Dart type (Color, BoxShadow, double, etc.)

**Smart Type Inference**:
```dart
// If property name contains "color" → Color
// If property name contains "shadow" → BoxShadow?
// If property name contains "padding" → EdgeInsets?
// If property name contains "border" → Border?
// Otherwise for size/dimension → double
```

### 2. DesignSystemGenerator Updates

**Location**: `lib/src/generators/design_system_generator.dart`

**Changes**:
1. **Dynamic Token Imports** (lines 47-55):
   ```dart
   // Before: Hardcoded button/input/text tokens
   // After: Loop through ALL components
   for (final comp in components) {
     final tokenFileName = '${toSnakeCase(baseName)}_tokens.dart';
     buffer.writeln("import 'tokens/$tokenFileName';");
   }
   ```

2. **Dynamic Token Exports** (lines 71-77):
   ```dart
   for (final comp in components) {
     final tokenFileName = '${toSnakeCase(baseName)}_tokens.dart';
     buffer.writeln("export 'tokens/$tokenFileName';");
   }
   ```

3. **Dynamic Token Getters** (lines 136-160):
   ```dart
   for (final comp in components) {
     final tokenMethodName = '${toLowerCase(baseName)}Tokens';

     if (comp.variants.isNotEmpty) {
       // Method with variant parameter
       c.methods.add(Method(...takes variant...));
     } else {
       // Simple getter
       c.methods.add(Method(...getter...));
     }
   }
   ```

### 3. Variant-Aware Token Methods

Components with variants get token methods that accept a variant parameter:

**With Variants** (Button, Text):
```dart
ButtonTokens buttonTokens(ButtonVariant variant);
TextTokens textTokens(TextVariant variant);
```

**Without Variants** (Checkbox, Slider, etc.):
```dart
CheckboxTokens get checkboxTokens;
SliderTokens get sliderTokens;
```

## Build Pipeline Integration

### When Component is Added

1. User creates `new_component.meta.dart`
2. `ComponentExtractor` parses meta file → `ComponentDefinition`
3. **`TokenGenerator.generate()`** analyzes properties
4. Generates `new_component_tokens.dart` (if tokens inferred)
5. **`DesignSystemGenerator`** dynamically:
   - Imports token file
   - Exports token file
   - Adds token getter to `DesignStyle`
6. Build system writes all files
7. User implements token getters in their renderers

### When Component is Removed

1. User deletes `component.meta.dart`
2. Build system regenerates `design_system.dart` (without removed component)
3. Imports/exports/getters automatically removed
4. Old token file becomes unused (can be manually deleted)

## Benefits

### 1. Zero Manual Work
```dart
// User just creates this:
@SyntaxComponent()
class SliderMeta {
  final double value;
  final Color? activeColor;
  final double trackHeight;
}

// System automatically generates:
// ✅ slider_tokens.dart
// ✅ Import/export in design_system.dart
// ✅ sliderTokens getter in DesignStyle
```

### 2. Consistency
All components follow the same token pattern automatically.

### 3. Type Safety
Generated token classes have proper types inferred from property names.

### 4. Maintainability
Adding new components doesn't require remembering manual steps.

### 5. Scalability
System works for 7 components or 700 components.

## Token Inference Rules

### Included Properties

| Pattern | Inferred Type | Example |
|---------|---------------|---------|
| `*color` or `*Color` | `Color` | activeColor, backgroundColor |
| `*width`, `*height` | `double` | borderWidth, trackHeight |
| `*radius` | `double` | borderRadius, thumbRadius |
| `*spacing`, `*padding`, `*margin` | `double` or `EdgeInsets` | padding, spacing |
| `shadow*` or `*shadow` | `BoxShadow?` | shadow, boxShadow |
| `border*` | `Border?` or `double` | border, borderWidth |
| `elevation` | `double` | elevation |

### Excluded Properties

| Type | Reason | Examples |
|------|--------|----------|
| Callbacks | Not styling | VoidCallback, ValueChanged |
| State | Not styling | value, enabled, loading |
| Content | Not styling | label, text, icon, hint |
| Controllers | Not styling | controller, focusNode |
| Config | Not styling | min, max, divisions |

## Future Enhancements

### 1. Custom Token Annotations
```dart
@SyntaxComponent()
class CustomMeta {
  @TokenProperty()  // Force include
  final String customProperty;

  @ExcludeFromTokens()  // Force exclude
  final Color nonTokenColor;
}
```

### 2. Token Validation
Validate that renderer implementations provide all required token properties.

### 3. Token Documentation Generation
Auto-generate markdown docs showing all available tokens per component.

### 4. Token Migration Tool
Help migrate existing hardcoded values to token system.

## Files Changed

### New Files (1)
- `lib/src/generators/token_generator.dart` (257 lines)

### Modified Files (2)
- `lib/src/generators/design_system_generator.dart`
  - Dynamic token imports/exports
  - Dynamic token getter generation
- `planning/19-automatic-token-generation-dec2025.md` (this file)

## Testing

### Unit Tests Needed
- `token_generator_test.dart` - Test property inference logic
- `design_system_generator_test.dart` - Test dynamic imports/exports

### Integration Tests Needed
- Create new component → Verify token file generated
- Component with variants → Verify parameterized token method
- Component with no tokenizable properties → Verify no token file

## Migration Path

### For Existing Components
1. Run `syntaxify build` to regenerate with new system
2. Existing manual token files remain compatible
3. Future components use automatic generation

### For New Projects
1. Define components in `.meta.dart` files
2. Run `syntaxify build`
3. Implement token getters in renderer mixins
4. Done!

## Key Takeaway

> **"Define the component ONCE, tokens generated AUTOMATICALLY"**

No more manual token file creation, import management, or getter declarations. The system infers visual styling properties and generates the complete token infrastructure automatically.
