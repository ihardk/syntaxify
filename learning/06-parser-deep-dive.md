# Parser Deep Dive 🔍

**Understanding how Syntaxify parses meta files**

This guide explains the parsing system that reads your `.meta.dart` and `.screen.dart` files and extracts component definitions, screen layouts, and enums.

---

## Overview

The parser system converts Dart source files into structured data models:

```
*.meta.dart   →  ComponentDefinition
*.screen.dart →  ScreenDefinition  
enums         →  ComponentEnum
```

### Key Classes

| Class                | Purpose                             |
| -------------------- | ----------------------------------- |
| `MetaParser`         | Entry point, orchestrates parsing   |
| `ComponentExtractor` | Extracts `@SyntaxComponent` classes |
| `EnumExtractor`      | Extracts enum declarations          |
| `PropertyExtractor`  | Extracts class field properties     |
| `AppParser`          | Parses screen layout AST nodes      |

---

## Architecture

```
MetaParser
    │
    ├── Uses Dart Analyzer
    │   to parse source files
    │
    └── _MetaVisitor (AST Visitor)
            │
            ├── visitClassDeclaration
            │   └── ComponentExtractor
            │       └── PropertyExtractor
            │
            ├── visitEnumDeclaration  
            │   └── EnumExtractor
            │
            └── visitTopLevelVariableDeclaration
                └── AppParser (screen layouts)
```

### File Structure

```
lib/src/parser/
├── meta_parser.dart         # Main entry point
├── layout_node_parser.dart  # Screen layout parsing
├── enum_parser.dart         # Enum parsing
├── token_parser.dart        # Token parsing
├── extractors/              # Focused extraction logic
│   ├── component_extractor.dart
│   ├── property_extractor.dart
│   └── extractors.dart      # Barrel file
└── strategies/              # Category-based parse strategies
    ├── interactive_strategy.dart
    ├── primitive_strategy.dart
    ├── structural_strategy.dart
    ├── node_parse_strategy.dart
    └── strategies.dart
```

---

## How Parsing Works

### 1. MetaParser Entry Point

```dart
class MetaParser {
  final Logger logger;

  /// Parse a single meta file
  Future<ComponentDefinition?> parseFile(File file) async {
    final content = await file.readAsString();
    final unitResult = parseString(content: content);

    final visitor = _MetaVisitor();
    unitResult.unit.visitChildren(visitor);

    return visitor.component;
  }

  /// Parse all meta files in a directory
  Future<ParseResult> parseDirectory(Directory directory) async {
    // Finds all .meta.dart and .screen.dart files
    // Returns ParseResult with components, screens, enums, errors
  }
}
```

### 2. AST Visitor Pattern

The `_MetaVisitor` extends Dart's `RecursiveAstVisitor` to walk the AST:

```dart
class _MetaVisitor extends RecursiveAstVisitor<void> {
  final ComponentExtractor _componentExtractor;
  final EnumExtractor _enumExtractor;
  final AppParser _nodeParser;

  ComponentDefinition? component;
  final screens = <ScreenDefinition>[];
  final enums = <ComponentEnum>[];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final extracted = _componentExtractor.extract(node);
    if (extracted != null) {
      component = extracted;
    }
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    enums.add(_enumExtractor.extract(node));
  }

  @override
  void visitTopLevelVariableDeclaration(node) {
    // Look for ScreenDefinition variables
    if (typeName == 'ScreenDefinition') {
      _tryParseScreen(initializer, variable.name.lexeme);
    }
  }
}
```

---

## Extractors

### ComponentExtractor

Extracts component definitions from `@SyntaxComponent` annotated classes:

```dart
class ComponentExtractor {
  final PropertyExtractor _propertyExtractor = PropertyExtractor();

  ComponentDefinition? extract(ClassDeclaration classNode) {
    final metaAnnotation = classNode.metadata
        .where((a) => a.name.toSource() == 'SyntaxComponent')
        .firstOrNull;
    if (metaAnnotation == null) return null;

    // Extract properties from class members
    final properties = <ComponentProp>[];
    for (final member in classNode.members) {
      if (member is FieldDeclaration) {
        for (final variable in member.fields.variables) {
          final prop = _propertyExtractor.extract(variable, member);
          if (prop != null) properties.add(prop);
        }
      }
    }

    return ComponentDefinition(
      name: StringUtils.toSnakeCase(classNode.name.lexeme),
      className: classNode.name.lexeme,
      explicitName: explicitName,
      properties: properties,
      variants: variants,
      description: _propertyExtractor.extractDocComment(classNode),
      typeParameters: typeParameters,
    );
  }
}
```

### PropertyExtractor

Extracts field properties from a class:

```dart
class PropertyExtractor {
  /// Extracts a ComponentProp from a variable declaration
  ComponentProp? extract(
    VariableDeclaration variable,
    FieldDeclaration declaration,
  ) {
    // Check for @Required or @Optional annotations
    final hasRequiredAnnotation = declaration.metadata.any(
      (a) => a.name.toSource() == 'Required',
    );
    
    // Type nullability determines required if no annotation
    final typeName = declaration.fields.type?.toSource() ?? 'dynamic';
    final isRequired = hasRequiredAnnotation || !typeName.endsWith('?');

    return ComponentProp(
      name: variable.name.lexeme,
      type: typeName,
      isRequired: isRequired,
      defaultValue: variable.initializer?.toSource(),
      description: extractDocComment(declaration),
    );
  }

  /// Extracts variants from @Variant annotation
  List<String> extractVariants(FieldDeclaration declaration) { ... }

  /// Extracts documentation comment
  String? extractDocComment(AnnotatedNode node) { ... }
}
```

### EnumExtractor

Extracts enum declarations:

```dart
class EnumExtractor {
  ComponentEnum extract(EnumDeclaration node) {
    final values = node.constants
        .map((c) => c.name.lexeme)
        .toList();

    return ComponentEnum(
      name: node.name.lexeme,
      values: values,
      description: _extractDocComment(node),
    );
  }
}
```

---

## Screen Layout Parsing

### AppParser

Parses screen layout expressions into `App` AST nodes:

```dart
class AppParser {
  ScreenDefinition parseScreenFromExpression(
    Expression expression,
    String varName,
  ) {
    // Parse ScreenDefinition constructor
    final args = _extractNamedArguments(expression);
    
    final id = args['id'] as String;
    final layout = _parseLayoutNode(args['layout']);
    final appBar = _parseAppBar(args['appBar']);

    return ScreenDefinition(
      id: id,
      layout: layout,
      appBar: appBar,
    );
  }

  App _parseLayoutNode(Expression node) {
    // Delegate to appropriate strategy
    return node.map(
      methodInvocation: (m) => _parseMethodInvocation(m),
      prefixedIdentifier: (p) => _parsePrefixedIdentifier(p),
    );
  }
}
```

### Parse Strategies

Each AST node type has a dedicated strategy:

```dart
// strategies/column_strategy.dart
class ColumnStrategy implements ParseStrategy {
  @override
  App parse(MethodInvocation node, AppParser parser) {
    final children = _extractChildren(node)
        .map((child) => parser.parseNode(child))
        .toList();

    return App.column(
      children: children,
      mainAxisAlignment: _extractMainAxisAlignment(node),
      crossAxisAlignment: _extractCrossAxisAlignment(node),
    );
  }
}
```

---

## Output Models

### ComponentDefinition

```dart
@freezed
sealed class ComponentDefinition with _$ComponentDefinition {
  const factory ComponentDefinition({
    required String name,
    required String className,
    String? explicitName,
    required List<ComponentProp> properties,
    required List<String> variants,
    String? description,
    @Default([]) List<String> typeParameters,
  }) = _ComponentDefinition;
}
```

### ParseResult

```dart
@freezed
sealed class ParseResult with _$ParseResult {
  const factory ParseResult({
    required List<ComponentDefinition> components,
    @Default([]) List<ScreenDefinition> screens,
    @Default([]) List<ComponentEnum> enums,
    required List<String> errors,
  }) = _ParseResult;
}
```

---

## Adding New Parsing Features

### Adding a New Annotation Parameter

1. **Update `ComponentExtractor`:**
```dart
String? _extractNewParam(Annotation annotation) {
  final arg = annotation.arguments?.arguments
      .whereType<NamedExpression>()
      .firstWhere((e) => e.name.label.name == 'newParam',
          orElse: () => null);
  return (arg?.expression as StringLiteral?)?.stringValue;
}
```

2. **Update `ComponentDefinition`:**
```dart
const factory ComponentDefinition({
  // ... existing fields
  String? newParam,  // Add new field
}) = _ComponentDefinition;
```

3. **Run build_runner:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Adding a New Layout Node Type

1. **Create strategy in `strategies/`:**
```dart
class MyNodeStrategy implements ParseStrategy {
  @override
  App parse(MethodInvocation node, AppParser parser) {
    // Parse node-specific arguments
    return App.myNode(...);
  }
}
```

2. **Register in `AppParser`:**
```dart
final _strategies = <String, ParseStrategy>{
  'column': ColumnStrategy(),
  'row': RowStrategy(),
  'myNode': MyNodeStrategy(),  // Add new strategy
};
```

---

## Debugging Parsing

### Enable Verbose Logging

```dart
final parser = MetaParser(logger: Logger()..level = Level.verbose);
```

### Print Parsed AST

```dart
final result = parseString(content: source);
print(result.unit.toSource());  // Pretty-print the AST
```

### Common Issues

| Issue               | Cause                      | Fix                |
| ------------------- | -------------------------- | ------------------ |
| Component not found | Missing `@SyntaxComponent` | Add annotation     |
| Properties empty    | Fields not public          | Make fields public |
| Enum not extracted  | Inside class               | Move to top level  |

---

## Related Docs

- **[05-code-generation.md](05-code-generation.md)** - How parsed data becomes code
- **[07-generator-deep-dive.md](07-generator-deep-dive.md)** - Code generation details
- **[12-file-reference.md](12-file-reference.md)** - Parser file descriptions
