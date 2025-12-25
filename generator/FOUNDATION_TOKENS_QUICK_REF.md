# Foundation Tokens - Quick Reference Card

**Version:** 0.2.0-beta | **Updated:** 2025-12-24

---

## 📋 At a Glance

### What Are Foundation Tokens?
Single source of truth for all design primitives (colors, typography, spacing, etc.)

### Why Use Them?
- Change `colorPrimary` once → affects all 21 renderers
- Consistent design system
- Self-documenting code
- Easy to create new design systems

### How to Access?
```dart
final foundation = AppTheme.of(context).style.foundation;
```

---

## 🎨 Colors (16)

### Primary
```dart
foundation.colorPrimary          // Main brand color (#6200EE)
foundation.colorOnPrimary        // Text on primary (white)
foundation.colorPrimaryContainer // Lighter variant
foundation.colorOnPrimaryContainer
```

### Secondary
```dart
foundation.colorSecondary        // Secondary brand
foundation.colorOnSecondary
foundation.colorSecondaryContainer
foundation.colorOnSecondaryContainer
```

### Surface
```dart
foundation.colorSurface          // Backgrounds
foundation.colorOnSurface        // Text on backgrounds
foundation.colorSurfaceVariant   // Subtle variations
foundation.colorOnSurfaceVariant
```

### Semantic
```dart
foundation.colorError            // Error states
foundation.colorOnError
foundation.colorOutline          // Borders
foundation.colorOutlineVariant   // Subtle borders
```

---

## ✍️ Typography (15)

### Display (Large headings)
```dart
foundation.displayLarge          // 57px, light
foundation.displayMedium         // 45px, light
foundation.displaySmall          // 36px, light
```

### Headlines
```dart
foundation.headlineLarge         // 32px, regular
foundation.headlineMedium        // 28px, regular
foundation.headlineSmall         // 24px, regular
```

### Titles
```dart
foundation.titleLarge            // 22px, medium
foundation.titleMedium           // 16px, medium
foundation.titleSmall            // 14px, medium
```

### Body
```dart
foundation.bodyLarge             // 16px, regular
foundation.bodyMedium            // 14px, regular (most used)
foundation.bodySmall             // 12px, regular
```

### Labels
```dart
foundation.labelLarge            // 14px, medium
foundation.labelMedium           // 12px, medium
foundation.labelSmall            // 11px, medium
```

---

## 📏 Spacing (8) - 8dp Grid

```dart
foundation.spacingXxxs           // 4dp   (0.25× base)
foundation.spacingXs             // 4dp   (alias)
foundation.spacingSm             // 8dp   (0.5× base)
foundation.spacingMd             // 16dp  (1× base) ← Most common
foundation.spacingLg             // 24dp  (1.5× base)
foundation.spacingXl             // 32dp  (2× base)
foundation.spacingXxl            // 48dp  (3× base)
foundation.spacingXxxl           // 64dp  (4× base)
```

**Usage:**
```dart
padding: EdgeInsets.all(foundation.spacingMd)  // 16dp
margin: EdgeInsets.symmetric(horizontal: foundation.spacingLg)  // 24dp
gap: foundation.spacingSm  // 8dp
```

---

## ⭕ Border Radius (6)

```dart
foundation.radiusNone            // 0dp   (sharp)
foundation.radiusSm              // 4dp   (subtle)
foundation.radiusMd              // 8dp   (moderate) ← Most common
foundation.radiusLg              // 16dp  (rounded)
foundation.radiusXl              // 24dp  (very rounded)
foundation.radiusFull            // 9999dp (pill)
```

**Usage:**
```dart
borderRadius: BorderRadius.circular(foundation.radiusMd)  // 8dp
```

---

## 🔼 Elevation (6)

```dart
foundation.elevationLevel0       // 0dp  (flat)
foundation.elevationLevel1       // 1dp  (subtle)
foundation.elevationLevel2       // 3dp  (standard) ← Most common
foundation.elevationLevel3       // 6dp  (prominent)
foundation.elevationLevel4       // 8dp  (very prominent)
foundation.elevationLevel5       // 12dp (maximum)
```

**Usage:**
```dart
elevation: foundation.elevationLevel2  // 3dp shadow
```

---

## 🔲 Border Width (4)

```dart
foundation.borderWidthNone       // 0dp  (no border)
foundation.borderWidthThin       // 1dp  (hairline)
foundation.borderWidthMedium     // 2dp  (standard) ← Most common
foundation.borderWidthThick      // 4dp  (bold)
```

**Usage:**
```dart
border: Border.all(
  width: foundation.borderWidthMedium,  // 2dp
  color: foundation.colorOutline,
)
```

---

## 🎭 Design Systems

### Material Design 3
```dart
AppTheme(style: MaterialStyle(), ...)
```
- Purple primary (#6200EE)
- Roboto font
- 8dp grid, rounded corners

### iOS (Cupertino)
```dart
AppTheme(style: CupertinoStyle(), ...)
```
- System blue
- San Francisco font
- iOS spacing, 10dp radius

### Neo-brutalism
```dart
AppTheme(style: NeoStyle(), ...)
```
- Gold (#FFD700)
- Extra bold (900 weight)
- Sharp corners, no shadows

---

## 🔧 Common Patterns

### Container with Foundation
```dart
Container(
  padding: EdgeInsets.all(foundation.spacingMd),
  decoration: BoxDecoration(
    color: foundation.colorPrimary,
    borderRadius: BorderRadius.circular(foundation.radiusMd),
    border: Border.all(
      color: foundation.colorOutline,
      width: foundation.borderWidthThin,
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: foundation.elevationLevel2,
        color: Colors.black.withOpacity(0.1),
      ),
    ],
  ),
  child: Text('Hello', style: foundation.bodyMedium),
)
```

### Button with Foundation
```dart
ElevatedButton(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(foundation.colorPrimary),
    foregroundColor: WidgetStateProperty.all(foundation.colorOnPrimary),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(
      horizontal: foundation.spacingLg,
      vertical: foundation.spacingMd,
    )),
  ),
  onPressed: () {},
  child: Text('Click', style: foundation.labelLarge),
)
```

### Card with Foundation
```dart
Card(
  color: foundation.colorSurface,
  elevation: foundation.elevationLevel2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(foundation.radiusMd),
  ),
  child: Padding(
    padding: EdgeInsets.all(foundation.spacingMd),
    child: Column(
      children: [
        Text('Title', style: foundation.titleMedium),
        SizedBox(height: foundation.spacingSm),
        Text('Body', style: foundation.bodyMedium),
      ],
    ),
  ),
)
```

---

## 📝 Component Tokens

### Using Foundation in Token Files
```dart
factory MyTokens.fromFoundation(FoundationTokens foundation) {
  return MyTokens(
    bgColor: foundation.colorPrimary,
    textColor: foundation.colorOnPrimary,
    radius: foundation.radiusMd,
    padding: EdgeInsets.all(foundation.spacingMd),
  );
}
```

### Using Tokens in Renderers
```dart
mixin MaterialMyRenderer on DesignStyle {
  @override
  MyTokens get myTokens => MyTokens.fromFoundation(foundation);

  @override
  Widget renderMy({...}) {
    final tokens = myTokens;
    // Use tokens...
  }
}
```

---

## 🚀 Smart Property Mapping

When TokenGenerator creates your component tokens:

| Your Property | Maps To Foundation |
|--------------|-------------------|
| `activeColor` | `colorPrimary` |
| `inactiveColor` | `colorSurfaceVariant` |
| `backgroundColor` | `colorSurface` |
| `textColor` | `colorOnSurface` |
| `borderColor` | `colorOutline` |
| `errorColor` | `colorError` |
| `borderWidth` | `borderWidthMedium` |
| `borderRadius` | `radiusMd` |
| `padding` | `EdgeInsets.symmetric(h: spacingMd, v: spacingSm)` |
| `margin` | `EdgeInsets.all(spacingSm)` |
| `textStyle` | `bodyMedium.copyWith(...)` |
| `hintStyle` | `bodyMedium.copyWith(color: colorOnSurfaceVariant)` |

---

## 💡 Pro Tips

### 1. Prefer Semantic Over Literal
```dart
// ✅ Good
color: foundation.colorPrimary

// ❌ Bad
color: Color(0xFF6200EE)
```

### 2. Use Spacing Scale
```dart
// ✅ Good
padding: EdgeInsets.all(foundation.spacingMd)  // 16dp

// ❌ Bad
padding: EdgeInsets.all(15.0)  // Off grid
```

### 3. Consistent Typography
```dart
// ✅ Good
style: foundation.bodyMedium

// ❌ Bad
style: TextStyle(fontSize: 14)  // Hardcoded
```

### 4. Component-Specific → Tokens, Universal → Foundation
```dart
// ✅ Component-specific (use tokens)
ButtonTokens.fromFoundation(foundation)

// ✅ Universal styling (use foundation directly)
Text('Hello', style: foundation.bodyMedium)
```

---

## 🔍 Quick Lookup

### Need a color?
- **Brand:** `colorPrimary`, `colorSecondary`
- **Backgrounds:** `colorSurface`, `colorSurfaceVariant`
- **Text:** `colorOnSurface`, `colorOnPrimary`
- **Borders:** `colorOutline`, `colorOutlineVariant`
- **Errors:** `colorError`

### Need spacing?
- **Tight:** `spacingSm` (8dp)
- **Normal:** `spacingMd` (16dp)
- **Loose:** `spacingLg` (24dp)

### Need text style?
- **Headings:** `headlineMedium`, `titleLarge`
- **Body:** `bodyMedium` ← Start here
- **Labels:** `labelMedium`

### Need rounded corners?
- **Subtle:** `radiusSm` (4dp)
- **Normal:** `radiusMd` (8dp)
- **Pill:** `radiusFull` (9999dp)

---

## 📚 Learn More

- **Full Guide:** `FOUNDATION_TOKENS_GUIDE.md`
- **Progress:** `FOUNDATION_TOKEN_PROGRESS.md`
- **Summary:** `SESSION_SUMMARY.md`

---

**Print this card and keep it handy while developing!** 📌
