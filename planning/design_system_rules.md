# Design System Rules

> Token primitives, component DNA, and style-specific constraints.

---

## 1. Token Primitives

### 1.1 Color Palette

```dart
class ColorTokens {
  // Brand
  final Color primary;
  final Color secondary;
  final Color accent;
  
  // Semantic
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  
  // Neutral
  final Color background;
  final Color surface;
  final Color border;
  
  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
}
```

### 1.2 Spacing Scale (8pt Grid)

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Tight gaps |
| `sm` | 8px | Default gap |
| `md` | 16px | Section padding |
| `lg` | 24px | Card padding |
| `xl` | 32px | Page margins |
| `xxl` | 48px | Major sections |

### 1.3 Radius Scale

| Token | Value | Usage |
|-------|-------|-------|
| `none` | 0px | Neo-Brutalism |
| `sm` | 4px | Badges, chips |
| `md` | 8px | Buttons, inputs |
| `lg` | 16px | Cards |
| `xl` | 24px | Modals |
| `full` | 999px | Pills, avatars |

### 1.4 Elevation Scale

| Token | Value | Usage |
|-------|-------|-------|
| `none` | 0 | Flat elements |
| `sm` | 2 | Buttons |
| `md` | 4 | Cards |
| `lg` | 8 | Dropdowns |
| `xl` | 16 | Modals |

---

## 2. Typography Scale (M3-Aligned)

| Token | Size | Weight | Line Height |
|-------|------|--------|-------------|
| `displayLarge` | 57px | 400 | 64px |
| `displayMedium` | 45px | 400 | 52px |
| `displaySmall` | 36px | 400 | 44px |
| `headlineLarge` | 32px | 400 | 40px |
| `headlineMedium` | 28px | 400 | 36px |
| `headlineSmall` | 24px | 400 | 32px |
| `titleLarge` | 22px | 500 | 28px |
| `titleMedium` | 16px | 500 | 24px |
| `titleSmall` | 14px | 500 | 20px |
| `bodyLarge` | 16px | 400 | 24px |
| `bodyMedium` | 14px | 400 | 20px |
| `bodySmall` | 12px | 400 | 16px |
| `labelLarge` | 14px | 500 | 20px |
| `labelMedium` | 12px | 500 | 16px |
| `labelSmall` | 11px | 500 | 16px |

---

## 3. Component DNA

Every component MUST have these token categories:

| Category | Examples |
|----------|----------|
| **Shape** | radius, borderWidth |
| **Color** | bgColor, textColor, borderColor |
| **Spacing** | padding, margin, gap |
| **Motion** | duration, curve |
| **State** | normal, hover, pressed, disabled |

---

## 4. Style-Specific Rules

### 4.1 Material Design

| Rule | Value |
|------|-------|
| Primary radius | 8-24px (rounded) |
| Shadows | Soft, blurred (elevation) |
| Borders | None (use elevation) |
| Motion | Emphasized curves, 250-300ms |
| Interaction | Ripple effect |

### 4.2 Cupertino (iOS)

| Rule | Value |
|------|-------|
| Primary radius | 8-16px (subtle) |
| Shadows | None or very subtle |
| Borders | None (use fills) |
| Motion | Spring physics, 200-250ms |
| Interaction | Opacity/scale change |

### 4.3 Neo-Brutalism

| Rule | Value |
|------|-------|
| Primary radius | 0px (sharp corners) |
| Shadows | Hard offset (4-8px, no blur) |
| Borders | 2-4px solid black |
| Motion | None or instant |
| Interaction | Translation (X/Y offset) |
| Colors | High contrast, primary colors |
| Typography | Bold, uppercase |

---

## 5. Token Validation Rules

### 5.1 Accessibility Minimums

| Rule | Requirement |
|------|-------------|
| Text contrast | 4.5:1 (normal), 3:1 (large) |
| Touch target | 48x48px minimum |
| Focus indicator | Visible, 2px+ |

### 5.2 Consistency Rules

| Rule | Enforcement |
|------|-------------|
| Spacing | Must use scale values only |
| Colors | Must reference palette, no hardcoded hex |
| Radius | Must use scale values only |
| Typography | Must use type scale |

---

## 6. Token Naming Convention

```
{component}_{property}_{variant}_{state}
```

Examples:
- `button_bg_primary_normal`
- `button_bg_primary_pressed`
- `input_border_default_focused`
- `card_shadow_elevated`

---

*Document Version: 2.0*
