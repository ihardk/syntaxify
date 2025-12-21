# Troubleshooting

Common issues and solutions when using Syntaxify.

## Common Errors

### Error: "Member not found: 'headline'"

**Cause:** Using outdated enum value from old examples.

**Fix:** Use correct TextVariant values:

```dart
// ❌ Wrong
variant: TextVariant.headline

// ✅ Correct
variant: TextVariant.headlineMedium
```

---

### Error: "KeyboardType.email not found"

**Cause:** Using wrong enum type.

**Fix:** Use Flutter's `TextInputType`:

```dart
// ❌ Wrong
keyboardType: KeyboardType.email

// ✅ Correct
keyboardType: TextInputType.emailAddress
```

---

### Error: "Could not find package syntaxify"

**Cause:** Dependency not installed or wrong path.

**Fix:**

1. Ensure pubspec.yaml has the dependency:
   ```yaml
   dev_dependencies:
     syntaxify: ^0.1.0-alpha.1
   ```

2. Run:
   ```bash
   dart pub get
   ```

---

### Error: Changes to component not reflected

**Cause:** Edited generated component file directly.

**Fix:**

1. Edit the `meta/*.meta.dart` file instead
2. Run `dart run syntaxify build` to regenerate
3. Remember: **Components regenerate, screens don't**

---

### Error: "No meta files found"

**Cause:** Running build from wrong directory or missing meta folder.

**Fix:**

1. Ensure you're in your project root
2. Check that `meta/` folder exists with `.meta.dart` files
3. Or specify path: `dart run syntaxify build --meta=path/to/meta`

---

### Error: AppTheme not found in widget tree

**Cause:** Component used without wrapping in `AppTheme`.

**Fix:** Wrap your app with `AppTheme`:

```dart
AppTheme(
  style: MaterialStyle(),
  child: MaterialApp(
    home: YourScreen(),
  ),
)
```

---

## Build Issues

### Build takes too long

Try building specific components:

```bash
dart run syntaxify build --component=AppButton
```

### Build output in wrong location

Specify custom output path:

```bash
dart run syntaxify build --output=lib/custom_path
```

### Config file not being read

Ensure `syntaxify.yaml` is in your project root (same level as `pubspec.yaml`):

```yaml
# syntaxify.yaml
meta: meta
output: lib/syntaxify
```

### Dry run shows no output

Make sure you have meta files to build:

```bash
dart run syntaxify build --dry-run
# Should show: "Files to write: ..."
```

---

## Runtime Issues

### Style not changing

Ensure you're changing the style in a `StatefulWidget` and calling `setState`:

```dart
void _switchStyle(DesignStyle style) {
  setState(() {
    _currentStyle = style;
  });
}
```

### Component not rendering correctly

1. Check that `AppTheme` is above the component in the widget tree
2. Verify the design style is properly initialized
3. Try hot restart (not just hot reload)

---

## Getting Help

- 📖 **Documentation:** Check other docs in this folder
- 🐛 **Report Issues:** [GitHub Issues](https://github.com/ihardk/syntaxify/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/ihardk/syntaxify/discussions)

---

## See Also

- [Getting Started](getting_started.md) - Installation & setup
- [API Reference](api-reference.md) - Component usage
- [Design System](design-system.md) - Architecture details
