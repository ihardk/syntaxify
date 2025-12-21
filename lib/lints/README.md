# Syntaxify Custom Lints

IDE-integrated validation for LayoutNode definitions in `.screen.dart` files.

## Available Lint Rules

### 1. `empty_button_label` (Error)
Detects empty button labels.

### 2. `invalid_callback_name` (Error)
Detects invalid Dart identifiers in callback names (no hyphens or spaces).

### 3. `empty_text_content` (Error)
Detects empty text content.

### 4. `empty_container` (Warning)
Detects columns/rows with no children.

## How to Enable

Add to `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint

  errors:
    empty_button_label: error
    invalid_callback_name: error
    empty_text_content: error
    empty_container: warning
```

Then run: `dart run custom_lint --watch`

## Benefits

- ✅ Instant feedback as you type
- ✅ Works in all Dart IDEs
- ✅ No build step needed
- ✅ Clear error messages with suggestions
