# Spec Requirements Document

> Spec: DX Improvements v0.2.0-beta
> Created: 2025-12-23

## Overview

Redesign the developer experience to reduce boilerplate, unify the variant system, and simplify the API surface. This release targets a 60% reduction in meta file verbosity while maintaining type-safe code generation.

## User Stories

### 1. Simplified Screen Definition

As a **Flutter developer**, I want to define screens with minimal boilerplate, so that I can focus on UI layout instead of configuration.

**Current (verbose):**
```dart
import 'package:example/syntaxify/design_system/design_system.dart' hide TextVariant;
import 'package:syntaxify/syntaxify.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  layout: LayoutNode.column(
    mainAxisAlignment: SyntaxMainAxisAlignment.center,
    children: [
      LayoutNode.text(text: 'Welcome', variant: TextVariant.headlineMedium),
    ],
  ),
);
```

**After (clean):**
```dart
import 'package:example/syntaxify/index.dart';

ScreenDefinition(
  layout: App.column([
    App.text('Welcome', variant: TextVariant.headlineMedium),
  ]),
)
```

### 2. Component Variants in Meta

As a **component author**, I want to define variants directly in my component specification, so that the generator creates type-safe enums automatically.

**Workflow:**
1. Define `@SyntaxComponent(variants: ['primary', 'secondary'])` in meta file
2. Run `syntaxify build`
3. Generator creates `ButtonVariant` enum
4. Use in screens with IDE autocomplete

### 4. Convention-Based Meta Parsing

As a **component author**, I want to use Dart's built-in syntax instead of custom annotations, so that my meta files are cleaner.

**Current (redundant annotations):**
```dart
@SyntaxComponent()
class ButtonMeta {
  @Required()
  final String label;
  
  @Optional()
  @Default('primary')
  final ButtonVariant variant;
  
  @Optional()
  final VoidCallback? onPressed;
  
  const ButtonMeta({required this.label, this.variant = ButtonVariant.primary, this.onPressed});
}
```

**After (pure Dart conventions):**
```dart
@SyntaxComponent(variants: ['primary', 'secondary', 'outlined'])
class Button {
  final String label;           // Non-nullable = required
  final String? variant;        // Nullable = optional
  final VoidCallback? onPressed;
}
```

**Parsing rules:**
- Non-nullable field → Required
- Nullable field (`?`) → Optional
- Constructor default → Default value
- Class name without "Meta" suffix

## Spec Scope

1. **Unified Variant System** - Variants defined in `@SyntaxComponent(variants: [...])`, enums auto-generated
2. **Simpler Naming** - `App.text()`, `App.button()` instead of `LayoutNode.xxx()`
3. **Cleaner Enums** - `MainAlignment` instead of `SyntaxMainAxisAlignment`
4. **Single Import** - One import for all syntaxify types
5. **Auto-infer ID** - Screen ID inferred from filename (`login.screen.dart` → `id: 'login'`)
6. **Convention-based Parsing** - Use Dart nullability instead of `@Required`/`@Optional`
7. **No Variable Requirement** - `ScreenDefinition(...)` without `final loginScreen = `

## Out of Scope

- Form validation or state management (business logic)
- Jetpack Compose emitter (Stage 3)
- Documentation restructuring
- CI/CD setup

## Expected Deliverable

1. Screen files require only one import: `package:syntaxify/syntaxify.dart`
2. All variants are defined in `@SyntaxComponent` and auto-generate enums
3. API uses `App.xxx()` for all layout nodes
4. Meta files use Dart conventions (no `@Required`, `@Optional`, `@Default`)
5. Screen ID inferred from filename
6. All 283+ tests pass with new API
7. No import collisions (TextVariant, ButtonVariant, etc.)
