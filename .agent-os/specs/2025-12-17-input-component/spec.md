# Spec Requirements Document

> Spec: Input Component (TextField)
> Created: 2025-12-17

## Overview

Implement a flexible `Input` component (TextField) that supports Material, Cupertino, and Neo-Brutalism styles. The component must handle text entry, prefix/suffix icons with actions, and integrate with `TextEditingController` for validation and state management.

## User Stories

### Text Entry
As a developer, I want to define an `Input` in my meta-schema so that I can generate a `TextField` with consistent styling across my app.

### Interactive Icons
As a developer, I want to specify tappable suffix icons (e.g. for "Clear text" or "Show Password") so that I can implement common UI patterns easily.

### Validation Support
As a developer, I want the generated widget to expose `errorText` and `controller` properties so that I can drive validation logic from my business logic layer without tight coupling in the view.

## Spec Scope

1.  **InputMeta Definition**: Schema for defining input fields with labels, hints, and icons.
2.  **State & Events**: Support for `enabled`, `error`, and `focus` visual states.
3.  **Callbacks**: Expose `onChanged`, `onSubmitted`, `onTapPrefix`, `onTapSuffix`.
4.  **Renderer Implementation**: Concrete implementations for all 3 supported design styles.

## Out of Scope

-   **Internal Form State**: The widget will not manage its own validation state; it is a controlled component.
-   **inputFormatters**: Complex formatting masks are deferred to a future update.
-   **Search Bars**: Specialized search variants are out of scope.

## Expected Deliverable

1.  `InputMeta` class in `forge`.
2.  Generated `AppInput` widget (or named component) in `lib/forge`.
3.  Verification via `forge build` generating correct code for all themes.
