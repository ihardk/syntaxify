# Syntaxify Coding Standards

## Core Principles

### 1. SOLID Design Principles

| Principle                     | Application in Syntaxify                                       |
| ----------------------------- | -------------------------------------------------------------- |
| **S** - Single Responsibility | Each class does one thing (Parser parses, Generator generates) |
| **O** - Open/Closed           | Extend via new renderers, don't modify existing                |
| **L** - Liskov Substitution   | All renderers are interchangeable                              |
| **I** - Interface Segregation | Small, focused interfaces (not god interfaces)                 |
| **D** - Dependency Inversion  | Depend on abstractions (e.g., `FileSystem` interface)          |

### 2. Clean Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION                             │
│   CLI commands, output formatting, user interaction          │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     USE CASES                                │
│   GenerateComponent, ParseMeta, ValidateTokens               │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN                                   │
│   MetaSpec, TokenDefinition, ComponentModel (pure Dart)      │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     DATA / INFRASTRUCTURE                    │
│   FileParser, CodeWriter, AnalyzerAdapter                    │
└─────────────────────────────────────────────────────────────┘
```

### 3. TDD/BDD Approach

```dart
// Write test FIRST (Red)
test('should parse @MetaComponent annotation', () {
  final result = parser.parse(buttonMetaSource);
  expect(result.componentName, equals('Button'));
  expect(result.fields, hasLength(3));
});

// Then implement (Green)
// Then refactor (Refactor)
```

**BDD for feature specs:**
```gherkin
Feature: Component Generation

  Scenario: Generate button from meta
    Given a meta file "button.meta.dart"
    When I run "syntaxify build"
    Then "app_button.dart" should exist
    And it should compile without errors
```

### 4. Design Patterns

| Pattern             | Usage                               |
| ------------------- | ----------------------------------- |
| **Factory**         | `ComponentFactory.create(metaType)` |
| **Strategy**        | Different renderers per theme       |
| **Builder**         | Code generation with `CodeBuilder`  |
| **Template Method** | Base renderer with hooks            |
| **Visitor**         | AST traversal for parsing           |
| **Repository**      | File system abstraction             |

## Generated Code Standards

### State Management Agnostic

Generated code uses simple `InheritedWidget` for theme access:

```dart
// Generated - works with ANY state management
class SyntaxTheme extends InheritedWidget {
  final SyntaxThemeData data;
  
  static SyntaxThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SyntaxTheme>()!.data;
  }
}

// User wraps with their choice:
// - Riverpod: ProviderScope wraps SyntaxTheme
// - Bloc: BlocProvider wraps SyntaxTheme
// - GetX: GetMaterialApp wraps SyntaxTheme
```

### No Framework Lock-in

Generated widgets are pure Flutter:
- ✅ No Riverpod imports
- ✅ No Bloc imports
- ✅ No GetX imports
- ✅ Works with `StatelessWidget` / `StatefulWidget`

## File Naming

- `snake_case.dart` for all files
- Tests: `{name}_test.dart`
- Generated: `app_{component}.dart`

## Documentation

- All public APIs have dartdoc
- Examples in doc comments
- Link to Syntaxify docs
