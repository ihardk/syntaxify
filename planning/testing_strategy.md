# Meta-UI Testing Strategy

> Comprehensive testing approach for the Meta-UI framework covering generator, generated code, and runtime behavior.

---

## Testing Pyramid

```
                    ┌─────────────────┐
                    │   E2E Tests     │  ← Full app flows
                    │   (5% effort)   │
                    └────────┬────────┘
                             │
               ┌─────────────┴─────────────┐
               │   Integration Tests       │  ← Theme switching, component composition
               │   (20% effort)            │
               └─────────────┬─────────────┘
                             │
          ┌──────────────────┴──────────────────┐
          │         Widget Tests                │  ← Individual component rendering
          │         (35% effort)                │
          └──────────────────┬──────────────────┘
                             │
     ┌───────────────────────┴───────────────────────┐
     │              Unit Tests                       │  ← Token resolution, generator logic
     │              (40% effort)                     │
     └───────────────────────────────────────────────┘
```

---

## 1. Unit Tests

### 1.1 Token Resolution Tests
**Purpose:** Verify tokens resolve correctly for all states and breakpoints.

```dart
// test/tokens/button_tokens_test.dart
void main() {
  group('ButtonTokens', () {
    test('resolves normal state correctly', () {
      final tokens = TokenLibrary.button(DesignStyle.material);
      expect(tokens.bgColor, Colors.deepPurple);
      expect(tokens.radius, 24);
    });

    test('resolves pressed state correctly', () {
      final stateTokens = TokenLibrary.buttonStates(DesignStyle.material);
      final resolved = stateTokens.bgColor.resolve({MaterialState.pressed});
      expect(resolved, Colors.deepPurple.shade700);
    });

    test('all styles have required tokens', () {
      for (final style in DesignStyle.values) {
        final tokens = TokenLibrary.button(style);
        expect(tokens.bgColor, isNotNull);
        expect(tokens.textColor, isNotNull);
        expect(tokens.radius, isNonNegative);
      }
    });
  });
}
```

### 1.2 Generator Logic Tests
**Purpose:** Verify the generator produces correct output.

```dart
// test/generator/generator_test.dart
void main() {
  group('MetaGenerator', () {
    test('generates valid Dart code from meta definition', () {
      final input = MetaButtonDef(label: 'String', onPressed: 'VoidCallback?');
      final output = Generator.generateButton(input);
      
      expect(output, contains('class AppButton'));
      expect(output, contains('final String label'));
      expect(output, isValidDartSyntax);
    });

    test('includes required imports', () {
      final output = Generator.generateButton(testDef);
      expect(output, contains("import 'package:flutter/material.dart'"));
    });

    test('fails gracefully on invalid input', () {
      expect(
        () => Generator.generateButton(invalidDef),
        throwsA(isA<MetaValidationError>()),
      );
    });
  });
}
```

### 1.3 Validation Tests
**Purpose:** Ensure meta definitions are validated before generation.

```dart
// test/validation/meta_validator_test.dart
void main() {
  group('MetaValidator', () {
    test('rejects missing required token', () {
      final def = ButtonTokensDef(radius: 8); // missing bgColor
      final result = MetaValidator.validate(def);
      
      expect(result.isValid, false);
      expect(result.errors, contains('Missing required: bgColor'));
    });

    test('warns on accessibility violation', () {
      final def = ButtonTokensDef(minTouchTarget: 32); // below 48
      final result = MetaValidator.validate(def);
      
      expect(result.warnings, contains('Touch target below 48px'));
    });
  });
}
```

---

## 2. Widget Tests

### 2.1 Component Rendering Tests
**Purpose:** Verify components render correctly with given tokens.

```dart
// test/widgets/button_widget_test.dart
void main() {
  group('AppButton', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(label: 'Click Me', onPressed: () {}),
        ),
      );
      
      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('applies Material tokens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MetaTheme(
            style: DesignStyle.material,
            child: AppButton(label: 'Test', onPressed: () {}),
          ),
        ),
      );
      
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.color, Colors.deepPurple);
      expect(decoration.borderRadius, BorderRadius.circular(24));
    });

    testWidgets('applies Neo tokens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MetaTheme(
            style: DesignStyle.neo,
            child: AppButton(label: 'Test', onPressed: () {}),
          ),
        ),
      );
      
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.border?.top.width, 3);
      expect(decoration.borderRadius, BorderRadius.zero);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(label: 'Test', onPressed: () => pressed = true),
        ),
      );
      
      await tester.tap(find.byType(AppButton));
      expect(pressed, true);
    });

    testWidgets('shows disabled state correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(label: 'Test', onPressed: null), // disabled
        ),
      );
      
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.color?.opacity, lessThan(1.0));
    });
  });
}
```

### 2.2 Accessibility Tests
**Purpose:** Verify accessibility compliance.

```dart
// test/widgets/accessibility_test.dart
void main() {
  group('Accessibility', () {
    testWidgets('button has semantic label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(label: 'Submit Form', onPressed: () {}),
        ),
      );
      
      final semantics = tester.getSemantics(find.byType(AppButton));
      expect(semantics.label, 'Submit Form');
      expect(semantics.hasAction(SemanticsAction.tap), true);
    });

    testWidgets('button meets minimum touch target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(label: 'X', onPressed: () {}),
        ),
      );
      
      final size = tester.getSize(find.byType(AppButton));
      expect(size.width, greaterThanOrEqualTo(48));
      expect(size.height, greaterThanOrEqualTo(48));
    });

    testWidgets('input announces error to screen reader', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppInput(
            placeholder: 'Email',
            errorText: 'Invalid email',
          ),
        ),
      );
      
      final semantics = tester.getSemantics(find.byType(AppInput));
      expect(semantics.value, contains('Invalid email'));
    });
  });
}
```

---

## 3. Golden Tests (Visual Regression)

### 3.1 Setup
```dart
// test/golden_test_config.dart
void main() {
  // Configure for deterministic rendering
  setUpAll(() async {
    await loadAppFonts();  // Ensure fonts are loaded
  });
}
```

### 3.2 Golden Test Examples
```dart
// test/golden/button_golden_test.dart
void main() {
  group('Button Golden Tests', () {
    testWidgets('Material button matches golden', (tester) async {
      await tester.pumpWidget(
        RepaintBoundary(
          child: MaterialApp(
            home: MetaTheme(
              style: DesignStyle.material,
              child: Center(child: AppButton(label: 'CLICK ME', onPressed: () {})),
            ),
          ),
        ),
      );
      
      await expectLater(
        find.byType(RepaintBoundary),
        matchesGoldenFile('goldens/button_material.png'),
      );
    });

    testWidgets('Neo button matches golden', (tester) async {
      await tester.pumpWidget(
        RepaintBoundary(
          child: MaterialApp(
            home: MetaTheme(
              style: DesignStyle.neo,
              child: Center(child: AppButton(label: 'CLICK ME', onPressed: () {})),
            ),
          ),
        ),
      );
      
      await expectLater(
        find.byType(RepaintBoundary),
        matchesGoldenFile('goldens/button_neo.png'),
      );
    });

    testWidgets('all button states match golden', (tester) async {
      await tester.pumpWidget(
        RepaintBoundary(
          child: MaterialApp(
            home: Column(
              children: [
                AppButton(label: 'Normal', onPressed: () {}),
                AppButton(label: 'Disabled', onPressed: null),
                AppButton(label: 'Loading', isLoading: true, onPressed: () {}),
              ],
            ),
          ),
        ),
      );
      
      await expectLater(
        find.byType(RepaintBoundary),
        matchesGoldenFile('goldens/button_states.png'),
      );
    });
  });
}
```

### 3.3 Golden File Organization
```
test/
└── goldens/
    ├── button_material.png
    ├── button_cupertino.png
    ├── button_neo.png
    ├── button_states.png
    ├── input_material.png
    ├── card_neo.png
    └── ...
```

---

## 4. Integration Tests

### 4.1 Theme Switching Tests
```dart
// test/integration/theme_switching_test.dart
void main() {
  group('Theme Switching', () {
    testWidgets('all components update on theme change', (tester) async {
      final themeNotifier = ValueNotifier(DesignStyle.material);
      
      await tester.pumpWidget(
        MaterialApp(
          home: ValueListenableBuilder<DesignStyle>(
            valueListenable: themeNotifier,
            builder: (_, style, __) => MetaTheme(
              style: style,
              child: Column(
                children: [
                  AppButton(label: 'Button', onPressed: () {}),
                  AppBadge(label: 'Badge'),
                  AppInput(placeholder: 'Input'),
                ],
              ),
            ),
          ),
        ),
      );
      
      // Verify Material styling
      expect(_getButtonRadius(tester), 24);
      
      // Switch to Neo
      themeNotifier.value = DesignStyle.neo;
      await tester.pumpAndSettle();
      
      // Verify Neo styling
      expect(_getButtonRadius(tester), 0);
      expect(_getButtonBorderWidth(tester), 3);
    });
  });
}
```

### 4.2 Component Composition Tests
```dart
// test/integration/composition_test.dart
void main() {
  group('Component Composition', () {
    testWidgets('Card contains styled children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MetaTheme(
            style: DesignStyle.material,
            child: AppCard(
              child: Column(
                children: [
                  AppButton(label: 'Nested Button', onPressed: () {}),
                  AppInput(placeholder: 'Nested Input'),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.byType(AppCard), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.byType(AppInput), findsOneWidget);
    });
  });
}
```

---

## 5. E2E Tests (Integration Test Driver)

### 5.1 Full Flow Test
```dart
// integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('complete user flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find and tap button
    await tester.tap(find.text('CLICK ME'));
    await tester.pumpAndSettle();
    
    // Verify snackbar appears
    expect(find.text('Button pressed!'), findsOneWidget);
    
    // Type in input
    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.pumpAndSettle();
    
    // Verify typed text displays
    expect(find.text('You typed: Hello'), findsOneWidget);
    
    // Switch theme
    await tester.tap(find.text('NEO'));
    await tester.pumpAndSettle();
    
    // Verify visual change (could use golden here)
  });
}
```

---

## 6. Generator-Specific Testing

### 6.1 Snapshot Testing for Generated Code
```dart
// test/generator/snapshot_test.dart
void main() {
  group('Generator Snapshots', () {
    test('button output matches snapshot', () {
      final output = Generator.generateButton(standardButtonDef);
      expect(output, matchesSnapshot('snapshots/button.dart.snap'));
    });

    test('theme output matches snapshot', () {
      final output = Generator.generateTheme(materialThemeDef);
      expect(output, matchesSnapshot('snapshots/theme.dart.snap'));
    });
  });
}
```

### 6.2 Round-Trip Testing
```dart
// test/generator/roundtrip_test.dart
void main() {
  test('meta definition survives generation round-trip', () {
    final input = ButtonMeta(
      label: TypeSpec.string,
      onPressed: TypeSpec.voidCallback,
      radius: 8,
    );
    
    final generated = Generator.generate(input);
    final parsed = Generator.parse(generated);
    
    expect(parsed.label, input.label);
    expect(parsed.radius, input.radius);
  });
}
```

---

## 7. Test Coverage Requirements

| Area | Minimum Coverage | Target Coverage |
|------|------------------|-----------------|
| Token Resolution | 90% | 100% |
| Generator Logic | 85% | 95% |
| Widget Rendering | 80% | 90% |
| Accessibility | 100% | 100% |
| Integration | 70% | 80% |

---

## 8. CI/CD Pipeline

```yaml
# .github/workflows/test.yml
name: Test Suite

on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter test --coverage test/tokens test/generator test/validation

  widget-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter test test/widgets

  golden-tests:
    runs-on: macos-latest  # Consistent rendering
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter test test/golden --update-goldens
      - uses: actions/upload-artifact@v3
        with:
          name: golden-failures
          path: test/golden/failures/

  integration-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter test integration_test
```

---

## 9. Test Utilities

### 9.1 Test Helpers (Generated)
```dart
// lib/testing/meta_test_helpers.dart (GENERATED)

/// Creates a test-ready AppButton with defaults
AppButton testButton({
  String label = 'Test Button',
  VoidCallback? onPressed,
  bool isLoading = false,
}) => AppButton(
  label: label,
  onPressed: onPressed ?? () {},
  isLoading: isLoading,
);

/// Creates a test-ready AppInput with defaults
AppInput testInput({
  String placeholder = 'Test Input',
  String? errorText,
  ValueChanged<String>? onChanged,
}) => AppInput(
  placeholder: placeholder,
  errorText: errorText,
  onChanged: onChanged,
);

/// Wraps widget in MetaTheme for testing
Widget wrapWithTheme(Widget child, {DesignStyle style = DesignStyle.material}) {
  return MaterialApp(
    home: MetaTheme(style: style, child: child),
  );
}
```

### 9.2 Custom Matchers
```dart
// test/matchers/meta_matchers.dart

Matcher hasRadius(double expected) => _HasRadius(expected);
Matcher hasBorderWidth(double expected) => _HasBorderWidth(expected);
Matcher hasBackgroundColor(Color expected) => _HasBackgroundColor(expected);
Matcher meetsAccessibilityGuidelines() => _MeetsAccessibility();
```

---

## 10. Testing Checklist (Per Component)

- [ ] Token resolution for all states (normal, hover, pressed, disabled)
- [ ] Token resolution for all design styles (Material, Cupertino, Neo)
- [ ] Widget renders with correct structure
- [ ] Widget applies tokens correctly
- [ ] Widget handles callbacks (onPressed, onChanged, etc.)
- [ ] Accessibility: semantic label present
- [ ] Accessibility: minimum touch target met
- [ ] Golden test for each style
- [ ] Golden test for each state
- [ ] Integration with parent components (Card containing Button)
- [ ] Theme switching updates component

---

*Document Version: 1.0*
*Last Updated: 2025-12-16*
