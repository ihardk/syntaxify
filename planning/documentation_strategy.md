# Documentation Strategy

> How Forge is documented for end users.

---

## 1. Documentation Layers

```
┌─────────────────────────────────────────┐
│       Getting Started Guide             │  ← 5 mins to first component
├─────────────────────────────────────────┤
│       Component API Reference           │  ← Auto-generated from code
├─────────────────────────────────────────┤
│       Theme Customization Guide         │  ← How to create custom themes
├─────────────────────────────────────────┤
│       Architecture Deep Dive            │  ← For contributors
└─────────────────────────────────────────┘
```

---

## 2. Getting Started Guide

### 2.1 Quick Start (README.md)
```markdown
# Forge

Build Flutter UIs that automatically adapt to any design system.

## Installation
```yaml
dev_dependencies:
  forge: ^1.0.0
```

## Usage
```dart
// 1. Define your button
AppButton(
  label: 'Click Me',
  onPressed: () => print('Pressed!'),
)

// 2. Wrap in theme
MetaTheme(
  style: DesignStyle.material,
  child: MyApp(),
)
```

## Generate
```bash
dart run forge build
```
```

### 2.2 Tutorial Structure
1. **Hello World** - First AppButton
2. **Theme Switching** - Material ↔ Neo
3. **Custom Tokens** - Modify colors
4. **Create Component** - Build AppCard
5. **Production Build** - Static mode

---

## 3. API Reference (Auto-Generated)

### 3.1 From Dart Comments
```dart
/// A customizable button that adapts to the current theme.
/// 
/// {@example}
/// AppButton(
///   label: 'Submit',
///   onPressed: () => form.submit(),
///   isLoading: isSubmitting,
/// )
/// {@end-example}
/// 
/// See also:
/// - [AppIconButton] for icon-only buttons
/// - [ButtonTokens] for customization
class AppButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;
  
  /// Called when the button is tapped.
  /// 
  /// If null, the button is disabled.
  final VoidCallback? onPressed;
  
  /// Shows a loading indicator instead of [label].
  final bool isLoading;
}
```

### 3.2 Generated Documentation
```bash
$ dart doc .

# Generates:
doc/
├── index.html
├── AppButton-class.html
├── ButtonTokens-class.html
└── ...
```

---

## 4. Component Explorer (Storybook-like)

### 4.1 Live Preview App
```dart
// tool/explorer/main.dart
void main() {
  runApp(MetaExplorer(
    components: [
      ComponentStory(
        name: 'AppButton',
        variants: [
          Variant('Default', AppButton(label: 'Click', onPressed: () {})),
          Variant('Disabled', AppButton(label: 'Click', onPressed: null)),
          Variant('Loading', AppButton(label: 'Click', onPressed: () {}, isLoading: true)),
        ],
      ),
      // ... more components
    ],
  ));
}
```

### 4.2 Explorer Features
- [ ] Live theme switching
- [ ] Token value editing
- [ ] Code snippet copying
- [ ] Responsive preview
- [ ] Accessibility audit

---

## 5. Theme Customization Guide

### 5.1 Document Structure
```markdown
# Creating Custom Themes

## 1. Define Tokens
```yaml
# theme.custom.yaml
button:
  radius: 16
  bgColor: "#FF5722"
  textColor: "#FFFFFF"
```

## 2. Add to Generator
```bash
forge build --themes=material,custom
```

## 3. Use in App
```dart
MetaTheme(
  style: DesignStyle.custom,
  child: MyApp(),
)
```
```

---

## 6. Inline Help

### 6.1 IDE Tooltips
```dart
/// 💡 **Tip:** Use `isLoading` instead of manually showing a spinner.
/// 
/// ⚠️ **Warning:** `onPressed: null` disables the button.
```

### 6.2 Assert Messages
```dart
assert(
  label.isNotEmpty,
  'AppButton: label cannot be empty. '
  'See: https://Forge.dev/docs/button#label',
);
```

---

## 7. Migration Guides

For each breaking version:
```markdown
# Migrating from v1.x to v2.0

## Breaking Changes

### ButtonTokens.color → ButtonTokens.bgColor
```diff
- color: Colors.blue,
+ bgColor: Colors.blue,
```

### onTap → onPressed
```diff
- onTap: () => ...,
+ onPressed: () => ...,
```
```

---

## 8. Error Documentation

Every error code links to documentation:
```
ERROR: META-001
Message: Missing required token 'bgColor'
Help: https://Forge.dev/errors/META-001
```

---

## 9. Documentation Hosting

| Platform | Purpose |
|----------|---------|
| GitHub Pages | API reference |
| Dedicated site | Guides & tutorials |
| pub.dev | Package README |
| In-repo `/docs` | Contributor docs |

---

## 10. Documentation CI

```yaml
# .github/workflows/docs.yml
- name: Generate API docs
  run: dart doc .

- name: Check for broken links
  run: npx linkinator ./doc --recurse

- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
```

---

*Document Version: 1.0*

