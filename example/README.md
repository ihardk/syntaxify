# Syntax Example App

**Live demonstration of Syntax code generator**

This Flutter app showcases Syntax's renderer pattern with real generated components.

## 🎯 What This Demonstrates

### Components
- **AppButton** - Material, Cupertino, and Neo button variants
- **AppText** - Typography with different text styles
- **AppInput** - Text fields with validation

### Design Systems
Switch between three design styles in real-time:
- **Material** - Google's Material Design
- **Cupertino** - Apple's iOS design language
- **Neo** - Modern neumorphic design

## 🚀 Running the Example

```bash
cd example
flutter pub get
flutter run
```

## 📂 Structure

```
example/
├── lib/
│   ├── main.dart              # Demo app with style switcher
│   ├── meta/                  # Component definitions
│   │   ├── button.meta.dart
│   │   ├── input.meta.dart
│   │   └── text.meta.dart
│   └── syntax/                # Generated code
│       ├── generated/         # Auto-generated components
│       └── design_system/     # Design system files
└── pubspec.yaml
```

## 🎨 How It Works

1. **Define** - Components defined in `meta/` folder
2. **Generate** - Run `syntax build` to generate code
3. **Use** - Import and use with `AppTheme`

```dart
AppTheme(
  style: MaterialStyle(),  // Switch to CupertinoStyle() or NeoStyle()
  child: MaterialApp(
    home: YourApp(),
  ),
)
```

## 🔄 Regenerating Components

To regenerate the components:

```bash
cd ..
syntax build --meta=example/meta --output=example/lib/syntax
```

Or from the root:
```bash
cd example
syntax build
```

## 💡 Key Takeaways

- **One Definition** - Components defined once in `meta/`
- **Multiple Renderings** - Same component, different styles
- **Type-Safe** - Generated code is fully type-safe
- **Editable** - Customize design system in `lib/syntax/design_system/`

---

**This is a working example of Syntax v0.1.0**
