# Forge Dependencies

> Complete documentation of all package dependencies.

## Runtime Dependencies

### analyzer
- **Version:** `^6.4.0`
- **Purpose:** Parse Dart source files to extract meta annotations and class definitions
- **Docs:** https://pub.dev/packages/analyzer
- **Why:** Official Dart team package. Handles all Dart syntax edge cases. Used instead of regex parsing.

### code_builder
- **Version:** `^4.10.0`
- **Purpose:** Programmatically construct Dart code as AST, then emit as formatted string
- **Docs:** https://pub.dev/packages/code_builder
- **Why:** Type-safe code generation. Avoids string concatenation bugs.

### dart_style
- **Version:** `^2.3.0`
- **Purpose:** Format generated Dart code according to official style guide
- **Docs:** https://pub.dev/packages/dart_style
- **Why:** Official formatter. Generated code matches `dart format` output.

### freezed_annotation
- **Version:** `^2.4.0`
- **Purpose:** Annotations for immutable data classes and union types
- **Docs:** https://pub.dev/packages/freezed_annotation
- **Why:** Runtime annotations only. Lightweight dependency for generated code.

### args
- **Version:** `^2.4.0`
- **Purpose:** Parse command-line arguments
- **Docs:** https://pub.dev/packages/args
- **Why:** Official Dart team package. Simple, well-tested.

### mason_logger
- **Version:** `^0.2.0`
- **Purpose:** Pretty CLI output with colors, progress bars, spinners
- **Docs:** https://pub.dev/packages/mason_logger
- **Why:** Used by Mason/Very Good CLI. Professional-looking output.

### path
- **Version:** `^1.8.0`
- **Purpose:** Cross-platform file path manipulation
- **Docs:** https://pub.dev/packages/path
- **Why:** Official Dart team package. Handles Windows/Unix path differences.

### file
- **Version:** `^7.0.0`
- **Purpose:** Testable file system abstraction
- **Docs:** https://pub.dev/packages/file
- **Why:** Allows mocking file system in tests. Clean Architecture friendly.

---

## Dev Dependencies

### freezed
- **Version:** `^2.4.0`
- **Purpose:** Code generator for immutable classes and union types
- **Docs:** https://pub.dev/packages/freezed
- **Why:** Generates copyWith, equality, pattern matching. FP-friendly.

### build_runner
- **Version:** `^2.4.0`
- **Purpose:** Run code generators
- **Docs:** https://pub.dev/packages/build_runner
- **Why:** Standard Flutter codegen tool. Required for freezed.

### test
- **Version:** `^1.24.0`
- **Purpose:** Unit and integration testing
- **Docs:** https://pub.dev/packages/test
- **Why:** Official Dart test framework.

### mocktail
- **Version:** `^1.0.0`
- **Purpose:** Mocking for tests
- **Docs:** https://pub.dev/packages/mocktail
- **Why:** Null-safe, simple API. No codegen required.

### lints
- **Version:** `^3.0.0`
- **Purpose:** Official Dart lint rules
- **Docs:** https://pub.dev/packages/lints
- **Why:** Consistent code style. Catches common mistakes.

---

## Version Constraints

```yaml
environment:
  sdk: '>=3.2.0 <4.0.0'
```

### Why These Versions?
- All packages are **latest stable** as of Dec 2024
- Using **caret syntax** (`^`) for minor version updates
- SDK 3.2+ for latest Dart features (patterns, sealed classes)

---

## Flutter SDK Compatibility

Generated code targets:
- **Flutter:** `>=3.38.0`
- **Dart:** `>=3.10.0`

This ensures:
- Pattern matching syntax
- Sealed classes
- Record types
- Class modifiers
- Latest language features


