## 0.1.0

- **Major Restructure**: Separated editable screens from generated components
  - Screens now generate to `lib/screens/` (editable by users)
  - Components generate to `lib/syntax/generated/` (regenerated on build)
  - Design system in `lib/syntax/design_system/` (customizable)
- **Improved Commands**: Added `syntax` executable for shorter commands
  - `syntax init` - Initialize project structure
  - `syntax build` - Generate components and screens
- **Package Imports**: Screens now use package imports instead of relative paths
- **Init Command**: Now creates `lib/syntax/design_system/` for customization
- **Renamed**: Project renamed from "Forge" to "Syntax"

## 0.0.1

- Initial Alpha Release.
- Added `Syntax` CLI with `build` and `clean` commands.
- Implemented `Button` component generator.
- Added support for multiple themes (`Material`, `Cupertino`, `Neo`).
- Implemented 5-layer SOLID architecture.
