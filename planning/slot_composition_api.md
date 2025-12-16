# Slot & Composition API

> How Forge handles component slots beyond simple `child`.

---

## 1. The Problem

Current approach:
```dart
class MetaCardSpec {
  final Widget child;  // Just one slot
}
```

Real components need multiple slots:
- **AppBar:** `leading`, `title`, `actions`
- **ListTile:** `leading`, `title`, `subtitle`, `trailing`
- **Dialog:** `title`, `content`, `actions`

---

## 2. Slot Definition

### 2.1 Named Slots
```dart
// meta/list_tile.meta.dart
@MetaComponent()
class ListTileSpec {
  final Widget? leading;
  final Widget title;           // Required
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
}
```

### 2.2 Slot Constraints
```dart
@MetaComponent()
class DialogSpec {
  @SlotConstraint(maxChildren: 3)
  final List<Widget> actions;
  
  @SlotConstraint(allowedTypes: [Text, RichText])
  final Widget title;
}
```

---

## 3. Slot Rendering

### 3.1 Generated Code
```dart
// GENERATED: app_list_tile.dart
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    final tokens = MetaTheme.of(context).listTileTokens;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: tokens.padding,
        child: Row(
          children: [
            if (leading != null) ...[
              SizedBox(width: tokens.leadingSize, child: leading),
              SizedBox(width: tokens.leadingGap),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: tokens.titleStyle,
                    child: title,
                  ),
                  if (subtitle != null)
                    DefaultTextStyle(
                      style: tokens.subtitleStyle,
                      child: subtitle!,
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
```

---

## 4. Slot Tokens

```dart
class ListTileTokens {
  // Layout
  final EdgeInsets padding;
  final double leadingSize;
  final double leadingGap;
  final double trailingGap;
  
  // Slot Styling
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
}
```

---

## 5. Nested Meta Components

### 5.1 Composition Pattern
```dart
// User code
AppCard(
  child: Column(
    children: [
      AppListTile(
        leading: AppAvatar(initials: 'JD'),
        title: Text('John Doe'),
        trailing: AppBadge(label: 'NEW'),
      ),
    ],
  ),
)
```

### 5.2 Style Inheritance
When a Meta component is nested, it inherits the parent's theme context:
```dart
// AppCard internally wraps children with theme scope
Widget build(context) {
  return MetaSlotScope(
    parentComponent: 'AppCard',
    child: spec.child,
  );
}
```

---

## 6. Action Slots (Special Case)

For components with action buttons:

```dart
@MetaComponent()
class DialogSpec {
  final Widget title;
  final Widget content;
  
  @ActionSlot()
  final List<MetaButtonSpec> actions;
}
```

Generator handles:
```dart
// GENERATED
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: spec.actions.map((action) => 
    Padding(
      padding: EdgeInsets.only(left: tokens.actionSpacing),
      child: AppButton(
        label: action.label,
        onPressed: action.onPressed,
      ),
    ),
  ).toList(),
)
```

---

## 7. Empty Slot Handling

| Scenario | Behavior |
|----------|----------|
| Optional slot is null | Slot space not rendered |
| Optional slot with fallback | Show fallback widget |
| Required slot is null | Compile error |

```dart
class ListTileSpec {
  final Widget? leading;        // Optional, collapses if null
  
  @SlotDefault(Icon(Icons.chevron_right))
  final Widget? trailing;       // Optional with default
  
  final Widget title;           // Required, compile error if missing
}
```

---

## 8. Slot Validation

Generator validates at build time:
```bash
ERROR: slot_validation
  Component: AppDialog
  Slot: actions
  Message: Maximum 3 actions allowed, found 5
```

---

*Document Version: 1.0*

