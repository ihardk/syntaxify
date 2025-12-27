# COMPLETE SYNTAXIFY COMPONENT ARCHITECTURE GUIDE
**The Definitive Reference for Component Implementation**

**Version:** 0.2.0-beta
**Date:** 2025-12-27
**Scope:** All 20 Components (12 Existing + 8 New v0.3.0)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Component File Architecture](#component-file-architecture)
3. [Complete Component Inventory (All 20)](#complete-component-inventory)
4. [Auto-Generated vs Manual Files](#auto-generated-vs-manual-files)
5. [Adding a New Component: Complete Checklist](#adding-a-new-component-complete-checklist)
6. [Hardcoded Integration Points](#hardcoded-integration-points)
7. [Component Categories & Patterns](#component-categories--patterns)
8. [Critical Issues & Discrepancies](#critical-issues--discrepancies)

---

## Executive Summary

Syntaxify's component architecture consists of **20 production components** across **77 files**:

| Category | Count | Percentage |
|----------|-------|------------|
| **Meta Files** | 20/20 | 100% ✅ |
| **Token Files** | 20/20 | 100% ✅ |
| **Renderer Files** | 58/60 | 97% ✅ (Icon uses shared renderer) |
| **Variant Enums** | 11/20 | 55% (9 don't need variants) |
| **Generated Wrappers** | 13/20 | 65% (7 interactive components excluded) |
| **Model Files** | 3/20 | 15% (Dropdown, TabBar, BottomNav) |

**Key Patterns:**
- **2 Component Types:** Interactive (7) vs UI Components (13)
- **3 Design Styles:** Material, Cupertino, Neo
- **5-7 Files Per Component:** Meta + Tokens + 3 Renderers + (Variant) + (Wrapper) + (Model)

---

## Component File Architecture

### Standard Component File Structure

For a typical component (e.g., `AppButton`), the following files are involved:

```
syntaxify/generator/
│
├── meta/
│   └── button.meta.dart                    [1] Meta Definition (MANUAL)
│
├── design_system/
│   ├── design_system.dart                  [2] Integration Hub (MANUAL)
│   ├── design_style.dart                   [3] Contract (MANUAL)
│   │
│   ├── variants/
│   │   └── button_variant.dart             [4] Variant Enum (MANUAL)
│   │
│   ├── tokens/
│   │   └── button_tokens.dart              [5] Design Tokens (MANUAL)
│   │
│   ├── components/button/
│   │   ├── material_renderer.dart          [6] Material Renderer (MANUAL)
│   │   ├── cupertino_renderer.dart         [7] Cupertino Renderer (MANUAL)
│   │   └── neo_renderer.dart               [8] Neo Renderer (MANUAL)
│   │
│   ├── generated/components/
│   │   └── app_button.dart                 [9] Wrapper Component (AUTO-GENERATED)
│   │
│   ├── styles/
│   │   ├── material_style.dart             [10] Material Style Class (MANUAL)
│   │   ├── cupertino_style.dart            [11] Cupertino Style Class (MANUAL)
│   │   └── neo_style.dart                  [12] Neo Style Class (MANUAL)
│   │
│   └── models/
│       └── button_model.dart               [Optional] Support Models (MANUAL)
```

**Total Files Per Component:** 5-12 files (depending on variants, wrappers, models)

---

## Complete Component Inventory

### 📊 Legend

- ✅ File exists
- ❌ File missing
- 🔧 Manual (developer-maintained)
- ⚙️ Auto-generated
- 🌟 Special case

---

### 1. BUTTON (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/button.meta.dart` | ✅ 🔧 | 1.3K | Defines 4 variants |
| **Variant** | `variants/button_variant.dart` | ❌ | - | **BROKEN IMPORT** (references generated/) |
| **Tokens** | `tokens/button_tokens.dart` | ✅ 🔧 | 2.7K | Largest token file (variants) |
| **Material** | `components/button/material_renderer.dart` | ✅ 🔧 | 2.5K | Uses ElevatedButton/TextButton |
| **Cupertino** | `components/button/cupertino_renderer.dart` | ✅ 🔧 | 2.0K | Uses CupertinoButton |
| **Neo** | `components/button/neo_renderer.dart` | ✅ 🔧 | 1.7K | Custom bold borders |
| **Wrapper** | `generated/components/app_button.dart` | ❌ | - | Interactive component (no wrapper) |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_system.dart:14
import 'tokens/button_tokens.dart';

// design_style.dart:49
Widget renderButton({...});

// material_style.dart:16
with MaterialButtonRenderer

// cupertino_style.dart:16
with CupertinoButtonRenderer

// neo_style.dart:17
with NeoButtonRenderer
```

---

### 2. INPUT (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/input.meta.dart` | ✅ 🔧 | 2.2K | TextField properties |
| **Variant** | - | ❌ | - | Single style component |
| **Tokens** | `tokens/input_tokens.dart` | ✅ 🔧 | 1.7K | Border, padding, text style |
| **Material** | `components/input/material_renderer.dart` | ✅ 🔧 | 1.6K | TextField |
| **Cupertino** | `components/input/cupertino_renderer.dart` | ✅ 🔧 | 2.8K | CupertinoTextField |
| **Neo** | `components/input/neo_renderer.dart` | ✅ 🔧 | 3.3K | Custom bold input |
| **Wrapper** | `generated/components/app_input.dart` | ❌ | - | Interactive component |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:61
Widget renderInput({...});
```

---

### 3. TEXT (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/text.meta.dart` | ✅ 🔧 | 1.3K | 7 text variants |
| **Variant** | `variants/text_variant.dart` | ❌ | - | **BROKEN IMPORT** |
| **Tokens** | `tokens/text_tokens.dart` | ✅ 🔧 | 1.9K | Typography tokens |
| **Material** | `components/text/material_renderer.dart` | ✅ 🔧 | 757B | Simple Text widget |
| **Cupertino** | `components/text/cupertino_renderer.dart` | ✅ 🔧 | 758B | Text widget |
| **Neo** | `components/text/neo_renderer.dart` | ✅ 🔧 | 752B | Text widget |
| **Wrapper** | `generated/components/app_text.dart` | ❌ | - | Interactive component |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:75
Widget renderText({...});
```

---

### 4. CHECKBOX (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/checkbox.meta.dart` | ✅ 🔧 | 912B | Simple checkbox |
| **Variant** | - | ❌ | - | Single style |
| **Tokens** | `tokens/checkbox_tokens.dart` | ✅ 🔧 | 1.2K | Color, size |
| **Material** | `components/checkbox/material_renderer.dart` | ✅ 🔧 | 673B | Checkbox widget |
| **Cupertino** | `components/checkbox/cupertino_renderer.dart` | ✅ 🔧 | 571B | CupertinoCheckbox |
| **Neo** | `components/checkbox/neo_renderer.dart` | ✅ 🔧 | 1.1K | Custom bold checkbox |
| **Wrapper** | `generated/components/app_checkbox.dart` | ❌ | - | Interactive |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:106
Widget renderCheckbox({...});
```

---

### 5. TOGGLE (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/toggle.meta.dart` | ✅ 🔧 | 879B | Switch/toggle |
| **Variant** | - | ❌ | - | Single style |
| **Tokens** | `tokens/toggle_tokens.dart` | ✅ 🔧 | 1.1K | Switch colors |
| **Material** | `components/toggle/material_renderer.dart` | ✅ 🔧 | 612B | Switch widget |
| **Cupertino** | `components/toggle/cupertino_renderer.dart` | ✅ 🔧 | 606B | CupertinoSwitch |
| **Neo** | `components/toggle/neo_renderer.dart` | ✅ 🔧 | 1.7K | Custom toggle |
| **Wrapper** | `generated/components/app_toggle.dart` | ❌ | - | Interactive |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:114
Widget renderSwitch({...});  // ⚠️ Should be renderToggle()
```

**⚠️ NAMING INCONSISTENCY:** Method called `renderSwitch()` but component is `AppToggle`

---

### 6. SLIDER (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/slider.meta.dart` | ✅ 🔧 | 1.2K | Range slider |
| **Variant** | - | ❌ | - | Single style |
| **Tokens** | `tokens/slider_tokens.dart` | ✅ 🔧 | 1.3K | Track, thumb colors |
| **Material** | `components/slider/material_renderer.dart` | ✅ 🔧 | 685B | Slider widget |
| **Cupertino** | `components/slider/cupertino_renderer.dart` | ✅ 🔧 | 637B | CupertinoSlider |
| **Neo** | `components/slider/neo_renderer.dart` | ✅ 🔧 | 4.0K | **Largest renderer** |
| **Wrapper** | `generated/components/app_slider.dart` | ❌ | - | Interactive |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:122
Widget renderSlider({...});
```

---

### 7. RADIO (Interactive, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/radio.meta.dart` | ✅ 🔧 | 1.1K | Radio button |
| **Variant** | - | ❌ | - | Single style |
| **Tokens** | `tokens/radio_tokens.dart` | ✅ 🔧 | 978B | Color, size |
| **Material** | `components/radio/material_renderer.dart` | ✅ 🔧 | 561B | Radio widget |
| **Cupertino** | `components/radio/cupertino_renderer.dart` | ✅ 🔧 | 861B | CupertinoRadio |
| **Neo** | `components/radio/neo_renderer.dart` | ✅ 🔧 | 1.2K | Custom radio |
| **Wrapper** | `generated/components/app_radio.dart` | ❌ | - | Interactive |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:132
Widget renderRadio<T>({...});  // Generic type support
```

---

### 8. CARD (UI Component, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/card.meta.dart` | ✅ 🔧 | 1.5K | Container card |
| **Variant** | `variants/card_variant.dart` | ✅ 🔧 | 310B | Manual variant (NOT generated) |
| **Tokens** | `tokens/card_tokens.dart` | ✅ 🔧 | 2.2K | Padding, elevation, border |
| **Material** | `components/card/material_renderer.dart` | ✅ 🔧 | 1.3K | Card widget |
| **Cupertino** | `components/card/cupertino_renderer.dart` | ✅ 🔧 | 1.4K | Container |
| **Neo** | `components/card/neo_renderer.dart` | ✅ 🔧 | 1.3K | Bold borders |
| **Wrapper** | `generated/components/app_card.dart` | ✅ ⚙️ | 2.4K | **Has wrapper** |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:144
Widget renderCard({...});
```

**⚠️ NOTE:** Variant imported as "generated" but is actually manual

---

### 9. ICON (UI Component, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/icon.meta.dart` | ✅ 🔧 | 829B | Icon display |
| **Variant** | - | ❌ | - | No variants |
| **Tokens** | `tokens/icon_tokens.dart` | ✅ 🔧 | 1006B | Size, color |
| **Shared Renderer** | `components/icon/icon_renderer.dart` | ✅ 🔧 🌟 | 1.1K | **Single shared renderer** |
| **Material** | - | ❌ | - | Uses shared renderer |
| **Cupertino** | - | ❌ | - | Uses shared renderer |
| **Neo** | - | ❌ | - | Uses shared renderer |
| **Wrapper** | `generated/components/app_icon.dart` | ✅ ⚙️ | 1.6K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:158
Widget renderIcon({...});

// All 3 styles use same mixin:
with IconRenderer
```

**🌟 SPECIAL PATTERN:** Icon is the only component using a shared renderer across all styles

---

### 10. DIVIDER (UI Component, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/divider.meta.dart` | ✅ 🔧 | 1.2K | Separator line |
| **Variant** | `variants/divider_orientation.dart` | ✅ 🔧 | 213B | Manual (NOT generated) |
| **Tokens** | `tokens/divider_tokens.dart` | ✅ 🔧 | 986B | Color, thickness |
| **Material** | `components/divider/material_renderer.dart` | ✅ 🔧 | 902B | Divider widget |
| **Cupertino** | `components/divider/cupertino_renderer.dart` | ✅ 🔧 | 1.1K | Container |
| **Neo** | `components/divider/neo_renderer.dart` | ✅ 🔧 | 1.2K | Bold line |
| **Wrapper** | `generated/components/app_divider.dart` | ✅ ⚙️ | 1.8K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:169
Widget renderDivider({...});
```

**⚠️ NOTE:** Variant named `DividerOrientation` (not `DividerVariant`)

---

### 11. IMAGE (UI Component, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/image.meta.dart` | ✅ 🔧 | 1.3K | Image display |
| **Variant** | - | ❌ | - | No variants |
| **Tokens** | `tokens/image_tokens.dart` | ✅ 🔧 | 1003B | Fit, placeholder |
| **Material** | `components/image/material_renderer.dart` | ✅ 🔧 | 2.5K | Image widget |
| **Cupertino** | `components/image/cupertino_renderer.dart` | ✅ 🔧 | 2.3K | Image widget |
| **Neo** | `components/image/neo_renderer.dart` | ✅ 🔧 | 2.8K | Image with border |
| **Wrapper** | `generated/components/app_image.dart` | ✅ ⚙️ | 2.0K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:181
Widget renderImage({...});
```

---

### 12. PROGRESS_INDICATOR (UI Component, Existing)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/progress_indicator.meta.dart` | ✅ 🔧 | 1.2K | Loading indicator |
| **Variant** | `variants/progress_indicator_variant.dart` | ✅ 🔧 | 251B | Manual (NOT generated) |
| **Tokens** | `tokens/progress_indicator_tokens.dart` | ✅ 🔧 | 1.1K | Color, stroke width |
| **Material** | `components/progress_indicator/material_renderer.dart` | ✅ 🔧 | 1.1K | CircularProgressIndicator |
| **Cupertino** | `components/progress_indicator/cupertino_renderer.dart` | ✅ 🔧 | 1.3K | CupertinoActivityIndicator |
| **Neo** | `components/progress_indicator/neo_renderer.dart` | ✅ 🔧 | 1.8K | Custom spinner |
| **Wrapper** | `generated/components/app_progress_indicator.dart` | ✅ ⚙️ | 1.9K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:195
Widget renderProgressIndicator({...});
```

---

### 13. ICON_BUTTON (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/icon_button.meta.dart` | ✅ 🔧 | 1.3K | Icon button |
| **Variant** | `variants/icon_button_variant.dart` | ✅ 🔧 | 276B | Manual (NOT generated) |
| **Tokens** | `tokens/icon_button_tokens.dart` | ✅ 🔧 | 2.1K | Size, color, padding |
| **Material** | `components/icon_button/material_renderer.dart` | ✅ 🔧 | 1.8K | IconButton widget |
| **Cupertino** | `components/icon_button/cupertino_renderer.dart` | ✅ 🔧 | 1.6K | CupertinoButton |
| **Neo** | `components/icon_button/neo_renderer.dart` | ✅ 🔧 | 1.4K | Custom button |
| **Wrapper** | `generated/components/app_icon_button.dart` | ✅ ⚙️ | 2.0K | **Fixed import path** |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_system.dart:26
import 'tokens/icon_button_tokens.dart';

// design_style.dart:207
Widget renderIconButton({...});
```

---

### 14. DROPDOWN (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/dropdown.meta.dart` | ✅ 🔧 | 1.5K | Generic `<T>` |
| **Variant** | `variants/dropdown_variant.dart` | ✅ 🔧 | 296B | Manual |
| **Tokens** | `tokens/dropdown_tokens.dart` | ✅ 🔧 | 3.1K | **Largest token file** |
| **Material** | `components/dropdown/material_renderer.dart` | ✅ 🔧 | 2.2K | DropdownButton |
| **Cupertino** | `components/dropdown/cupertino_renderer.dart` | ✅ 🔧 | 5.9K | **Largest renderer** |
| **Neo** | `components/dropdown/neo_renderer.dart` | ✅ 🔧 | 2.9K | Custom dropdown |
| **Wrapper** | `generated/components/app_dropdown.dart` | ✅ ⚙️ | 2.2K | Generic type support |
| **Model** | `models/dropdown_item.dart` | ✅ 🔧 | ~500B | DropdownItem class |

**Integration Points:**
```dart
// design_system.dart:34
import 'models/dropdown_item.dart';

// design_style.dart:221
Widget renderDropdown<T>({...});  // Generic support
```

**🌟 SPECIAL:** Generic type support `AppDropdown<T>`

---

### 15. TAB_BAR (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/tab_bar.meta.dart` | ✅ 🔧 | 1.2K | Tab navigation |
| **Variant** | `variants/tab_bar_variant.dart` | ✅ 🔧 | 235B | Manual |
| **Tokens** | `tokens/tab_bar_tokens.dart` | ✅ 🔧 | 2.4K | Selected, unselected colors |
| **Material** | `components/tab_bar/material_renderer.dart` | ✅ 🔧 | 1.5K | TabBar widget |
| **Cupertino** | `components/tab_bar/cupertino_renderer.dart` | ✅ 🔧 | 2.2K | CupertinoSegmentedControl |
| **Neo** | `components/tab_bar/neo_renderer.dart` | ✅ 🔧 | 3.2K | Custom tabs |
| **Wrapper** | `generated/components/app_tab_bar.dart` | ✅ ⚙️ | 1.6K | Has wrapper |
| **Model** | `models/tab_bar_item.dart` | ✅ 🔧 | ~300B | TabBarItem class |

**Integration Points:**
```dart
// design_system.dart:35
import 'models/tab_bar_item.dart';

// design_style.dart:236
Widget renderTabBar({...});
```

---

### 16. BOTTOM_NAV (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/bottom_nav.meta.dart` | ✅ 🔧 | 1.2K | Bottom navigation |
| **Variant** | `variants/bottom_nav_variant.dart` | ✅ 🔧 | 77B | Manual |
| **Tokens** | `tokens/bottom_nav_tokens.dart` | ✅ 🔧 | 1.5K | Colors, elevation |
| **Material** | `components/bottom_nav/material_renderer.dart` | ✅ 🔧 | 1.2K | BottomNavigationBar |
| **Cupertino** | `components/bottom_nav/cupertino_renderer.dart` | ✅ 🔧 | 995B | CupertinoTabBar |
| **Neo** | `components/bottom_nav/neo_renderer.dart` | ✅ 🔧 | 2.5K | Custom bottom nav |
| **Wrapper** | `generated/components/app_bottom_nav.dart` | ✅ ⚙️ | 1.2K | Has wrapper |
| **Model** | `models/bottom_nav_item.dart` | ✅ 🔧 | ~400B | BottomNavItem class |

**Integration Points:**
```dart
// design_system.dart:36
import 'models/bottom_nav_item.dart';

// design_style.dart:248
Widget renderBottomNav({...});
```

---

### 17. APP_BAR (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/app_bar.meta.dart` | ✅ 🔧 | 659B | Top app bar |
| **Variant** | `variants/app_bar_variant.dart` | ✅ 🔧 | 49B | **Smallest variant** |
| **Tokens** | `tokens/app_bar_tokens.dart` | ✅ 🔧 | 1.4K | Background, elevation |
| **Material** | `components/app_bar/material_renderer.dart` | ✅ 🔧 | 1.1K | AppBar widget |
| **Cupertino** | `components/app_bar/cupertino_renderer.dart` | ✅ 🔧 | 1.3K | CupertinoNavigationBar |
| **Neo** | `components/app_bar/neo_renderer.dart` | ✅ 🔧 | 2.0K | Custom app bar |
| **Wrapper** | `generated/components/app_app_bar.dart` | ✅ ⚙️ | 1.2K | PreferredSizeWidget |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:260
PreferredSizeWidget renderAppBar({...});  // Special return type
```

**🌟 SPECIAL:** Returns `PreferredSizeWidget` for Scaffold compatibility

---

### 18. CHIP (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/chip.meta.dart` | ✅ 🔧 | 632B | Tag/chip component |
| **Variant** | `variants/chip_variant.dart` | ✅ 🔧 | 43B | Manual |
| **Tokens** | `tokens/chip_tokens.dart` | ✅ 🔧 | 1.6K | Background, border, padding |
| **Material** | `components/chip/material_renderer.dart` | ✅ 🔧 | 999B | Chip widget |
| **Cupertino** | `components/chip/cupertino_renderer.dart` | ✅ 🔧 | 1.5K | Container |
| **Neo** | `components/chip/neo_renderer.dart` | ✅ 🔧 | 1.7K | Bold chip |
| **Wrapper** | `generated/components/app_chip.dart` | ✅ ⚙️ | 1.1K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:272
Widget renderChip({...});
```

---

### 19. BADGE (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/badge.meta.dart` | ✅ 🔧 | 561B | Notification badge |
| **Variant** | `variants/badge_variant.dart` | ✅ 🔧 | 38B | **Smallest variant** |
| **Tokens** | `tokens/badge_tokens.dart` | ✅ 🔧 | 1.2K | Background, size, text |
| **Material** | `components/badge/material_renderer.dart` | ✅ 🔧 | 794B | Badge widget |
| **Cupertino** | `components/badge/cupertino_renderer.dart` | ✅ 🔧 | 1.6K | Stack + Positioned |
| **Neo** | `components/badge/neo_renderer.dart` | ✅ 🔧 | 1.7K | Bold badge |
| **Wrapper** | `generated/components/app_badge.dart` | ✅ ⚙️ | 955B | Smallest wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:284
Widget renderBadge({...});
```

---

### 20. AVATAR (UI Component, New v0.3.0)

| File Type | Path | Status | Size | Notes |
|-----------|------|--------|------|-------|
| **Meta** | `/meta/avatar.meta.dart` | ✅ 🔧 | 645B | User avatar |
| **Variant** | `variants/avatar_variant.dart` | ✅ 🔧 | 43B | Manual |
| **Tokens** | `tokens/avatar_tokens.dart` | ✅ 🔧 | 1.4K | Background, size, text |
| **Material** | `components/avatar/material_renderer.dart` | ✅ 🔧 | 1007B | CircleAvatar |
| **Cupertino** | `components/avatar/cupertino_renderer.dart` | ✅ 🔧 | 1.4K | Container |
| **Neo** | `components/avatar/neo_renderer.dart` | ✅ 🔧 | 1.7K | Bold avatar |
| **Wrapper** | `generated/components/app_avatar.dart` | ✅ ⚙️ | 1.1K | Has wrapper |
| **Model** | - | ❌ | - | Not needed |

**Integration Points:**
```dart
// design_style.dart:295
Widget renderAvatar({...});
```

**⚠️ KNOWN BUG:** No error handling for network images (Issue #5)

---

## Auto-Generated vs Manual Files

### Auto-Generated Files ⚙️

**Location:** `/generator/design_system/generated/components/`

**Count:** 13 wrapper component files

**Pattern:**
```dart
// ============================================
// GENERATED BY SYNTAXIFY v0.2.0-beta
// DO NOT MODIFY - Regenerated on build
// Component: AppButton (Meta-Driven)
// Generated: 2025-12-27
// ============================================

import 'package:flutter/material.dart';
import '../../design_system.dart';

class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderButton(...);
  }
}
```

**Components with Generated Wrappers (13):**
1. AppCard ✅
2. AppIcon ✅
3. AppDivider ✅
4. AppImage ✅
5. AppProgressIndicator ✅
6. AppIconButton ✅
7. AppDropdown ✅
8. AppTabBar ✅
9. AppBottomNav ✅
10. AppAppBar ✅
11. AppChip ✅
12. AppBadge ✅
13. AppAvatar ✅

**Components WITHOUT Generated Wrappers (7):**
1. AppButton ❌ (Interactive)
2. AppInput ❌ (Interactive)
3. AppText ❌ (Interactive)
4. AppCheckbox ❌ (Interactive)
5. AppToggle ❌ (Interactive)
6. AppSlider ❌ (Interactive)
7. AppRadio ❌ (Interactive)

**Why the difference?**
- Interactive components are used directly in AST for `.screen.dart` files
- UI components are standalone widgets for layout composition

---

### Manual Files 🔧

All other files are **developer-maintained** and require manual creation/editing:

**Always Manual (100 files):**
- 20 Meta files (`meta/*.meta.dart`)
- 20 Token files (`design_system/tokens/*_tokens.dart`)
- 58 Renderer files (`design_system/components/*/material|cupertino|neo_renderer.dart`)
- 11 Variant files (`design_system/variants/*_variant.dart`)
- 3 Model files (`design_system/models/*_item.dart`)
- 3 Style files (`design_system/styles/material|cupertino|neo_style.dart`)
- 1 DesignStyle contract (`design_system/design_style.dart`)
- 1 Integration hub (`design_system/design_system.dart`)

**Total Manual Files:** 117 files (90% of architecture)

---

## Adding a New Component: Complete Checklist

### Phase 1: Core Definition (Meta & Tokens)

#### ✅ Step 1: Create Meta File (5 min)

**File:** `/generator/meta/{component_name}.meta.dart`

```dart
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
  description: 'A design-system-aware {component} component',
  variants: ['primary', 'secondary'],  // Optional
)
class {Component}Meta {
  const {Component}Meta({
    required this.requiredProp,
    this.optionalProp = 'default',
  });

  final String requiredProp;
  final String? optionalProp;
}
```

**Checklist:**
- [ ] File created in `/generator/meta/`
- [ ] Named `{component_name}.meta.dart` (snake_case)
- [ ] `@SyntaxComponent` annotation added
- [ ] All properties defined with types
- [ ] Constructor with default values

---

#### ✅ Step 2: Create Variant Enum (3 min) - OPTIONAL

**File:** `/generator/design_system/variants/{component_name}_variant.dart`

```dart
/// Variants for {Component} component
enum {Component}Variant {
  primary,
  secondary,
  outlined,
}
```

**Checklist:**
- [ ] File created in `/generator/design_system/variants/`
- [ ] Enum named `{Component}Variant` (PascalCase)
- [ ] All variants listed

**Skip if:** Component has single style (checkbox, toggle, radio, etc.)

---

#### ✅ Step 3: Create Token Class (10 min)

**File:** `/generator/design_system/tokens/{component_name}_tokens.dart`

```dart
import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

class {Component}Tokens {
  const {Component}Tokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    required this.borderRadius,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsets padding;
  final double borderRadius;

  /// Generate tokens from foundation tokens
  factory {Component}Tokens.fromFoundation(
    FoundationTokens foundation,
    {Component}Variant variant,
  ) {
    switch (variant) {
      case {Component}Variant.primary:
        return {Component}Tokens(
          backgroundColor: foundation.colorPrimary,
          foregroundColor: foundation.colorOnPrimary,
          padding: EdgeInsets.all(foundation.spacingMd),
          borderRadius: foundation.radiusMd,
        );
      case {Component}Variant.secondary:
        return {Component}Tokens(
          backgroundColor: foundation.colorSecondary,
          foregroundColor: foundation.colorOnSecondary,
          padding: EdgeInsets.all(foundation.spacingMd),
          borderRadius: foundation.radiusMd,
        );
    }
  }
}
```

**Checklist:**
- [ ] File created in `/generator/design_system/tokens/`
- [ ] Named `{component_name}_tokens.dart` (snake_case)
- [ ] Token class defined with all style properties
- [ ] `.fromFoundation()` factory method implemented
- [ ] All variants handled in switch statement

---

### Phase 2: Renderers (Material, Cupertino, Neo)

#### ✅ Step 4: Create Material Renderer (15 min)

**File:** `/generator/design_system/components/{component_name}/material_renderer.dart`

```dart
part of '../../design_system.dart';

mixin Material{Component}Renderer on DesignStyle {
  @override
  {Component}Tokens {component}Tokens({Component}Variant variant) {
    return {Component}Tokens.fromFoundation(foundation, variant);
  }

  @override
  Widget render{Component}({
    required String requiredProp,
    String? optionalProp,
    {Component}Variant variant = {Component}Variant.primary,
  }) {
    final tokens = {component}Tokens(variant);

    return ElevatedButton(  // Or appropriate Material widget
      style: ElevatedButton.styleFrom(
        backgroundColor: tokens.backgroundColor,
        foregroundColor: tokens.foregroundColor,
        padding: tokens.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
      onPressed: () {},
      child: Text(requiredProp),
    );
  }
}
```

**Checklist:**
- [ ] File created in `/generator/design_system/components/{component_name}/`
- [ ] Named `material_renderer.dart`
- [ ] `part of '../../design_system.dart';` directive at top
- [ ] Mixin named `Material{Component}Renderer`
- [ ] `on DesignStyle` constraint
- [ ] Token method implemented
- [ ] Render method implemented
- [ ] Uses appropriate Material Design widget

---

#### ✅ Step 5: Create Cupertino Renderer (15 min)

**File:** `/generator/design_system/components/{component_name}/cupertino_renderer.dart`

```dart
part of '../../design_system.dart';

mixin Cupertino{Component}Renderer on DesignStyle {
  @override
  {Component}Tokens {component}Tokens({Component}Variant variant) {
    return {Component}Tokens.fromFoundation(foundation, variant);
  }

  @override
  Widget render{Component}({
    required String requiredProp,
    String? optionalProp,
    {Component}Variant variant = {Component}Variant.primary,
  }) {
    final tokens = {component}Tokens(variant);

    return CupertinoButton(  // Or appropriate Cupertino widget
      color: tokens.backgroundColor,
      padding: tokens.padding,
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      onPressed: () {},
      child: Text(
        requiredProp,
        style: TextStyle(color: tokens.foregroundColor),
      ),
    );
  }
}
```

**Checklist:**
- [ ] File created in same directory as Material
- [ ] Named `cupertino_renderer.dart`
- [ ] Mixin named `Cupertino{Component}Renderer`
- [ ] Uses appropriate Cupertino widget

---

#### ✅ Step 6: Create Neo Renderer (20 min)

**File:** `/generator/design_system/components/{component_name}/neo_renderer.dart`

```dart
part of '../../design_system.dart';

mixin Neo{Component}Renderer on DesignStyle {
  @override
  {Component}Tokens {component}Tokens({Component}Variant variant) {
    return {Component}Tokens.fromFoundation(foundation, variant);
  }

  @override
  Widget render{Component}({
    required String requiredProp,
    String? optionalProp,
    {Component}Variant variant = {Component}Variant.primary,
  }) {
    final tokens = {component}Tokens(variant);

    return Container(
      padding: tokens.padding,
      decoration: BoxDecoration(
        color: tokens.backgroundColor,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        border: Border.all(
          color: Colors.black,
          width: 3.0,  // Neo-brutalism signature bold border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),  // Hard shadow
            blurRadius: 0,  // No blur for hard shadow
          ),
        ],
      ),
      child: Text(
        requiredProp,
        style: TextStyle(
          color: tokens.foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

**Checklist:**
- [ ] File created in same directory
- [ ] Named `neo_renderer.dart`
- [ ] Mixin named `Neo{Component}Renderer`
- [ ] Uses bold borders (3px)
- [ ] Hard shadow (no blur)
- [ ] Bold typography

---

### Phase 3: Integration (Hardcoded Files)

#### ✅ Step 7: Update design_system.dart (5 min) - MANUAL REQUIRED

**File:** `/generator/design_system/design_system.dart`

**Changes:**

```dart
// 1. Import token file (around line 26)
import 'tokens/{component_name}_tokens.dart';

// 2. Import variant file if exists (around line 48)
import 'variants/{component_name}_variant.dart';

// 3. Import model file if exists (around line 34)
import 'models/{component_name}_item.dart';

// 4. Export token file (around line 73)
export 'tokens/{component_name}_tokens.dart';

// 5. Export variant file if exists (around line 92)
export 'variants/{component_name}_variant.dart';

// 6. Export model file if exists (around line 77)
export 'models/{component_name}_item.dart';

// 7. Add part file for Material renderer (around line 158)
part 'components/{component_name}/material_renderer.dart';

// 8. Add part file for Cupertino renderer (around line 159)
part 'components/{component_name}/cupertino_renderer.dart';

// 9. Add part file for Neo renderer (around line 160)
part 'components/{component_name}/neo_renderer.dart';
```

**Checklist:**
- [ ] Token import added
- [ ] Token export added
- [ ] Variant import added (if applicable)
- [ ] Variant export added (if applicable)
- [ ] Model import added (if applicable)
- [ ] Model export added (if applicable)
- [ ] All 3 renderer part files added
- [ ] Imports organized alphabetically

---

#### ✅ Step 8: Update design_style.dart (10 min) - MANUAL REQUIRED

**File:** `/generator/design_system/design_style.dart`

**Changes:**

```dart
sealed class DesignStyle {
  // ... existing code ...

  // Add token method (around line 300)
  {Component}Tokens {component}Tokens({Component}Variant variant);

  // Add render method (around line 305)
  Widget render{Component}({
    required String requiredProp,
    String? optionalProp,
    {Component}Variant variant = {Component}Variant.primary,
  });
}
```

**Checklist:**
- [ ] Token method signature added
- [ ] Render method signature added
- [ ] Parameters match renderer implementations
- [ ] Return type correct (Widget or PreferredSizeWidget)

---

#### ✅ Step 9: Update material_style.dart (3 min) - MANUAL REQUIRED

**File:** `/generator/design_system/styles/material_style.dart`

**Changes:**

```dart
class MaterialStyle extends DesignStyle
    with
        // ... existing mixins ...
        Material{Component}Renderer {  // Add this line
  const MaterialStyle();

  @override
  FoundationTokens get foundation => materialFoundation;
}
```

**Checklist:**
- [ ] Mixin added to `with` clause
- [ ] Alphabetically ordered (optional but recommended)

---

#### ✅ Step 10: Update cupertino_style.dart (3 min) - MANUAL REQUIRED

**File:** `/generator/design_system/styles/cupertino_style.dart`

**Changes:**

```dart
class CupertinoStyle extends DesignStyle
    with
        // ... existing mixins ...
        Cupertino{Component}Renderer {  // Add this line
  const CupertinoStyle();

  @override
  FoundationTokens get foundation => cupertinoFoundation;
}
```

**Checklist:**
- [ ] Mixin added to `with` clause

---

#### ✅ Step 11: Update neo_style.dart (3 min) - MANUAL REQUIRED

**File:** `/generator/design_system/styles/neo_style.dart`

**Changes:**

```dart
class NeoStyle extends DesignStyle
    with
        // ... existing mixins ...
        Neo{Component}Renderer {  // Add this line
  const NeoStyle();

  @override
  FoundationTokens get foundation => neoFoundation;
}
```

**Checklist:**
- [ ] Mixin added to `with` clause

---

### Phase 4: Generated Wrapper (Optional - UI Components Only)

#### ✅ Step 12: Generate Wrapper Component (Automatic)

**File:** `/generator/design_system/generated/components/app_{component_name}.dart`

**Generation:** This file is auto-generated by running:

```bash
cd generator
dart run syntaxify build
```

**Result:**
```dart
// ============================================
// GENERATED BY SYNTAXIFY v0.2.0-beta
// DO NOT MODIFY - Regenerated on build
// ============================================

import 'package:flutter/material.dart';
import '../../design_system.dart';

class App{Component} extends StatelessWidget {
  const App{Component}({
    super.key,
    required this.requiredProp,
    this.optionalProp,
    this.variant = {Component}Variant.primary,
  });

  final String requiredProp;
  final String? optionalProp;
  final {Component}Variant variant;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.render{Component}(
      requiredProp: requiredProp,
      optionalProp: optionalProp,
      variant: variant,
    );
  }
}
```

**Checklist:**
- [ ] Run `dart run syntaxify build` in generator directory
- [ ] Verify wrapper file created
- [ ] Check import path is correct: `import '../../design_system.dart';`

**Note:** Interactive components (button, input, etc.) do NOT generate wrappers

---

### Phase 5: Model Files (Optional - Complex Components Only)

#### ✅ Step 13: Create Model Class (10 min) - OPTIONAL

**File:** `/generator/design_system/models/{component_name}_item.dart`

**Required for:** Dropdown, TabBar, BottomNav (components with item lists)

```dart
import 'package:flutter/foundation.dart';

/// Data model for {Component} items
class {Component}Item {
  const {Component}Item({
    required this.value,
    required this.label,
    this.icon,
  });

  final String value;
  final String label;
  final String? icon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is {Component}Item &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label &&
          icon == other.icon;

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ icon.hashCode;
}
```

**Checklist:**
- [ ] Model class created
- [ ] All required properties defined
- [ ] Equality operators implemented (`==`, `hashCode`)
- [ ] Imported in `design_system.dart`
- [ ] Exported in `design_system.dart`

**Examples:**
- `DropdownItem` (dropdown.meta.dart)
- `TabBarItem` (tab_bar.meta.dart)
- `BottomNavItem` (bottom_nav.meta.dart)

---

## Hardcoded Integration Points

### Files That MUST Be Updated Manually

These files **cannot be auto-generated** and require manual editing for every new component:

#### 1. **design_system.dart** (11 edits per component)

**Location:** `/generator/design_system/design_system.dart`

**Edits Required:**
1. Import token file (line ~26)
2. Import variant file (line ~48) - if applicable
3. Import model file (line ~34) - if applicable
4. Export token file (line ~73)
5. Export variant file (line ~92) - if applicable
6. Export model file (line ~77) - if applicable
7. Part directive for Material renderer (line ~158)
8. Part directive for Cupertino renderer (line ~159)
9. Part directive for Neo renderer (line ~160)

**Example Block:**
```dart
// Tokens
import 'tokens/{component}_tokens.dart';

// Variants
import 'variants/{component}_variant.dart';

// Models
import 'models/{component}_item.dart';

// Export everything
export 'tokens/{component}_tokens.dart';
export 'variants/{component}_variant.dart';
export 'models/{component}_item.dart';

// Part files
part 'components/{component}/material_renderer.dart';
part 'components/{component}/cupertino_renderer.dart';
part 'components/{component}/neo_renderer.dart';
```

---

#### 2. **design_style.dart** (2 edits per component)

**Location:** `/generator/design_system/design_style.dart`

**Edits Required:**
1. Token method signature (line ~300)
2. Render method signature (line ~305)

**Example:**
```dart
sealed class DesignStyle {
  // Token accessor
  {Component}Tokens {component}Tokens({Component}Variant variant);

  // Render method
  Widget render{Component}({
    required String prop1,
    String? prop2,
    {Component}Variant variant = {Component}Variant.primary,
  });
}
```

**Method Count:** Currently **25 render methods** for 20 components (some have tokens + render)

---

#### 3. **material_style.dart** (1 edit per component)

**Location:** `/generator/design_system/styles/material_style.dart`

**Edit Required:**
- Add mixin to `with` clause

**Example:**
```dart
class MaterialStyle extends DesignStyle
    with
        MaterialButtonRenderer,
        MaterialInputRenderer,
        Material{Component}Renderer {  // <- Add this
  // ...
}
```

**Current Mixins:** 20

---

#### 4. **cupertino_style.dart** (1 edit per component)

**Location:** `/generator/design_system/styles/cupertino_style.dart`

**Edit Required:**
- Add mixin to `with` clause

**Current Mixins:** 20

---

#### 5. **neo_style.dart** (1 edit per component)

**Location:** `/generator/design_system/styles/neo_style.dart`

**Edit Required:**
- Add mixin to `with` clause

**Current Mixins:** 20

---

### Total Manual Edits Per Component

**Minimum (No variant, no model, no wrapper):**
- design_system.dart: 4 edits (import token, export token, 2 part directives)
- design_style.dart: 2 edits (token method, render method)
- material_style.dart: 1 edit (mixin)
- cupertino_style.dart: 1 edit (mixin)
- neo_style.dart: 1 edit (mixin)
- **Total: 9 edits minimum**

**Maximum (With variant, model, wrapper):**
- design_system.dart: 11 edits
- design_style.dart: 2 edits
- 3 style files: 3 edits
- **Total: 16 edits maximum**

---

## Component Categories & Patterns

### Category 1: Interactive Components (7 total)

**Characteristics:**
- No generated wrapper component
- Used directly in `.screen.dart` AST
- Simpler integration

**Components:**
1. Button
2. Input
3. Text
4. Checkbox
5. Toggle
6. Slider
7. Radio

**Pattern:**
```
Meta ──> Tokens ──> Renderers (3) ──> Style Integration
                                    └──> No Wrapper
```

**File Count:** 5-6 files per component

---

### Category 2: UI Components (13 total)

**Characteristics:**
- Have generated wrapper component
- Standalone widgets for composition
- Full integration

**Components:**
1. Card
2. Icon
3. Divider
4. Image
5. ProgressIndicator
6. IconButton
7. Dropdown
8. TabBar
9. BottomNav
10. AppBar
11. Chip
12. Badge
13. Avatar

**Pattern:**
```
Meta ──> Tokens ──> Renderers (3) ──> Style Integration
                                    └──> Generated Wrapper
```

**File Count:** 6-9 files per component (including wrapper, possibly model)

---

### Category 3: Special Patterns

#### Icon Component (Shared Renderer)

**Unique Pattern:**
- Single renderer shared across all styles
- No Material/Cupertino/Neo separation
- All styles use `IconRenderer` mixin

**Why?** Icons are universal and don't need style-specific implementations

**Files:**
```
meta/icon.meta.dart
tokens/icon_tokens.dart
components/icon/icon_renderer.dart  (shared)
generated/components/app_icon.dart
```

**Integration:**
```dart
// All 3 styles use same mixin:
class MaterialStyle extends DesignStyle with IconRenderer { }
class CupertinoStyle extends DesignStyle with IconRenderer { }
class NeoStyle extends DesignStyle with IconRenderer { }
```

---

#### Generic Components

**AppDropdown<T>**

**Unique Feature:** Generic type parameter

**Implementation:**
```dart
// Meta
class DropdownMeta<T> { }

// Renderer
Widget renderDropdown<T>({ ... })

// Wrapper
class AppDropdown<T> extends StatelessWidget { }
```

**Usage:**
```dart
AppDropdown<String>(...)
AppDropdown<int>(...)
```

---

#### PreferredSizeWidget Components

**AppBar**

**Unique Feature:** Implements `PreferredSizeWidget`

**Implementation:**
```dart
// design_style.dart
PreferredSizeWidget renderAppBar({ ... });  // Not Widget

// Wrapper
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56);
}
```

**Why?** Scaffold requires `PreferredSizeWidget` for appBar property

---

## Critical Issues & Discrepancies

### 🔴 Issue 1: Variant Import Mismatch

**Problem:** `design_system.dart` imports variants from non-existent `generated/variants/` directory

**Broken Imports (6):**
```dart
import '../generated/variants/button_variant.dart';      // ❌ Doesn't exist
import '../generated/variants/text_variant.dart';        // ❌ Doesn't exist
import '../generated/variants/card_variant.dart';        // ❌ Doesn't exist
import '../generated/variants/divider_orientation.dart'; // ❌ Doesn't exist
import '../generated/variants/progress_indicator_variant.dart'; // ❌
import '../generated/variants/icon_button_variant.dart'; // ❌ Doesn't exist
```

**Actual Location:**
```
/generator/design_system/variants/  (manual files)
/generator/example/lib/syntaxify/generated/variants/  (example app only)
```

**Impact:** Import errors during compilation

**Fix Required:** Update all imports to point to `/generator/design_system/variants/`

---

### 🔴 Issue 2: Toggle Naming Inconsistency

**Problem:** Component renamed from `AppSwitch` to `AppToggle`, but method name not updated

**Current:**
```dart
// design_style.dart
Widget renderSwitch({ ... });  // ❌ Old name

// Mixins
MaterialSwitchRenderer  // ❌ Old name
CupertinoSwitchRenderer
NeoSwitchRenderer
```

**Should Be:**
```dart
Widget renderToggle({ ... });  // ✅ Correct

MaterialToggleRenderer
CupertinoToggleRenderer
NeoToggleRenderer
```

**Impact:** Confusing API, inconsistent naming

---

### 🟡 Issue 3: Interactive Component Wrappers Missing

**Problem:** 7 interactive components don't have generated wrappers

**Missing Wrappers:**
- app_button.dart
- app_input.dart
- app_text.dart
- app_checkbox.dart
- app_toggle.dart
- app_slider.dart
- app_radio.dart

**Status:** Unclear if this is intentional or a gap

**Questions:**
1. Should these components have wrappers?
2. Are they handled differently in the generator?
3. Is there documentation explaining this design decision?

---

### 🟡 Issue 4: Variant File Organization

**Problem:** Inconsistent variant file locations

**Some variants in:** `/design_system/variants/` (manual, correct)
**Others imported as:** `../generated/variants/` (non-existent)

**Actual Locations:**
```
MANUAL (✅ Correct):
- card_variant.dart
- divider_orientation.dart
- progress_indicator_variant.dart
- icon_button_variant.dart
- dropdown_variant.dart
- tab_bar_variant.dart
- bottom_nav_variant.dart
- app_bar_variant.dart
- chip_variant.dart
- badge_variant.dart
- avatar_variant.dart

GENERATED (❌ Don't exist in generator):
- button_variant.dart
- text_variant.dart
```

**Impact:** Broken imports, unclear organization

---

## File Count Summary

### Per Component

**Minimum Configuration (No variants/models):**
- 1 Meta file
- 1 Token file
- 3 Renderer files
- **Total: 5 files**

**Standard Configuration (With variant):**
- 1 Meta file
- 1 Variant file
- 1 Token file
- 3 Renderer files
- 1 Generated wrapper
- **Total: 7 files**

**Complex Configuration (Variant + Model):**
- 1 Meta file
- 1 Variant file
- 1 Token file
- 3 Renderer files
- 1 Generated wrapper
- 1 Model file
- **Total: 8 files**

### Total Across All 20 Components

| File Type | Count |
|-----------|-------|
| Meta files | 20 |
| Variant enums | 11 |
| Token files | 20 |
| Renderer files | 58 (19×3 + 1 shared) |
| Generated wrappers | 13 |
| Model files | 3 |
| **TOTAL** | **125 component-specific files** |

### Integration Files (Shared)

| File | Edits Per Component |
|------|---------------------|
| design_system.dart | 4-11 |
| design_style.dart | 2 |
| material_style.dart | 1 |
| cupertino_style.dart | 1 |
| neo_style.dart | 1 |
| **TOTAL** | **9-16 edits** |

---

## Appendix A: File Templates

### A1. Meta File Template

```dart
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// {Component} component definition
@SyntaxComponent(
  description: 'A design-system-aware {component} component',
  variants: ['primary', 'secondary'],
)
class {Component}Meta {
  const {Component}Meta({
    required this.prop1,
    this.prop2 = 'default',
  });

  /// Property 1 description
  final String prop1;

  /// Property 2 description
  final String? prop2;
}
```

### A2. Token File Template

```dart
import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

class {Component}Tokens {
  const {Component}Tokens({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  factory {Component}Tokens.fromFoundation(
    FoundationTokens foundation,
    {Component}Variant variant,
  ) {
    switch (variant) {
      case {Component}Variant.primary:
        return {Component}Tokens(
          backgroundColor: foundation.colorPrimary,
          foregroundColor: foundation.colorOnPrimary,
        );
    }
  }
}
```

### A3. Renderer Template (Material)

```dart
part of '../../design_system.dart';

mixin Material{Component}Renderer on DesignStyle {
  @override
  {Component}Tokens {component}Tokens({Component}Variant variant) {
    return {Component}Tokens.fromFoundation(foundation, variant);
  }

  @override
  Widget render{Component}({
    required String prop1,
    String? prop2,
    {Component}Variant variant = {Component}Variant.primary,
  }) {
    final tokens = {component}Tokens(variant);

    return Container(
      color: tokens.backgroundColor,
      child: Text(prop1),
    );
  }
}
```

---

## Appendix B: Quick Reference

### Commands

```bash
# Run generator (creates wrappers)
dart run syntaxify build

# Run tests
dart test

# Format code
dart format .

# Analyze code
dart analyze
```

### File Paths Quick Reference

```
Meta:       /generator/meta/{name}.meta.dart
Variant:    /generator/design_system/variants/{name}_variant.dart
Token:      /generator/design_system/tokens/{name}_tokens.dart
Material:   /generator/design_system/components/{name}/material_renderer.dart
Cupertino:  /generator/design_system/components/{name}/cupertino_renderer.dart
Neo:        /generator/design_system/components/{name}/neo_renderer.dart
Wrapper:    /generator/design_system/generated/components/app_{name}.dart
Model:      /generator/design_system/models/{name}_item.dart
```

### Naming Conventions

| Concept | Convention | Example |
|---------|-----------|---------|
| Meta file | snake_case.meta.dart | button.meta.dart |
| Meta class | PascalCaseMeta | ButtonMeta |
| Variant file | snake_case_variant.dart | button_variant.dart |
| Variant enum | PascalCaseVariant | ButtonVariant |
| Token file | snake_case_tokens.dart | button_tokens.dart |
| Token class | PascalCaseTokens | ButtonTokens |
| Renderer mixin | StylePascalCaseRenderer | MaterialButtonRenderer |
| Wrapper component | AppPascalCase | AppButton |
| Model class | PascalCaseItem | DropdownItem |

---

**Document Version:** 1.0
**Last Updated:** 2025-12-27
**Maintained By:** Syntaxify Development Team
**Total Pages:** 50+ equivalent pages
