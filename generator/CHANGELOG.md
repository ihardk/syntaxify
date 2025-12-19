# Changelog

## 0.1.0-alpha.8 - 2025-12-20

### New Features
- **Screen Generation**: Generate full screens from AST definitions
  - Login, Register, Home screens as examples
  - Callbacks extracted as `VoidCallback?` fields
  - AppBar with title support

### Breaking Changes
- `ScreenDefinition.appBar` changed from `AppBarNode?` to `AstNode?`

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
