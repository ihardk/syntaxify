# Issue #2: Action Wiring Implementation

## Status: ✅ ALREADY IMPLEMENTED

## Original Problem Description

The critique stated that action wiring is missing:

**AST Definition:**
```dart
LayoutNode.button(
  label: 'Login',
  onPressed: 'handleLogin',  // String identifier
)
```

**Expected Generated Screen:**
```dart
class LoginScreen extends StatelessWidget {
  final VoidCallback? handleLogin;  // ← Generator must add this

  const LoginScreen({this.handleLogin});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: 'Login',
      onPressed: handleLogin,  // ← Wire string → callback
    );
  }
}
```

**Claimed Missing:**
- Generator doesn't collect action identifiers
- Generator doesn't generate constructor params
- No wiring from string identifier to callback

## Current Implementation Analysis

### File: `lib/src/generators/screen_generator.dart`

**Callback Collection (Lines 79-104):**
```dart
Set<String> _collectCallbacks(LayoutNode node) {
  final callbacks = <String>{};

  node.map(
    column: (n) {
      for (final child in n.children) {
        callbacks.addAll(_collectCallbacks(child));
      }
    },
    row: (n) {
      for (final child in n.children) {
        callbacks.addAll(_collectCallbacks(child));
      }
    },
    button: (n) {
      if (n.onPressed != null) callbacks.add(n.onPressed!);
    },
    text: (_) {},
    textField: (_) {}, // TODO: Add onChanged etc if needed
    icon: (_) {},
    spacer: (_) {},
    appBar: (_) {},
  );

  return callbacks;
}
```

**Field Generation (Lines 47-50):**
```dart
..fields.addAll(callbacks.map((name) => Field((f) => f
  ..name = name
  ..type = refer('VoidCallback?')
  ..modifier = FieldModifier.final$)))
```

**Constructor Parameter Generation (Lines 56-59):**
```dart
..optionalParameters.addAll(callbacks.map((name) => Parameter((p) => p
  ..name = name
  ..named = true
  ..toThis = true)))
```

**Button Emission with Wiring (lib/src/emitters/layout_emitter.dart:63-74):**
```dart
Expression _emitButton(ButtonNode node) {
  return refer('AppButton').newInstance([], {
    'label': literalString(node.label),
    'onPressed':
        node.onPressed != null ? refer(node.onPressed!) : literalNull,
    // ... other params
  });
}
```

## Real-World Evidence

**Input:** `example/meta/login.screen.dart`
```dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: LayoutNode.column(
    children: [
      LayoutNode.button(
        label: 'Sign In',
        onPressed: 'handleLogin',  // String identifier
      ),
    ],
  ),
);
```

**Generated Output:** `example/lib/screens/login_screen.dart`
```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.handleLogin,  // ✅ Generated constructor param
  });

  final VoidCallback? handleLogin;  // ✅ Generated field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppButton(
          label: 'Sign In',
          onPressed: handleLogin,  // ✅ Wired correctly
        ),
      ])
    );
  }
}
```

## Findings

✅ **The action wiring IS fully implemented!**

The implementation:
1. ✅ Collects all callback identifiers from AST using `_collectCallbacks()`
2. ✅ Generates fields: `final VoidCallback? handleLogin;`
3. ✅ Generates constructor parameters with `toThis: true`
4. ✅ Wires string identifiers to callbacks: `onPressed: handleLogin`
5. ✅ Handles nested layouts (recursively traverses Column/Row children)

## Current Limitations

The implementation works correctly but has some room for improvement:

### 1. TextField Callbacks Not Collected (Line 97)
```dart
textField: (_) {}, // TODO: Add onChanged etc if needed
```

**Impact:** Low - TextField callbacks are less critical than button actions

**Plan if fixing:**
- Collect `onChanged`, `onSubmitted` from TextFieldNode
- Generate callbacks like `final ValueChanged<String>? onEmailChanged`

### 2. Only VoidCallback Type Supported

**Current:** All callbacks are `VoidCallback?`

**Future Enhancement:**
- Support `ValueChanged<T>?` for text fields
- Support `FormFieldValidator<T>?` for validation
- Support custom callback signatures

### 3. No Validation of Callback Names

**Current:** Accepts any string as callback name, even invalid Dart identifiers

**Example that would break:**
```dart
LayoutNode.button(
  label: 'Click',
  onPressed: 'my-callback',  // Invalid Dart identifier!
)
```

**Generates:**
```dart
final VoidCallback? my-callback;  // Syntax error!
```

**Solution:** Add AST validation (see Issue #3)

## Conclusion

**NO IMPLEMENTATION NEEDED** - Action wiring is fully functional.

The critique appears to be based on outdated code or misunderstanding.

## Potential Enhancements (Low Priority)

If we want to improve the current working implementation:

1. **Add TextField callback support** (5 LOC change)
   ```dart
   textField: (n) {
     if (n.onChanged != null) callbacks.add(n.onChanged!);
     if (n.onSubmitted != null) callbacks.add(n.onSubmitted!);
   }
   ```

2. **Type-aware callback generation** (requires AST changes)
   - Store callback signature in AST
   - Generate appropriate types (`ValueChanged<String>?` vs `VoidCallback?`)

3. **Callback validation** (part of Issue #3 - AST Validation)
   - Validate callback names are valid Dart identifiers
   - Warn on duplicate callback names

## Files Verified

1. ✅ `lib/src/generators/screen_generator.dart:79-104` - Callback collection
2. ✅ `lib/src/generators/screen_generator.dart:47-59` - Field/param generation
3. ✅ `lib/src/emitters/layout_emitter.dart:63-74` - Callback wiring
4. ✅ `example/meta/login.screen.dart` - Input example
5. ✅ `example/lib/screens/login_screen.dart` - Generated output
