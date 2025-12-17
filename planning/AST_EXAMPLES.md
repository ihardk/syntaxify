# AST Examples

Reference examples demonstrating correct AST patterns.

---

## Example 1: Login Screen

### Intent
A login screen with email, password, and submit action.

### AST Definition

```dart
ScreenDefinition(
  id: 'login',
  layout: ColumnNode(
    children: [
      TextNode(
        text: 'Welcome Back',
        variant: TextVariant.heading,
      ),

      InputNode(
        label: 'Email',
        hint: 'you@example.com',
        prefixIcon: 'email',
      ),

      InputNode(
        label: 'Password',
        obscureText: true,
        prefixIcon: 'lock',
      ),

      ButtonNode(
        label: 'Login',
        variant: ButtonVariant.primary,
        onPressed: 'login',  // ✅ Semantic string, not callback
      ),
    ],
  ),
);
```

### What This Proves

| Principle                    | Demonstrated By                            |
| ---------------------------- | ------------------------------------------ |
| Inputs are pure data         | `InputNode` has no `TextEditingController` |
| Actions are semantic strings | `onPressed: 'login'` not `() => login()`   |
| Icons are semantic           | `prefixIcon: 'email'` not `Icons.email`    |
| Layout is explicit           | `ColumnNode` with ordered `children`       |
| No styling assumptions       | No spacing, colors, or TextStyle           |
