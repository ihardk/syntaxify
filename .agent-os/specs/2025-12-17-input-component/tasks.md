# Spec Tasks

## Tasks

- [x] 1. Core Architecture (Meta & Tokens)
  - [x] 1.1 Define `InputMeta` class in `forge` (label, hint, icons, callbacks)
  - [x] 1.2 Define `InputTokens` in `design_system` (styles, colors, borders)
  - [x] 1.3 Implement `DesignStyle.renderInput` abstract method
  - [x] 1.4 Implement `AppIcons` registry in `design_system` (Map<String, IconData>)
  - [x] 1.5 Update `ThemeGenerator` to support input tokens

- [x] 2. Generator Implementation (Mixins)
  - [x] 2.1 Implement `MaterialInputRenderer` mixin (InputDecoration map)
  - [x] 2.2 Implement `CupertinoInputRenderer` mixin (CupertinoTextField)
  - [x] 2.3 Implement `NeoInputRenderer` mixin (Custom Brutalist Container with shadow)
  - [x] 2.4 Create `InputGenerator` class (wire up controller, errorText, callbacks)
  - [x] 2.5 Register `InputGenerator` in main generator loop

- [x] 3. Testing & Verification
  - [x] 3.1 Create widget tests for Material/Cupertino/Neo inputs
  - [x] 3.2 Verify `controller` and `errorText` propagation
  - [x] 3.3 Verify `onChanged` and `onSubmitted` callbacks
  - [x] 3.4 Golden tests for visual regression
  - [x] 3.5 Verify Focus Traversal and ObscureText toggle
  - [x] 3.6 Manual verification in `test_app` with `flutter run`
