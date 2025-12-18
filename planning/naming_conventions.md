# Naming Conventions

> Consistent naming standards for Syntax AST and generated code.

---

## 1. File Naming

| Type                 | Pattern                    | Example                 |
| -------------------- | -------------------------- | ----------------------- |
| AST definition       | `{screen}.dart`            | `login.dart`            |
| Generated widget     | `{screen}_screen.dart`     | `login_screen.dart`     |
| Generated controller | `{screen}_controller.dart` | `login_controller.dart` |

---

## 2. AST Node Naming

| Type        | Pattern            | Example                         |
| ----------- | ------------------ | ------------------------------- |
| Screen root | `ScreenDefinition` | `ScreenDefinition(id: 'login')` |
| Layout      | `{Type}Node`       | `ColumnNode`, `RowNode`         |
| Primitive   | `{Type}Node`       | `ButtonNode`, `TextNode`        |

---

## 3. Action Naming

Actions are **semantic strings**, not callbacks.

| Pattern     | Example                          |
| ----------- | -------------------------------- |
| Verb        | `'login'`, `'submit'`, `'save'`  |
| Verb + Noun | `'saveActivity'`, `'deleteItem'` |

❌ **Never:**
```dart
onPressed: () => login()  // Runtime callback
```

✅ **Always:**
```dart
onPressed: 'login'  // Semantic identifier
```

---

## 4. Variant Naming

| Pattern       | Example                         |
| ------------- | ------------------------------- |
| ButtonVariant | `primary`, `secondary`, `ghost` |
| TextVariant   | `heading`, `body`, `caption`    |

---

## 5. Semantic Icon Names

| Name       | Meaning           |
| ---------- | ----------------- |
| `'email'`  | Email icon        |
| `'lock'`   | Password/security |
| `'search'` | Search action     |
| `'menu'`   | Navigation menu   |

---

## 6. Boolean Naming

| Pattern         | Example                   |
| --------------- | ------------------------- |
| `is{Adjective}` | `isLoading`, `isDisabled` |
| `has{Noun}`     | `hasError`, `hasIcon`     |

---

## 7. Anti-Patterns

❌ **Avoid:**
```dart
onTap           // Use onPressed (semantic string)
onClick         // Use onPressed
VoidCallback    // Use String for action name
```

✅ **Prefer:**
```dart
onPressed: 'submit'
variant: 'primary'
icon: 'email'
```

---

*Document Version: 2.0 (AST-aligned)*
