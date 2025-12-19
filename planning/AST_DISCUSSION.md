# Syntaxify AST Architecture Discussion

> Saved conversation from 2025-12-18

---

## Context: The Pivot

We pivoted Syntaxify from a **design-system code generator** to a **framework-agnostic AST/IR compiler**.

---

## What is Syntaxify Now?

**Old Syntaxify:** Annotation-driven design system generator
- Generated styled Flutter widgets
- Used `VoidCallback` for actions
- Runtime theming support

**New Syntaxify:** UI AST compiler
- Generates plain Flutter code from data-only AST
- Actions are symbolic strings (`'login'`, not `() => login()`)
- Compile-time only, no runtime interpretation
- Multi-platform potential (Flutter today, Compose tomorrow)

---

## The Core Specification

### What the AST IS:
- Compile-time only
- Framework-agnostic
- Data-only (primitives, strings, enums)
- Serializable

### What the AST IS NOT (Non-Negotiable):
- No Flutter widgets/Compose APIs
- No runtime callbacks or lambdas
- No business logic
- No async constructs
- No framework types (`BuildContext`, `Color`, `TextStyle`)

### Allowed in AST:
- Primitive values: `String`, `int`, `double`, `bool`, `enum`
- Semantic identifiers: `'submitLogin'`, `'email'`, `'search'`

---

## AST Layers

### 1. Screen Root
```dart
ScreenDefinition(
  id: 'login',
  layout: ...
)
```

### 2. Layout Nodes
- `ColumnNode`
- `RowNode`
- `StackNode`
- `ListNode`

### 3. Primitive Component Nodes
- `TextNode`
- `ButtonNode`
- `TextFieldNode`
- `IconNode`
- `ImageNode`
- `ToggleNode`
- `SpacerNode`

---

## Example: Login Screen AST

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
        onPressed: 'login',  // ✅ String, not callback
      ),
    ],
  ),
);
```

---

## What Goes Into an AST

| Category       | Example                       | Purpose                          |
| -------------- | ----------------------------- | -------------------------------- |
| **Structure**  | `ColumnNode(children: [...])` | How things are arranged          |
| **Intent**     | `ButtonNode(label: 'Login')`  | What something IS                |
| **References** | `onPressed: 'login'`          | Pointers to external definitions |

---

## Old vs New Approach

| Aspect  | Old                          | New AST                      |
| ------- | ---------------------------- | ---------------------------- |
| Actions | `void Function()? onPressed` | `String onPressed = 'login'` |
| Icons   | `IconData? icon`             | `String icon = 'email'`      |
| Styling | Token classes with `Color`   | No styling in AST            |
| Scope   | Component-level              | Screen-level                 |

---

## The Compiler Pipeline

```
1. PARSE          2. VALIDATE       3. RESOLVE        4. EMIT
   ↓                  ↓                 ↓                ↓
┌─────────┐      ┌─────────┐      ┌─────────┐      ┌─────────┐
│ Read    │      │ Check   │      │ Link    │      │ Output  │
│ .dart   │ ───► │ AST     │ ───► │ Actions │ ───► │ Flutter │
│ files   │      │ Rules   │      │ + Icons │      │ Code    │
└─────────┘      └─────────┘      └─────────┘      └─────────┘
```

### What You Already Have:
- ✅ Parser (MetaParser using Dart analyzer)
- ⚠️ AST Nodes (need redesign)
- ⚠️ Validation (needs expansion)
- ⚠️ Code Emission (rename to Emitter)

### What to Add:
- `Validator` — Check AST rules
- `Resolver` — Map `'login'` → `controller.login`
- Screen-level nodes

---

## 5-Stage Roadmap

| Stage | Focus                         | Status |
| ----- | ----------------------------- | ------ |
| 1     | Prove Feasibility             | ✅      |
| 2     | Lock Correctness & Narrative  | ⬅️ NOW  |
| 3     | Prove Power (Layout + Screen) | ⬜      |
| 4     | Make It Legible               | ⬜      |
| 5     | Career or Monetization        | ⬜      |

### Stage 2 Checklist:
1. Fix callback → action identifier in specs
2. Update README language
3. Add golden test
4. Write ARCHITECTURE.md

---

## Why AST Approach for Learning

Skills it teaches:
1. **IR/AST Design** — Language theory
2. **Multi-pass Compilation** — How real compilers work
3. **Emitter Abstraction** — One input → multiple outputs
4. **Constraint Thinking** — Platform-agnostic design

Where these skills are valued:
- Google (Dart team)
- Meta (React Compiler)
- JetBrains
- Flutter team
- Vercel, Supabase, Prisma

---

## Key Principles

1. **Generate structure, not decisions**
2. **Compile-time over runtime**
3. **Primitives over domains**
4. **Ownership over magic**

> **Final Rule:** Syntaxify exists to remove repetition, not responsibility.

---

## Documentation Cleanup Summary

- Planning folder: 23 → 9 files
- All docs now aligned with AST approach
- Core docs: `AST.md`, `SPEC.md`, `ROADMAP.md`, `AST_EXAMPLES.md`
- All 6 agent files updated

---

## Reference Files

- `planning/AST.md` — Full AST specification
- `planning/SPEC.md` — Core Syntaxify specification
- `planning/ROADMAP.md` — 5-stage development plan
- `planning/AST_EXAMPLES.md` — Login screen example
