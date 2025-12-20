# Issue #4: Parser Relies on Naming Conventions (Magic Strings)

## Status: ⚠️ PARTIALLY IMPLEMENTED

## Problem Description

The codebase uses "magic" string manipulation to derive component names:

**Current Code:**
```dart
final className = componentDef.className.replaceAll('Meta', '');
final generatedName = 'App$className';
```

**Problems:**
1. **Magic strings** - Hard-coded 'Meta' and 'App' prefixes
2. **Breaks if user names differently** - What if they use `ButtonSpec` instead of `ButtonMeta`?
3. **No explicit contract** - Naming is implicit, not declared
4. **Inconsistent** - Different files might compute names differently

**Proposed Solution:**
```dart
@SyntaxComponent(
  name: 'AppButton',  // Explicit output name
  description: 'A button',
)
class ButtonMeta { ... }
```

## Current State Analysis

### Files Using Magic String Replacement

**1. `lib/src/generators/component/button_generator.dart:28-30`**
```dart
bool canHandle(ComponentDefinition component) {
  final componentName =
      component.className.replaceAll('Meta', '').toLowerCase();
  return componentName == componentType;
}
```

**2. `lib/src/generators/component/text_generator.dart:28-30`**
```dart
bool canHandle(ComponentDefinition component) {
  final componentName =
      component.className.replaceAll('Meta', '').toLowerCase();
  return componentName == componentType;
}
```

**3. `lib/src/generators/component/input_generator.dart:24-26`**
```dart
bool canHandle(ComponentDefinition component) {
  final componentName =
      component.className.replaceAll('Meta', '').toLowerCase();
  return componentName == componentType;
}
```

**4. `lib/src/generators/component/generic_generator.dart:32-34`**
```dart
final componentName = component.className.replaceAll('Meta', '');
final className = 'App$componentName';
final tokenName = componentName.toLowerCase();
```

**5. `lib/src/use_cases/generate_component.dart:43-45`**
```dart
final componentName =
    component.className.replaceAll('Meta', '').toLowerCase();
final fileName = 'app_$componentName.dart';
```

**6. `lib/src/generator/widget_generator.dart` (need to check)**

## Progress Made During Initial Investigation

### ✅ Already Completed

1. **Updated `@SyntaxComponent` annotation** (`lib/src/annotations/syntax_annotations.dart`)
   ```dart
   class SyntaxComponent {
     final String? name;  // NEW: Explicit component name
     final String? description;
     const SyntaxComponent({this.name, this.description});
   }
   ```

2. **Updated `ComponentDefinition` model** (`lib/src/models/component_definition.dart`)
   ```dart
   @freezed
   sealed class ComponentDefinition with _$ComponentDefinition {
     const factory ComponentDefinition({
       required String name,
       required String className,
       String? explicitName,  // NEW: Stores @SyntaxComponent(name: '...')
       required List<ComponentProp> properties,
       required List<String> variants,
       String? description,
     }) = _ComponentDefinition;
   }
   ```

3. **Updated parser to extract explicit name** (`lib/src/parser/meta_parser.dart:99-112`)
   ```dart
   // Extract explicit name from annotation
   String? explicitName;
   final args = metaAnnotation.arguments?.arguments;
   if (args != null) {
     for (final arg in args) {
       if (arg is analyzer.NamedExpression) {
         if (arg.name.label.name == 'name') {
           if (arg.expression is analyzer.StringLiteral) {
             explicitName = (arg.expression as analyzer.StringLiteral).stringValue;
           }
         }
       }
     }
   }

   component = ComponentDefinition(
     // ...
     explicitName: explicitName,  // NEW
     // ...
   );
   ```

4. **Updated generators to use explicit name with fallback**
   - ✅ button_generator.dart
   - ✅ text_generator.dart
   - ✅ input_generator.dart
   - ✅ generic_generator.dart
   - ✅ generate_component.dart

5. **Created utility helper** (`lib/src/utils/component_naming.dart`)
   ```dart
   class ComponentNaming {
     static String getComponentName(ComponentDefinition component) {
       if (component.explicitName != null && component.explicitName!.isNotEmpty) {
         return component.explicitName!;
       }
       return component.className.replaceAll('Meta', '');  // Fallback
     }

     static String getComponentType(ComponentDefinition component) {
       final name = getComponentName(component);
       final withoutApp = name.startsWith('App') ? name.substring(3) : name;
       return withoutApp.toLowerCase();
     }
   }
   ```

## Remaining Work

### ❌ Not Yet Complete

1. **Freezed regeneration needed**
   - File: `lib/src/models/component_definition.freezed.dart`
   - Status: Not regenerated (no dart SDK available during analysis)
   - Action: Run `dart run build_runner build --delete-conflicting-outputs`

2. **Update widget_generator.dart**
   - Need to check if it uses magic strings
   - Update if needed

3. **Update any other files using the pattern**
   - Search codebase for remaining `replaceAll('Meta')`
   - Verify no other magic string patterns

4. **Update documentation**
   - Update user guide with explicit name usage
   - Add migration guide for existing code

5. **Add validation**
   - Validate explicit name is valid Dart identifier
   - Warn if using legacy naming without explicit name
   - Part of Issue #3 (AST Validation)

6. **Update example meta files**
   - Add `name: 'AppButton'` to example/meta/button.meta.dart
   - Add `name: 'AppText'` to example/meta/text.meta.dart
   - Add `name: 'AppInput'` to example/meta/input.meta.dart

## Implementation Plan

### Phase 1: Complete Core Implementation (2-3 hours)

1. **Regenerate Freezed Files**
   ```bash
   cd generator
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Check widget_generator.dart**
   ```bash
   grep -n "replaceAll.*Meta" lib/src/generator/widget_generator.dart
   ```
   Update if needed.

3. **Verify all replacements**
   ```bash
   # Search entire codebase
   grep -r "replaceAll.*Meta" lib/
   ```
   Update any remaining files.

4. **Test the changes**
   - Run existing tests
   - Build example project
   - Verify generated code is correct

### Phase 2: Update Examples & Docs (1-2 hours)

5. **Update example meta files**

   **File:** `generator/example/meta/button.meta.dart`
   ```dart
   @SyntaxComponent(
     name: 'AppButton',  // NEW
     description: 'A customizable button',
   )
   class ButtonMeta {
     // ...
   }
   ```

   **File:** `generator/example/meta/text.meta.dart`
   ```dart
   @SyntaxComponent(
     name: 'AppText',  // NEW
     description: 'A text display component',
   )
   class TextMeta {
     // ...
   }
   ```

   **File:** `generator/example/meta/input.meta.dart`
   ```dart
   @SyntaxComponent(
     name: 'AppInput',  // NEW
     description: 'A text input field',
   )
   class InputMeta {
     // ...
   }
   ```

6. **Update documentation**

   **File:** `docs/api-reference.md` (add section)
   ```markdown
   ## Component Naming

   ### Explicit Names (Recommended)

   Use the `name` parameter to explicitly specify the component name:

   \`\`\`dart
   @SyntaxComponent(
     name: 'AppButton',
     description: 'A button',
   )
   class ButtonMeta { ... }
   \`\`\`

   ### Legacy Naming (Deprecated)

   Without explicit name, the generator strips 'Meta' suffix:

   \`\`\`dart
   @SyntaxComponent()
   class ButtonMeta { ... }  // Generates: AppButton
   \`\`\`

   **Warning:** This relies on naming conventions and may break if you rename your class.
   ```

### Phase 3: Add Validation (1 hour)

7. **Add name validation to AstValidator** (Part of Issue #3)
   ```dart
   // In component_definition validator
   List<ValidationError> validateComponentDefinition(ComponentDefinition def) {
     final errors = <ValidationError>[];

     // Warn if using legacy naming
     if (def.explicitName == null) {
       errors.add(ValidationError(
         type: ValidationErrorType.legacyNaming,
         message: 'Component uses legacy naming convention',
         suggestion: 'Add explicit name: @SyntaxComponent(name: "${def.className.replaceAll('Meta', '')}")',
         severity: ErrorSeverity.warning,
       ));
     }

     // Validate explicit name is valid identifier
     if (def.explicitName != null && !_isValidDartIdentifier(def.explicitName!)) {
       errors.add(ValidationError(
         type: ValidationErrorType.invalidIdentifier,
         message: 'Component name must be a valid Dart identifier',
         fieldName: 'name',
         severity: ErrorSeverity.error,
       ));
     }

     return errors;
   }
   ```

## Testing Strategy

**File:** `test/naming/component_naming_test.dart` (NEW)

```dart
import 'package:test/test.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/utils/component_naming.dart';

void main() {
  group('ComponentNaming', () {
    test('uses explicit name when provided', () {
      final component = ComponentDefinition(
        name: 'button',
        className: 'ButtonMeta',
        explicitName: 'MyCustomButton',
        properties: [],
        variants: [],
      );

      expect(ComponentNaming.getComponentName(component), 'MyCustomButton');
      expect(ComponentNaming.getComponentType(component), 'mycustombutton');
    });

    test('falls back to className without Meta', () {
      final component = ComponentDefinition(
        name: 'button',
        className: 'ButtonMeta',
        properties: [],
        variants: [],
      );

      expect(ComponentNaming.getComponentName(component), 'Button');
    });

    test('strips App prefix for component type', () {
      final component = ComponentDefinition(
        name: 'button',
        className: 'ButtonMeta',
        explicitName: 'AppButton',
        properties: [],
        variants: [],
      );

      expect(ComponentNaming.getComponentType(component), 'button');
    });

    test('handles non-App prefixed names', () {
      final component = ComponentDefinition(
        name: 'card',
        className: 'CardMeta',
        explicitName: 'MyCard',
        properties: [],
        variants: [],
      );

      expect(ComponentNaming.getComponentType(component), 'mycard');
    });
  });
}
```

## Benefits

1. ✅ **Explicit contract** - Name is declared, not inferred
2. ✅ **Flexible naming** - Users can name classes however they want
3. ✅ **Backwards compatible** - Falls back to old behavior if no explicit name
4. ✅ **Self-documenting** - `@SyntaxComponent(name: 'AppButton')` is clear
5. ✅ **Refactor-safe** - Renaming meta class doesn't break generation

## Breaking Changes

**None!** This is backwards compatible:

- **Old code** (without explicit name): Works with fallback
- **New code** (with explicit name): Uses explicit name

Users can migrate gradually:

```dart
// Step 1: Add explicit name matching current behavior
@SyntaxComponent(name: 'AppButton')  // Same as before
class ButtonMeta { ... }

// Step 2: Rename class if desired
@SyntaxComponent(name: 'AppButton')  // Output stays same!
class ButtonSpec { ... }  // Meta class renamed

// Step 3: Change output name if desired
@SyntaxComponent(name: 'MyButton')  // Different output!
class ButtonSpec { ... }
```

## Example Usage

**Before:**
```dart
// meta/button.meta.dart
@SyntaxComponent(description: 'A button')
class ButtonMeta {  // MUST be named *Meta
  final String label;
}

// Generates: lib/syntaxify/generated/components/app_button.dart
// Class name: AppButton
```

**After:**
```dart
// meta/button.meta.dart
@SyntaxComponent(
  name: 'AppButton',  // Explicit!
  description: 'A button',
)
class ButtonComponent {  // Can be named anything!
  final String label;
}

// Generates: lib/syntaxify/generated/components/app_button.dart
// Class name: AppButton
```

**Custom naming:**
```dart
@SyntaxComponent(name: 'PrimaryButton')
class CTAButtonMeta {
  final String label;
}

// Generates: lib/syntaxify/generated/components/primary_button.dart
// Class name: PrimaryButton
```

## Files Modified

1. ✅ `lib/src/annotations/syntax_annotations.dart` - Added `name` field
2. ✅ `lib/src/models/component_definition.dart` - Added `explicitName` field
3. ✅ `lib/src/parser/meta_parser.dart` - Extract name from annotation
4. ✅ `lib/src/generators/component/button_generator.dart` - Use explicit name
5. ✅ `lib/src/generators/component/text_generator.dart` - Use explicit name
6. ✅ `lib/src/generators/component/input_generator.dart` - Use explicit name
7. ✅ `lib/src/generators/component/generic_generator.dart` - Use explicit name
8. ✅ `lib/src/use_cases/generate_component.dart` - Use explicit name
9. ✅ `lib/src/utils/component_naming.dart` - NEW helper utility
10. ❌ `lib/src/models/component_definition.freezed.dart` - Needs regeneration
11. ❌ `example/meta/*.meta.dart` - Need to add explicit names
12. ❌ `docs/api-reference.md` - Need to document feature

## Conclusion

**MOSTLY IMPLEMENTED** - Needs completion

- Core functionality: ✅ Done (annotation, model, parser, generators)
- Freezed regeneration: ❌ TODO (requires dart SDK)
- Examples: ❌ TODO
- Documentation: ❌ TODO
- Validation: ❌ TODO (part of Issue #3)

**Estimated remaining effort:** 4-5 hours
**Priority:** Medium (works with fallback, but should complete for clean API)
