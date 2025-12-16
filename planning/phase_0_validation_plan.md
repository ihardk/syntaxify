# Phase 0: Manual Validation Prototype (Raw Example)

**Goal:** implement the **Exact Example from the Chat** manually (without building a generator tool yet) to validate the "Radio Button Style Switcher" concept.

## 1. Project Setup
- [ ] Initialize `meta_demo` as a standard Flutter app.

## 2. The Logic (Manually Written)
We will implement the "Runtime Engine" pattern first, as it's the fastest way to validate the UX.
*   **File:** `lib/architecture.dart`
    *   `enum DesignStyle { material, cupertino, neo }`
    *   `class OneButtonTokens { ... }` (The Data)
    *   `class TokenLibrary { ... }` (The Registry)
    *   `class OneButtonRenderer { ... }` (The Widget)
    *   `class UIEngine { ... }` (The dynamic builder)

## 3. The Demo UI
*   **File:** `lib/main.dart`
    *   **State:** `DesignStyle style = DesignStyle.material;`
    *   **UI:** Row of 3 Radio Buttons.
    *   **The "Meta" Component:** `UIEngine.build(node, style)`
    *   **Interaction:** Clicking "Neo" updates `style`, which triggers `UIEngine` to look up new tokens and re-render the button.

## 4. Success Criteria
*   Run `flutter run`.
*   Click "Neo" -> Button turns Yellow/Boxy.
*   Click "Cupertino" -> Button turns Grey/Rounded.
*   **Validation:** Proves that *Data-Driven Styling* works in Flutter before we commit to writing a complex Code Generator.

## Next Step
Shall I initialize the `meta_demo` app and write these files?

