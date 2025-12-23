# Issue #9: Testing Coverage

## Status: ⚠️ BASIC TESTS EXIST (Medium Priority)

## Current State

**Existing tests:**
```
generator/test/
├── parser/
│   └── enum_parsing_test.dart  ✅
├── app_input_test.dart  ✅
├── widget_test.dart  ✅
└── golden_test.dart  ✅
```

**What's tested:**
- ✅ Enum parsing
- ✅ Basic widget tests
- ✅ Some golden tests

**What's NOT tested:**
- ❌ Full build flow (integration tests)
- ❌ AST → code generation (golden tests)
- ❌ Error paths
- ❌ Edge cases
- ❌ Screen generation
- ❌ Component generators
- ❌ Cache system (when added)

## Missing Test Categories

### 1. Integration Tests

Test full build flow:
```dart
test('builds complete project from meta files', () async {
  // Setup: Create temp dir with meta files
  final tempDir = await createTempProject([
    'meta/button.meta.dart',
    'meta/login.screen.dart',
  ]);

  // Execute: Run build
  final exitCode = await runBuild(tempDir);

  // Verify: Check generated files
  expect(exitCode, 0);
  expect(File('${tempDir}/lib/generated/components/app_button.dart'), exists);
  expect(File('${tempDir}/lib/screens/login_screen.dart'), exists);

  // Verify: Generated code compiles
  final compileResult = await Process.run('dart', ['analyze', tempDir]);
  expect(compileResult.exitCode, 0);
});
```

### 2. Golden Tests for Code Generation

Exact output verification:
```dart
test('generates correct button code', () {
  final ast = App.button(label: 'Click Me', onPressed: 'handleClick');
  final generated = LayoutEmitter().emit(ast);
  final formatted = DartFormatter().format(generated.toString());

  expect(
    formatted,
    equals(File('test/golden/button.golden.dart').readAsStringSync()),
  );
});
```

### 3. Error Path Tests

Test that errors are caught properly:
```dart
test('rejects empty button label', () {
  expect(
    () => ScreenGenerator().generate(
      ScreenDefinition(
        id: 'test',
        layout: App.button(label: ''),
      ),
    ),
    throwsA(isA<ValidationException>()),
  );
});
```

### 4. Edge Case Tests

Unusual but valid inputs:
```dart
test('handles deeply nested columns', () {
  final ast = App.column(children: [
    App.column(children: [
      App.column(children: [
        App.text(text: 'Nested'),
      ]),
    ]),
  ]);

  expect(() => LayoutEmitter().emit(ast), returnsNormally);
});
```

## Implementation Plan

### Phase 1: Add Integration Tests (4 hours)
- Test full build command
- Test init command
- Test clean command

### Phase 2: Add Golden Tests (6 hours)
- Create golden files for each component type
- Add AST → code golden tests
- Add screen generation golden tests

### Phase 3: Add Error Tests (3 hours)
- Test validation errors
- Test parse errors
- Test generation errors

### Phase 4: Add Edge Case Tests (3 hours)
- Deep nesting
- Many children
- Empty values
- Special characters

**Total effort:** 16 hours
**Priority:** Medium (confidence in refactoring)

## File Structure

```
test/
├── integration/
│   ├── build_flow_test.dart
│   ├── init_command_test.dart
│   └── clean_command_test.dart
├── golden/
│   ├── button.golden.dart
│   ├── text.golden.dart
│   ├── login_screen.golden.dart
│   └── ast_emission_test.dart
├── validation/
│   ├── button_validation_test.dart
│   ├── text_validation_test.dart
│   └── screen_validation_test.dart
├── edge_cases/
│   ├── nesting_test.dart
│   ├── special_chars_test.dart
│   └── empty_values_test.dart
└── ...
```
