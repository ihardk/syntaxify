---
description: Run tests for generator and generated code
---

# Testing Workflow

Standard workflow for testing Syntax generator and generated components.

## Prerequisites
- Generator project has been built
- Example app has generated files in `example/lib/generated/`

## Testing Steps

### 1. Run Generator Unit Tests
// turbo
```bash
cd generator
dart test
```

**Expected:** All parser, generator, and use case tests pass.

### 2. Build Generated Code to Example
// turbo
```bash
cd generator
dart run bin/syntax.dart build --output example/lib/generated
```

**Expected:** 4+ files generated (components, theme, tokens, index).

### 3. Run Widget Tests
// turbo
```bash
cd generator/example
flutter test
```

**Expected:** All widget tests pass (rendering, tokens, interactions, semantics).

## Test Coverage Targets (from QA Agent)

| Category             | Target |
| -------------------- | ------ |
| Generator Unit Tests | 95%    |
| Widget Tests         | 90%    |
| Token Coverage       | 100%   |

## Test Categories

### Generator Tests (`generator/test/`)
- **Parser tests:** Meta file parsing, annotation extraction
- **Generator tests:** Code output correctness, SOLID compliance
- **Registry tests:** Component generator selection

### Widget Tests (`generator/example/test/`)
- **Rendering:** Label, layout, appearance
- **Tokens:** Correct token application per DesignStyle
- **Interactions:** tap, disabled, loading states
- **Accessibility:** Semantics labels
- **Theme switching:** Dynamic style changes

## Adding New Component Tests

1. Create widget test file: `example/test/<component>_test.dart`
2. Test with all DesignStyles: material, cupertino, neo
3. Test interactions: tap, hover, focus, disabled
4. Test accessibility: semantics, keyboard nav
5. Run: `flutter test`
