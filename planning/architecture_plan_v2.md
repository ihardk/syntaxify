# Meta-UI Architecture Plan

> Master architecture document with links to detailed specifications.

---

## Table of Contents
1. [Core Architecture](#1-core-architecture)
2. [Renderer Polymorphism](#2-renderer-polymorphism)
3. [State & Interactivity](#3-state--interactivity)
4. [Theming Modes](#4-theming-modes)
5. [Responsive Tokens](#5-responsive-tokens)
6. [Accessibility](#6-accessibility)
7. [Animation & Motion](#7-animation--motion)
8. [Platform Adaptation](#8-platform-adaptation)
9. [Form & Validation](#9-form--validation)
10. [i18n & RTL](#10-i18n--rtl)
11. [Extensibility](#11-extensibility)
12. [Risk Matrix](#12-risk-matrix)

**Detailed Docs:** [theme_inheritance](./theme_inheritance.md) | [testing_strategy](./testing_strategy.md) | [logging_debugging](./logging_debugging.md) | [dependency_management](./dependency_management.md)

---

## 1. Core Architecture

### The 5-Layer Model

```
┌─────────────────────────────────────────────────────────────┐
│  LAYER 5: GENERATOR                                         │
│  CLI tool that reads meta definitions and outputs Flutter   │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  LAYER 4: IMPLEMENTATION VARIANTS                           │
│  MaterialButtonImpl, GlassButtonImpl, NeoButtonImpl         │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  LAYER 3: RENDERER TEMPLATES                                │
│  Generic widget blueprints with token placeholders          │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  LAYER 2: TOKEN LIBRARY                                     │
│  Pure data definitions for visual properties                │
└─────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  LAYER 1: SPECIFICATION (API)                               │
│  MetaButtonSpec, MetaInputSpec - Props without Style        │
└─────────────────────────────────────────────────────────────┘
```

### Key Principle
- **Old:** Token → Renderer (1:1)
- **New:** Token → Implementation Strategy → Renderer (1:N:1)

---

## 2. Renderer Polymorphism

### Problem
A single `ButtonRenderer` cannot handle structurally different designs:
- Material: `InkWell` with ripple
- Cupertino: `BackdropFilter` with blur
- Neo: `Stack` with offset shadow

### Solution: Implementation Interface

```dart
abstract class ButtonImplementation {
  Widget build(ButtonTokens tokens, MetaButtonSpec spec);
}

class MaterialButtonImpl implements ButtonImplementation { ... }
class GlassButtonImpl implements ButtonImplementation { ... }
class NeoButtonImpl implements ButtonImplementation { ... }
```

### Configuration
```yaml
# theme.material.yaml
button:
  implementation: "standard"

# theme.glass.yaml  
button:
  implementation: "glass"
  tokens: { blurRadius: 10 }
```

---

## 3. State & Interactivity

### State Token Maps

```dart
class StateTokens<T> {
  final T normal;
  final T? hover;
  final T? pressed;
  final T? disabled;
  
  T resolve(Set<MaterialState> states) { ... }
}
```

### Interaction Wrapper Pattern
```dart
class AppButton extends StatelessWidget {
  Widget build(context) {
    return InteractionWrapper(
      onTap: spec.onPressed,
      builder: (states) => ButtonVisual(
        tokens: tokens.resolve(states),
        spec: spec,
      ),
    );
  }
}
```

---

## 4. Theming Modes

### Compile-Time (Static)
```bash
meta_gen --mode=static --theme=neo
```
- Tokens inlined as `const`
- Maximum performance
- Rebuild required for theme change

### Runtime (Dynamic)
```bash
meta_gen --mode=dynamic --themes=material,cupertino,neo
```
- Theme switching at runtime
- Uses `InheritedWidget`

📖 **Details:** [technical_specs.md](./technical_specs.md)

---

## 5. Responsive Tokens

```dart
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  
  T resolve(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200 && desktop != null) return desktop!;
    if (width > 600 && tablet != null) return tablet!;
    return mobile;
  }
}
```

```yaml
button:
  radius:
    mobile: 8
    tablet: 12
    desktop: 16
```

---

## 6. Accessibility

### Requirements
- Semantic labels for screen readers
- Minimum touch targets (48x48)
- Color contrast validation

### Generator Auto-Wraps
```dart
Widget build(context) {
  return Semantics(
    button: true,
    label: spec.label,
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: ButtonVisual(...),
    ),
  );
}
```

📖 **Details:** [design_system_rules.md](./design_system_rules.md)

---

## 7. Animation & Motion

### Motion Tokens

```dart
class ThemeMotion {
  final Duration shortDuration;   // 100ms
  final Duration mediumDuration;  // 250ms
  final Curve standardCurve;
}

class ButtonTokens {
  final Duration pressAnimationDuration;
  final Curve pressAnimationCurve;
  final double pressedScale;  // 0.95 for Cupertino, 1.0 for Neo
}
```

---

## 8. Platform Adaptation

### Behavioral Differences
- **iOS:** Swipe-back, bounce scroll
- **Android:** Back button, overscroll glow
- **Web:** Hover states, URL routing

```dart
class PlatformBehavior {
  final ScrollPhysics scrollPhysics;
  final PageTransitionsBuilder pageTransition;
  final bool useSwipeBack;
}
```

---

## 9. Form & Validation

### State Machine
```
Input States: Empty → Focused → Typing → Filled
Error States: Valid → Invalid → Valid
```

```dart
class MetaInputSpec {
  final String placeholder;
  final List<ValidationRule> validators;
  final ValueChanged<String>? onChanged;
}
```

📖 **Details:** [slot_composition_api.md](./slot_composition_api.md)

---

## 10. i18n & RTL

```dart
class ButtonTokens {
  final EdgeInsetsDirectional padding;  // NOT EdgeInsets
}
```

Generator uses `leading`/`trailing` slots instead of `left`/`right`.

---

## 11. Extensibility

### Custom Components

```dart
@MetaComponent()
class RatingSpec {
  final int maxStars;
  final int currentRating;
  final ValueChanged<int>? onChanged;
}
```

```bash
meta_gen --scan=lib/meta,lib/user_components
```

---

## 12. Risk Matrix

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Renderer variant explosion | High | High | Composition pattern |
| Runtime theming performance | Medium | Medium | Caching |
| Accessibility forgotten | High | High | Generator auto-wraps |
| Dark mode inconsistency | High | Medium | Validation |
| State logic duplication | High | Medium | InteractionWrapper |

---

## Related Documents

### Technical Specifications
| Topic | Document |
|-------|----------|
| CLI & File Formats | [technical_specs.md](./technical_specs.md) |
| Token Scales & Rules | [design_system_rules.md](./design_system_rules.md) |
| Naming Standards | [naming_conventions.md](./naming_conventions.md) |
| Multi-Slot Components | [slot_composition_api.md](./slot_composition_api.md) |

### Runtime Behavior
| Topic | Document |
|-------|----------|
| Dark Mode & Nested Theming | [theme_inheritance.md](./theme_inheritance.md) |
| Assets, Icons & Fonts | [asset_management.md](./asset_management.md) |
| Performance Targets | [performance_benchmarks.md](./performance_benchmarks.md) |

### Quality & Operations
| Topic | Document |
|-------|----------|
| Testing Strategy | [testing_strategy.md](./testing_strategy.md) |
| Error Boundaries | [error_handling.md](./error_handling.md) |
| Debug Tools | [logging_debugging.md](./logging_debugging.md) |
| Disaster Recovery | [rollback_recovery.md](./rollback_recovery.md) |
| SDK Versions | [dependency_management.md](./dependency_management.md) |
| API Documentation | [documentation_strategy.md](./documentation_strategy.md) |

### Implementation & Business
| Topic | Document |
|-------|----------|
| 7-Phase Roadmap | [execution_roadmap.md](./execution_roadmap.md) |
| Vision & Monetization | [product_strategy.md](./product_strategy.md) |
| Phase 0 (Complete) | [phase_0_validation_plan.md](./phase_0_validation_plan.md) |
| Phase 1 (Generator) | [phase_1_validation_plan.md](./phase_1_validation_plan.md) |

---

*Document Version: 3.0 (Slimmed)*
*Last Updated: 2025-12-16*
