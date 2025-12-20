# Issue #6: Design Tokens Hardcoded

## Status: ❌ NOT IMPLEMENTED (Low Priority)

## Problem

Colors and design values are hardcoded in Dart:

**Current:** `design_system/styles/material/button_renderer.dart:8-14`
```dart
ButtonTokens buttonTokens(ButtonVariant variant) {
  switch (variant) {
    case ButtonVariant.primary:
      return const ButtonTokens(
        radius: 8,
        bgColor: Colors.blue,  // HARDCODED!
        textColor: Colors.white,
      );
  }
}
```

**Should be:**
```yaml
# design_tokens.yaml
colors:
  primary: "#2196F3"
  secondary: "#757575"

button:
  primary:
    background: $primary
    text: white
    radius: 8
```

## Workaround

Users can currently edit `design_system/styles/*/button_renderer.dart` directly since these files are in their project.

## Implementation Plan

1. Add `yaml` dependency to pubspec
2. Create `TokenLoader` class
3. Update style renderers to load from YAML
4. Add `syntaxify init --tokens` to generate sample YAML

**Files:**
- NEW: `lib/src/config/token_loader.dart`
- NEW: `design_tokens.yaml` (template)
- MODIFY: `lib/src/generators/component/*_generator.dart`

**Effort:** 6-8 hours
**Priority:** Low (workaround exists)
**Users requesting:** 0 so far
