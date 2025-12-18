# Testing Strategy

> Testing approach for Syntax compiler and generated code.

---

## Testing Pyramid

```
        E2E (5%)        ← Full screen generation flows
    Integration (20%)   ← Multi-node AST compilation
    Golden Tests (35%)  ← Input AST → Output code snapshots
    Unit Tests (40%)    ← Node parsing, emitter logic
```

---

## 1. Unit Tests

### AST Node Tests
```dart
test('ButtonNode serializes correctly', () {
  final node = ButtonNode(label: 'Login', onPressed: 'login');
  expect(node.onPressed, 'login');  // String, not callback
});
```

### Emitter Logic Tests
```dart
test('emits ElevatedButton from ButtonNode', () {
  final output = FlutterEmitter.emit(ButtonNode(label: 'Go'));
  expect(output, contains('ElevatedButton'));
});
```

---

## 2. Golden Tests (Critical)

### Purpose
Assert exact output from input AST.

```dart
test('login_screen output matches golden', () {
  final ast = parseFile('screens/login.dart');
  final output = FlutterEmitter.generate(ast);
  expect(output, matchesGoldenFile('goldens/login_screen.dart.golden'));
});
```

### Golden File Organization
```
test/
└── goldens/
    ├── login_screen.dart.golden
    ├── settings_screen.dart.golden
    └── ...
```

---

## 3. Validation Tests

```dart
test('rejects callback type in AST', () {
  final invalid = ButtonNode(onPressed: () {});  // Should fail at compile
  expect(() => validate(invalid), throwsA(isA<AstValidationError>()));
});
```

---

## 4. Coverage Requirements

| Area             | Minimum      |
| ---------------- | ------------ |
| AST Node Parsing | 100%         |
| Emitter Logic    | 95%          |
| Validation       | 100%         |
| Golden Tests     | 1 per screen |

---

## 5. CI/CD

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - run: dart test test/unit test/golden
```

---

*Document Version: 2.0 (AST-aligned)*
