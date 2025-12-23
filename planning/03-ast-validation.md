# Issue #3: AST Validation

## Status: ✅ IMPLEMENTED (Dec 2024)

## Problem Description

Currently, there's NO validation of AST nodes before code generation. This allows invalid AST definitions to pass through and cause:

1. **Syntax errors at code generation time** (confusing stack traces)
2. **Runtime errors in generated code** (even worse UX)
3. **Silent bugs** (wrong behavior, no errors)

### Examples of Invalid AST That Currently Passes

**Example 1: Empty Button Label**
```dart
App.button(
  label: '',  // Empty string - useless button!
  onPressed: 'handleClick',
)
```
**Result:** Generates `AppButton(label: '')` - compiles but looks broken

---

**Example 2: Invalid Dart Identifier**
```dart
App.button(
  label: 'Click Me',
  onPressed: 'this-is-not-valid',  // Hyphens not allowed in Dart!
)
```
**Generated Code:**
```dart
final VoidCallback? this-is-not-valid;  // SYNTAXIFY ERROR!
```
**Result:** Generated code doesn't compile - confusing error message

---

**Example 3: Empty Column**
```dart
App.column(
  children: [],  // No children - meaningless widget
)
```
**Result:** Generates `Column(children: [])` - compiles but likely a bug

---

**Example 4: Conflicting Properties**
```dart
App.text(
  text: 'Hello',
  maxLines: 1,
  overflow: TextOverflow.visible,  // Conflicts with maxLines!
)
```
**Result:** Generates code with conflicting props - unexpected behavior

---

**Example 5: Nested Invalid Data**
```dart
App.column(
  children: [
    App.button(label: '', onPressed: 'bad-name'),  // Both invalid!
    App.text(text: ''),  // Empty text
  ],
)
```
**Result:** Multiple issues, hard to debug

## Current Code Flow (No Validation)

```
User defines AST in .screen.dart
         ↓
AppParser.parseScreenFromExpression()
         ↓
ScreenGenerator.generate()
         ↓
LayoutEmitter.emit()
         ↓
Write to file
         ↓
User runs app → BOOM 💥
```

**Problem:** Errors caught WAY too late (at Dart compile time or runtime)

## Proposed Solution

### Architecture: Validation Layer

```
User defines AST in .screen.dart
         ↓
AppParser.parseScreenFromExpression()
         ↓
✨ NEW: AstValidator.validate() ✨  ← Catch errors early!
         ↓
   Valid? → No → BuildResult with errors
         ↓
        Yes
         ↓
ScreenGenerator.generate()
         ↓
LayoutEmitter.emit()
         ↓
Write to file
```

### Validation Error Model

**File:** `lib/src/models/validation_error.dart` (NEW)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error.freezed.dart';

/// Represents a validation error in an AST node
@freezed
class ValidationError with _$ValidationError {
  const factory ValidationError({
    /// The type of validation error
    required ValidationErrorType type,

    /// Human-readable error message
    required String message,

    /// Path to the problematic node (e.g., "column.children[0].button")
    String? nodePath,

    /// Field name that caused the error
    String? fieldName,

    /// Suggested fix
    String? suggestion,

    /// Error severity
    @Default(ErrorSeverity.error) ErrorSeverity severity,
  }) = _ValidationError;
}

enum ValidationErrorType {
  emptyValue,           // Empty string where content expected
  invalidIdentifier,    // Invalid Dart identifier name
  emptyChildren,        // Container with no children
  conflictingProperties,// Mutually exclusive props set
  invalidEnumValue,     // Enum value doesn't exist
  negativeNumber,       // Negative value where positive expected
  outOfRange,          // Value outside allowed range
}

enum ErrorSeverity {
  error,   // Must fix - won't generate valid code
  warning, // Should fix - might cause issues
  info,    // Consider fixing - best practice
}
```

### Validator Implementation

**File:** `lib/src/validation/ast_validator.dart` (NEW)

```dart
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/validation_error.dart';

/// Validates AST nodes for correctness before code generation
class AstValidator {
  const AstValidator();

  /// Validates an AST node and all its children
  /// Returns list of validation errors (empty if valid)
  List<ValidationError> validate(App node, [String path = 'root']) {
    return node.map(
      column: (n) => _validateColumn(n, path),
      row: (n) => _validateRow(n, path),
      button: (n) => _validateButton(n, path),
      text: (n) => _validateText(n, path),
      textField: (n) => _validateTextField(n, path),
      icon: (n) => _validateIcon(n, path),
      spacer: (n) => _validateSpacer(n, path),
      appBar: (n) => _validateAppBar(n, path),
    );
  }

  /// Validates a button node
  List<ValidationError> _validateButton(ButtonNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.button';

    // Rule: Label cannot be empty
    if (node.label.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Button label cannot be empty',
        nodePath: nodePath,
        fieldName: 'label',
        suggestion: 'Provide a non-empty label like "Submit" or "Cancel"',
      ));
    }

    // Rule: onPressed must be valid Dart identifier
    if (node.onPressed != null) {
      if (!_isValidDartIdentifier(node.onPressed!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'onPressed must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'onPressed',
          suggestion: 'Use camelCase names like "handleSubmit" instead of "${node.onPressed}"',
        ));
      }
    }

    // Rule: Icon name should exist (if we have icon registry)
    if (node.icon != null) {
      // TODO: Validate against AppIcons registry
    }

    return errors;
  }

  /// Validates a column node
  List<ValidationError> _validateColumn(ColumnNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.column';

    // Rule: Column must have at least one child
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Column must have at least one child',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add child widgets like App.text() or App.button()',
        severity: ErrorSeverity.warning, // Warning, not error (could be intentional)
      ));
    }

    // Recursively validate children
    for (int i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath.children[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a row node
  List<ValidationError> _validateRow(RowNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.row';

    // Rule: Row must have at least one child
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Row must have at least one child',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add child widgets like App.text() or App.button()',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (int i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath.children[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a text node
  List<ValidationError> _validateText(TextNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.text';

    // Rule: Text cannot be empty (warning, might be intentional)
    if (node.text.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Text content is empty',
        nodePath: nodePath,
        fieldName: 'text',
        suggestion: 'Consider providing visible text content',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: maxLines should be positive
    if (node.maxLines != null && node.maxLines! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLines must be greater than 0',
        nodePath: nodePath,
        fieldName: 'maxLines',
        suggestion: 'Use a positive number like 1, 2, or 3',
      ));
    }

    return errors;
  }

  /// Validates a text field node
  List<ValidationError> _validateTextField(TextFieldNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.textField';

    // Rule: Label should not be empty (warning)
    if (node.label != null && node.label!.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'TextField label is empty',
        nodePath: nodePath,
        fieldName: 'label',
        suggestion: 'Provide a label like "Email" or "Password"',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: Callback names must be valid identifiers
    if (node.onChanged != null && !_isValidDartIdentifier(node.onChanged!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'onChanged must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onChanged',
        suggestion: 'Use camelCase like "onEmailChanged"',
      ));
    }

    if (node.onSubmitted != null && !_isValidDartIdentifier(node.onSubmitted!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'onSubmitted must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onSubmitted',
        suggestion: 'Use camelCase like "onPasswordSubmitted"',
      ));
    }

    // Rule: maxLength should be positive
    if (node.maxLength != null && node.maxLength! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLength must be greater than 0',
        nodePath: nodePath,
        fieldName: 'maxLength',
      ));
    }

    return errors;
  }

  /// Validates an icon node
  List<ValidationError> _validateIcon(IconNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.icon';

    // Rule: Icon name cannot be empty
    if (node.name.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Icon name cannot be empty',
        nodePath: nodePath,
        fieldName: 'name',
        suggestion: 'Provide an icon name like "home" or "search"',
      ));
    }

    return errors;
  }

  /// Validates a spacer node
  List<ValidationError> _validateSpacer(SpacerNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.spacer';

    // Rule: flex should be positive
    if (node.flex != null && node.flex! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Spacer flex must be greater than 0',
        nodePath: nodePath,
        fieldName: 'flex',
        suggestion: 'Use a positive number like 1 or 2',
      ));
    }

    return errors;
  }

  /// Validates an app bar node
  List<ValidationError> _validateAppBar(AppBarNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.appBar';

    // Rule: Callback names must be valid identifiers
    if (node.leadingAction != null && !_isValidDartIdentifier(node.leadingAction!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'leadingAction must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'leadingAction',
        suggestion: 'Use camelCase like "handleBack"',
      ));
    }

    return errors;
  }

  /// Checks if a string is a valid Dart identifier
  /// Rules: Must start with letter or _, contain only letters, digits, _
  bool _isValidDartIdentifier(String name) {
    if (name.isEmpty) return false;

    // Dart identifier regex: starts with letter or underscore,
    // followed by letters, digits, or underscores
    final identifierRegex = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

    if (!identifierRegex.hasMatch(name)) return false;

    // Check if it's a Dart keyword
    const dartKeywords = {
      'assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
      'default', 'do', 'else', 'enum', 'extends', 'false', 'final',
      'finally', 'for', 'if', 'in', 'is', 'new', 'null', 'rethrow',
      'return', 'super', 'switch', 'this', 'throw', 'true', 'try',
      'var', 'void', 'while', 'with',
    };

    return !dartKeywords.contains(name);
  }
}
```

### Integration Points

**1. Screen Generator Integration**

**File:** `lib/src/generators/screen_generator.dart`

Add validation before generation:

```dart
import 'package:syntaxify/src/validation/ast_validator.dart';

class ScreenGenerator {
  const ScreenGenerator({
    this.layoutEmitter = const LayoutEmitter(),
    this.validator = const AstValidator(),  // NEW
  });

  final LayoutEmitter layoutEmitter;
  final AstValidator validator;  // NEW

  String generate(ScreenDefinition screen, {String? packageName}) {
    // NEW: Validate before generating
    final errors = validator.validate(screen.layout);

    if (errors.isNotEmpty) {
      // Throw with helpful error message
      final errorMessages = errors.map((e) =>
        '${e.nodePath}: ${e.message}' +
        (e.suggestion != null ? '\n  → ${e.suggestion}' : '')
      ).join('\n');

      throw ValidationException(
        'AST validation failed for screen "${screen.id}":\n$errorMessages',
        errors: errors,
      );
    }

    // ... existing generation code
  }
}
```

**2. Build Use Case Integration**

**File:** `lib/src/use_cases/build_all.dart`

Add validation errors to BuildResult:

```dart
// Generate screens to lib/screens/ (editable)
for (final screen in screens) {
  try {
    logger.info('Validating Screen: ${screen.id}');

    // NEW: Validate before generating
    final validationErrors = AstValidator().validate(screen.layout);

    if (validationErrors.isNotEmpty) {
      final errorMsgs = validationErrors
        .where((e) => e.severity == ErrorSeverity.error)
        .map((e) => '${e.nodePath}: ${e.message}')
        .toList();

      final warningMsgs = validationErrors
        .where((e) => e.severity == ErrorSeverity.warning)
        .map((e) => '${e.nodePath}: ${e.message}')
        .toList();

      errors.addAll(errorMsgs.map((e) => 'Screen ${screen.id}: $e'));
      warnings.addAll(warningMsgs.map((w) => 'Screen ${screen.id}: $w'));

      // Skip generation if errors (not warnings)
      if (errorMsgs.isNotEmpty) {
        logger.err('Skipping screen ${screen.id} due to validation errors');
        continue;
      }
    }

    logger.info('Generating Screen: ${screen.id}');
    // ... existing generation code
  }
}
```

## Error Message Examples

### Before Validation (Current)

```bash
$ dart run syntaxify build
✗ Build failed: FormatException: Unexpected character (at line 45)
  at DartFormatter.format
  at ScreenGenerator.generate
  ...
```
**User reaction:** 😕 "What? Where's line 45? In my file or generated file?"

### After Validation (Proposed)

```bash
$ dart run syntaxify build
⚠ Screen login has 2 validation errors:

✗ root.column.children[2].button: Button label cannot be empty
  → Provide a non-empty label like "Submit" or "Cancel"

✗ root.column.children[2].button: onPressed must be a valid Dart identifier
  → Use camelCase names like "handleSubmit" instead of "handle-submit"

⚠ root.column: Column must have at least one child

Build failed with 2 error(s) and 1 warning(s)
```
**User reaction:** 😊 "Ah! I need to fix my button definition in the screen AST!"

## Implementation Plan

### Phase 1: Core Validation (Critical)
- [ ] Create `ValidationError` model
- [ ] Create `AstValidator` class
- [ ] Implement validators for: button, text, textField
- [ ] Integrate with `ScreenGenerator`
- [ ] Add tests for common error cases

**Effort:** 4-6 hours
**Files:** 3 new, 2 modified

### Phase 2: Complete Validation (High Priority)
- [ ] Validators for: column, row, icon, spacer, appBar
- [ ] Recursive child validation
- [ ] Dart keyword checking
- [ ] Integration with BuildAllUseCase

**Effort:** 3-4 hours
**Files:** 1 modified

### Phase 3: Advanced Validation (Medium Priority)
- [ ] Cross-field validation (conflicting props)
- [ ] Icon registry validation
- [ ] Custom validation rules API
- [ ] Validation configuration (enable/disable rules)

**Effort:** 4-5 hours
**Files:** 2-3 new

## Testing Strategy

**File:** `test/validation/ast_validator_test.dart`

```dart
void main() {
  group('AstValidator - Button', () {
    test('rejects empty label', () {
      final node = App.button(label: '', onPressed: 'handleClick');
      final errors = AstValidator().validate(node);

      expect(errors, hasLength(1));
      expect(errors[0].type, ValidationErrorType.emptyValue);
      expect(errors[0].fieldName, 'label');
    });

    test('rejects invalid identifier', () {
      final node = App.button(label: 'Click', onPressed: 'bad-name');
      final errors = AstValidator().validate(node);

      expect(errors, hasLength(1));
      expect(errors[0].type, ValidationErrorType.invalidIdentifier);
      expect(errors[0].fieldName, 'onPressed');
    });

    test('accepts valid button', () {
      final node = App.button(label: 'Submit', onPressed: 'handleSubmit');
      final errors = AstValidator().validate(node);

      expect(errors, isEmpty);
    });
  });

  group('AstValidator - Column', () {
    test('warns on empty children', () {
      final node = App.column(children: []);
      final errors = AstValidator().validate(node);

      expect(errors, hasLength(1));
      expect(errors[0].severity, ErrorSeverity.warning);
    });

    test('recursively validates children', () {
      final node = App.column(children: [
        App.button(label: '', onPressed: 'handleClick'),
        App.text(text: ''),
      ]);

      final errors = AstValidator().validate(node);
      expect(errors.length, greaterThan(1)); // Multiple child errors
    });
  });
}
```

## Benefits

1. ✅ **Early Error Detection** - Catch issues at build time, not runtime
2. ✅ **Better Error Messages** - Clear, actionable feedback
3. ✅ **Prevent Invalid Code** - Never generate code that won't compile
4. ✅ **Developer Productivity** - Fix issues faster with good diagnostics
5. ✅ **Documentation** - Validation rules = implicit API documentation

## Alternatives Considered

### Alternative 1: Runtime Validation in Widgets
```dart
class AppButton extends StatelessWidget {
  AppButton({required this.label}) {
    assert(label.isNotEmpty, 'Label cannot be empty');
  }
}
```

**Pros:** Catches errors in generated code too
**Cons:** Too late! Generated code already written. User sees assert error, not helpful build error.

### Alternative 2: Freezed Validation
```dart
@freezed
class ButtonNode with _$ButtonNode {
  @Assert('label.isNotEmpty')
  const factory ButtonNode({required String label}) = _ButtonNode;
}
```

**Pros:** Automatic, type-safe
**Cons:**
- Freezed asserts are runtime only
- Can't provide helpful suggestions
- Can't do cross-field validation

**Verdict:** Custom validator is best approach for build-time validation with rich error messages.

## Conclusion

**NEEDS IMPLEMENTATION** - High Priority

This is a critical missing feature that will significantly improve DX.

Estimated effort: **12-15 hours** for full implementation
Priority: **HIGH** (affects all users, causes confusing errors)
