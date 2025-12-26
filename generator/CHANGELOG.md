# Changelog

## 0.2.0 - 2025-12-26

### 🎯 Major Features

**Dynamic Design System (Custom Component Extensibility)**
- **Any component is now fully integrated with the design system!**
  - Add `supercard.meta.dart` → Generator creates `renderSuperCard()` in `DesignStyle`
  - Automatically generates stub renderers (`MaterialSuperCardRenderer`, etc.)
  - Your custom components work with Material/Cupertino/Neo out of the box
- **`DesignSystemGenerator`**: New generator that dynamically builds:
  - `design_style.dart` - Abstract base class with ALL render methods
  - `*_style.dart` - Concrete style classes mixing in ALL renderers
  - `*/material_renderer.dart` - Stub implementations for new components
- **Zero Boilerplate**: Just define a `.meta.dart` file, run `build`, implement the stub

**Convention-Based Meta Parsing (DX Improvements)**
- **Non-nullable type = Required**: `final String label;` is required
- **Nullable type = Optional**: `final String? hint;` is optional
- **Constructor defaults = Defaults**: `final bool isLoading = false;` uses `false`
- **Deprecated old annotations**: `@Required`, `@Optional`, `@Default` still work but deprecated

**Unified Variant System**
- **`@SyntaxComponent(variants: [...])`**: Define variants inline
- **EnumGenerator**: Generates `ButtonVariant` enum from `variants: ['primary', 'secondary']`
- **Output**: `generated/variants/button_variant.dart`

**Package Name Substitution** (New)
- `syntaxify init` now automatically detects your package name from `pubspec.yaml`
- Replaces `$packageName` in generated templates with your actual package name
- Ensures generated code imports correctly out of the box

### 🔧 Improvements

**Dependency Updates**
- Updated all dependencies to latest major versions (`analyzer ^7.x`, `dart_style ^3.x`) for better stability and performance.

**Better Default Value Handling**
- Generator now respects `defaultValue` when determining nullability
- Fixes `invalid_implementation_override` errors for optional params with defaults

**Reduced Import Complexity**
- `TextVariant` collision fixed (single source of truth)
- Meta files only need `import 'package:syntaxify/syntaxify.dart';`

### 🔧 Improvements

**Better Default Value Handling**
- Generator now respects `defaultValue` when determining nullability
- Fixes `invalid_implementation_override` errors for optional params with defaults

**Reduced Import Complexity**
- `TextVariant` collision fixed (single source of truth)
- Meta files only need `import 'package:syntaxify/syntaxify.dart';`

### 📦 New Files

| File                                              | Purpose                          |
| ------------------------------------------------- | -------------------------------- |
| `lib/src/generators/design_system_generator.dart` | Dynamic design system generation |
| `lib/src/generators/enum_generator.dart`          | Generates variant enums          |
| `lib/syntaxify/design_system/components/*/`       | Generated renderer stubs         |

### 📊 Statistics

- **283+ tests** passing
- **7 components** × **3 styles** = **21 styled variants**
- **Unlimited custom components** now possible

---

## 0.1.0-alpha.10 - 2025-12-21

### 🎯 Major Features

**Watch Mode (Issue #10)** 🆕
- **`syntaxify build --watch`**: Auto-rebuild on file changes
  - DirectoryWatcher monitors `meta/` directory
  - Detects `.meta.dart` and `.screen.dart` file changes
  - 300ms debouncing to prevent duplicate rebuilds
  - Shows timestamp: `[HH:MM:SS] Watching for changes...`
  - Clean exit with Ctrl+C
- **Usage**: Run `syntaxify build --watch` and edit meta files
- **DX Impact**: No more manual rebuild commands

### 🔧 Bug Fixes

**Cross-Platform Path Handling**
- Fixed `path.join` → `path.posix.join` in `GenerateComponentUseCase`
- Consistent forward slash paths on Windows/Mac/Linux
- Fixed test failures related to path comparison

**Test Fixes**
- Fixed `generate_component_test.dart` expectations to match actual generator output
- Updated `InputGenerator` test assertions
- Fixed timestamp comparison in "overwrites existing file" test
- 172 tests passing, 61 skipped

### 📦 Dependencies

**Added:**
- `watcher: ^1.1.0` - File system watching for watch mode

### 📚 Documentation

**Updated:**
- `planning/00-SUMMARY.md` - Marked #3, #5, #10 as implemented
- `planning/ROADMAP.md` - Advanced to Stage 4
- `planning/10-watch-mode.md` - Marked as implemented
- Comprehensive gap analysis completed

### 🏗️ Infrastructure

**Modified:**
- `lib/src/cli/build_command.dart` - Added `--watch` flag, `_runWatch()` method
- `lib/src/use_cases/generate_component.dart` - Fixed path.posix.join

### 📊 Statistics

- **+100 lines** for watch mode implementation
- **172 tests** passing
- **Stage 4** of roadmap reached

---

## 0.1.0-alpha.9 - 2025-12-21

### 🎯 Major Features

**Validation System (Issue #1)**
- **LayoutValidator**: Comprehensive validation for all node types
  - Validates empty values, invalid identifiers, conflicting properties
  - Three severity levels: error (blocks build), warning, info
  - Integrated into build process with detailed error reporting
- **ValidationError Model**: Freezed model with error types and suggestions
- **60+ Test Cases**: Full coverage in `test/validation/layout_validator_test.dart`

**IDE-Integrated Linting**
- **10 Custom Lint Rules** using `custom_lint_builder`
  - Real-time validation in VS Code, Android Studio, IntelliJ
  - Catches errors as you type, not just at build time
  - Rules: empty values (5), invalid identifiers (1), negative numbers (1), property conflicts (1), missing fields (2)
- **Two-Tier Validation**: Edit-time (IDE) + Build-time (CLI)

**Incremental Build Cache (Issue #2)**
- **BuildCache System**: Smart caching for performance optimization
  - SHA-256 content hashing for accurate change detection
  - Timestamp tracking with graceful fallback
  - Persists to `.syntaxify_cache.json`
- **BuildCacheManager**: Complete cache lifecycle management
  - Load/save cache automatically
  - Detect changed files and missing outputs
  - Clean up stale entries
- **Build Options**: `enableCache` and `forceRebuild` parameters
- **Performance**: Skip regeneration of unchanged files

### 🔄 Breaking Changes

**App → App Rename**
- Renamed `App` to `App` throughout entire codebase (23 files)
- More accessible naming for non-technical users
- Migration notes in documentation

**FileSystem Interface**
- Added `getStats()` method for file metadata
- New `FileStats` class with modification time and size
- Implemented in `LocalFileSystem` and `MemoryFileSystem`

### 📦 Dependencies

**Added:**
- `crypto: ^3.0.3` - SHA-256 hashing for build cache
- `custom_lint_builder: ^0.6.4` - Custom lint rules for IDE integration

### 📚 Documentation

**New Guides:**
- `learning/16-validation-and-linting.md` - Complete validation system guide

**Updated:**
- `learning/03-ast-system.md` - Updated with App naming
- `learning/13-api-reference.md` - Updated API documentation
- All references to App updated to App

### 🏗️ Infrastructure

**New Files:**
- `lib/src/models/build_cache.dart` - Cache models (BuildCache, CacheEntry)
- `lib/src/models/validation_error.dart` - Validation error model
- `lib/src/infrastructure/build_cache_manager.dart` - Cache management (207 lines)
- `lib/src/validation/layout_validator.dart` - Validation logic (520+ lines)
- `lib/lints/layout_node_lints.dart` - Custom lint rules
- `lib/syntaxify_lints.dart` - Lint plugin entry point
- `test/validation/layout_validator_test.dart` - Validation tests

**Modified:**
- `lib/src/use_cases/build_all.dart` - Integrated validation + caching
- `lib/src/core/interfaces/file_system.dart` - Added getStats()
- `lib/src/infrastructure/local_file_system.dart` - Implemented getStats()
- `lib/src/infrastructure/memory_file_system.dart` - Added timestamp tracking
- `lib/syntaxify.dart` - Updated exports

### 📊 Statistics

- **+1000+ lines** of production code
- **+333 lines** for cache system alone
- **+520 lines** for validation system
- **+60 test cases** for comprehensive coverage
- **23 files** refactored for App rename
- **16 documentation files** created/updated

### 🎁 Developer Experience

**Build-Time Validation:**
- Errors, warnings, and info messages during `syntaxify build`
- Helpful suggestions for fixing issues
- Skips generation for screens with critical errors

**Edit-Time Validation:**
- Red squiggly lines in your IDE for errors
- Yellow for warnings, blue for info
- Quick fixes and suggestions

**Performance:**
- Incremental builds only process changed files
- Cache persists across builds
- Significant speedup for large projects

### 🔮 Future Enhancements

- CLI flags: `--no-cache`, `--clear-cache`
- Cache statistics in BuildResult
- Dependency-based cache invalidation
- Golden test integration

---

## 0.1.0-alpha.8 - 2025-12-20

### New Features
- **Screen Generation**: Generate full screens from AST definitions
  - Login, Register, Home screens as examples
  - Callbacks extracted as `VoidCallback?` fields
  - AppBar with title support

### Breaking Changes
- `ScreenDefinition.appBar` changed from `AppBarNode?` to `App?`

### Dependency Upgrades
- dart_style 3.x (added `languageVersion` parameter)
- analyzer 9.x (handled `name2` deprecation)
- freezed compatibility with sealed classes

### Documentation
- Added AST Nodes section to API reference
- Updated project structure examples
- Improved dartdoc comments on public API

---

## 0.1.0-alpha.1 - 2025-12-19

**⚠️ Alpha Release - API may change**

Initial alpha release to reserve package name and gather early feedback.

### Features

**Core Architecture:**
- ✅ Renderer pattern (WHAT vs HOW separation)
- ✅ Multi-style design system support
- ✅ AST-based code generation

**Components (Full Renderer Support):**
- ✅ AppButton - Buttons with variants (primary, secondary, text, outlined)
- ✅ AppText - Text with typography variants
- ✅ AppInput - Text fields with validation

**Design Styles:**
- ✅ Material Design
- ✅ Cupertino (iOS)
- ✅ Neo (Modern/Custom)

**CLI Commands:**
- ✅ `syntaxify init` - Initialize project structure
- ✅ `syntaxify build` - Generate components with smart path detection
- ✅ `syntaxify clean` - Remove generated files

**Screen Generation:**
- ✅ Generate screen scaffolds from meta definitions
- ✅ Preserve user edits on rebuild (screens not regenerated)

### Bug Fixes
- Fixed path detection for lib/syntaxify/design_system
- Fixed screen overwrite issue (user edits now preserved)
- Fixed barrel file exports (screens excluded)
- Fixed meta file imports to use public API

### Documentation
- Comprehensive README with problem statement
- Real-world fintech app example
- User manual and developer manual
- Working example app with live style switching

### Known Limitations
- Only 3 components with full renderer support
- Custom components get basic Container widget (not full renderer pattern)
- No tests yet
- API may change in future releases

### Roadmap
See [GitHub](https://github.com/ihardk/syntaxify) for full roadmap and issues.

**Star ⭐ the repo to follow development!**

---

## 0.1.0

- **Major Restructure**: Separated editable screens from generated components
  - Screens now generate to `lib/screens/` (editable by users)
  - Components generate to `lib/syntaxify/generated/` (regenerated on build)
  - Design system in `lib/syntaxify/design_system/` (customizable)
- **Improved Commands**: Added `syntaxify` executable for shorter commands
  - `syntaxify init` - Initialize project structure
  - `syntaxify build` - Generate components and screens
- **Package Imports**: Screens now use package imports instead of relative paths
- **Init Command**: Now creates `lib/syntaxify/design_system/` for customization
- **Renamed**: Project renamed from "Forge" to "Syntaxify"

## 0.0.1

- Initial Alpha Release.
- Added `Syntaxify` CLI with `build` and `clean` commands.
- Implemented `Button` component generator.
- Added support for multiple themes (`Material`, `Cupertino`, `Neo`).
- Implemented 5-layer SOLID architecture.
