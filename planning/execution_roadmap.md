# Execution Roadmap

> Phased implementation plan with dependencies, milestones, and deliverables.

---

## Overview

```
Phase 0 ──► Phase 1 ──► Phase 2 ──► Phase 3 ──► Phase 4 ──► Phase 5 ──► Phase 6 ──► Phase 7
Manual      Generator   First       Multi       Complex     Layout      Slivers     CLI
Prototype   Foundation  Component   Theme       Inputs      System      Advanced    Product
   ✅          ✅          ✅          ✅          ⬜          ⬜          ⬜          ⬜
```

---

## Phase 0: Manual Prototype ✅ COMPLETE

**Duration:** 1 week
**Status:** Done

### Deliverables
- [x] Manual `meta_arch.dart` with Token + Spec + Renderer
- [x] Working demo with style switching
- [x] 4 components: Button, Badge, Card, Input
- [x] 3 styles: Material, Cupertino, Neo
- [x] Widget tests passing

### Outcome
Validated that the architecture works manually. Ready for automation.

---

## Phase 1: Generator Foundation ✅ COMPLETE

**Duration:** 2 weeks
**Dependencies:** Phase 0

### Tasks
- [x] Create `/generator` Dart console app
- [x] Define meta file schema (`@MetaComponent` annotation)
- [x] Implement basic file parser
- [x] Implement template engine
- [x] Generate single component from meta definition
- [x] CLI: `forge build`

### Deliverables
- [x] `forge` CLI that runs
- [x] Generates `AppButton` from `button.meta.dart`
- [x] Output matches manual implementation quality

### Success Criteria
```bash
$ forge build --component=button
✓ Generated lib/forge/generated/components/app_button.dart
```

---

## Phase 2: First Component (Button) ✅ COMPLETE

**Duration:** 1 week
**Dependencies:** Phase 1

### Tasks
- [x] Full button implementation with all state tokens
- [x] Variant support (primary, secondary, ghost)
- [x] Disabled state handling
- [x] Loading state handling
- [x] Generated tests

### Deliverables
- [x] `AppButton` widget with full API
- [x] Golden tests for each variant/state
- [x] Documentation generated

---

## Phase 3: Multi-Theme Support ✅ COMPLETE

**Duration:** 2 weeks
**Dependencies:** Phase 2

### Tasks
- [x] Theme configuration file (`forge.yaml`)
- [x] Token resolution per theme
- [x] Runtime theme switching (`--mode=dynamic`)
- [x] Static theme compilation (`--mode=static`)
- [x] `AppTheme` InheritedWidget generation

### Deliverables
- [x] 3 themes working: Material, Cupertino, Neo
- [x] Theme switching demo app
- [x] Performance benchmarks

### Success Criteria
```bash
$ forge build --output=lib/forge
✓ Generated 3 theme variants
```

---

## Phase 4: Complex Input Components

**Duration:** 2 weeks
**Dependencies:** Phase 3

### Tasks
- [ ] `AppInput` with focus states
- [ ] `AppTextArea` (multiline)
- [ ] Error state styling
- [ ] Validation rule generation
- [ ] Form integration pattern

### Deliverables
- [ ] Full input component suite
- [ ] Form example with validation
- [ ] State management integration docs

---

## Phase 5: Layout System

**Duration:** 3 weeks
**Dependencies:** Phase 4

### Tasks
- [ ] `AppRow` / `AppColumn` with gap tokens
- [ ] `AppStack` for positioning
- [ ] `AppContainer` with constraints
- [ ] Responsive breakpoint support
- [ ] Spacing scale enforcement

### Deliverables
- [ ] Layout primitives generated
- [ ] Responsive demo
- [ ] Migration guide from raw Flutter

---

## Phase 6: Advanced Layouts (Slivers)

**Duration:** 3 weeks
**Dependencies:** Phase 5

### Tasks
- [ ] `AppScrollView` wrapping CustomScrollView
- [ ] `AppSliverList` / `AppSliverGrid`
- [ ] `AppSliverHeader` (app bar)
- [ ] Performance optimization
- [ ] Lazy loading patterns

### Deliverables
- [ ] Sliver component suite
- [ ] Performance benchmarks vs raw Flutter
- [ ] Example: Complex scrolling screen

---

## Phase 7: CLI Productization

**Duration:** 2 weeks
**Dependencies:** Phase 6

### Tasks
- [ ] `forge init` - project scaffolding
- [ ] `forge add <component>` - add new component
- [ ] `forge migrate` - schema upgrades
- [ ] `forge doctor` - health check
- [ ] pub.dev publishing

### Deliverables
- [ ] Published package on pub.dev
- [ ] Full CLI documentation
- [ ] Getting started guide
- [ ] Example repositories

---

## Dependency Graph

```mermaid
graph LR
    P0[Phase 0: Prototype] --> P1[Phase 1: Generator]
    P1 --> P2[Phase 2: Button]
    P2 --> P3[Phase 3: Themes]
    P3 --> P4[Phase 4: Inputs]
    P4 --> P5[Phase 5: Layout]
    P5 --> P6[Phase 6: Slivers]
    P6 --> P7[Phase 7: CLI]
```

---

## Risk Points

| Phase   | Risk                       | Mitigation                      |
| ------- | -------------------------- | ------------------------------- |
| Phase 1 | Template engine complexity | Start with string interpolation |
| Phase 3 | Performance overhead       | Benchmark early, static mode    |
| Phase 5 | Responsive complexity      | Support progressive adoption    |
| Phase 6 | Sliver abstraction         | Allow escape hatch to raw       |

---

## Time Estimate

| Phase   | Duration | Cumulative |
| ------- | -------- | ---------- |
| Phase 0 | 1 week   | 1 week ✅   |
| Phase 1 | 2 weeks  | 3 weeks    |
| Phase 2 | 1 week   | 4 weeks    |
| Phase 3 | 2 weeks  | 6 weeks    |
| Phase 4 | 2 weeks  | 8 weeks    |
| Phase 5 | 3 weeks  | 11 weeks   |
| Phase 6 | 3 weeks  | 14 weeks   |
| Phase 7 | 2 weeks  | 16 weeks   |

**Total: ~4 months to full MVP**

---

*Document Version: 2.0*

