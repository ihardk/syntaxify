# Technical Specification

This is the technical specification for the spec detailed in @.agent-os/specs/2025-12-17-input-component/spec.md

## Technical Requirements

### 1. Meta Definition (`InputMeta`)
New class in `package:forge/src/meta/input.meta.dart` (or similar schema definition).

**Properties:**
-   `String label`: Label text.
-   `String? hint`: Placeholder text.
-   `bool obscureText`: For passwords (default false).
-   `String? prefixIcon`: Name of the icon token (e.g., 'user', 'search'). // Instead of String its fine if we use IconToken or IDK maybe flutter icons you decide
-   `String? suffixIcon`: Name of the icon token. // same as prefixIcon
-   `TextInputType keyboardType`: Default `text`.

### 2. Generated Widget API
The generated Flutter widget must accept runtime parameters:

```dart
const AppInput({
  super.key,
  this.controller,
  this.onChanged,
  this.onSubmitted,
  this.errorText,
  this.enabled = true,
  this.onTapPrefix,
  this.onTapSuffix,
  //.. is validation onChanged or onSubmit
  //.. plus place holder text
});
```

### 3. Renderer Mixins (`renderInput`)
Update `DesignStyle` sealed class to include:
`Widget renderInput(BuildContext context, InputProperties properties);`

Implement mixins:
-   **Material**: Wraps `TextField` with `InputDecoration`. Maps `errorText` to decoration.
-   **Cupertino**: Wraps `CupertinoTextField`. Handles placeholder and overlays manually if needed to match API.
-   **Neo**: Custom `Container` with border and `BasicTextField` (or `TextField` with collapsed decoration).

### 4. Icon Handling
-   **Registry Pattern**: Use `AppIcons.get(meta.prefixIcon)` to resolve `IconData`.
-   **Interactivity**:
    -   Icons should be tappable if an `onTap` callback is provided.
    -   If `suffixIcon` is defined in meta but `onTapSuffix` is null at runtime, icon is static.
    -   If `onTapSuffix` is provided, wrap icon in `InkWell`/`GestureDetector`.

### 5. Tokens
-   Add `InputTokens` to `design_system`.
-   Properties: `backgroundColor`, `borderColor`, `borderWidth`, `borderRadius`, `textStyle`, `hintStyle`, `errorStyle`, `contentPadding`.
