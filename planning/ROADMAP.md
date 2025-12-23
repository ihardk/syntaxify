# Syntaxify Development Roadmap

## Current Position: Stage 5 (Phase 3 Complete ✅)

---

## Stage 1: Prove Feasibility ✅ DONE
- [x] CLI exists
- [x] Analyzer-based parsing works
- [x] Annotation-driven specs
- [x] Token parsing
- [x] Code emission
- [x] Tests pass
- [x] Example app runs

---

## Stage 2: Lock Correctness & Narrative ✅ DONE

### 2.1 Fix Conceptual Leak ✅
- [x] Replace `void Function()` → `String` action identifiers in specs
- [x] Generator wires action names to controller methods

### 2.2 Freeze Spec Contract ✅
- [x] Create `planning/SPEC.md`
- [x] Create `planning/AST.md`

### 2.3 Align Docs with Reality ✅
- [x] Restructured README for pub.dev (concise, user-focused)
- [x] Added dartdoc comments to public API
- [x] Published multiple alpha versions to pub.dev

### 2.4 Dependency Upgrade ✅ (Dec 2024)
- [x] Upgraded to dart_style 3.x (added languageVersion parameter)
- [x] Upgraded to analyzer 9.x (handled name2 deprecation)
- [x] Fixed freezed compatibility with sealed classes
- [x] All tests passing

---

## Stage 3: Prove Power ✅ DONE

### 3.1 Implement Layout Compiler ✅
- [x] `ColumnNode` (vertical layout)
- [x] `RowNode` (horizontal layout)
- [x] Explicit children order
- [x] Spacer nodes with sizes

### 3.2 Compile Real Screens ✅
- [x] Login screen with form fields
- [x] Register screen with validation
- [x] Home dashboard with stats

### 3.3 Validation System ✅ (Dec 2024)
- [x] `LayoutValidator` (484 lines, validates all node types)
- [x] `ValidationError` model with severity levels
- [x] IDE linting (10 custom lint rules)
- [x] 172+ tests passing

### 3.4 Incremental Build ✅ (Dec 2024)
- [x] `BuildCacheManager` with SHA-256 hashing
- [x] Timestamp + content hash checking
- [x] Integrated with build pipeline

---

## Stage 4: Make It Legible ⬅️ NOW

### 4.1 Update Documentation
- [x] Update 00-SUMMARY.md with implementation status
- [x] Update ROADMAP.md (this file)
- [x] Write ARCHITECTURE.md

### 4.2 Add Watch Mode ✅
- [x] `syntaxify build --watch`

### 4.3 Golden Tests ✅
- [x] Input spec → Generated Dart → Assert exact match

---

### 4.4 Update README
- [x] Update README with implementation status
- [x] Update ROADMAP.md (this file)
- [x] Write ARCHITECTURE.md

## Stage 5: Productization (High-End Product)
> Focus: Extensibility, Developer Experience, and Stability.

### 5.1 Core Architecture Refactor (Stability) ✅ COMPLETE
- [x] **AST Structural Split** (Issue #13)
  - [x] Define `App`, `PrimitiveNode`, `InteractiveNode` sealed classes
  - [x] Implement `NodeMetadata` mixin (id, visibleWhen)
  - [x] Migrate `LayoutEmitter` to Visitor pattern
  - [x] Add 18+ node types (structural, primitive, interactive)
- [x] **Validation Engine 2.0** ✅
  - [x] Implement hierarchical validation (Parent-Child rules)
  - [x] Add "Suggestion" engine for common errors
  - [x] 85+ validation tests

### 5.2 Extensibility System (Growth) ✅ COMPLETE
- [x] **Plugin Architecture** (Issue #8)
  - [x] Define `SyntaxifyPlugin` interface (Generator + Validator contract)
  - [x] Implement `GeneratorRegistry` for plugin management
  - [x] Add `App.custom` for plugin extensibility
  - [x] E2E test: `plugin_e2e_test.dart`
- [x] **Default Plugin**
  - [x] Core components moved to internal DefaultPlugin
  - [x] Custom emitter handlers working

### 5.3 Developer Experience (Polish) ✅ COMPLETE
- [x] **Watch Mode** ✅
  - [x] `syntaxify build --watch`
- [x] **Configuration Engine** (Issue #11)
  - [x] Define `SyntaxifyConfig` model
  - [x] Implement `ConfigLoader` with YAML parsing
  - [x] `syntaxify init` creates `syntaxify.yaml`
- [x] **Advanced CLI Features** (Issue #12)
  - [x] `--dry-run` mode with `DryRunFileSystem`
  - [x] Improved error reporting with `mason_logger`
- [x] **Design System Expansion**
  - [x] 7 components × 3 styles (Material/Cupertino/Neo)
  - [x] AppCheckbox, AppSwitch, AppSlider, AppRadio wrappers
  - [x] 12 new renderer files created
- [x] **DartDoc Coverage**
  - [x] All public APIs documented

### 5.4 Testing Coverage ✅ COMPLETE
- [x] 303 tests passing
- [x] Unit tests for all node types
- [x] Integration tests (phase1_e2e, plugin_e2e, all_ast_nodes_e2e)
- [x] Emission and validation tests for 26 components

---

## Analysis Status (Dec 2025)

| Metric         | Value                                        |
| -------------- | -------------------------------------------- |
| Tests          | 303 passing ✅                                |
| Lint Issues    | Info-level only (no errors)                  |
| Source Modules | 14 directories                               |
| AST Node Types | 26 (structural/primitive/interactive/custom) |
| Design System  | 7 components × 3 styles                      |
| Documentation  | 6 comprehensive docs + 14 learning guides    |

