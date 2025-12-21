# 16. Validation and IDE-Integrated Linting

> **Level**: Intermediate
> **Prerequisites**: 03-ast-system.md, 05-code-generation.md

This guide explains Syntaxify's comprehensive validation system that catches errors both at edit-time (in your IDE) and at build-time (during code generation).

---

## Table of Contents

1. [Overview](#overview)
2. [The LayoutNode Naming](#the-layoutnode-naming)
3. [Two-Tier Validation](#two-tier-validation)
4. [IDE-Integrated Linting](#ide-integrated-linting)
5. [Build-Time Validation](#build-time-validation)
6. [All Lint Rules](#all-lint-rules)
7. [Enabling Custom Lints](#enabling-custom-lints)
8. [Best Practices](#best-practices)

---

## Overview

Syntaxify provides **two layers of validation** to catch errors early:

1. **IDE-Integrated Linting** - Shows errors as you type in VS Code, Android Studio, or IntelliJ
2. **Build-Time Validation** - Validates during `syntaxify build` command

This ensures you catch mistakes immediately, not after running the build command.

```dart
// ❌ IDE shows error immediately: "Button label cannot be empty"
LayoutNode.button(
  label: '',  // Red squiggly line appears
  onPressed: 'handleClick',
)

// ✅ Fixed - no errors
LayoutNode.button(
  label: 'Submit',
  onPressed: 'handleClick',
)
```

---

## The LayoutNode Naming

We renamed `AstNode` to `LayoutNode` to make the API more approachable for developers who aren't familiar with compiler terminology.

### Why the Change?

- **Before**: `AstNode.button()` - "AST" is technical jargon (Abstract Syntax Tree)
- **After**: `LayoutNode.button()` - Clear and descriptive

### Migration Guide

If you have existing code using `AstNode`, simply replace all occurrences with `LayoutNode`:

```dart
// Old code (before v0.1.0-alpha.8)
final node = AstNode.column(
  children: [
    AstNode.text(text: 'Hello'),
    AstNode.button(label: 'Click me'),
  ],
);

// New code (v0.1.0-alpha.8+)
final node = LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Hello'),
    LayoutNode.button(label: 'Click me'),
  ],
);
```

All factory constructors remain the same:
- `LayoutNode.column()` ✅
- `LayoutNode.row()` ✅
- `LayoutNode.button()` ✅
- `LayoutNode.text()` ✅
- `LayoutNode.textField()` ✅
- `LayoutNode.icon()` ✅
- `LayoutNode.spacer()` ✅
- `LayoutNode.appBar()` ✅

---

## Two-Tier Validation

### 1. IDE-Integrated Linting (Edit-Time)

Shows errors **as you type** in your code editor.

**When it runs**: Continuously while editing `.screen.dart` files
**Technology**: Custom lint rules using `custom_lint_builder`
**Where**: VS Code, Android Studio, IntelliJ IDEA
**Coverage**: 10 common error patterns

Example:
```dart
// You type this in VS Code...
LayoutNode.button(
  label: '',  // ← Immediately shows red squiggly
)

// Hover shows:
// ⚠️ Button label cannot be empty
// 💡 Provide a non-empty label like "Submit" or "Cancel"
```

### 2. Build-Time Validation (Code Generation)

Validates **before generating Flutter code**.

**When it runs**: During `syntaxify build` command
**Technology**: `LayoutValidator` class
**Coverage**: All node properties, recursive validation

Example:
```bash
$ syntaxify build

❌ Validation failed:
  screens/login.screen.dart:15
  └─ Button label cannot be empty
     Field: label
     Suggestion: Provide a non-empty label like "Submit" or "Cancel"
```

---

## IDE-Integrated Linting

### How It Works

Custom lint rules analyze your code **in real-time** and report errors directly in your IDE.

**Architecture**:
```
Your .screen.dart file
    ↓
Dart Analyzer (runs continuously)
    ↓
custom_lint plugin
    ↓
Syntaxify lint rules (10 rules)
    ↓
IDE shows errors/warnings/info
```

### Installation

1. **Add to your project's `pubspec.yaml`**:
```yaml
dev_dependencies:
  custom_lint: ^0.6.4
  syntaxify: ^0.1.0-alpha.8
```

2. **Create `analysis_options.yaml`**:
```yaml
analyzer:
  plugins:
    - custom_lint

  errors:
    # Syntaxify custom lints - Empty values
    empty_button_label: error
    empty_text_content: error
    empty_icon_name: error
    empty_appbar_title: warning

    # Container checks
    empty_container: warning

    # Identifier validation
    invalid_callback_name: error

    # Number validation
    negative_number_value: error

    # Property conflicts
    conflicting_properties: info

    # Missing fields
    missing_textfield_label: warning
```

3. **Run the custom lint analyzer**:
```bash
# One-time check
dart run custom_lint

# Continuous watch mode (recommended)
dart run custom_lint --watch
```

### Severity Levels

- **error** (🔴): Must fix - blocks code generation
- **warning** (🟡): Should fix - best practice violation
- **info** (🔵): Consider fixing - suggestions for improvement

---

## Build-Time Validation

The `LayoutValidator` provides comprehensive validation during code generation.

### Usage in Code

```dart
import 'package:syntaxify/src/validation/layout_validator.dart';
import 'package:syntaxify/src/models/validation_error.dart';

void main() {
  final validator = LayoutValidator();

  final node = LayoutNode.button(
    label: '',  // Invalid
    onPressed: 'handle-click',  // Invalid (contains hyphen)
  );

  final errors = validator.validate(node);

  for (final error in errors) {
    print('${error.severity.name.toUpperCase()}: ${error.message}');
    print('  Path: ${error.nodePath}');
    print('  Field: ${error.fieldName}');
    print('  Suggestion: ${error.suggestion}');
  }
}

// Output:
// ERROR: Button label cannot be empty
//   Path: root.button
//   Field: label
//   Suggestion: Provide a non-empty label like "Submit" or "Cancel"
//
// ERROR: onPressed must be a valid Dart identifier
//   Path: root.button
//   Field: onPressed
//   Suggestion: Use camelCase names like "handleSubmit" instead of "handle-click"
```

### ValidationError Model

```dart
@freezed
class ValidationError with _$ValidationError {
  const factory ValidationError({
    required ValidationErrorType type,
    required String message,
    String? nodePath,
    String? fieldName,
    String? suggestion,
    @Default(ErrorSeverity.error) ErrorSeverity severity,
  }) = _ValidationError;
}

enum ValidationErrorType {
  emptyValue,           // Empty strings where content is required
  invalidIdentifier,    // Invalid Dart identifier (contains hyphens, spaces, etc.)
  emptyChildren,        // Container with no children
  conflictingProperties,// Properties that conflict (e.g., maxLines=1 + overflow=visible)
  negativeNumber,       // Negative values where positive is required
  outOfRange,           // Value outside valid range
}

enum ErrorSeverity {
  error,    // Must fix
  warning,  // Should fix
  info,     // Consider fixing
}
```

---

## All Lint Rules

### 1. Empty Value Checks

#### `empty_button_label` (🔴 ERROR)

**Detects**: Empty button labels

```dart
// ❌ Error
LayoutNode.button(
  label: '',  // Cannot be empty
  onPressed: 'handleClick',
)

// ✅ Fixed
LayoutNode.button(
  label: 'Submit',
  onPressed: 'handleClick',
)
```

**Message**: Button label cannot be empty
**Suggestion**: Provide a non-empty label like "Submit" or "Cancel"

---

#### `empty_text_content` (🔴 ERROR)

**Detects**: Empty text content

```dart
// ❌ Error
LayoutNode.text(
  text: '',  // Cannot be empty
)

// ✅ Fixed
LayoutNode.text(
  text: 'Hello World',
)
```

**Message**: Text content cannot be empty
**Suggestion**: Provide non-empty text content or use a Spacer instead

---

#### `empty_icon_name` (🔴 ERROR)

**Detects**: Empty icon names

```dart
// ❌ Error
LayoutNode.icon(
  name: '',  // Cannot be empty
)

// ❌ Error
LayoutNode.button(
  label: 'Click',
  icon: '',  // Cannot be empty
  iconPosition: IconPosition.left,
)

// ✅ Fixed
LayoutNode.icon(
  name: 'home',
)

LayoutNode.button(
  label: 'Click',
  icon: 'arrow_forward',
  iconPosition: IconPosition.left,
)
```

**Message**: Icon name cannot be empty
**Suggestion**: Provide a valid icon name like "home" or "settings"

---

#### `empty_appbar_title` (🟡 WARNING)

**Detects**: AppBar without a title

```dart
// ⚠️ Warning
LayoutNode.appBar(
  // No title provided
  leadingAction: 'handleBack',
)

// ✅ Fixed
LayoutNode.appBar(
  title: 'My App',
  leadingAction: 'handleBack',
)
```

**Message**: AppBar should have a title
**Suggestion**: Provide a descriptive title for the app bar

---

### 2. Container Checks

#### `empty_container` (🟡 WARNING)

**Detects**: Column or Row with no children

```dart
// ⚠️ Warning
LayoutNode.column(
  children: [],  // Empty children list
)

// ✅ Fixed
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Hello'),
    LayoutNode.button(label: 'Click me'),
  ],
)
```

**Message**: Container has no children
**Suggestion**: Add child widgets like LayoutNode.text() or LayoutNode.button()

---

### 3. Identifier Validation

#### `invalid_callback_name` (🔴 ERROR)

**Detects**: Invalid Dart identifiers in callbacks

```dart
// ❌ Error - contains hyphen
LayoutNode.button(
  label: 'Submit',
  onPressed: 'handle-click',  // Invalid: contains hyphen
)

// ❌ Error - contains space
LayoutNode.textField(
  label: 'Email',
  onChanged: 'handle change',  // Invalid: contains space
)

// ❌ Error - Dart keyword
LayoutNode.button(
  label: 'Click',
  onPressed: 'class',  // Invalid: Dart keyword
)

// ✅ Fixed - valid camelCase identifiers
LayoutNode.button(
  label: 'Submit',
  onPressed: 'handleClick',
)

LayoutNode.textField(
  label: 'Email',
  onChanged: 'handleChange',
  onSubmitted: 'handleSubmit',
  binding: 'emailController',
)
```

**Checks these properties**:
- `button.onPressed`
- `textField.onChanged`
- `textField.onSubmitted`
- `textField.binding`
- `appBar.leadingAction`

**Valid identifier rules**:
- Starts with letter or underscore
- Contains only letters, digits, and underscores
- Not a Dart keyword (class, if, for, etc.)

**Message**: Callback name must be a valid Dart identifier
**Suggestion**: Use camelCase names like "handleSubmit" instead of names with hyphens or spaces

---

### 4. Number Validation

#### `negative_number_value` (🔴 ERROR)

**Detects**: Negative or zero values where positive numbers are required

```dart
// ❌ Error - maxLines must be positive
LayoutNode.text(
  text: 'Hello',
  maxLines: -1,  // Invalid: negative
)

// ❌ Error - maxLength must be positive
LayoutNode.textField(
  label: 'Name',
  maxLength: 0,  // Invalid: zero
)

// ❌ Error - flex must be positive
LayoutNode.spacer(
  flex: -1,  // Invalid: negative
)

// ✅ Fixed
LayoutNode.text(
  text: 'Hello',
  maxLines: 2,
)

LayoutNode.textField(
  label: 'Name',
  maxLength: 50,
)

LayoutNode.spacer(
  flex: 1,
)
```

**Checks these properties**:
- `text.maxLines` - must be > 0
- `textField.maxLines` - must be > 0
- `textField.maxLength` - must be > 0
- `spacer.flex` - must be > 0

**Message**: Value must be a positive number
**Suggestion**: Use a positive integer value

---

### 5. Property Conflicts

#### `conflicting_properties` (🔵 INFO)

**Detects**: Property combinations that may cause unexpected behavior

```dart
// ℹ️ Info - maxLines=1 with overflow=visible may cause issues
LayoutNode.text(
  text: 'Very long text that will overflow',
  maxLines: 1,
  overflow: TextOverflow.visible,  // May cause layout issues
)

// ✅ Better approach
LayoutNode.text(
  text: 'Very long text that will overflow',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,  // Shows "..." when truncated
)
```

**Message**: These properties may conflict and cause unexpected behavior
**Suggestion**: Consider using TextOverflow.ellipsis instead of visible

---

### 6. Missing Required Fields

#### `missing_textfield_label` (🟡 WARNING)

**Detects**: TextField with neither label nor hint

```dart
// ⚠️ Warning - no label or hint
LayoutNode.textField(
  onChanged: 'handleChange',
  // Missing both label and hint
)

// ✅ Fixed - has label
LayoutNode.textField(
  label: 'Email',
  onChanged: 'handleChange',
)

// ✅ Also valid - has hint
LayoutNode.textField(
  hint: 'Enter your email',
  onChanged: 'handleChange',
)

// ✅ Best - has both
LayoutNode.textField(
  label: 'Email',
  hint: 'example@email.com',
  onChanged: 'handleChange',
)
```

**Message**: TextField should have either a label or hint
**Suggestion**: Provide a label or hint to guide the user

---

## Enabling Custom Lints

### Step-by-Step Setup

#### 1. Add Dependencies

Add to your project's `pubspec.yaml`:

```yaml
dependencies:
  syntaxify: ^0.1.0-alpha.8

dev_dependencies:
  custom_lint: ^0.6.4
```

Run:
```bash
dart pub get
```

#### 2. Configure Analysis Options

Create or update `analysis_options.yaml` in your project root:

```yaml
include: package:lints/recommended.yaml

analyzer:
  plugins:
    - custom_lint

  strong-mode:
    implicit-casts: false
    implicit-dynamic: false

  errors:
    # Syntaxify custom lints - Empty values
    empty_button_label: error
    empty_text_content: error
    empty_icon_name: error
    empty_appbar_title: warning

    # Container checks
    empty_container: warning

    # Identifier validation
    invalid_callback_name: error

    # Number validation
    negative_number_value: error

    # Property conflicts
    conflicting_properties: info

    # Missing fields
    missing_textfield_label: warning

linter:
  rules:
    # Standard Dart lints
    - avoid_print
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - prefer_final_fields
    - unnecessary_const
    - unnecessary_new

# Custom lint configuration
custom_lint:
  # Enable Syntaxify lints for .screen.dart files
  enable_all_lint_rules: true
```

#### 3. Run Custom Lint

```bash
# One-time analysis
dart run custom_lint

# Watch mode (recommended during development)
dart run custom_lint --watch
```

#### 4. IDE Integration

**VS Code**:
1. Install "Dart" extension
2. Custom lints work automatically when `analysis_options.yaml` is configured
3. Errors appear as red/yellow squiggles

**Android Studio / IntelliJ**:
1. Install "Dart" plugin
2. Custom lints work automatically
3. Errors appear in Problems panel

**Running in Background**:
```bash
# Keep this running in a terminal during development
dart run custom_lint --watch
```

---

## Best Practices

### 1. Enable Both Validation Layers

✅ **DO**: Use both IDE linting and build-time validation
```bash
# Terminal 1: Keep custom lint running
dart run custom_lint --watch

# Terminal 2: Run builds
syntaxify build
```

❌ **DON'T**: Rely on only one layer
```bash
# Missing IDE feedback
syntaxify build  # Only validates at build time
```

---

### 2. Fix Errors Before Warnings

Priority order:
1. 🔴 **Errors** - Must fix (empty values, invalid identifiers, negative numbers)
2. 🟡 **Warnings** - Should fix (empty containers, missing labels)
3. 🔵 **Info** - Consider fixing (property conflicts)

---

### 3. Use Descriptive Names

✅ **DO**: Use meaningful, descriptive identifiers
```dart
LayoutNode.button(
  label: 'Submit Form',
  onPressed: 'handleFormSubmission',
)

LayoutNode.textField(
  label: 'Email Address',
  binding: 'emailController',
  onChanged: 'handleEmailChanged',
  onSubmitted: 'validateAndSubmit',
)
```

❌ **DON'T**: Use generic or unclear names
```dart
LayoutNode.button(
  label: 'Click',
  onPressed: 'handler1',
)

LayoutNode.textField(
  label: 'Input',
  binding: 'ctrl',
  onChanged: 'fn',
)
```

---

### 4. Provide User Guidance

✅ **DO**: Give clear labels and hints
```dart
LayoutNode.textField(
  label: 'Password',
  hint: 'Must be at least 8 characters',
  obscureText: true,
  maxLength: 128,
)
```

❌ **DON'T**: Leave fields unlabeled
```dart
LayoutNode.textField(
  // No label or hint - user doesn't know what to enter
  obscureText: true,
)
```

---

### 5. Handle Text Overflow Properly

✅ **DO**: Use ellipsis for single-line truncation
```dart
LayoutNode.text(
  text: 'Very long username that might overflow',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,  // Shows "..."
)
```

❌ **DON'T**: Use visible overflow with maxLines
```dart
LayoutNode.text(
  text: 'Very long username that might overflow',
  maxLines: 1,
  overflow: TextOverflow.visible,  // May cause layout issues
)
```

---

### 6. Validate Custom Identifiers

All callback names must be valid Dart identifiers:

✅ **Valid**:
- `handleClick`
- `onSubmit`
- `validateEmail`
- `_privateHandler`
- `handleButtonPress2`

❌ **Invalid**:
- `handle-click` (contains hyphen)
- `on submit` (contains space)
- `validate@email` (contains special char)
- `class` (Dart keyword)
- `2handleClick` (starts with number)

---

### 7. Keep Containers Non-Empty

✅ **DO**: Add meaningful children
```dart
LayoutNode.column(
  children: [
    LayoutNode.text(text: 'Welcome'),
    LayoutNode.button(label: 'Get Started'),
  ],
)
```

❌ **DON'T**: Create empty containers
```dart
LayoutNode.column(
  children: [],  // Warning: empty container
)
```

If you need spacing, use `LayoutNode.spacer()` instead.

---

## Summary

Syntaxify's validation system provides:

✅ **10 IDE-integrated lint rules** catching errors as you type
✅ **Comprehensive build-time validation** before code generation
✅ **Clear error messages** with actionable suggestions
✅ **Three severity levels** (error, warning, info)
✅ **Works in all major IDEs** (VS Code, Android Studio, IntelliJ)

**Quick Setup**:
1. Add `custom_lint` to `dev_dependencies`
2. Configure `analysis_options.yaml`
3. Run `dart run custom_lint --watch`
4. Enjoy real-time error feedback!

---

## Next Steps

- **[03-ast-system.md](./03-ast-system.md)** - Deep dive into LayoutNode architecture
- **[05-code-generation.md](./05-code-generation.md)** - How validation integrates with code generation
- **[15-writing-tests.md](./15-writing-tests.md)** - Testing validation rules

---

**Questions?** Check our [GitHub Issues](https://github.com/ihardk/syntaxify/issues) or [API Reference](./13-api-reference.md).
