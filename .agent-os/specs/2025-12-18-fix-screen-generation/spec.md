# Spec Requirements Document

> Spec: Fix Screen Generation
> Created: 2025-12-18

## Overview

Refine the `ScreenGenerator` and associated architecture to robustly support `P0` screen definitions, ensuring correct parsing of all properties and emitting properly linked Syntaxify Design System components.

## User Stories

### Reliable Screen Compilation
As a specific developer, I want my `.screen.dart` files to be fully parsed and compiled into correct Flutter code, so that I don't overlook properties like `onPressed` or `hintText`.

### System-Compliant Output
As an architect, I want generated screens to use `AppButton` and `AppInput` instead of raw Material widgets, so that global design system changes propagate to all screens automatically.

## Spec Scope

1.  **MetaParser Upgrade** - Expand parsing logic to cover all `P0` node properties (TextField `hint`, Button `onPressed`, etc).
2.  **LayoutEmitter Refactor** - Toggle from emitting `ElevatedButton`/`TextField` to `AppButton`/`AppInput`.
3.  **Imports & Fields Management** - Ensure `ScreenGenerator` adds necessary imports and generates callback fields for actions.
4.  **Enum Parsing** - Implement robust enum parsing for `KeyboardType`, `TextInputAction`, `MainAxisAlignment` etc.

## Out of Scope

-   **P1/P2 Nodes** - Complex nodes like `ListView` or `Stack` (unless trivial).
-   **ViewModel Binding** - Advanced state management generation.
-   **Navigation logic** - Router integration.

## Expected Deliverable

1.  `MetaParser` correctly populates `ScreenDefinition` AST from the `login.screen.dart` fixture.
2.  `LayoutEmitter` outputs `AppButton(...)` using `code_builder`.
3.  Generated `login_screen.dart` contains valid imports and code.
