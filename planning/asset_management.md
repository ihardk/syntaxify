# Asset Management

> How Meta-UI handles icons, images, and fonts per theme.

---

## 1. The Problem

Different design systems use different assets:
- **Material:** Filled icons, Roboto font
- **Cupertino:** SF Symbols, SF Pro font  
- **Neo:** Bold/stroke icons, Mono font

---

## 2. Icon System

### 2.1 Icon Tokens
```dart
class IconTokens {
  final IconData homeIcon;
  final IconData settingsIcon;
  final IconData userIcon;
  final double defaultSize;
  final Color defaultColor;
}
```

### 2.2 Theme-Specific Icons
```yaml
# theme.material.yaml
icons:
  style: filled
  home: Icons.home
  settings: Icons.settings
  user: Icons.person

# theme.cupertino.yaml
icons:
  style: outlined
  home: CupertinoIcons.home
  settings: CupertinoIcons.settings
  user: CupertinoIcons.person

# theme.neo.yaml
icons:
  style: custom
  package: neo_icons
  home: NeoIcons.home
  settings: NeoIcons.settings
```

### 2.3 Icon Usage
```dart
// Generated helper
class MetaIcons {
  static IconData home(BuildContext context) {
    return MetaTheme.of(context).iconTokens.homeIcon;
  }
}

// Usage
Icon(MetaIcons.home(context))
```

---

## 3. Font System

### 3.1 Typography Tokens
```dart
class TypographyTokens {
  final String fontFamily;
  final String fontFamilyMono;
  final TextStyle displayLarge;
  final TextStyle bodyMedium;
  // ... M3 type scale
}
```

### 3.2 Theme-Specific Fonts
```yaml
# theme.material.yaml
typography:
  fontFamily: Roboto
  fontFamilyMono: RobotoMono
  
# theme.cupertino.yaml
typography:
  fontFamily: .SF Pro Text  # System font
  fontFamilyMono: SF Mono
  
# theme.neo.yaml
typography:
  fontFamily: Space Grotesk
  fontFamilyMono: Space Mono
```

### 3.3 Font Loading
```dart
// In main.dart
void main() async {
  // Load custom fonts based on theme
  await MetaFonts.load(DesignStyle.neo);
  runApp(MyApp());
}
```

---

## 4. Image System

### 4.1 Image Tokens
```yaml
# theme.material.yaml
images:
  placeholder: assets/material/placeholder.png
  logo: assets/material/logo.svg
  emptyState: assets/material/empty.png

# theme.neo.yaml
images:
  placeholder: assets/neo/placeholder.png
  logo: assets/neo/logo.svg
  emptyState: assets/neo/empty.png
```

### 4.2 Image Usage
```dart
// Generated helper
class MetaImages {
  static String logo(BuildContext context) {
    return MetaTheme.of(context).imageTokens.logo;
  }
}

// Usage
Image.asset(MetaImages.logo(context))
```

---

## 5. Asset Directory Structure

```
assets/
├── shared/                   # Cross-theme assets
│   └── app_icon.png
├── material/
│   ├── icons/
│   ├── images/
│   └── fonts/
├── cupertino/
│   ├── icons/
│   ├── images/
│   └── fonts/
└── neo/
    ├── icons/
    ├── images/
    └── fonts/
```

---

## 6. Asset Preloading

### 6.1 Eager Loading
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Preload current theme assets
  await MetaAssets.preload(DesignStyle.material);
  
  runApp(MyApp());
}
```

### 6.2 Lazy Loading (Theme Switch)
```dart
class _MyAppState extends State<MyApp> {
  DesignStyle _style = DesignStyle.material;
  
  Future<void> _switchTheme(DesignStyle newStyle) async {
    // Load assets before switching
    await MetaAssets.preload(newStyle);
    setState(() => _style = newStyle);
  }
}
```

---

## 7. SVG Support

### 7.1 Vector Icons
```yaml
# theme.neo.yaml
icons:
  format: svg
  basePath: assets/neo/icons/
  home: home.svg
  settings: settings.svg
```

### 7.2 Generated Code
```dart
// Uses flutter_svg internally
Widget _buildIcon(String name) {
  if (tokens.iconFormat == 'svg') {
    return SvgPicture.asset(
      '${tokens.iconBasePath}$name',
      width: tokens.defaultSize,
      colorFilter: ColorFilter.mode(tokens.defaultColor, BlendMode.srcIn),
    );
  }
  return Icon(tokens.icons[name], size: tokens.defaultSize);
}
```

---

## 8. Asset Validation

### 8.1 Generator Checks
```bash
$ meta_gen build

Validating assets...
✓ assets/material/logo.png exists
✗ assets/neo/logo.png MISSING

ERROR: Asset 'logo' not found for theme 'neo'
  Expected: assets/neo/logo.png
```

### 8.2 Asset Manifest
```yaml
# Generated: .meta_assets.yaml
material:
  logo: assets/material/logo.png (24KB)
  icons: 45 files
  fonts: [Roboto, RobotoMono]
neo:
  logo: assets/neo/logo.png (18KB)
  icons: 45 files
  fonts: [SpaceGrotesk, SpaceMono]
```

---

## 9. Fallback Strategy

| Missing Asset | Fallback |
|---------------|----------|
| Icon | Default Flutter icon |
| Image | Placeholder with theme color |
| Font | System default |

```dart
Widget _buildImage(String key) {
  final path = tokens.images[key];
  if (path == null || !_assetExists(path)) {
    return Container(
      color: tokens.placeholderColor,
      child: Icon(Icons.image_not_supported),
    );
  }
  return Image.asset(path);
}
```

---

## 10. pubspec.yaml Generation

```bash
$ meta_gen assets

Adding assets to pubspec.yaml...

flutter:
  assets:
    - assets/shared/
    - assets/material/images/
    - assets/cupertino/images/
    - assets/neo/images/
  
  fonts:
    - family: SpaceGrotesk
      fonts:
        - asset: assets/neo/fonts/SpaceGrotesk-Regular.ttf
        - asset: assets/neo/fonts/SpaceGrotesk-Bold.ttf
          weight: 700
```

---

*Document Version: 1.0*
