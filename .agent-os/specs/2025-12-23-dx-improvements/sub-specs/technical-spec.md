# Technical Specification

This is the technical specification for the spec detailed in @.agent-os/specs/2025-12-23-dx-improvements/spec.md

## Technical Requirements

### 1. Update @SyntaxComponent Annotation

**File:** `lib/src/annotations/syntax_annotations.dart`

```dart
class SyntaxComponent {
  final String? name;
  final String? description;
  final List<String>? variants;  // NEW
  
  const SyntaxComponent({this.name, this.description, this.variants});
}
```

### 2. Update ComponentDefinition Model

**File:** `lib/src/models/component_definition.dart`

Add `variants` list field to store parsed variant names.

### 3. Update MetaParser

**File:** `lib/src/parser/meta_parser.dart`

Extract `variants` from `@SyntaxComponent` annotation's ListLiteral argument.

### 4. Create EnumGenerator

**File:** `lib/src/generators/enum_generator.dart` (NEW)

Generate enum per component:
- Input: component name + variants list
- Output: `enum ${ComponentName}Variant { variant1, variant2, ... }`

### 5. Update BuildAllUseCase

**File:** `lib/src/use_cases/build_all.dart`

Add enum generation step after component generation:
- Write to `$outputDir/generated/variants/${component}_variant.dart`

### 6. Rename Sealed Class

**File:** `lib/src/models/ast/layout_node.dart`

- [x] Already done: `LayoutNode` → `App`

### 7. Rename Enums

**File:** `lib/src/models/ast/enums.dart`

- [x] Already done: `SyntaxMainAxisAlignment` → `MainAlignment`
- [x] Already done: `SyntaxCrossAxisAlignment` → `CrossAlignment`

### 8. Update Meta Files

Add `variants` to all component meta files:

| File               | Variants                                                 |
| ------------------ | -------------------------------------------------------- |
| `button.meta.dart` | `['primary', 'secondary', 'outlined', 'text']`           |
| `text.meta.dart`   | `['displayLarge', 'headlineMedium', 'titleMedium', ...]` |
| `spacer.meta.dart` | `['xs', 'sm', 'md', 'lg', 'xl']`                         |

### 9. Remove Old Variant System

- Delete `@Variant` annotation
- Remove `EnumParser` class
- Remove `TextVariant` from `enums.dart` (now generated)
- Keep layout enums: `MainAlignment`, `CrossAlignment`

### 10. Update Exports

**File:** `lib/syntaxify.dart`

- Export `App` (formerly LayoutNode)
- Export layout enums
- Do NOT export component variants (generated per project)

### 11. Convention-Based Meta Parsing

**File:** `lib/src/parser/meta_parser.dart`

Change property extraction logic:

```dart
// OLD: Check annotations
if (hasAnnotation('Required')) isRequired = true;
if (hasAnnotation('Optional')) isRequired = false;
if (hasAnnotation('Default')) defaultValue = getDefaultValue();

// NEW: Use Dart type system
final isNullable = typeName.endsWith('?');
isRequired = !isNullable;
defaultValue = extractFromConstructor(fieldName);
```

**Parsing rules:**
| Dart Syntax                | Interpretation          |
| -------------------------- | ----------------------- |
| `final String label;`      | Required (non-nullable) |
| `final String? hint;`      | Optional (nullable)     |
| `this.variant = 'primary'` | Default value           |

### 12. Deprecate Old Annotations

**File:** `lib/src/annotations/syntax_annotations.dart`

```dart
@Deprecated('Use Dart nullability: non-nullable = required')
class Required { const Required({this.doc}); final String? doc; }

@Deprecated('Use Dart nullability: nullable (?) = optional')
class Optional { const Optional({this.doc}); final String? doc; }

@Deprecated('Use constructor defaults: this.field = value')
class Default { const Default(this.value); final String value; }
```

### 13. Screen ID Inference

**File:** `lib/src/parser/meta_parser.dart`

```dart
String _inferIdFromFilename(String filePath) {
  // login.screen.dart → 'login'
  final basename = path.basenameWithoutExtension(filePath);
  return basename.replaceAll('.screen', '');
}

// Make 'id' optional in ScreenDefinition
// If not provided, infer from filename
```

### 14. Remove Variable Requirement for Screens

**File:** `lib/src/parser/meta_parser.dart`

Accept screen definitions without variable assignment:

```dart
// Support both:
final loginScreen = ScreenDefinition(...);  // Current
ScreenDefinition(...);  // NEW: anonymous
```

---

## Files to Modify

| File                        | Change                                                       |
| --------------------------- | ------------------------------------------------------------ |
| `syntax_annotations.dart`   | Add `variants`, deprecate `@Required`/`@Optional`/`@Default` |
| `component_definition.dart` | Add `variants` field                                         |
| `meta_parser.dart`          | Convention parsing, ID inference, anonymous screens          |
| `enum_generator.dart`       | NEW FILE - generate enums                                    |
| `build_all.dart`            | Call enum generator                                          |
| `enums.dart`                | Remove generated variants                                    |
| `meta/*.meta.dart`          | Add `variants: [...]`, remove annotations                    |
| `syntaxify.dart`            | Update exports                                               |

---

## Migration Path

1. Update annotation and model (non-breaking)
2. Update parser with convention support (non-breaking, old annotations still work)
3. Add enum generator (non-breaking)
4. Update build use case (non-breaking)
5. Update meta files with variants, remove old annotations
6. Deprecate old annotations (warnings only)
7. Update tests
8. Publish v0.2.0-beta
