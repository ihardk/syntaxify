# Writing Tests 🧪

**Complete guide to testing in Syntaxify**

This guide shows you how to write effective tests for Syntaxify components, generators, parsers, and more.

---

## Table of Contents

1. [Test Structure](#test-structure)
2. [Testing Parsers](#testing-parsers)
3. [Testing Generators](#testing-generators)
4. [Testing Emitters](#testing-emitters)
5. [Testing Renderers](#testing-renderers)
6. [Testing Use Cases](#testing-use-cases)
7. [Widget Tests](#widget-tests)
8. [Integration Tests](#integration-tests)
9. [Test Fixtures](#test-fixtures)
10. [Best Practices](#best-practices)

---

## Test Structure

### Directory Organization

```
generator/
├── test/
│   ├── fixtures/                  # Test data files
│   │   ├── button.meta.dart       # Sample component
│   │   └── login.screen.dart      # Sample screen
│   │
│   ├── parser/                    # Parser tests
│   │   ├── meta_parser_test.dart
│   │   └── screen_parser_test.dart
│   │
│   ├── generators/                # Generator tests
│   │   ├── component/
│   │   │   ├── button_generator_test.dart
│   │   │   └── text_generator_test.dart
│   │   └── screen_generator_test.dart
│   │
│   ├── emitters/                  # Emitter tests
│   │   └── layout_emitter_test.dart
│   │
│   ├── use_cases/                 # Use case tests
│   │   ├── generate_component_test.dart
│   │   └── generate_screen_test.dart
│   │
│   └── design_system/             # Renderer tests
│       ├── material/
│       │   └── button_renderer_test.dart
│       └── widget_tests/
│           └── app_button_test.dart
│
└── lib/
    └── src/
```

---

## Testing Parsers

### Testing MetaParser

**File:** `test/parser/meta_parser_test.dart`

```dart
import 'package:test/test.dart';
import 'package:syntaxify/src/parser/meta_parser.dart';
import 'package:syntaxify/src/models/component_definition.dart';

void main() {
  group('MetaParser', () {
    late MetaParser parser;

    setUp(() {
      parser = MetaParser();
    });

    group('parse', () {
      test('parses component with explicit name', () {
        // Arrange
        final filePath = 'test/fixtures/button.meta.dart';

        // Act
        final component = parser.parse(filePath);

        // Assert
        expect(component.name, equals('AppButton'));
        expect(component.className, equals('ButtonMeta'));
        expect(component.explicitName, equals('AppButton'));
      });

      test('parses component properties', () {
        final component = parser.parse('test/fixtures/button.meta.dart');

        expect(component.properties.length, equals(3));

        final labelProp = component.properties
            .firstWhere((p) => p.name == 'label');
        expect(labelProp.type, equals('String'));
        expect(labelProp.isRequired, isTrue);

        final onPressedProp = component.properties
            .firstWhere((p) => p.name == 'onPressed');
        expect(onPressedProp.type, equals('VoidCallback?'));
        expect(onPressedProp.isRequired, isFalse);
      });

      test('parses component description', () {
        final component = parser.parse('test/fixtures/button.meta.dart');

        expect(
          component.description,
          equals('A button component'),
        );
      });

      test('throws on missing @SyntaxComponent annotation', () {
        expect(
          () => parser.parse('test/fixtures/invalid_no_annotation.meta.dart'),
          throwsA(isA<Exception>()),
        );
      });

      test('throws on invalid file path', () {
        expect(
          () => parser.parse('test/fixtures/nonexistent.meta.dart'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('extractVariants', () {
      test('extracts enum variants from properties', () {
        final component = parser.parse('test/fixtures/button.meta.dart');

        expect(component.variants, contains('ButtonVariant'));
      });

      test('returns empty list when no variants', () {
        final component = parser.parse('test/fixtures/simple_text.meta.dart');

        expect(component.variants, isEmpty);
      });
    });
  });
}
```

### Test Fixture Example

**File:** `test/fixtures/button.meta.dart`

```dart
import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// A button component
@SyntaxComponent(
  name: 'AppButton',
  description: 'A button component',
)
class ButtonMeta {
  final String label;
  final ButtonVariant? variant;
  final VoidCallback? onPressed;
}
```

---

## Testing Generators

### Testing ButtonGenerator

**File:** `test/generators/component/button_generator_test.dart`

```dart
import 'package:test/test.dart';
import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/generators/component/button_generator.dart';
import 'package:syntaxify/src/models/component_definition.dart';

void main() {
  group('ButtonGenerator', () {
    late ButtonGenerator generator;

    setUp(() {
      generator = ButtonGenerator();
    });

    group('generate', () {
      test('generates StatelessWidget class', () {
        // Arrange
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: [],
        );

        // Act
        final library = generator.generate(component);

        // Assert
        expect(library.body.length, equals(1));

        final classDecl = library.body.first as Class;
        expect(classDecl.name, equals('AppButton'));
        expect(classDecl.extend?.symbol, equals('StatelessWidget'));
      });

      test('generates constructor with required parameters', () {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(name: 'onPressed', type: 'VoidCallback?', isRequired: false),
          ],
          variants: [],
        );

        final library = generator.generate(component);
        final classDecl = library.body.first as Class;
        final constructor = classDecl.constructors.first;

        // Check constructor is const
        expect(constructor.constant, isTrue);

        // Check parameters
        final params = constructor.optionalParameters;
        expect(params.any((p) => p.name == 'label' && p.required), isTrue);
        expect(params.any((p) => p.name == 'onPressed' && !p.required), isTrue);
      });

      test('generates build method that delegates to style', () {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
          ],
          variants: [],
        );

        final library = generator.generate(component);
        final classDecl = library.body.first as Class;
        final buildMethod = classDecl.methods
            .firstWhere((m) => m.name == 'build');

        expect(buildMethod.returns?.symbol, equals('Widget'));
        expect(buildMethod.annotations.first.code, contains('override'));

        final bodyCode = buildMethod.body.toString();
        expect(bodyCode, contains('AppTheme.of(context)'));
        expect(bodyCode, contains('.style.renderButton'));
      });

      test('generates field declarations', () {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          properties: [
            ComponentProp(name: 'label', type: 'String', isRequired: true),
            ComponentProp(name: 'variant', type: 'ButtonVariant?', isRequired: false),
          ],
          variants: [],
        );

        final library = generator.generate(component);
        final classDecl = library.body.first as Class;

        expect(classDecl.fields.length, equals(2));

        final labelField = classDecl.fields
            .firstWhere((f) => f.name == 'label');
        expect(labelField.type?.symbol, equals('String'));
        expect(labelField.modifier, equals(FieldModifier.final$));

        final variantField = classDecl.fields
            .firstWhere((f) => f.name == 'variant');
        expect(variantField.type?.symbol, equals('ButtonVariant?'));
      });

      test('includes documentation from component definition', () {
        final component = ComponentDefinition(
          name: 'AppButton',
          className: 'ButtonMeta',
          description: 'A button component for user actions',
          properties: [],
          variants: [],
        );

        final library = generator.generate(component);
        final classDecl = library.body.first as Class;

        expect(classDecl.docs.isNotEmpty, isTrue);
        expect(
          classDecl.docs.first,
          contains('A button component for user actions'),
        );
      });
    });
  });
}
```

---

## Testing Emitters

### Testing LayoutEmitter

**File:** `test/emitters/layout_emitter_test.dart`

```dart
import 'package:test/test.dart';
import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast_node.dart';

void main() {
  group('LayoutEmitter', () {
    late LayoutEmitter emitter;

    setUp(() {
      emitter = LayoutEmitter();
    });

    group('emit', () {
      test('emits Column for ColumnNode', () {
        // Arrange
        final node = AstNode.column(
          children: [
            AstNode.text(text: 'Hello'),
          ],
        );

        // Act
        final expression = emitter.emit(node);

        // Assert
        final code = expression.accept(DartEmitter()).toString();
        expect(code, contains('Column'));
        expect(code, contains('children:'));
      });

      test('emits Row for RowNode', () {
        final node = AstNode.row(
          children: [
            AstNode.text(text: 'Left'),
            AstNode.text(text: 'Right'),
          ],
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('Row'));
        expect(code, contains('children:'));
      });

      test('emits AppText for TextNode', () {
        final node = AstNode.text(
          text: 'Hello World',
          variant: TextVariant.headlineMedium,
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('AppText'));
        expect(code, contains("text: 'Hello World'"));
        expect(code, contains('TextVariant.headlineMedium'));
      });

      test('emits AppButton for ButtonNode', () {
        final node = AstNode.button(
          label: 'Click Me',
          onPressed: 'handleClick',
          variant: ButtonVariant.primary,
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('AppButton'));
        expect(code, contains("label: 'Click Me'"));
        expect(code, contains('onPressed: handleClick'));
        expect(code, contains('ButtonVariant.primary'));
      });

      test('emits AppInput for TextFieldNode', () {
        final node = AstNode.textField(
          label: 'Email',
          placeholder: 'you@example.com',
          keyboardType: KeyboardType.email,
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('AppInput'));
        expect(code, contains("label: 'Email'"));
        expect(code, contains("placeholder: 'you@example.com'"));
        expect(code, contains('KeyboardType.email'));
      });

      test('emits nested layout correctly', () {
        final node = AstNode.column(
          children: [
            AstNode.text(text: 'Header'),
            AstNode.row(
              children: [
                AstNode.button(label: 'Cancel', onPressed: 'onCancel'),
                AstNode.button(label: 'OK', onPressed: 'onOk'),
              ],
            ),
          ],
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('Column'));
        expect(code, contains('AppText'));
        expect(code, contains('Row'));
        expect(code, contains('AppButton'));
      });

      test('emits SizedBox for SpacerNode', () {
        final node = AstNode.spacer(height: 24);

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('SizedBox'));
        expect(code, contains('height: 24'));
      });

      test('handles empty children list', () {
        final node = AstNode.column(children: []);

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('Column'));
        expect(code, contains('children: []'));
      });

      test('includes alignment parameters', () {
        final node = AstNode.column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        );

        final expression = emitter.emit(node);
        final code = expression.accept(DartEmitter()).toString();

        expect(code, contains('mainAxisAlignment: MainAxisAlignment.center'));
        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.start'));
      });
    });
  });
}
```

---

## Testing Renderers

### Testing MaterialButtonRenderer

**File:** `test/design_system/material/button_renderer_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/design_system.dart';

void main() {
  group('MaterialButtonRenderer', () {
    late MaterialStyle style;

    setUp(() {
      style = const MaterialStyle();
    });

    group('buttonTokens', () {
      test('returns Material Design tokens', () {
        final tokens = style.buttonTokens;

        expect(tokens.primaryBackgroundColor, equals(Colors.blue));
        expect(tokens.borderRadius, equals(8.0));
        expect(tokens.paddingVertical, greaterThan(0));
      });
    });

    group('renderButton', () {
      testWidgets('renders ElevatedButton', (tester) async {
        // Arrange
        final button = style.renderButton(
          label: 'Test Button',
          variant: ButtonVariant.primary,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: button,
            ),
          ),
        );

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Test Button'), findsOneWidget);
      });

      testWidgets('calls onPressed when tapped', (tester) async {
        // Arrange
        var tapped = false;
        final button = style.renderButton(
          label: 'Tap Me',
          onPressed: () => tapped = true,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: button,
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        expect(tapped, isTrue);
      });

      testWidgets('renders primary variant correctly', (tester) async {
        final button = style.renderButton(
          label: 'Primary',
          variant: ButtonVariant.primary,
        );

        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: button)),
        );

        final elevatedButton = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(elevatedButton, isNotNull);
        // Additional styling checks...
      });

      testWidgets('is disabled when onPressed is null', (tester) async {
        final button = style.renderButton(
          label: 'Disabled',
          onPressed: null,
        );

        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: button)),
        );

        final elevatedButton = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(elevatedButton.onPressed, isNull);
      });
    });
  });
}
```

---

## Testing Use Cases

### Testing GenerateComponentsUseCase

**File:** `test/use_cases/generate_component_test.dart`

```dart
import 'dart:io';
import 'package:test/test.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';

void main() {
  group('GenerateComponentsUseCase', () {
    late GenerateComponentsUseCase useCase;
    late Directory tempDir;

    setUp(() {
      useCase = GenerateComponentsUseCase();

      // Create temp directory for test files
      tempDir = Directory.systemTemp.createTempSync('syntaxify_test_');
      Directory.current = tempDir;

      // Create meta directory
      Directory('meta').createSync();
    });

    tearDown(() {
      // Cleanup
      tempDir.deleteSync(recursive: true);
    });

    group('execute', () {
      test('finds meta files in meta directory', () async {
        // Arrange
        final metaFile = File('meta/button.meta.dart');
        metaFile.writeAsStringSync('''
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
}
''');

        // Act
        await useCase.execute();

        // Assert
        expect(
          File('lib/generated/components/app_button.dart').existsSync(),
          isTrue,
        );
      });

      test('generates component for each meta file', () async {
        // Create multiple meta files
        File('meta/button.meta.dart').writeAsStringSync('''
@SyntaxComponent(name: 'AppButton')
class ButtonMeta { final String label; }
''');

        File('meta/text.meta.dart').writeAsStringSync('''
@SyntaxComponent(name: 'AppText')
class TextMeta { final String text; }
''');

        await useCase.execute();

        expect(
          File('lib/generated/components/app_button.dart').existsSync(),
          isTrue,
        );
        expect(
          File('lib/generated/components/app_text.dart').existsSync(),
          isTrue,
        );
      });

      test('throws when meta directory does not exist', () async {
        // Remove meta directory
        Directory('meta').deleteSync();

        expect(
          () => useCase.execute(),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
```

---

## Widget Tests

### Testing Generated Components

**File:** `test/design_system/widget_tests/app_button_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/design_system.dart';
import 'package:syntaxify/generated/components.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders with Material style', (tester) async {
      await tester.pumpWidget(
        AppTheme(
          style: const MaterialStyle(),
          child: MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Test Button',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders with Cupertino style', (tester) async {
      await tester.pumpWidget(
        AppTheme(
          style: const CupertinoStyle(),
          child: MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Test Button',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed callback when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        AppTheme(
          style: const MaterialStyle(),
          child: MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Tap Me',
                onPressed: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('supports different variants', (tester) async {
      await tester.pumpWidget(
        AppTheme(
          style: const MaterialStyle(),
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppButton(
                    label: 'Primary',
                    variant: ButtonVariant.primary,
                  ),
                  AppButton(
                    label: 'Secondary',
                    variant: ButtonVariant.secondary,
                  ),
                  AppButton(
                    label: 'Text',
                    variant: ButtonVariant.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
    });

    testWidgets('throws without AppTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(label: 'Test'),
          ),
        ),
      );

      expect(tester.takeException(), isNotNull);
    });
  });
}
```

---

## Integration Tests

### Testing Full Generation Flow

**File:** `test/integration/full_generation_test.dart`

```dart
import 'dart:io';
import 'package:test/test.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/use_cases/generate_screen.dart';

void main() {
  group('Full Generation Flow', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('syntaxify_integration_');
      Directory.current = tempDir;
      Directory('meta').createSync();
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('generates complete component with all renderers', () async {
      // Create meta file
      File('meta/card.meta.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(name: 'AppCard', description: 'A card component')
class CardMeta {
  final String title;
  final String? subtitle;
  final Widget? child;
}
''');

      // Generate
      await GenerateComponentsUseCase().execute();

      // Verify component file
      final componentFile = File('lib/generated/components/app_card.dart');
      expect(componentFile.existsSync(), isTrue);

      final componentContent = componentFile.readAsStringSync();
      expect(componentContent, contains('class AppCard'));
      expect(componentContent, contains('extends StatelessWidget'));
      expect(componentContent, contains('final String title'));

      // Verify renderers for all styles
      expect(
        File('design_system/styles/material/card_renderer.dart').existsSync(),
        isTrue,
      );
      expect(
        File('design_system/styles/cupertino/card_renderer.dart').existsSync(),
        isTrue,
      );
      expect(
        File('design_system/styles/neo/card_renderer.dart').existsSync(),
        isTrue,
      );
    });

    test('generates screen with callbacks', () async {
      // Create screen definition
      File('meta/profile.screen.dart').writeAsStringSync('''
import 'package:syntaxify/syntaxify.dart';

final profileScreen = ScreenDefinition(
  id: 'profile',
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Profile'),
      AstNode.button(label: 'Logout', onPressed: 'handleLogout'),
      AstNode.button(label: 'Settings', onPressed: 'handleSettings'),
    ],
  ),
);
''');

      // Generate
      await GenerateScreenUseCase().execute();

      // Verify screen file
      final screenFile = File('lib/screens/profile_screen.dart');
      expect(screenFile.existsSync(), isTrue);

      final screenContent = screenFile.readAsStringSync();
      expect(screenContent, contains('class ProfileScreen'));
      expect(screenContent, contains('final VoidCallback? handleLogout'));
      expect(screenContent, contains('final VoidCallback? handleSettings'));
      expect(screenContent, contains('onPressed: handleLogout'));
      expect(screenContent, contains('onPressed: handleSettings'));
    });
  });
}
```

---

## Test Fixtures

### Creating Reusable Fixtures

**File:** `test/fixtures/test_fixtures.dart`

```dart
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/ast_node.dart';

class TestFixtures {
  static ComponentDefinition buttonComponent() {
    return const ComponentDefinition(
      name: 'AppButton',
      className: 'ButtonMeta',
      explicitName: 'AppButton',
      description: 'A button component',
      properties: [
        ComponentProp(
          name: 'label',
          type: 'String',
          isRequired: true,
        ),
        ComponentProp(
          name: 'onPressed',
          type: 'VoidCallback?',
          isRequired: false,
        ),
        ComponentProp(
          name: 'variant',
          type: 'ButtonVariant?',
          isRequired: false,
        ),
      ],
      variants: ['ButtonVariant'],
    );
  }

  static AstNode loginScreenLayout() {
    return AstNode.column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AstNode.text(
          text: 'Welcome Back',
          variant: TextVariant.headlineMedium,
        ),
        AstNode.spacer(height: 24),
        AstNode.textField(
          label: 'Email',
          keyboardType: KeyboardType.email,
        ),
        AstNode.spacer(height: 16),
        AstNode.textField(
          label: 'Password',
          obscureText: true,
        ),
        AstNode.spacer(height: 32),
        AstNode.button(
          label: 'Sign In',
          onPressed: 'handleLogin',
        ),
      ],
    );
  }
}
```

**Usage:**

```dart
import 'package:test/test.dart';
import 'test/fixtures/test_fixtures.dart';

void main() {
  test('generates button component', () {
    final component = TestFixtures.buttonComponent();
    // Use in test...
  });

  test('emits login screen layout', () {
    final layout = TestFixtures.loginScreenLayout();
    // Use in test...
  });
}
```

---

## Best Practices

### 1. Use Descriptive Test Names

```dart
// ❌ BAD
test('test1', () { });

// ✅ GOOD
test('parses component with explicit name from @SyntaxComponent annotation', () { });
```

### 2. Follow AAA Pattern

```dart
test('emits Column for ColumnNode', () {
  // Arrange - Set up test data
  final node = AstNode.column(children: []);

  // Act - Execute the code under test
  final expression = emitter.emit(node);

  // Assert - Verify the result
  expect(expression.toString(), contains('Column'));
});
```

### 3. Test One Thing Per Test

```dart
// ❌ BAD - Testing multiple things
test('parser works correctly', () {
  expect(parser.parse('...').name, equals('AppButton'));
  expect(parser.parse('...').properties.length, equals(3));
  expect(parser.parse('...').description, isNotNull);
});

// ✅ GOOD - Separate tests
test('parses component name', () {
  expect(parser.parse('...').name, equals('AppButton'));
});

test('parses component properties', () {
  expect(parser.parse('...').properties.length, equals(3));
});

test('parses component description', () {
  expect(parser.parse('...').description, isNotNull);
});
```

### 4. Use setUp and tearDown

```dart
group('MetaParser', () {
  late MetaParser parser;
  late Directory tempDir;

  setUp(() {
    parser = MetaParser();
    tempDir = Directory.systemTemp.createTempSync();
    Directory.current = tempDir;
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  // Tests...
});
```

### 5. Test Edge Cases

```dart
group('LayoutEmitter', () {
  test('handles empty children list', () {
    final node = AstNode.column(children: []);
    final result = emitter.emit(node);
    expect(result, isNotNull);
  });

  test('handles null optional parameters', () {
    final node = AstNode.button(label: 'Test', onPressed: null);
    final result = emitter.emit(node);
    expect(result, isNotNull);
  });

  test('handles deeply nested layout', () {
    final node = AstNode.column(
      children: [
        AstNode.row(
          children: [
            AstNode.column(
              children: [
                AstNode.text(text: 'Deep'),
              ],
            ),
          ],
        ),
      ],
    );
    final result = emitter.emit(node);
    expect(result, isNotNull);
  });
});
```

### 6. Use Matchers Effectively

```dart
// String matchers
expect(code, contains('AppButton'));
expect(code, startsWith('class'));
expect(code, endsWith('}'));
expect(code, matches(RegExp(r'final \w+ \w+;')));

// Number matchers
expect(count, greaterThan(0));
expect(count, lessThanOrEqualTo(10));
expect(value, closeTo(3.14, 0.01));

// Collection matchers
expect(list, isEmpty);
expect(list, isNotEmpty);
expect(list, hasLength(3));
expect(list, contains('item'));
expect(list, containsAll(['a', 'b']));

// Type matchers
expect(widget, isA<ElevatedButton>());
expect(exception, isA<ParseException>());

// Null matchers
expect(value, isNull);
expect(value, isNotNull);
```

### 7. Test Error Cases

```dart
test('throws on invalid input', () {
  expect(
    () => parser.parse('invalid/path'),
    throwsA(isA<FileSystemException>()),
  );
});

test('throws with helpful error message', () {
  expect(
    () => parser.parse('meta/invalid.dart'),
    throwsA(
      predicate((e) =>
        e.toString().contains('No @SyntaxComponent annotation found'),
      ),
    ),
  );
});
```

### 8. Mock External Dependencies

```dart
import 'package:mocktail/mocktail.dart';

class MockFileSystem extends Mock implements FileSystem {}

void main() {
  group('GenerateComponentsUseCase', () {
    late MockFileSystem mockFs;
    late GenerateComponentsUseCase useCase;

    setUp(() {
      mockFs = MockFileSystem();
      useCase = GenerateComponentsUseCase(fileSystem: mockFs);
    });

    test('calls file system to write generated code', () {
      // Arrange
      when(() => mockFs.writeFile(any(), any()))
          .thenAnswer((_) async => {});

      // Act
      await useCase.execute();

      // Assert
      verify(() => mockFs.writeFile(
        'lib/generated/components/app_button.dart',
        any(),
      )).called(1);
    });
  });
}
```

---

## Running Tests

### Run All Tests

```bash
cd generator
dart test
```

### Run Specific Test File

```bash
dart test test/parser/meta_parser_test.dart
```

### Run Tests with Coverage

```bash
dart test --coverage=coverage
dart pub global activate coverage
dart pub global run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --report-on=lib
```

### Run Tests in Watch Mode

```bash
# Using fswatch (macOS) or inotifywait (Linux)
fswatch -o test/ lib/ | xargs -n1 -I{} dart test
```

### Run Widget Tests

```bash
cd generator/example
flutter test
```

---

## Coverage Goals

**Target coverage:** 70-80%

**Critical areas (should have >90% coverage):**
- Parsers
- Generators
- Emitters
- Use cases

**Lower priority (can have <70% coverage):**
- CLI commands (integration tested)
- Renderer mixins (widget tested)

**Check coverage:**

```bash
dart test --coverage=coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Continuous Integration

**GitHub Actions workflow:**

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: dart-lang/setup-dart@v1
        with:
          sdk: stable

      - name: Install dependencies
        run: cd generator && dart pub get

      - name: Run analyzer
        run: cd generator && dart analyze

      - name: Run tests
        run: cd generator && dart test

      - name: Check coverage
        run: |
          cd generator
          dart test --coverage=coverage
          dart pub global activate coverage
          dart pub global run coverage:format_coverage \
            --lcov \
            --in=coverage \
            --out=coverage/lcov.info \
            --report-on=lib

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./generator/coverage/lcov.info
```

---

## Summary

**Test Types:**
- ✅ Unit tests - Parsers, generators, emitters
- ✅ Widget tests - Rendered components
- ✅ Integration tests - Full generation flow
- ✅ Fixture-based tests - Reusable test data

**Best Practices:**
- Descriptive test names
- AAA pattern (Arrange, Act, Assert)
- One assertion per test
- Test edge cases
- Use setUp/tearDown
- Mock external dependencies

**Coverage:**
- Target: 70-80%
- Critical areas: >90%
- Run with `dart test --coverage`

---

**Happy testing!** 🧪✅
