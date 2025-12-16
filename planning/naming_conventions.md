# Naming Conventions

> Consistent naming standards for Meta-UI framework.

---

## 1. File Naming

| Type | Pattern | Example |
|------|---------|---------|
| Meta definition | `{component}.meta.dart` | `button.meta.dart` |
| Token definition | `{component}.tokens.dart` | `button.tokens.dart` |
| Theme config | `theme.{name}.yaml` | `theme.material.yaml` |
| Generated component | `app_{component}.dart` | `app_button.dart` |
| Generated theme | `app_theme.dart` | `app_theme.dart` |

---

## 2. Class Naming

| Type | Pattern | Example |
|------|---------|---------|
| Meta Spec | `{Component}Spec` | `ButtonSpec`, `InputSpec` |
| Tokens | `{Component}Tokens` | `ButtonTokens`, `InputTokens` |
| Generated Widget | `App{Component}` | `AppButton`, `AppInput` |
| Implementation Variant | `{Style}{Component}Impl` | `MaterialButtonImpl`, `GlassButtonImpl` |
| State Enum | `{Component}State` | `ButtonState`, `InputState` |

---

## 3. Callback Naming

### 3.1 Standard Callbacks

| Action | Name | Signature |
|--------|------|-----------|
| Tap/Click | `onPressed` | `VoidCallback?` |
| Value change | `onChanged` | `ValueChanged<T>?` |
| Submit | `onSubmitted` | `ValueChanged<String>?` |
| Focus gained | `onFocusGained` | `VoidCallback?` |
| Focus lost | `onFocusLost` | `VoidCallback?` |
| Long press | `onLongPress` | `VoidCallback?` |
| Swipe | `onSwipe` | `ValueChanged<SwipeDirection>?` |

### 3.2 Why `onPressed` not `onTap`
- **Consistency:** Flutter's `ElevatedButton` uses `onPressed`
- **Semantics:** "Press" implies intentional action, "Tap" is gesture-specific
- **Accessibility:** Screen readers say "Press button"

---

## 4. Token Property Naming

### 4.1 Visual Properties
| Property | Name | Type |
|----------|------|------|
| Background | `bgColor` | `Color` |
| Foreground/Text | `textColor` | `Color` |
| Border | `borderColor`, `borderWidth` | `Color`, `double` |
| Corner radius | `radius` | `double` |
| Shadow | `shadowOffset`, `shadowBlur` | `Offset`, `double` |
| Elevation | `elevation` | `double` |
| Opacity | `opacity` | `double` |

### 4.2 Spacing Properties
| Property | Name | Type |
|----------|------|------|
| All sides | `padding` | `EdgeInsets` |
| Outer spacing | `margin` | `EdgeInsets` |
| Between items | `gap` or `spacing` | `double` |

### 4.3 State Variations
| Pattern | Example |
|---------|---------|
| `{property}{State}` | `bgColorPressed`, `borderColorFocused` |
| Hover | `bgColorHover` |
| Pressed | `bgColorPressed` |
| Disabled | `bgColorDisabled` |
| Error | `borderColorError` |

---

## 5. Slot Naming

| Slot Type | Name |
|-----------|------|
| Primary content | `child` |
| Before main content | `leading` |
| After main content | `trailing` |
| Header | `header` |
| Footer | `footer` |
| Actions (buttons) | `actions` |
| Icon | `icon` |
| Title | `title` |
| Subtitle | `subtitle` |

---

## 6. Theme & Style Naming

| Concept | Name |
|---------|------|
| Design system enum | `DesignStyle` |
| Enum values | `material`, `cupertino`, `neo` (lowercase) |
| Theme provider | `MetaTheme` |
| Theme data | `MetaThemeData` |
| Brightness | `light`, `dark` |

---

## 7. Generator CLI Naming

| Command | Action |
|---------|--------|
| `meta_gen build` | Generate all code |
| `meta_gen watch` | Watch mode |
| `meta_gen clean` | Remove generated files |
| `meta_gen list` | List components |
| `meta_gen inspect {name}` | Show component details |
| `meta_gen migrate` | Run migrations |

---

## 8. Abbreviations

**Allowed:**
- `bg` = background
- `btn` = button (in comments only)
- `impl` = implementation

**Not Allowed:**
- `clr` → use `color`
- `txt` → use `text`
- `bdr` → use `border`

---

## 9. Boolean Naming

| Pattern | Example |
|---------|---------|
| `is{Adjective}` | `isLoading`, `isDisabled`, `isSelected` |
| `has{Noun}` | `hasError`, `hasIcon` |
| `can{Verb}` | `canSubmit`, `canDismiss` |
| `should{Verb}` | `shouldValidate` |

---

## 10. Anti-Patterns

❌ **Avoid:**
```dart
onTap          // Use onPressed
onClick        // Use onPressed  
color          // Use bgColor or textColor
disabled       // Use isDisabled
loading        // Use isLoading
```

✅ **Prefer:**
```dart
onPressed
bgColor / textColor
isDisabled
isLoading
```

---

*Document Version: 1.0*
