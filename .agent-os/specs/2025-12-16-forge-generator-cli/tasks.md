# Tasks Checklist

Tasks for spec: @.agent-os/specs/2025-12-16-forge-generator-cli/spec.md

## Phase 1 Tasks

### 1. Project Setup
- [x] Create `generator/` folder
- [x] Initialize Dart project with `dart create`
- [x] Set up pubspec.yaml with dependencies
- [x] Create folder structure (bin, lib, test)

### 2. CLI Parser
- [x] Create `bin/forge.dart` entry point
- [x] Implement argument parsing with `args` package
- [x] Add `build` command handler
- [x] Add `clean` command handler
- [x] Add `--component` flag support

### 3. Meta File Parser
- [x] Create `parser/meta_parser.dart`
- [x] Parse class definition from source
- [x] Extract `@MetaComponent` annotation
- [x] Extract field definitions with annotations
- [x] Handle `@Required`, `@Optional`

### 4. Token File Parser
- [x] Create `parser/token_parser.dart`
- [x] Parse token class from source
- [x] Extract token properties with types

### 5. Code Generator
- [x] Create `generator/widget_generator.dart`
- [x] Create file header template
- [x] Create widget class template
- [x] Create build method template
- [x] Use AppTheme.of(context) pattern ✓

### 6. Theme Generator
- [x] Create `generator/theme_generator.dart`
- [x] Generate AppTheme InheritedWidget
- [x] Generate AppThemeData with factory constructors
- [x] Support DesignStyle (material/cupertino/neo)

### 7. File Writer
- [x] Write to `lib/generated/components/` folder
- [x] Write to `lib/generated/theme/` folder
- [x] Copy token files to output
- [x] Generate barrel file (index.dart)
- [x] Format output with dart format

### 8. Integration
- [x] Connect all components in main CLI
- [x] Test with Button component
- [x] Verify output matches architecture (AppTheme pattern)

### 9. Testing
- [x] Unit tests for meta parser (6 tests)
- [x] Unit tests for widget generator (7 tests)
- [ ] Integration test for full flow

## Output Structure (Matches technical_specs.md)

```
lib/generated/
├── components/
│   └── app_button.dart     ← Uses AppTheme.of(context).button
├── theme/
│   └── app_theme.dart      ← InheritedWidget + AppThemeData
├── tokens/
│   └── button_tokens.dart  ← ButtonTokens + ButtonTokensLibrary
└── index.dart              ← Barrel file
```
