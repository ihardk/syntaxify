# Syntax Specification

This document defines **what Syntax generates**, **what it never generates**, and **where responsibility ends**. It is the authoritative contract for future development.

---

## 1. Design Principles

Syntax is built on four immutable principles:

1. **Generate structure, not decisions**
2. **Compile-time over runtime**
3. **Primitives over domains**
4. **Ownership over magic**

If a feature violates any of these, it must be rejected.

---

## 2. Inputs (Compile‑Time IRs)

Syntax operates on three independent inputs.

### 2.1 UI AST

* Describes UI intent and structure
* Primitive-only
* No runtime logic

Defined in `AST.md`.

---

### 2.2 Intent Graph

Describes application flow and state **symbolically**.

Contains:

* State fields
* Actions
* Effect sequences (symbolic)

Does NOT contain:

* Async code
* API calls
* Business rules

---

### 2.3 Data Schema IR

Describes **data shape only**.

Contains:

* Entity names
* Fields
* Types

Does NOT contain:

* REST details
* Validation rules
* Persistence strategies

---

## 3. What Syntax Generates

Syntax MAY generate:

### UI Layer

* Flutter widgets
* Compose UI functions
* Theme wiring

### Logic Scaffolding

* Controllers / ViewModels
* State fields
* Action entry points

### Data Layer Structure

* Repository interfaces
* DTOs
* Mappers
* API client stubs

All generated code is:

* Plain
* Editable
* Owned by the developer

---

## 4. What Syntax NEVER Generates

Syntax must NEVER generate:

* Business logic
* Validation rules
* Authorization decisions
* Retry / caching policies
* Database queries
* Domain behavior

These are **human responsibilities**.

---

## 5. Regeneration Rules

1. Generated files may be overwritten safely
2. Business logic must live outside generated code
3. Extension points must be explicit
4. No hidden runtime dependency is allowed

---

## 6. Clean Architecture Mapping

| Layer        | Generated     | Human‑Written |
| ------------ | ------------- | ------------- |
| UI Widgets   | ✅             | ❌             |
| Controllers  | ✅ (structure) | ❌ (logic)     |
| Use Cases    | ⚠️ (skeleton)  | ✅             |
| Repositories | ✅ (interface) | ❌ (impl)      |
| Data Sources | ❌             | ✅             |

---

## 7. Cross‑Platform Contract

Syntax guarantees:

* Same AST → multiple targets
* Platform differences live in emitters
* No platform leakage into IRs

---

## 8. Anti‑Goals

Syntax explicitly does NOT aim to:

* Replace Flutter / Compose
* Become a runtime framework
* Hide generated code
* Enforce architecture dogma

---

## 9. Change Policy

Any change must answer:

1. Is this structural?
2. Is it platform‑agnostic?
3. Can it be expressed symbolically?

If not, it is out of scope.

---

## 10. Final Rule

> Syntax exists to remove repetition, not responsibility.

This rule overrides all others.
