# Syntax AST (Abstract Syntax Tree)

## 1. Purpose

The Syntax AST is the **canonical, compile-time, data-only representation of UI intent and structure**. It exists solely to enable deterministic code generation for multiple UI frameworks (Flutter today, Jetpack Compose / CMP tomorrow).

The AST is not executable. It is not a runtime framework. It is an **Intermediate Representation (IR)**.

---

## 2. What the AST IS

The AST describes:

* **UI intent** (button, text, input)
* **UI structure** (parent → children, ordering)
* **Semantic references** (actions, bindings, icons)

It is:

* Compile-time only
* Framework-agnostic
* Deterministic
* Serializable in concept

---

## 3. What the AST IS NOT (Non‑Negotiable)

The AST must NEVER contain:

* Flutter widgets
* Compose APIs
* Runtime callbacks or lambdas
* Business logic
* Async constructs (`Future`, `Stream`)
* Framework types (`BuildContext`, `Modifier`)
* Styling implementations (`Color`, `TextStyle`)

If something executes at runtime, it does **not** belong in the AST.

---

## 4. Allowed Value Types

The AST may contain only:

### 4.1 Primitive values

* `String`
* `int`
* `double`
* `bool`
* `enum`

### 4.2 Semantic identifiers

* Action names (`"submitLogin"`)
* State bindings (`"email"`)
* Icon names (`"search"`)

These are **symbols**, not implementations.

### 4.3 Optional data

* Nullable primitives
* Compile-time defaults

---

## 5. AST Layers

The AST is intentionally minimal and has exactly **three layers**.

### 5.1 Screen Root

Represents a single UI surface.

```dart
ScreenDefinition(
  id: 'login',
  layout: ...
)
```

Rules:

* One root per screen
* No navigation logic

---

### 5.2 Layout Nodes

Define structure and hierarchy.

Examples:

* `ColumnNode`
* `RowNode`
* `StackNode`
* `ListNode`

Rules:

* Order is explicit
* No spacing inference
* No layout heuristics

---

### 5.3 Primitive Component Nodes

Syntax generates **only universal UI primitives**.

Allowed primitives:

* `TextNode`
* `ButtonNode`
* `TextFieldNode`
* `IconNode`
* `ImageNode`
* `ToggleNode`
* `SpacerNode`

Rules:

* No domain-specific components
* No visual styling logic
* No widget APIs

---

## 6. Forbidden Node Types

The AST must NOT define:

* Domain widgets (`TaskItem`, `DashboardCard`)
* App-specific components
* Business concepts

Complex UI is achieved by **composition of primitives**, not new nodes.

---

## 7. Correct vs Incorrect Examples

### Correct

```dart
ButtonNode(
  label: 'Login',
  onPressed: 'submitLogin'
)
```

### Incorrect

```dart
ButtonNode(
  onPressed: () => submitLogin()
)
```

---

## 8. Compiler Responsibilities

The compiler (not the AST) is responsible for:

* Validation
* Default resolution
* Action binding
* State wiring
* Token application
* Framework-specific emission

---

## 9. Cross‑Platform Guarantee Rule

> If a feature cannot be emitted to **both Flutter and Jetpack Compose**, it does not belong in the AST.

---

## 10. Canonical Definition (One Sentence)

> The Syntax AST is a compile-time, data-only, framework-agnostic representation of UI intent and structure used exclusively for code generation.
