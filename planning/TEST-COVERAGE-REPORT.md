# Test Coverage Report - Syntaxify

**Generated:** 2025-12-20
**Version:** 0.1.0-alpha.8

---

## Executive Summary

| Metric | Value | Status |
|--------|-------|--------|
| **Source Files** | 51 | - |
| **Test Files** | 10 | ⚠️ Low |
| **Total Tests** | ~39 | ⚠️ Low |
| **Coverage Estimate** | ~25-30% | ❌ Poor |
| **Critical Paths Tested** | 40% | ⚠️ Incomplete |

### Overall Assessment: **POOR** ⚠️

The codebase has **basic unit tests** but lacks:
- ❌ Integration tests (end-to-end build flow)
- ❌ Error path tests
- ❌ Edge case tests
- ❌ CLI command tests
- ❌ Use case tests
- ❌ Golden/snapshot tests for code generation

---

## Test File Breakdown

### ✅ TESTED (10 test files, ~39 tests)

#### 1. Parser Tests (13 tests)
**File:** `test/parser/meta_parser_test.dart` (6 tests)
- ✅ Parses @MetaComponent annotation
- ✅ Extracts required fields
- ✅ Extracts optional fields
- ✅ Extracts all fields from ButtonMeta
- ✅ Returns null for files without annotation
- ✅ Parses directory returning all components

**File:** `test/parser/ast_node_parser_test.dart` (3 tests)
- ✅ Basic AST node parsing
- ✅ Screen definition parsing
- ✅ Node parameter extraction

**File:** `test/parser/enum_parsing_test.dart` (1 test)
- ✅ Enum value parsing

**Coverage:** ~60% of parser functionality

---

#### 2. Generator Tests (10 tests)
**File:** `test/generators/screen_generator_test.dart` (2 tests)
- ✅ Generates simple screen with AppBar and Body
- ✅ Generates screen without AppBar

**File:** `test/generator/widget_generator_test.dart` (7 tests)
- ✅ Widget generation basics
- ✅ Component code generation
- ✅ Import statement generation

**Coverage:** ~40% of generator functionality

---

#### 3. Emitter Tests (3 tests)
**File:** `test/emitters/layout_emitter_test.dart` (3 tests)
- ✅ Emits Text widget
- ✅ Emits Button widget (Filled)
- ✅ Emits TextField widget

**Coverage:** ~30% (only 3 out of 8 node types tested)

**Missing:**
- ❌ Column emission
- ❌ Row emission
- ❌ Icon emission
- ❌ Spacer emission
- ❌ AppBar emission

---

#### 4. Model Tests (11 tests)
**File:** `test/models/ast/ast_node_test.dart` (11 tests)
- ✅ AST node creation
- ✅ Freezed equality/hashCode
- ✅ JSON serialization
- ✅ CopyWith functionality

**Coverage:** ~70% of model functionality

---

#### 5. Example/Integration Tests (3 tests)
**File:** `example/test/widget_test.dart` (1 test)
- ✅ Basic widget smoke test

**File:** `example/test/app_input_test.dart` (1 test)
- ✅ AppInput widget test

**File:** `example/test/golden_test.dart` (1 test)
- ✅ Basic golden test

**Coverage:** Minimal

---

## ❌ NOT TESTED (Critical Gaps)

### 1. Use Cases (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/use_cases/build_all.dart` (398 lines) - **CRITICAL**
- ❌ `lib/src/use_cases/generate_component.dart` (52 lines) - **HIGH**
- ❌ `lib/src/use_cases/generate_screen.dart` (45 lines) - **HIGH**

**Impact:** Main build flow is UNTESTED

---

### 2. CLI Commands (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/cli/build_command.dart` (172 lines) - **CRITICAL**
- ❌ `lib/src/cli/init_command.dart` (141 lines) - **HIGH**
- ❌ `lib/src/cli/clean_command.dart` (46 lines) - **MEDIUM**

**Impact:** User-facing commands UNTESTED

---

### 3. Component Generators (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/generators/component/button_generator.dart` (290 lines)
- ❌ `lib/src/generators/component/text_generator.dart` (~250 lines)
- ❌ `lib/src/generators/component/input_generator.dart` (~250 lines)
- ❌ `lib/src/generators/component/generic_generator.dart` (~200 lines)

**Impact:** Component code generation UNTESTED

---

### 4. Generator Registry (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/generators/generator_registry.dart`

**Impact:** Generator selection logic UNTESTED

---

### 5. Infrastructure (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/infrastructure/dart_code_formatter.dart`
- ❌ `lib/src/infrastructure/local_file_system.dart`
- ❌ `lib/src/infrastructure/memory_file_system.dart`

**Impact:** File I/O and formatting UNTESTED

---

### 6. Theme Generation (0% coverage)
**Files with NO tests:**
- ❌ `lib/src/generator/theme_generator.dart`
- ❌ `lib/src/generator/syntax_generator.dart`

**Impact:** Theme/design system generation UNTESTED

---

### 7. Error Handling (0% coverage)
**No tests for:**
- ❌ Invalid AST nodes
- ❌ Missing files
- ❌ Parse errors
- ❌ Generation errors
- ❌ File write failures

**Impact:** Error paths COMPLETELY UNTESTED

---

### 8. Edge Cases (0% coverage)
**No tests for:**
- ❌ Empty components
- ❌ Deeply nested layouts (10+ levels)
- ❌ Large number of children (100+ items)
- ❌ Special characters in strings
- ❌ Unicode in identifiers
- ❌ Extremely long parameter lists

**Impact:** Edge cases will cause bugs

---

### 9. Integration Tests (0% coverage)
**No tests for:**
- ❌ Full build flow (meta → generated code → compilation)
- ❌ Init command creating project structure
- ❌ Clean command removing generated files
- ❌ Building with different style options
- ❌ Regenerating after meta file changes

**Impact:** End-to-end workflows UNTESTED

---

### 10. Golden/Snapshot Tests (minimal coverage)
**Exists but minimal:**
- ⚠️ `example/test/golden_test.dart` (1 basic test)

**Missing golden tests for:**
- ❌ Button generation → exact code output
- ❌ Text generation → exact code output
- ❌ Screen generation → exact code output
- ❌ Complex nested layouts
- ❌ All component variants

**Impact:** Code generation regression UNDETECTED

---

## Critical Missing Test Categories

### Category 1: Integration Tests (CRITICAL)

**What's needed:**
```dart
// test/integration/full_build_test.dart
test('builds complete project from scratch', () async {
  final tempDir = await createTempProject();

  // Write meta files
  await writeMeta(tempDir, 'button.meta.dart', buttonMetaContent);
  await writeMeta(tempDir, 'login.screen.dart', loginScreenContent);

  // Run build
  final exitCode = await runBuild(tempDir);
  expect(exitCode, 0);

  // Verify generated files exist
  expect(File('${tempDir}/lib/generated/components/app_button.dart'), exists);
  expect(File('${tempDir}/lib/screens/login_screen.dart'), exists);

  // Verify generated code compiles
  final analyzeResult = await Process.run('dart', ['analyze', tempDir]);
  expect(analyzeResult.exitCode, 0);

  // Verify generated code has no lints
  expect(analyzeResult.stdout, contains('No issues found'));
});

test('init command creates correct structure', () async {
  final tempDir = await Directory.systemTemp.createTemp('syntaxify_test_');

  final exitCode = await runInit(tempDir);
  expect(exitCode, 0);

  // Verify directories created
  expect(Directory('${tempDir}/meta'), exists);
  expect(Directory('${tempDir}/lib/syntaxify'), exists);

  // Verify files created
  expect(File('${tempDir}/meta/button.meta.dart'), exists);
  expect(File('${tempDir}/lib/syntaxify/design_system/design_system.dart'), exists);
});
```

---

### Category 2: Golden Tests (HIGH PRIORITY)

**What's needed:**
```dart
// test/golden/button_generation_test.dart
test('generates correct button code', () {
  final component = ComponentDefinition(
    name: 'button',
    className: 'ButtonMeta',
    properties: [
      ComponentProp(name: 'label', type: 'String', isRequired: true),
      ComponentProp(name: 'onPressed', type: 'String?', isRequired: false),
    ],
    variants: [],
  );

  final generator = ButtonGenerator();
  final generated = generator.generate(component: component);

  expect(
    generated,
    equals(File('test/golden/button.golden.dart').readAsStringSync()),
  );
});

// test/golden/screen_generation_test.dart
test('generates correct login screen', () {
  final screen = ScreenDefinition(
    id: 'login',
    layout: AstNode.column(children: [
      AstNode.text(text: 'Welcome'),
      AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
    ]),
  );

  final generator = ScreenGenerator();
  final generated = generator.generate(screen);

  expect(
    generated,
    equals(File('test/golden/login_screen.golden.dart').readAsStringSync()),
  );
});
```

---

### Category 3: Error Path Tests (HIGH PRIORITY)

**What's needed:**
```dart
// test/validation/error_handling_test.dart
test('rejects empty button label', () {
  expect(
    () => AstNode.button(label: ''),
    throwsA(isA<ValidationException>()),
  );
});

test('handles missing meta file gracefully', () async {
  final parser = MetaParser(logger: Logger());
  final result = await parser.parseFile(File('nonexistent.dart'));

  expect(result, isNull);
  // No crash, no exception
});

test('handles malformed meta file', () async {
  final tempFile = File('test/fixtures/malformed.meta.dart');
  await tempFile.writeAsString('this is not valid dart');

  final parser = MetaParser(logger: Logger());
  expect(
    () => parser.parseFile(tempFile),
    throwsA(isA<FormatException>()),
  );
});

test('handles write permission errors', () async {
  final fs = LocalFileSystem();
  final readOnlyPath = '/read-only/file.dart';

  expect(
    () => fs.writeFile(readOnlyPath, 'content'),
    throwsA(isA<FileSystemException>()),
  );
});
```

---

### Category 4: Use Case Tests (CRITICAL)

**What's needed:**
```dart
// test/use_cases/build_all_test.dart
test('BuildAllUseCase generates all components', () async {
  final useCase = BuildAllUseCase(
    fileSystem: MemoryFileSystem(),
    registry: GeneratorRegistry(),
    logger: Logger(),
  );

  final result = await useCase.execute(
    components: [buttonComponent, textComponent],
    screens: [loginScreen],
    tokens: [],
    outputDir: '/output',
    metaDirectoryPath: '/meta',
  );

  expect(result.hasErrors, false);
  expect(result.filesGenerated, 2);
  expect(result.generatedFiles, contains('components/app_button.dart'));
});

// test/use_cases/generate_component_test.dart
test('GenerateComponentUseCase creates correct file', () async {
  final useCase = GenerateComponentUseCase(
    fileSystem: MemoryFileSystem(),
    registry: GeneratorRegistry(),
  );

  final filePath = await useCase.execute(
    component: buttonComponent,
    outputDir: '/output',
  );

  expect(filePath, equals('components/app_button.dart'));
});
```

---

### Category 5: CLI Command Tests (CRITICAL)

**What's needed:**
```dart
// test/cli/build_command_test.dart
test('build command with valid project', () async {
  final command = BuildCommand(logger: Logger());
  final exitCode = await command.run();

  expect(exitCode, 0);
});

test('build command with missing meta dir', () async {
  final command = BuildCommand(logger: Logger());
  // Delete meta directory

  final exitCode = await command.run();
  expect(exitCode, isNot(0));
});

// test/cli/init_command_test.dart
test('init command creates structure', () async {
  final command = InitCommand(logger: Logger());
  final exitCode = await command.run();

  expect(exitCode, 0);
  expect(Directory('meta'), exists);
});
```

---

## Test Coverage by Layer

| Layer | Files | Tested | Coverage | Priority |
|-------|-------|--------|----------|----------|
| **CLI** | 3 | 0 | 0% | CRITICAL |
| **Use Cases** | 3 | 0 | 0% | CRITICAL |
| **Generators** | 8 | 2 | 25% | HIGH |
| **Parsers** | 3 | 3 | 100% | ✅ GOOD |
| **Emitters** | 1 | 1 | 30% | MEDIUM |
| **Models** | 8 | 1 | 60% | MEDIUM |
| **Infrastructure** | 3 | 0 | 0% | MEDIUM |
| **Total** | 51 | 10 | ~25-30% | POOR |

---

## Recommended Testing Roadmap

### Phase 1: Critical Path Coverage (12-16 hours)

**Priority: CRITICAL**

1. **Use Case Tests** (4 hours)
   - Test `BuildAllUseCase.execute()`
   - Test `GenerateComponentUseCase.execute()`
   - Test `GenerateScreenUseCase.execute()`

2. **CLI Command Tests** (4 hours)
   - Test `build` command happy path
   - Test `init` command
   - Test error cases

3. **Integration Tests** (4 hours)
   - Full build flow test
   - Init → Build → Verify
   - Meta change → Rebuild

4. **Error Path Tests** (4 hours)
   - Invalid AST tests
   - Missing file tests
   - Permission error tests

**Target coverage after Phase 1:** 60%

---

### Phase 2: Component Generator Coverage (8-10 hours)

**Priority: HIGH**

5. **Component Generator Tests** (6 hours)
   - Test ButtonGenerator
   - Test TextGenerator
   - Test InputGenerator
   - Test GenericGenerator

6. **Golden Tests** (4 hours)
   - Button golden test
   - Text golden test
   - Screen golden test
   - Complex layout golden test

**Target coverage after Phase 2:** 75%

---

### Phase 3: Edge Cases & Completeness (6-8 hours)

**Priority: MEDIUM**

7. **Edge Case Tests** (3 hours)
   - Deep nesting (10+ levels)
   - Large children count (100+ items)
   - Special characters
   - Unicode

8. **Emitter Completeness** (3 hours)
   - Test all 8 node types
   - Test nested layouts
   - Test props combinations

**Target coverage after Phase 3:** 85%

---

### Phase 4: Infrastructure & Polish (4-6 hours)

**Priority: LOW**

9. **Infrastructure Tests** (2 hours)
   - FileSystem tests
   - CodeFormatter tests

10. **Registry Tests** (2 hours)
    - Generator selection
    - Fallback to generic

**Target coverage after Phase 4:** 90%+

---

## Total Effort Estimate

| Phase | Hours | Priority | Coverage Gain |
|-------|-------|----------|---------------|
| Phase 1 | 12-16 | Critical | 25% → 60% |
| Phase 2 | 8-10 | High | 60% → 75% |
| Phase 3 | 6-8 | Medium | 75% → 85% |
| Phase 4 | 4-6 | Low | 85% → 90%+ |
| **TOTAL** | **30-40** | - | **+65%** |

---

## Comparison with Industry Standards

| Metric | Syntaxify | Industry Standard | Status |
|--------|-----------|-------------------|--------|
| Unit Test Coverage | 25-30% | 70-80% | ❌ Below |
| Integration Tests | None | Required | ❌ Missing |
| Critical Path Coverage | 40% | 100% | ❌ Below |
| Error Path Coverage | 0% | 60-70% | ❌ Missing |
| Golden Tests | Minimal | Common | ⚠️ Incomplete |

---

## Risk Assessment

### HIGH RISK (No Tests)

1. **Build Command** - Main user-facing feature, 0 tests
2. **BuildAllUseCase** - Core build logic, 0 tests
3. **Component Generators** - Code generation, 0 tests
4. **Error Handling** - No error path tests

**Impact:** Bugs likely to reach production

### MEDIUM RISK (Partial Tests)

1. **ScreenGenerator** - 2 basic tests, many edge cases untested
2. **LayoutEmitter** - 3 out of 8 node types tested
3. **Parsers** - Good coverage but missing edge cases

**Impact:** Edge case bugs possible

### LOW RISK (Good Tests)

1. **Models** - Freezed equality/json tested
2. **MetaParser** - Core parsing tested

**Impact:** Low bug likelihood

---

## Key Takeaways

### ❌ What's Missing

1. **No integration tests** - Full workflows untested
2. **No CLI tests** - User-facing commands untested
3. **No use case tests** - Core business logic untested
4. **No error tests** - Error handling untested
5. **No golden tests** - Code generation regression undetected

### ⚠️ What Exists But Is Incomplete

1. Parser tests (60% coverage)
2. Generator tests (25% coverage)
3. Emitter tests (30% coverage)
4. Golden tests (minimal)

### ✅ What's Good

1. Model tests (70% coverage)
2. Basic parsing tested
3. Foundation exists for expansion

---

## Recommendations

### Immediate Actions (Before v1.0)

1. **Add integration tests** - Test full build flow
2. **Add CLI command tests** - Test user-facing features
3. **Add use case tests** - Test core business logic
4. **Add error path tests** - Test failure scenarios

### Long-term Actions

1. Set up code coverage tracking (codecov.io)
2. Add coverage requirements to CI/CD (min 70%)
3. Add golden test infrastructure
4. Add performance benchmarks

---

## CI/CD Integration Recommendations

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: dart-lang/setup-dart@v1

      - name: Install dependencies
        run: dart pub get

      - name: Run tests
        run: dart test --coverage=coverage

      - name: Generate coverage report
        run: dart run coverage:format_coverage --lcov --in=coverage --out=coverage.lcov

      - name: Upload to codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.lcov

      - name: Verify coverage threshold
        run: |
          COVERAGE=$(dart run coverage:test_with_coverage --min-coverage 70)
          if [ $? -ne 0 ]; then
            echo "Coverage below 70%"
            exit 1
          fi
```

---

## Conclusion

**Current State:** POOR (25-30% coverage)
**Target State:** GOOD (70-80% coverage)
**Gap:** 45-55% coverage to add
**Effort:** 30-40 hours

The test coverage is **critically insufficient** for a code generation tool. The main build flow, CLI commands, and error handling are **completely untested**, posing significant risk.

**Recommended:** Prioritize Phase 1 (critical path tests) immediately before adding new features.
