---
description: Clean up generated files and rebuild fresh
---

# Cleanup Workflow

> Remove generated files, caches, and rebuild from clean state.

## Usage
```
/cleanup
```

---

## Steps

### 1. Clean Generated Code
```bash
cd d:\Workspace\forge\generator
dart run bin/forge.dart clean
```

Or manually:
```bash
rm -rf generator/example/lib/forge/generated/
```

### 2. Clean Build Artifacts
```bash
cd d:\Workspace\forge\generator
dart pub get
```

```bash
cd d:\Workspace\forge\generator\example
flutter clean
flutter pub get
```

### 3. Clean Test Caches
```bash
cd d:\Workspace\forge\generator
rm -rf .dart_tool/
```

### 4. Verify Clean State
```bash
dart analyze
flutter analyze
```

---

## Optional: Deep Clean

### Remove All Transient Files
```bash
# Generator
cd d:\Workspace\forge\generator
rm -rf .dart_tool/ build/ pubspec.lock

# Example app
cd d:\Workspace\forge\generator\example
rm -rf .dart_tool/ build/ pubspec.lock
```

### Reinstall Dependencies
```bash
cd d:\Workspace\forge\generator
dart pub get

cd d:\Workspace\forge\generator\example
flutter pub get
```

---

## When to Use

| Scenario                  | Command    |
| ------------------------- | ---------- |
| Generated code is stale   | `/cleanup` |
| Tests behaving oddly      | `/cleanup` |
| After major branch switch | `/cleanup` |
| Before demo/presentation  | `/cleanup` |
