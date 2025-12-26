# Syntaxify Issues Log

This document tracks issues identified during development and their resolutions.

---

## Issue #001: Foundation Tokens Missing Color Import
**Date:** 2025-12-25  
**Severity:** Error  
**Status:** ✅ Resolved

### Symptoms
- `dart analyze` shows: `Undefined class 'Color'` in `foundation_tokens.dart`
- Foundation tokens fail to compile

### Root Cause
`foundation_tokens.dart` used `part of '../../design_system.dart';` but the `DesignSystemGenerator` imported it via `import` directive. A file cannot be both imported AND used as a part.

### Fix
Changed `generator/design_system/tokens/foundation/foundation_tokens.dart`:
```dart
// Before (broken):
part of '../../design_system.dart';

// After (fixed):
import 'package:flutter/material.dart';
```

### Files Changed
- `generator/design_system/tokens/foundation/foundation_tokens.dart`

---

## Issue #002: Windows Path Separator in Foundation Token Copy
**Date:** 2025-12-25  
**Severity:** Error  
**Status:** ✅ Resolved

### Symptoms
- Build warning: `Cannot copy file to 'foundation/foundation\cupertino_foundation.dart'`
- Mixed forward/backslash in paths on Windows

### Root Cause
`entity.path` on Windows returns backslashes, but `p.posix.join()` uses forward slashes, creating malformed paths.

### Fix
Normalize paths in `LocalFileSystem` and `build_all.dart`:
```dart
// Normalize path separators for cross-platform compatibility
final normalizedPath = entity.path.replaceAll('\\', '/');
```

### Files Changed
- `generator/lib/src/infrastructure/local_file_system.dart` - `createDirectory()`, `copyFile()`
- `generator/lib/src/use_cases/build_all.dart` - foundation token copy loop

---

## Issue #003: Foundation Tokens Not Copied on Fresh Project
**Date:** 2025-12-25  
**Severity:** Error  
**Status:** ✅ Resolved

### Symptoms
- Fresh project: `syntaxify build` shows "Foundation token directory not found"
- Foundation tokens missing from output

### Root Cause
Build copies from project's `designSystemDir` (output), but on first build this doesn't exist. No fallback to generator package's bundled assets.

### Fix
Added `_getPackageBundledFoundationDir()` helper that locates the generator package's bundled `design_system/tokens/foundation/` directory using `Platform.script` path traversal.

```dart
// Fallback to package bundled design_system if project dir doesn't exist
if (!await foundationTokenDir.exists()) {
  final packageFoundationDir = _getPackageBundledFoundationDir();
  if (await packageFoundationDir.exists()) {
    foundationTokenDir = packageFoundationDir;
  }
}
```

### Files Changed
- `generator/lib/src/use_cases/build_all.dart` - Added fallback logic + helper method

---

## Issue #004: Custom Component Token File Not Generated
**Date:** 2025-12-25  
**Severity:** Error  
**Status:** ✅ Resolved

### Symptoms
- `dart analyze` shows: `Undefined class 'SuperCardTokens'`
- Token file not generated for custom components with no token-worthy properties

### Root Cause
`TokenGenerator.generate()` returned `null` when no properties matched token patterns (color, size, shadow). Custom components like SuperCard with only `bool value` had no matching patterns.

### Fix
Changed `TokenGenerator.generate()` to **always** generate a stub token file:
```dart
// Before:
String? generate(ComponentDefinition component) {
  if (tokenProperties.isEmpty) return null;  // ❌ Skipped
  ...
}

// After:
String generate(ComponentDefinition component) {
  // Always generate - provides scaffold for custom components
  ...
}
```

### Files Changed
- `generator/lib/src/generators/token_generator.dart` - Removed null return

---

## Issue #005: Empty Token Properties Cause Syntax Error
**Date:** 2025-12-25  
**Severity:** Error  
**Status:** ✅ Resolved

### Symptoms
- Build warning: `Could not format - Expected an identifier at ','`
- Token file generation fails for empty scaffolds

### Root Cause
`_generateFromFoundationFactory()` generated `return ClassName(,);` with trailing comma when `properties` was empty.

### Fix
Conditionally generate body content:
```dart
final bodyContent = properties.isEmpty
    ? 'return $className();'
    : '''return $className(
        $propertyMappings,
      );''';
```

### Files Changed
- `generator/lib/src/generators/token_generator.dart` - `_generateFromFoundationFactory()`

---

## Summary

| Issue | Category          | Impact | Resolution                          |
| ----- | ----------------- | ------ | ----------------------------------- |
| #001  | Import            | Error  | Use import instead of part of       |
| #002  | Windows           | Error  | Normalize path separators           |
| #003  | First Build       | Error  | Package fallback for bundled assets |
| #004  | Custom Components | Error  | Always generate token scaffold      |
| #005  | Code Generation   | Error  | Handle empty properties list        |
