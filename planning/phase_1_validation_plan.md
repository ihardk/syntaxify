# Phase 0: Validation Prototype Plan

**Goal:** Prove the "Code Generator" approach works by building the **Multi-Style Button Demo** (Material / Cupertino / Neo) discussed in the conversation.

## 1. Project Setup
Instead of just empty folders, we will create a working playground.
- [ ] Initialize `meta_gen` (The Tool) as a generic Dart console app.
- [ ] Initialize `meta_demo` (The App) as a standard Flutter app.

## 2. Meta Definitions (The Input)
We will create these specific files in `meta_demo/meta/`:
*   `theme.meta.dart`: Defines the 3 variants.
    *   `Material`: Radius 4, Blue bg, Elevation 2.
    *   `Cupertino`: Radius 8, Grey bg, No shadow.
    *   `Neo`: Radius 0, Yellow bg, Border 3px, Heavy shadow.
*   `button.meta.dart`: Defines the `MetaButtonSpec` (label, onPressed).

## 3. The Generator Logic (The Tool)
We will write a **Simple Script** (v0 of the generator) that:
1.  Reads `theme.meta.dart`.
2.  Generates `lib/theme/app_theme.dart` containing:
    *   `AppThemeData` class.
    *   `AppTheme` inherited widget.
    *   `AppTheme.material`, `AppTheme.cupertino`, `AppTheme.neo` factories.
3.  Reads `button.meta.dart`.
4.  Generates `lib/components/app_button.dart` that:
    *   Looks up `AppTheme.of(context).button`.
    *   Applies the tokens (radius, color, border) to a Container.

## 4. The Validation Demo (The Output)
We will build `lib/main.dart` in the `meta_demo` app:
*   **State:** `DesignStyle _currentStyle = DesignStyle.material;`
*   **UI:** 3 Radio Buttons to toggle `_currentStyle`.
*   **Theme Wrapper:** Wraps the content in `AppTheme(data: AppTheme.from(_currentStyle))`.
*   **Content:** A single `<AppButton label="Meta Button" />`.

## 5. Success Criteria
*   You run `dart run ../meta_gen`.
*   You run `flutter run`.
*   Clicking "Neo" instantly transforms the button to Yellow/Boxy **without hot reload** (because the logic is already generated).
*   **Crucial:** The `lib/main.dart` has NO `if (style == neo)` logic. It just uses `AppTheme`.

## Next Step
Shall I start by creating the folder structure for `meta_gen` and `meta_demo`?
