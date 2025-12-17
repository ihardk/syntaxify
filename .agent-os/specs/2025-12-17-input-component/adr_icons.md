# Architectural Decision: Icon Registry

## Problem
Allowing arbitrary `IconData` or strings for icons in Meta files makes tree-shaking impossible and breaks type safety. We need a way to reference icons in `meta` files that resolves to valid `IconData` at runtime.

## Solution: AppIcon Registry

We will create a centralized `AppIcons` class in the design system.

### 1. The Registry (`design_system/app_icons.dart`)
```dart
class AppIcons {
  static const Map<String, IconData> registry = {
    'user': Icons.person,
    'search': Icons.search,
    'close': Icons.close,
    // User adds mappings here
  };

  static IconData? get(String name) => registry[name];
}
```

### 2. Meta Definition
`InputMeta` will store the *key*:
```dart
class InputMeta {
  final String? prefixIcon; // e.g. "search"
}
```

### 3. Usage
The generator renders code that looks up the icon:
```dart
prefixIcon: AppIcons.get('search') != null ? Icon(AppIcons.get('search')) : null
```

### Benefits
- **Tree-shaking**: Only icons imported in `AppIcons` are bundled.
- **Decoupling**: Meta doesn't know about Flutter/Material/Cupertino.
- **Theming**: `AppIcons` could switch sets based on platform if we want advanced logic later.
