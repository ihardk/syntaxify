# Implementation Plan: Centralized Foundation Token System for Syntaxify

**Date:** December 24, 2025
**Author:** Implementation Planning Agent
**Related:** CODE_REVIEW_FINDINGS.md (Gaps #1, #2, #3)

---

## Executive Summary

This plan implements a centralized, scalable foundation token system for the Syntaxify Flutter UI generator, addressing three critical gaps identified in the code review:

- **Fix #3 (PRIORITY):** Implement centralized foundation token system
- **Fix #1 (CRITICAL):** Integrate TokenGenerator into build pipeline
- **Fix #2 (OPTIONAL):** Generate renderer token stubs automatically

**Priority Order:** Fix #3 MUST be completed before Fix #1 to avoid generating legacy token structure.

**Impact:** Reduces theme changes from editing 6+ files to editing 1 file. Enables dark mode, brand variants, and design system handoff with Figma.

**Estimated Timeline:** 8-12 hours (1-2 focused coding sessions)

---

## Table of Contents

1. [Current State Analysis](#phase-1-current-state-analysis)
2. [Target Architecture](#phase-2-target-architecture-foundation-token-system)
3. [Implementation Steps](#phase-3-detailed-implementation-steps)
4. [Migration Strategy](#phase-4-migration-strategy--backward-compatibility)
5. [Testing Strategy](#phase-5-testing-strategy)
6. [Risks & Mitigation](#phase-6-risks--mitigation)
7. [Rollout Timeline](#phase-7-rollout-timeline)

---

## Phase 1: Current State Analysis

### Current Architecture (Component-Scoped Tokens)

```
design_system/
├── tokens/
│   ├── button_tokens.dart      → activeColor: Colors.blue
│   ├── checkbox_tokens.dart    → activeColor: Colors.blue
│   ├── toggle_tokens.dart      → activeTrackColor: Colors.blue
│   ├── slider_tokens.dart      → activeTrackColor: Colors.blue
│   ├── radio_tokens.dart       → activeColor: Colors.blue
│   ├── input_tokens.dart       → focusColor: Colors.blue
│   └── text_tokens.dart        → color: Colors.black87
│
├── components/
│   ├── button/
│   │   ├── material_renderer.dart    → buttonTokens() { Colors.blue, padding: 24,12, radius: 8 }
│   │   ├── cupertino_renderer.dart   → buttonTokens() { Colors.blue, ... }
│   │   └── neo_renderer.dart         → buttonTokens() { Colors.black, ... }
│   └── ... (7 components × 3 styles = 21 renderer files)
│
└── styles/
    ├── material_style.dart    → extends DesignStyle with Material*Renderer mixins
    ├── cupertino_style.dart   → extends DesignStyle with Cupertino*Renderer mixins
    └── neo_style.dart         → extends DesignStyle with Neo*Renderer mixins
```

### Problems Identified

1. **Duplicated Hardcoded Values:**
   - `Colors.blue` appears in 6+ files
   - `EdgeInsets.symmetric(horizontal: 24, vertical: 12)` duplicated
   - `BorderRadius.circular(8)` scattered across components

2. **No Single Source of Truth:**
   - To change brand color from blue → purple: Edit 6+ files
   - To switch to dark mode: Edit every token file
   - Inconsistent spacing (some use 12, others use 16)

3. **Doesn't Scale:**
   - Adding 10 more components = 10 more files with duplicated values
   - No centralized typography scale
   - No elevation/shadow system

4. **Gaps in Build Pipeline:**
   - TokenGenerator exists but never called (orphaned)
   - Token files manually created and copied
   - Renderer token getters manually implemented

---

## Phase 2: Target Architecture (Foundation Token System)

### Proposed File Structure

```
design_system/
├── tokens/
│   ├── foundation/
│   │   ├── foundation_tokens.dart       ← NEW: Base class with all foundation properties
│   │   ├── material_foundation.dart     ← NEW: Material Design 3 token values
│   │   ├── cupertino_foundation.dart    ← NEW: iOS HIG token values
│   │   └── neo_foundation.dart          ← NEW: Neo-brutalism token values
│   │
│   └── components/  (or keep at tokens/ level for backward compatibility)
│       ├── button_tokens.dart           ← MODIFIED: Add .fromFoundation() factory
│       ├── checkbox_tokens.dart         ← MODIFIED: Add .fromFoundation() factory
│       ├── toggle_tokens.dart           ← MODIFIED: Add .fromFoundation() factory
│       ├── slider_tokens.dart           ← MODIFIED: Add .fromFoundation() factory
│       ├── radio_tokens.dart            ← MODIFIED: Add .fromFoundation() factory
│       ├── input_tokens.dart            ← MODIFIED: Add .fromFoundation() factory
│       └── text_tokens.dart             ← MODIFIED: Add .fromFoundation() factory
│
├── design_style.dart                    ← MODIFIED: Add foundation getter
└── styles/
    ├── material_style.dart              ← MODIFIED: Override foundation, use .fromFoundation()
    ├── cupertino_style.dart             ← MODIFIED: Override foundation, use .fromFoundation()
    └── neo_style.dart                   ← MODIFIED: Override foundation, use .fromFoundation()
```

### Foundation Token Class Design

**Location:** `generator/design_system/tokens/foundation/foundation_tokens.dart`

```dart
/// Foundation design tokens
///
/// Single source of truth for colors, typography, spacing, elevation, and borders.
/// Each design style (Material, Cupertino, Neo) provides its own foundation values.
class FoundationTokens {
  // ========== COLOR SYSTEM ==========
  // Primary colors
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorPrimaryContainer;
  final Color colorOnPrimaryContainer;

  // Secondary colors
  final Color colorSecondary;
  final Color colorOnSecondary;

  // Surface colors
  final Color colorSurface;
  final Color colorOnSurface;
  final Color colorSurfaceVariant;
  final Color colorOnSurfaceVariant;

  // Utility colors
  final Color colorError;
  final Color colorOnError;
  final Color colorOutline;
  final Color colorShadow;

  // Neutral colors
  final Color colorBackground;
  final Color colorOnBackground;

  // ========== TYPOGRAPHY SCALE ==========
  // Display styles (largest)
  final TextStyle displayLarge;    // 57sp
  final TextStyle displayMedium;   // 45sp
  final TextStyle displaySmall;    // 36sp

  // Headline styles
  final TextStyle headlineLarge;   // 32sp
  final TextStyle headlineMedium;  // 28sp
  final TextStyle headlineSmall;   // 24sp

  // Title styles
  final TextStyle titleLarge;      // 22sp
  final TextStyle titleMedium;     // 16sp
  final TextStyle titleSmall;      // 14sp

  // Body styles
  final TextStyle bodyLarge;       // 16sp
  final TextStyle bodyMedium;      // 14sp
  final TextStyle bodySmall;       // 12sp

  // Label styles (smallest)
  final TextStyle labelLarge;      // 14sp
  final TextStyle labelMedium;     // 12sp
  final TextStyle labelSmall;      // 11sp

  // ========== SPACING SCALE ==========
  // 8dp grid system
  final double spacingXs;   // 4dp
  final double spacingSm;   // 8dp
  final double spacingMd;   // 16dp
  final double spacingLg;   // 24dp
  final double spacingXl;   // 32dp
  final double spacing2Xl;  // 48dp
  final double spacing3Xl;  // 64dp

  // ========== BORDER RADIUS SCALE ==========
  final double radiusNone;  // 0dp
  final double radiusSm;    // 4dp
  final double radiusMd;    // 8dp
  final double radiusLg;    // 16dp
  final double radiusXl;    // 24dp
  final double radiusFull;  // 9999dp (pill shape)

  // ========== ELEVATION/SHADOW SYSTEM ==========
  final double elevationLevel0;  // 0dp
  final double elevationLevel1;  // 1dp
  final double elevationLevel2;  // 3dp
  final double elevationLevel3;  // 6dp
  final double elevationLevel4;  // 8dp
  final double elevationLevel5;  // 12dp

  // ========== BORDER WIDTH SCALE ==========
  final double borderWidthNone;   // 0dp
  final double borderWidthThin;   // 1dp
  final double borderWidthMedium; // 2dp
  final double borderWidthThick;  // 4dp

  const FoundationTokens({
    // Colors (16 properties)
    required this.colorPrimary,
    required this.colorOnPrimary,
    required this.colorPrimaryContainer,
    required this.colorOnPrimaryContainer,
    required this.colorSecondary,
    required this.colorOnSecondary,
    required this.colorSurface,
    required this.colorOnSurface,
    required this.colorSurfaceVariant,
    required this.colorOnSurfaceVariant,
    required this.colorError,
    required this.colorOnError,
    required this.colorOutline,
    required this.colorShadow,
    required this.colorBackground,
    required this.colorOnBackground,

    // Typography (15 properties)
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,

    // Spacing (7 properties)
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.spacingXl,
    required this.spacing2Xl,
    required this.spacing3Xl,

    // Border Radius (6 properties)
    required this.radiusNone,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radiusFull,

    // Elevation (6 properties)
    required this.elevationLevel0,
    required this.elevationLevel1,
    required this.elevationLevel2,
    required this.elevationLevel3,
    required this.elevationLevel4,
    required this.elevationLevel5,

    // Border Width (4 properties)
    required this.borderWidthNone,
    required this.borderWidthThin,
    required this.borderWidthMedium,
    required this.borderWidthThick,
  });
}
```

### Material Foundation Example

**Location:** `generator/design_system/tokens/foundation/material_foundation.dart`

```dart
part of '../../design_system.dart';

/// Material Design 3 Foundation Tokens
///
/// Based on Material Design 3 color system and typography scale.
/// Reference: https://m3.material.io/foundations/design-tokens
const materialFoundation = FoundationTokens(
  // ========== COLORS (Material Design 3) ==========
  colorPrimary: Color(0xFF6200EE),
  colorOnPrimary: Color(0xFFFFFFFF),
  colorPrimaryContainer: Color(0xFFBB86FC),
  colorOnPrimaryContainer: Color(0xFF3700B3),

  colorSecondary: Color(0xFF03DAC6),
  colorOnSecondary: Color(0xFF000000),

  colorSurface: Color(0xFFFFFFFF),
  colorOnSurface: Color(0xFF1C1B1F),
  colorSurfaceVariant: Color(0xFFE7E0EC),
  colorOnSurfaceVariant: Color(0xFF49454F),

  colorError: Color(0xFFB00020),
  colorOnError: Color(0xFFFFFFFF),

  colorOutline: Color(0xFF79747E),
  colorShadow: Color(0xFF000000),

  colorBackground: Color(0xFFFFFBFE),
  colorOnBackground: Color(0xFF1C1B1F),

  // ========== TYPOGRAPHY (Roboto) ==========
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25),
  displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),

  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),

  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),

  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),

  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),

  // ========== SPACING (8dp grid) ==========
  spacingXs: 4.0,
  spacingSm: 8.0,
  spacingMd: 16.0,
  spacingLg: 24.0,
  spacingXl: 32.0,
  spacing2Xl: 48.0,
  spacing3Xl: 64.0,

  // ========== BORDER RADIUS ==========
  radiusNone: 0.0,
  radiusSm: 4.0,
  radiusMd: 8.0,
  radiusLg: 16.0,
  radiusXl: 24.0,
  radiusFull: 9999.0,

  // ========== ELEVATION ==========
  elevationLevel0: 0.0,
  elevationLevel1: 1.0,
  elevationLevel2: 3.0,
  elevationLevel3: 6.0,
  elevationLevel4: 8.0,
  elevationLevel5: 12.0,

  // ========== BORDER WIDTH ==========
  borderWidthNone: 0.0,
  borderWidthThin: 1.0,
  borderWidthMedium: 2.0,
  borderWidthThick: 4.0,
);
```

---

## Phase 3: Detailed Implementation Steps

### Step 1: Create Foundation Token Infrastructure (PRIORITY: CRITICAL)

**Files to Create:**

1. `generator/design_system/tokens/foundation/foundation_tokens.dart`
2. `generator/design_system/tokens/foundation/material_foundation.dart`
3. `generator/design_system/tokens/foundation/cupertino_foundation.dart`
4. `generator/design_system/tokens/foundation/neo_foundation.dart`

**Implementation Order:**
1. Create base `FoundationTokens` class
2. Create `materialFoundation` (validate with Material Design 3 docs)
3. Create `cupertinoFoundation` (validate with iOS HIG)
4. Create `neoFoundation` (use existing Neo patterns)

---

### Step 2: Add Foundation Getter to DesignStyle (PRIORITY: CRITICAL)

**Files to Modify:**

1. `generator/lib/src/generators/design_system_generator.dart` (line ~125)
2. `generator/design_system/design_style.dart` (manual update for now)

**Changes in design_system_generator.dart:**

```dart
// In generateDesignStyle() method, after line 134:
c.methods.add(Method((m) => m
  ..name = 'foundation'
  ..type = MethodType.getter
  ..returns = refer('FoundationTokens')
  ..docs.add('/// Foundation design tokens (colors, typography, spacing, etc.)')));
```

---

### Step 3: Migrate Component Tokens to Foundation-Aware (PRIORITY: CRITICAL)

**Files to Modify (7 total):**

1. `generator/design_system/tokens/button_tokens.dart`
2. `generator/design_system/tokens/checkbox_tokens.dart`
3. `generator/design_system/tokens/toggle_tokens.dart`
4. `generator/design_system/tokens/slider_tokens.dart`
5. `generator/design_system/tokens/radio_tokens.dart`
6. `generator/design_system/tokens/input_tokens.dart`
7. `generator/design_system/tokens/text_tokens.dart`

**Migration Pattern (example for button_tokens.dart):**

```dart
class ButtonTokens {
  final double radius;
  final double borderWidth;
  final Color bgColor;
  final Color textColor;
  final EdgeInsets padding;
  final Color? borderColor;

  const ButtonTokens({
    required this.radius,
    required this.borderWidth,
    required this.bgColor,
    required this.textColor,
    required this.padding,
    this.borderColor,
  });

  /// Create ButtonTokens from foundation tokens
  factory ButtonTokens.fromFoundation(
    FoundationTokens foundation, {
    required ButtonVariant variant,
  }) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: foundation.colorPrimary,
          textColor: foundation.colorOnPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
      case ButtonVariant.secondary:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: foundation.colorSecondary,
          textColor: foundation.colorOnSecondary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
      case ButtonVariant.outlined:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthMedium,
          bgColor: Colors.transparent,
          textColor: foundation.colorPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
          borderColor: foundation.colorPrimary,
        );
      case ButtonVariant.text:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: Colors.transparent,
          textColor: foundation.colorPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
    }
  }
}
```

**Repeat for all 7 component token files.**

---

### Step 4: Update Renderer Mixins to Use Foundation (PRIORITY: CRITICAL)

**Files to Modify (21 total - 7 components × 3 styles)**

**Before:**
```dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return const ButtonTokens(
      radius: 8,
      borderWidth: 0,
      bgColor: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }
}
```

**After:**
```dart
mixin MaterialButtonRenderer on DesignStyle {
  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return ButtonTokens.fromFoundation(foundation, variant: variant);
  }
}
```

---

### Step 5: Update Concrete Style Classes (PRIORITY: CRITICAL)

**Files to Modify:**

1. `generator/design_system/styles/material_style.dart`
2. `generator/design_system/styles/cupertino_style.dart`
3. `generator/design_system/styles/neo_style.dart`

**Changes:**

```dart
// material_style.dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer, MaterialCheckboxRenderer, ... {
  const MaterialStyle();

  @override
  FoundationTokens get foundation => materialFoundation; // ✅ NEW
}
```

---

### Step 6: Update design_system.dart Main Library (PRIORITY: CRITICAL)

**File:** `generator/design_system/design_system.dart`

**Add:**

```dart
// Foundation token imports
import 'tokens/foundation/foundation_tokens.dart';

// Foundation token parts
part 'tokens/foundation/material_foundation.dart';
part 'tokens/foundation/cupertino_foundation.dart';
part 'tokens/foundation/neo_foundation.dart';
```

---

### Step 7: Update DesignSystemGenerator (PRIORITY: HIGH)

**File:** `generator/lib/src/generators/design_system_generator.dart`

**Changes:**

1. Add foundation imports to main library (line ~45)
2. Add foundation parts to main library (line ~92)
3. Add foundation getter to concrete styles (line ~273)

---

### Step 8: Update TokenGenerator for Foundation-Aware Tokens (PRIORITY: HIGH)

**File:** `generator/lib/src/generators/token_generator.dart`

Add `.fromFoundation()` factory generation with intelligent property mapping.

---

### Step 9: Integrate TokenGenerator into Build Pipeline (PRIORITY: CRITICAL)

**File:** `generator/lib/src/use_cases/build_all.dart`

**Location:** Add AFTER line 246 (after enum generation, BEFORE design system copying)

---

### Step 10: Generate Renderer Token Stubs (PRIORITY: LOW - OPTIONAL)

Add method to DesignSystemGenerator to auto-generate renderer token stubs.

---

## Phase 4: Migration Strategy & Backward Compatibility

### Backward Compatibility Approach

1. **Component Tokens Keep Original Constructor**
   - Existing code continues to work
   - No breaking changes

2. **Token File Generation is Non-Destructive**
   - Generated tokens skip existing files
   - Check `if (!exists)` before generating

3. **Phased Rollout**
   - Phase 1: Foundation infrastructure (no breaking changes)
   - Phase 2: Add .fromFoundation() factories (backward compatible)
   - Phase 3: Migrate renderers (internal change)
   - Phase 4: Enable automatic generation (opt-in)

---

## Phase 5: Testing Strategy

### Unit Tests

1. `test/generators/token_generator_test.dart`
2. `test/tokens/foundation_tokens_test.dart`
3. `test/generators/design_system_generator_test.dart`

### Integration Tests

1. `test/integration/foundation_token_e2e_test.dart`
2. `test/integration/token_generation_e2e_test.dart`

### Manual Testing Checklist

- [ ] Build example app with foundation tokens
- [ ] Switch between Material/Cupertino/Neo styles
- [ ] Verify all 7 components render correctly
- [ ] Test variant components (Button, Text)
- [ ] Test non-variant components (Checkbox, Toggle, etc.)
- [ ] Verify no visual regressions

---

## Phase 6: Risks & Mitigation

### Risk #1: Breaking Changes for Existing Users
**Severity:** MEDIUM
**Mitigation:** Maintain backward compatibility, non-destructive generation

### Risk #2: Foundation Token Values Don't Match Material Design 3
**Severity:** HIGH
**Mitigation:** Cross-reference with official docs, use Material Theme Builder

### Risk #3: TokenGenerator Mapping Logic is Incomplete
**Severity:** MEDIUM
**Mitigation:** Generate TODOs for unmapped properties, comprehensive tests

---

## Phase 7: Rollout Timeline

### **Realistic Timeline: 1-2 Focused Sessions (8-12 hours)**

Most of this work is straightforward copy-paste with pattern following. Can be done in 1-2 coding sessions:

### **Session 1: Foundation & Migration (4-6 hours)**

**Hour 1: Foundation Infrastructure (1-1.5 hours)**
- Create `foundation_tokens.dart` base class (30 min)
- Create `material_foundation.dart` with Material Design 3 values (20 min)
- Create `cupertino_foundation.dart` with iOS values (20 min)
- Create `neo_foundation.dart` with brutalist values (20 min)

**Hour 2-3: Component Token Migration (2-3 hours)**
- Add `.fromFoundation()` factory to button_tokens.dart (pattern reference - 30 min)
- Repeat pattern for 6 remaining token files (20 min each = 2 hours)
- Update design_system.dart imports/exports (15 min)

**Hour 4-5: Renderer Migration (2-3 hours)**
- Update MaterialButtonRenderer to use foundation (pattern reference - 20 min)
- Update remaining 6 Material renderers (10 min each = 1 hour)
- Update 7 Cupertino renderers (10 min each = 1 hour)
- Update 7 Neo renderers (10 min each = 1 hour)
- Update MaterialStyle/CupertinoStyle/NeoStyle classes (15 min)

**Hour 6: Initial Testing (30 min)**
- Build example app
- Quick visual check of all 3 styles
- Fix any immediate issues

### **Session 2: Generator Integration & Testing (4-6 hours)**

**Hour 1-2: Generator Updates (1-2 hours)**
- Update DesignSystemGenerator for foundation support (45 min)
- Update TokenGenerator with .fromFoundation() generation (45 min)
- Update design_style.dart generator code (30 min)

**Hour 3: Build Pipeline Integration (1 hour)**
- Add TokenGenerator invocation in build_all.dart (20 min)
- Test generation flow (20 min)
- Handle edge cases (20 min)

**Hour 4-5: Testing (1-2 hours)**
- Run existing test suite (ensure no regressions)
- Add foundation token unit tests (30 min)
- Manual testing in example app (30 min)
- Test all 3 styles (Material, Cupertino, Neo) (30 min)

**Hour 6: Polish & Commit (1 hour)**
- Clean up any TODOs
- Update documentation
- Create comprehensive commit
- Final verification

---

### **Alternative: Incremental Approach (3-4 sessions)**

If you prefer smaller, reviewable PRs:

**Session 1 (2-3 hours):** Foundation infrastructure only
- Create 4 foundation token files
- Add foundation getter to DesignStyle
- **Commit & Push**

**Session 2 (2-3 hours):** Component token migration
- Add .fromFoundation() factories to 7 token files
- **Commit & Push**

**Session 3 (2-3 hours):** Renderer migration
- Update all 21 renderers to use foundation
- Update 3 style classes
- **Commit & Push**

**Session 4 (2-3 hours):** Generator integration & testing
- Update generators
- Integrate into build pipeline
- Full testing
- **Commit & Push**

---

### **Recommended Approach**

**Single focused session (8-10 hours)** is best because:
- Changes are tightly coupled (foundation → tokens → renderers)
- Easier to test as a cohesive unit
- Less context switching
- Single atomic commit

**Original 5-week estimate was overly conservative** and assumed:
- Part-time work (1-2 hours/day)
- Lots of review/discussion cycles
- Learning curve for patterns
- Multiple stakeholder approvals

For a focused implementation session: **8-12 hours total**

---

## Critical Files Reference

### Create New Files (4)
1. `generator/design_system/tokens/foundation/foundation_tokens.dart`
2. `generator/design_system/tokens/foundation/material_foundation.dart`
3. `generator/design_system/tokens/foundation/cupertino_foundation.dart`
4. `generator/design_system/tokens/foundation/neo_foundation.dart`

### Modify Existing Files (38)
- **Component Tokens (7):** button, checkbox, toggle, slider, radio, input, text
- **Renderers (21):** 7 components × 3 styles
- **Styles (3):** material_style, cupertino_style, neo_style
- **Core (4):** design_style, design_system, design_system_generator, build_all
- **Generator (3):** token_generator, design_system_generator, build_all

---

## Success Criteria

### Functional Requirements
✅ Foundation tokens created for Material, Cupertino, Neo
✅ All 7 component tokens have .fromFoundation() factories
✅ All 21 renderers use foundation instead of hardcoded values
✅ TokenGenerator integrated into build pipeline
✅ Backward compatibility maintained
✅ Example app renders correctly in all 3 styles

### Quality Requirements
✅ Material foundation matches Material Design 3 spec
✅ Unit tests pass (90%+ coverage on new code)
✅ Integration tests pass
✅ No visual regressions

---

## Next Steps

1. **Begin Phase 1** (Foundation Infrastructure)
2. **Create PR** for review after each phase
3. **Test incrementally** at each step
4. **Document as you build**

---

## References

- [Material Design 3 Token System](https://m3.material.io/foundations/design-tokens)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Figma Design Tokens Plugin](https://www.figma.com/community/plugin/888356646278934516/design-tokens)
- [W3C Design Tokens Community Group](https://www.w3.org/community/design-tokens/)
