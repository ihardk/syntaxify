# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Syntaxify is a **compile-time UI compiler for Flutter** that solves the "1:N problem" - enabling one codebase to render in multiple design systems (Material, Cupertino, custom brands). It's a Dart CLI tool (v0.2.0-beta) that generates production-ready Flutter code from declarative `.meta.dart` definitions.

**Core Innovation:** Separates WHAT (component intent) from HOW (visual rendering) using a renderer pattern. Change `AppTheme(style: MaterialStyle())` to `AppTheme(style: CupertinoStyle())` and the entire app switches design systems.

## Repository Structure

```
syntaxify/
├── generator/              # The CLI tool (package:syntaxify)
│   ├── bin/               # CLI entry point
│   ├── lib/src/           # Core implementation
│   │   ├── cli/          # Command implementations (init, build, clean)
│   │   ├── parser/       # AST parsing (reads .meta.dart, .screen.dart)
│   │   ├── emitters/     # Code generation (emits Flutter widgets)
│   │   ├── generators/   # Component-specific generators
│   │   ├── models/       # Domain models (App AST, ComponentDefinition)
│   │   ├── use_cases/    # Orchestration layer
│   │   └── validation/   # Validation engine
│   ├── design_system/     # Template design system (copied to user projects)
│   ├── meta/              # Built-in component definitions
│   ├── test/              # 303 tests (unit, integration, golden)
│   ├── example/           # Demo app showing all features
│   └── docs/              # User & developer documentation
└── planning/              # Roadmap and architecture docs
```

## Development Commands

### Working in `generator/` (The CLI Package)

```bash
# Install dependencies
cd generator
dart pub get

# Run all tests (303 tests)
dart test

# Run specific test file
dart test test/parser/extractors/component_extractor_test.dart

# Run tests matching pattern
dart test --name "component extraction"

# Run with coverage (if needed)
dart test --coverage=coverage

# Build the generator locally
dart pub get

# Run the generator against example app
cd example
dart run syntaxify build

# Run with watch mode (continuous rebuilding)
dart run syntaxify build --watch

# Dry run (preview without writing)
dart run syntaxify build --dry-run

# Build specific component only
dart run syntaxify build --component=AppButton

# Clean generated files
dart run syntaxify clean
```

### Running the Example App

```bash
cd generator/example
flutter run

# The example demonstrates:
# - 5 tabs with different component categories
# - Live style switching (Material/Cupertino/Neo)
# - 3 generated screens (home, login, register)
# - All 7 interactive components
```

### Code Generation & Freezed

```bash
# Regenerate freezed models (if you modify @freezed classes)
cd generator
dart run build_runner build

# Watch mode for continuous generation
dart run build_runner watch

# Clean and rebuild
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

## Architecture Deep Dive

### The Compilation Pipeline

**Input → Parsing → Validation → Emission → Output**

1. **Parsing Phase** (`lib/src/parser/`)
   - `ComponentExtractor` reads `.meta.dart` files using Dart's `analyzer` package
   - `AppParser` parses `.screen.dart` files into `App` AST (sealed union)
   - Uses **Strategy Pattern**: `StructuralNodeStrategy`, `PrimitiveNodeStrategy`, `InteractiveNodeStrategy`

2. **Validation Phase** (`lib/src/validation/`)
   - `LayoutValidator` (484 lines) performs hierarchical validation
   - Catches: empty values, invalid identifiers, empty containers, conflicting properties
   - Provides helpful error suggestions

3. **Emission Phase** (`lib/src/emitters/`)
   - `LayoutEmitter` walks AST using **Visitor Pattern**
   - Delegates to emission strategies per node type
   - Uses `code_builder` for programmatic Dart code generation

4. **Generation Phase** (`lib/src/generators/`)
   - `DesignSystemGenerator` creates the `DesignStyle` sealed class
   - `ComponentGenerator` implementations create `App*` wrapper components
   - `ScreenGenerator` creates StatefulWidget screens (editable after generation)

### The Renderer Pattern

**Core architectural innovation:**

```dart
// The Contract (sealed class in lib/syntaxify/design_system/design_style.dart)
sealed class DesignStyle {
  Widget renderButton({required String label, ...});
  Widget renderToggle({required bool value, ...});
  // ... render methods for all 7 components
}

// Implementations (Material, Cupertino, Neo)
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer, MaterialToggleRenderer, ... {
  // Material Design rendering
}

// Generated Components (delegate to style)
class AppButton extends StatelessWidget {
  build(context) {
    return AppTheme.of(context).style.renderButton(...);
  }
}
```

**Result:** One component definition works across all design systems. Change style at runtime.

### AST Structure (Sealed Unions)

The `App` type is a **sealed union** (using Freezed) with 4 categories:

```dart
sealed class App {
  App.structural(StructuralNode node)  // Column, Row, Container, Card, Stack, etc.
  App.primitive(PrimitiveNode node)    // Text, Icon, Image, Divider, Spacer, etc.
  App.interactive(InteractiveNode node) // Button, TextField, Checkbox, Toggle, etc.
  App.custom(CustomNode node)          // User-defined components (e.g., SuperCard)
}
```

**Pattern matching:** Use `.when()`, `.maybeWhen()`, or `.map()` for exhaustive handling.

### Key Design Patterns Used

1. **Sealed Classes** (Freezed) - Type-safe union types for AST nodes
2. **Strategy Pattern** - Parsing and emission strategies per node category
3. **Visitor Pattern** - `LayoutEmitter` walks AST and emits code
4. **Builder Pattern** - `code_builder` for programmatic code generation
5. **Renderer Pattern** - Separation of component definition from visual implementation
6. **Plugin Architecture** - `SyntaxifyPlugin` interface for extensibility
7. **Registry Pattern** - `GeneratorRegistry` for component and emitter handlers

## Important Implementation Details

### Meta File Parsing

**Location:** `lib/src/parser/extractors/component_extractor.dart`

Recent enhancement (57 new lines): Now analyzes **constructor parameters** to extract:
- Default values from constructor (e.g., `enabled = true`)
- `required` keyword detection
- Updates `ComponentDefinition` properties with accurate metadata

**Why this matters:** Ensures generated components have correct default values and required/optional parameters.

### Screen Generation vs Component Generation

**Two different lifecycles:**

1. **Components** (`lib/syntaxify/generated/components/*.dart`)
   - Regenerated on EVERY `syntaxify build`
   - DO NOT EDIT - changes will be lost
   - Driven by `.meta.dart` files

2. **Screens** (`lib/screens/*.dart`)
   - Generated ONCE (if file doesn't exist)
   - You OWN the code after generation
   - Freely editable - won't be overwritten

### Build Cache System

**Location:** `lib/src/use_cases/build_all_use_case.dart`

Uses SHA-256 content hashing + timestamp checking:
- Calculates hash of `.meta.dart` content
- Compares with previous build cache
- Only regenerates changed files

**Performance:** Incremental builds skip unchanged components.

## Testing Strategy

**303 tests across multiple categories:**

### Unit Tests (`test/`)
- `parser/` - AST parsing, extractors, strategies
- `emitters/` - Code emission, strategies
- `generators/` - Component generation logic
- `validation/` - Error detection and messages
- `models/` - Domain model behavior

### Integration Tests (`test/integration/`)
- `full_build_test.dart` - End-to-end build pipeline
- `all_ast_nodes_e2e_test.dart` - All 26 node types
- `plugin_e2e_test.dart` - Plugin system
- `phase1_e2e_test.dart` - Phase 1 features

### Golden Tests (`test/golden/`)
- `button_generation_golden_test.dart` - Snapshot testing of generated code
- Ensures generated output consistency across changes

### Running Specific Test Categories

```bash
# All parser tests
dart test test/parser/

# All emitter tests
dart test test/emitters/

# Integration tests only
dart test test/integration/

# Golden tests
dart test test/golden/
```

## Common Development Tasks

### Adding a New Component

1. **Define meta file** in `generator/meta/{component}.meta.dart`:
```dart
@SyntaxComponent(description: 'A design-system-aware component')
class ComponentMeta {
  @Required()
  final String requiredProp;

  @Optional()
  @Default('defaultValue')
  final String? optionalProp;
}
```

2. **Run build** to auto-generate:
   - `lib/syntaxify/generated/components/app_{component}.dart`
   - `lib/syntaxify/design_system/components/{component}/*_renderer.dart` (stubs)
   - `DesignStyle.render{Component}()` method

3. **Implement renderers** (Material, Cupertino, Neo) in design system

4. **Add tests** in `test/integration/all_ast_nodes_e2e_test.dart`

### Debugging the Generator

**VSCode launch configuration** (`.vscode/launch.json`):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Build (Example)",
      "request": "launch",
      "type": "dart",
      "program": "bin/syntaxify.dart",
      "args": ["build", "--verbose"],
      "cwd": "${workspaceFolder}/example"
    }
  ]
}
```

Set breakpoints in `lib/src/generators/` and run "Debug Build (Example)".

### Modifying the AST

**Key files:**
- `lib/src/models/ast/layout_node.dart` - Root `App` sealed class
- `lib/src/models/ast/structural/structural_node.dart` - Structural nodes
- `lib/src/models/ast/primitive/primitive_node.dart` - Primitive nodes
- `lib/src/models/ast/interactive/interactive_node.dart` - Interactive nodes

**After modifying @freezed classes:**
```bash
dart run build_runner build
```

### Recent Breaking Change: Switch → Toggle

**Commit:** Renamed `AppSwitch` to `AppToggle` (component + renderers)

**Affected files:**
- Deleted: `components/switch/*.dart` (9 files)
- Added: `components/toggle/*.dart` (9 files)
- Updated: All README references, design system contracts

**Reason:** Better naming convention, avoids confusion with Dart's `switch` keyword.

## Configuration Files

### `syntaxify.yaml`

Project-level configuration (auto-detected in user projects):

```yaml
# Source meta files
meta: meta

# Output directory
output: lib/syntaxify

# Design system directory
design_system: lib/syntaxify/design_system

# Tokens directory
tokens: lib/syntaxify/design_system

# Generation options
generate:
  screens: true
  components: true
```

### `analysis_options.yaml`

**Important:** Exclude `meta/` directory from analysis:

```yaml
analyzer:
  exclude:
    - meta/**
```

**Why:** Meta files use Syntaxify's DSL (e.g., `App.button()`) which triggers false Dart analyzer errors.

## Documentation Files

- `generator/README.md` - User-facing package documentation
- `generator/docs/user_manual.md` - Comprehensive user guide
- `generator/docs/developer_manual.md` - Architecture & contributing
- `generator/docs/api-reference.md` - Component API documentation
- `generator/docs/design-system.md` - Renderer pattern deep dive
- `generator/docs/troubleshooting.md` - Common errors & solutions
- `ARCHITECTURE.md` - High-level system design
- `planning/ROADMAP.md` - Feature roadmap and milestones

## Code Style & Conventions

### Naming Conventions

- **Components:** `AppButton`, `AppToggle`, `AppInput` (PascalCase with `App` prefix)
- **Meta files:** `button.meta.dart`, `toggle.meta.dart` (snake_case.meta.dart)
- **Screen files:** `login.screen.dart` (snake_case.screen.dart)
- **Renderers:** `MaterialButtonRenderer`, `CupertinoToggleRenderer` (PascalCase mixins)
- **Styles:** `MaterialStyle`, `CupertinoStyle`, `NeoStyle` (PascalCase)

### File Organization

**Generated code headers:**
```dart
// ============================================
// GENERATED BY SYNTAXIFY v0.2.0-beta
// DO NOT MODIFY - Regenerated on build
// Component: AppButton (Meta-Driven)
// Generated: 2025-12-24T15:41:38.893554
// ============================================
```

**Meta file structure:**
```dart
library;  // Library directive at top

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: '...')
class ComponentMeta {
  // Properties with @Required() or @Optional()
  // Constructor with defaults
}
```

## Current Status & Roadmap

**Version:** 0.2.0-beta

**Completed (v0.1.0 → v0.2.0):**
- ✅ Core AST parser with 26 node types
- ✅ 7 interactive components × 3 styles = 21 variants
- ✅ Screen generation from `.screen.dart` files
- ✅ CLI with init, build, watch, clean commands
- ✅ Build cache system (SHA-256 hashing)
- ✅ 303 tests passing (unit, integration, golden)
- ✅ Custom component support (e.g., SuperCard)
- ✅ Convention-based DX (auto-detect paths)

**Next (v1.0.0):**
- 🔮 VS Code extension
- 🔮 Visual theme editor
- 🔮 Complete component library
- 🔮 Component marketplace

## Troubleshooting

### Line Ending Warnings (CRLF)

**Current state:** 17 files show CRLF warnings on Windows.

**Fix:** Add `.gitattributes`:
```
* text=auto
```

### Analysis Errors in `meta/` Folder

**Error:** "Undefined name 'App'" or "Target of URI doesn't exist"

**Cause:** Meta files use Syntaxify DSL, not standard Dart.

**Fix:** Exclude in `analysis_options.yaml`:
```yaml
analyzer:
  exclude:
    - meta/**
```

### Tests Failing After AST Changes

**Cause:** Freezed models not regenerated.

**Fix:**
```bash
dart run build_runner clean
dart run build_runner build
dart test
```

## Important Notes for AI Assistants

1. **DO NOT edit generated files** in `lib/syntaxify/generated/components/` - they're regenerated on every build
2. **Screens are editable** in `lib/screens/` - only generated once, then user-owned
3. **Meta files are the source of truth** - edit these to change component APIs
4. **Use sealed classes exhaustively** - Always handle all cases with `.when()` or `.map()`
5. **Run tests after AST changes** - 303 tests ensure nothing breaks
6. **Freezed models need regeneration** - Run `build_runner` after modifying `@freezed` classes
7. **Recent rename: Switch → Toggle** - Use `AppToggle`, not `AppSwitch`
8. **Constructor analysis is critical** - `ComponentExtractor` now reads constructor defaults (as of recent commits)
