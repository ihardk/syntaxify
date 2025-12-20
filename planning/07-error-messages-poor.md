# Issue #7: Error Messages Poor

## Status: ⚠️ PARTIALLY IMPLEMENTED (Medium Priority)

## Problem

**Current errors:**
```bash
catch (e) {
  logger.err('Failed to generate component: $e');
}
```

**Output:**
```
✗ Failed to generate component: FormatException: Unexpected character
```

No context about:
- Which file caused the error
- What line number
- How to fix it
- Whether it's a bug or user error

## Should Be

```dart
catch (e, stackTrace) {
  if (e is AnalyzerError) {
    logger.err('Failed to parse meta/${component.name}.meta.dart');
    logger.detail('Line ${e.line}: ${e.message}');
    logger.info('Check that @SyntaxComponent annotation is present');
  } else if (e is GeneratorError) {
    logger.err('Failed to generate code for ${component.name}');
    logger.detail(e.message);
    logger.info('This might be a bug. Please report at: $issueUrl');
  } else {
    logger.err('Unexpected error: $e');
    logger.detail(stackTrace.toString());
  }
}
```

## Current State

**Good error handling exists in some places:**
- ✅ `build_command.dart` - catches and reports build errors
- ✅ `meta_parser.dart` - uses logger for warnings

**Poor error handling:**
- ❌ Generic `catch (e)` in use_cases
- ❌ No stack traces logged
- ❌ No suggestions for fixes
- ❌ No distinction between user errors and bugs

## Implementation Plan

1. Create custom exception types
2. Add context to all catch blocks
3. Add helpful suggestions
4. Log stack traces for unexpected errors

**Files to modify:**
- `lib/src/use_cases/build_all.dart`
- `lib/src/use_cases/generate_component.dart`
- `lib/src/use_cases/generate_screen.dart`
- `lib/src/parser/meta_parser.dart`

**Effort:** 3-4 hours
**Priority:** Medium (improves DX significantly)
