# Dependency Management

> SDK versions, package dependencies, and compatibility matrix.

---

## 1. Supported Versions

### 1.1 Flutter SDK
| Meta-UI Version | Flutter Min | Flutter Max | Recommended |
|-----------------|-------------|-------------|-------------|
| 1.x | 3.16.0 | 3.x.x | 3.19.0 |
| 2.x | 3.22.0 | 4.x.x | Latest stable |

### 1.2 Dart SDK
| Meta-UI Version | Dart Min | Dart Max |
|-----------------|----------|----------|
| 1.x | 3.2.0 | 3.x.x |
| 2.x | 3.4.0 | 4.x.x |

---

## 2. Package Dependencies

### 2.1 Runtime Dependencies
```yaml
# pubspec.yaml (generated project)
dependencies:
  flutter:
    sdk: flutter
  # Meta-UI has ZERO runtime dependencies
```

**Philosophy:** Generated code is pure Flutter. No external packages required at runtime.

### 2.2 Generator Dependencies
```yaml
# meta_gen/pubspec.yaml
dependencies:
  args: ^2.4.0          # CLI parsing
  yaml: ^3.1.0          # Theme file parsing
  path: ^1.8.0          # File path handling
  
dev_dependencies:
  test: ^1.24.0
  lints: ^3.0.0
```

---

## 3. Version Pinning Strategy

### 3.1 Strict Pinning (Recommended for Teams)
```yaml
dev_dependencies:
  meta_gen: 1.2.3  # Exact version
```

### 3.2 Caret Pinning (Solo Developers)
```yaml
dev_dependencies:
  meta_gen: ^1.2.0  # Accept patches
```

---

## 4. Compatibility Matrix

### 4.1 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Full | API 21+ |
| iOS | ✅ Full | iOS 12+ |
| Web | ✅ Full | All modern browsers |
| macOS | ✅ Full | 10.14+ |
| Windows | ✅ Full | Windows 10+ |
| Linux | ✅ Full | GTK 3.22+ |

### 4.2 Null Safety
- **Required:** All Meta-UI code is null-safe
- **Generated code:** Always null-safe

---

## 5. Breaking Change Policy

### 5.1 Semantic Versioning
- **Major (x.0.0):** Breaking schema changes
- **Minor (1.x.0):** New features, backwards compatible
- **Patch (1.0.x):** Bug fixes only

### 5.2 Deprecation Timeline
```
v1.2.0 - Feature X deprecated (warning)
v1.3.0 - Feature X deprecated (loud warning)
v2.0.0 - Feature X removed
```

---

## 6. Upgrade Guide

### 6.1 Check Current Version
```bash
$ meta_gen --version
meta_gen 1.2.3
```

### 6.2 Upgrade Process
```bash
# 1. Update pubspec.yaml
# 2. Get dependencies
flutter pub get

# 3. Check for breaking changes
meta_gen doctor

# 4. Run migration if needed
meta_gen migrate

# 5. Regenerate all components
meta_gen build --force

# 6. Run tests
flutter test
```

---

## 7. Flutter Version Detection

### 7.1 Automatic Adaptation
```dart
// Generated code adapts to Flutter version
import 'package:flutter/foundation.dart';

Widget _buildButton() {
  // Flutter 3.19+ uses new API
  if (kFlutterMemoryAllocationsEnabled) {
    return _buildModern();
  }
  return _buildLegacy();
}
```

### 7.2 Generator Warning
```bash
$ meta_gen build

WARNING: Flutter version 3.10.0 detected
  Recommended: 3.16.0+
  Some features may not work correctly.
  
Continue? [y/N]
```

---

## 8. Lock Files

### 8.1 pubspec.lock
Always commit `pubspec.lock` for reproducible builds.

### 8.2 Generator Lock
```yaml
# .meta_gen.lock
generator_version: 1.2.3
schema_version: 2
last_generated: 2024-12-16T12:30:00Z
flutter_version: 3.19.0
```

---

## 9. CI/CD Version Matrix

```yaml
# .github/workflows/test.yml
strategy:
  matrix:
    flutter: [3.16.0, 3.19.0, stable]
    
steps:
  - uses: subosito/flutter-action@v2
    with:
      flutter-version: ${{ matrix.flutter }}
  - run: meta_gen build
  - run: flutter test
```

---

## 10. Troubleshooting

| Issue | Solution |
|-------|----------|
| "Unsupported Flutter version" | Upgrade Flutter or pin older Meta-UI |
| "Dart SDK too old" | Run `flutter upgrade` |
| "Generated code has errors" | Regenerate with `--force` |
| "Package not found" | Run `flutter pub get` in generator |

---

*Document Version: 1.0*
