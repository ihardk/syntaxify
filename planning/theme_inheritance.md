# Theme Inheritance & Nesting

> How themes cascade through the widget tree.

---

## 1. Default Behavior

```dart
// Theme set at root
MetaTheme(
  style: DesignStyle.material,
  child: MyApp(),
)

// All descendants use Material tokens
AppButton(...)  // Uses Material tokens
AppCard(
  child: AppInput(...)  // Also uses Material tokens
)
```

---

## 2. Nested Theme Override

### 2.1 Full Override
```dart
MetaTheme(
  style: DesignStyle.material,  // Root theme
  child: Column(
    children: [
      AppButton(...),  // Material
      
      MetaTheme(
        style: DesignStyle.neo,  // Override for subtree
        child: AppCard(
          child: AppButton(...),  // Neo
        ),
      ),
    ],
  ),
)
```

### 2.2 Partial Override (Token Level)
```dart
MetaTheme(
  style: DesignStyle.material,
  child: MetaTokenOverride(
    buttonTokens: ButtonTokens(
      bgColor: Colors.red,  // Override just this
      // ... other tokens inherited
    ),
    child: AppButton(...),  // Red button, other tokens from Material
  ),
)
```

---

## 3. Brightness (Dark Mode) Nesting

### 3.1 System Follows Brightness
```dart
MetaTheme(
  style: DesignStyle.material,
  brightness: Brightness.light,  // Explicit
  child: MyApp(),
)
```

### 3.2 Dark Section in Light App
```dart
MetaTheme(
  style: DesignStyle.material,
  brightness: Brightness.light,
  child: Column(
    children: [
      AppCard(...),  // Light
      
      MetaTheme.dark(  // Convenience constructor
        child: AppCard(...),  // Dark
      ),
    ],
  ),
)
```

---

## 4. Implementation

### 4.1 InheritedWidget Chain
```dart
class MetaTheme extends InheritedWidget {
  final DesignStyle style;
  final Brightness brightness;
  final MetaTokenOverrides? overrides;
  
  static MetaThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<MetaTheme>();
    assert(theme != null, 'No MetaTheme found in context');
    return theme!.resolve(context);
  }
  
  MetaThemeData resolve(BuildContext context) {
    // Check for parent overrides
    final parent = context.findAncestorWidgetOfExactType<MetaTheme>();
    
    if (parent != null && overrides != null) {
      return parent.resolve(context).merge(overrides!);
    }
    
    return MetaThemeData(
      style: style,
      brightness: brightness,
      // Load tokens for this style + brightness
    );
  }
}
```

### 4.2 Token Resolution Order
1. Local `MetaTokenOverride` (if any)
2. Nearest `MetaTheme` ancestor
3. Root `MetaTheme`
4. Default (Material Light)

---

## 5. Context-Aware Components

### 5.1 Card with Dark Interior
```dart
class AppCard extends StatelessWidget {
  final Widget child;
  final bool forceDark;  // Force dark mode inside card
  
  @override
  Widget build(BuildContext context) {
    final tokens = MetaTheme.of(context).cardTokens;
    
    Widget content = Container(
      decoration: BoxDecoration(...),
      child: child,
    );
    
    if (forceDark) {
      content = MetaTheme.dark(child: content);
    }
    
    return content;
  }
}
```

### 5.2 Auto-Contrast Text
```dart
// Text inside a dark card should auto-switch to light color
class MetaText extends StatelessWidget {
  final String text;
  
  @override
  Widget build(BuildContext context) {
    final brightness = MetaTheme.of(context).brightness;
    final textColor = brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black;
    
    return Text(text, style: TextStyle(color: textColor));
  }
}
```

---

## 6. Scope Widgets

### 6.1 Component Scope
```dart
// Inside a Card, Buttons get special styling
class CardButtonScope extends InheritedWidget {
  final bool isInsideCard = true;
  
  static bool of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CardButtonScope>()
        ?.isInsideCard ?? false;
  }
}

// Button checks scope
class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInsideCard = CardButtonScope.of(context);
    final tokens = isInsideCard 
        ? MetaTheme.of(context).cardButtonTokens
        : MetaTheme.of(context).buttonTokens;
    // ...
  }
}
```

---

## 7. Performance Considerations

### 7.1 Avoid Deep Nesting
```dart
// ❌ Bad: Excessive nesting
MetaTheme(
  child: MetaTokenOverride(
    child: MetaTheme.dark(
      child: MetaTokenOverride(
        child: AppButton(...),
      ),
    ),
  ),
)

// ✅ Good: Single override
MetaTheme.dark(
  overrides: combinedOverrides,
  child: AppButton(...),
)
```

### 7.2 Caching
```dart
class MetaTheme extends InheritedWidget {
  // Cache resolved theme data
  late final MetaThemeData _cached = _resolve();
  
  @override
  bool updateShouldNotify(MetaTheme oldWidget) {
    return style != oldWidget.style || 
           brightness != oldWidget.brightness;
  }
}
```

---

## 8. Use Cases

| Scenario | Solution |
|----------|----------|
| Dark card in light app | `MetaTheme.dark(child: AppCard(...))` |
| Brand color override | `MetaTokenOverride(buttonTokens: ...)` |
| Debug mode styling | `MetaTheme(style: DesignStyle.debug, ...)` |
| Per-route theming | Wrap route with `MetaTheme` |
| Modal with different theme | `showDialog` with `MetaTheme` wrapper |

---

*Document Version: 1.0*
