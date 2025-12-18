# Technical Specification

This is the technical specification for the spec detailed in @.agent-os/specs/2025-12-18-fix-screen-generation/spec.md

## Technical Requirements

### 1. MetaParser Updates
-   **Method**: `_parseAstNode` and `visitTopLevelVariableDeclaration`.
-   **Enums**: Implement parsers for `TextInputAction`, `KeyboardType`, `MainAxisAlignment`, `CrossAxisAlignment`.
-   **Props**:
    -   `ButtonNode`: Parse `onPressed` (String), `size` (enum), `icon` (name), `isDisabled` (bool).
    -   `TextFieldNode`: Parse `hint`, `obscureText`, `keyboardType`, etc.
    -   `SpacerNode`: Parse `flex`.
    -   `Layout`: Parse `main/crossAxisAlignment`.

### 2. LayoutEmitter Refactor
-   **Imports**: The generated file must import:
    -   `package:syntax/syntax.dart` (or distinct component files if barrel not available).
    -   `package:flutter/material.dart`
-   **Components**:
    -   Emit `AppButton(...)` instead of `ElevatedButton`.
    -   Emit `AppInput(...)` instead of `TextField`.
-   **Enums**: Emit proper enum values (e.g. `ButtonVariant.filled`).
-   **Typography**:
    -   Emit `Text(..., style: DesignSystem.of(context).typography.headlineMedium)` (or similar) instead of `Theme.of(context)...`.
    -   Ensure `LayoutEmitter` uses the generated `DesignSystem` class.

### 3. ScreenGenerator & Fields
-   **Field Generation**:
    -   If an AST node has `onPressed: 'submit'`, the `ScreenGenerator` must generate:
        -   `final VoidCallback? submit;` field.
        -   `const LoginScreen({super.key, this.submit});` constructor.
    -   Or for P0, just emit `VoidCallback` fields for now (User stated "Action Parsing").
-   **Binding**: For now, assume these are passed from parent or ViewModel.

## External Dependencies (Conditional)
None.

## Implementation Plan

1.  **Refactor MetaParser**: Add helper methods for property extraction.
2.  **Refactor LayoutEmitter**: Update `refer` calls to point to Syntax components.
3.  **Update ScreenGenerator**: Handle imports.
4.  **Verify**: Re-run `login_screen.dart` E2E test.
