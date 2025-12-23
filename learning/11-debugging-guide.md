# Debugging Guide 🐛

**Common issues and how to fix them**

Running into problems? This guide will help you debug and solve common issues.

---

## Table of Contents

1. [Build Errors](#build-errors)
2. [Generation Errors](#generation-errors)
3. [Runtime Errors](#runtime-errors)
4. [Rendering Issues](#rendering-issues)
5. [Testing Issues](#testing-issues)
6. [Debugging Techniques](#debugging-techniques)

---

## Build Errors

### Error: "No AppTheme found in context"

**Full error:**
```
════════ Exception caught by widgets library ════════
No AppTheme found in context. Wrap your app with AppTheme.
```

**Cause:**
You're using a Syntaxify component but forgot to wrap your app with `AppTheme`.

**Fix:**
```dart
// ❌ WRONG
void main() {
  runApp(MyApp());
}

// ✅ CORRECT
void main() {
  runApp(
    AppTheme(
      style: MaterialStyle(),
      child: MyApp(),
    ),
  );
}
```

---

### Error: "Missing concrete implementation"

**Full error:**
```
Missing concrete implementation of 'DesignStyle.renderButton'
```

**Cause:**
You added a new render method to `DesignStyle` but didn't implement it in all styles.

**Fix:**

1. Check `DesignStyle`:
```dart
abstract class DesignStyle {
  Widget renderButton({...});  // This method exists
}
```

2. Implement in ALL styles:
```dart
// MaterialStyle
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer {  // Implements renderButton
}

// CupertinoStyle
class CupertinoStyle extends DesignStyle
    with CupertinoButtonRenderer {  // Implements renderButton
}

// NeoStyle
class NeoStyle extends DesignStyle
    with NeoButtonRenderer {  // Implements renderButton
}
```

---

### Error: "The part directive... doesn't exist"

**Full error:**
```
The part directive 'tokens/card_tokens.dart' doesn't exist
```

**Cause:**
You added a `part` directive but the file doesn't exist yet.

**Fix:**

1. Create the missing file:
```bash
touch generator/design_system/tokens/card_tokens.dart
```

2. Add `part of` directive:
```dart
// card_tokens.dart
part of '../design_system.dart';

class CardTokens {
  // ...
}
```

---

### Error: "Undefined class 'AppButton'"

**Full error:**
```
Undefined class 'AppButton'
```

**Cause:**
Component hasn't been generated yet, or you forgot to import it.

**Fix:**

1. Generate the component:
```bash
cd generator
dart run syntaxify build
```

2. Import the component:
```dart
import 'package:syntaxify/generated/components.dart';
// or
import 'package:syntaxify/generated/components/app_button.dart';
```

---

## Generation Errors

### Error: "No @SyntaxComponent found"

**Full error:**
```
Exception: No @SyntaxComponent found in meta/button.meta.dart
```

**Cause:**
Your meta file is missing the `@SyntaxComponent` annotation.

**Fix:**
```dart
// ❌ WRONG
class ButtonMeta {
  final String label;
}

// ✅ CORRECT
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
}
```

**Import the annotation:**
```dart
import 'package:syntaxify/syntaxify.dart';
```

---

### Error: "Invalid property type"

**Full error:**
```
Exception: Invalid property type: MyCustomType
```

**Cause:**
You're using a type that Syntaxify doesn't recognize.

**Allowed types:**
- Dart primitives: `String`, `int`, `double`, `bool`
- Flutter types: `Widget`, `VoidCallback`, `ValueChanged<T>`, `EdgeInsetsGeometry`, `Color`
- Syntaxify enums: `ButtonVariant`, `TextVariant`, etc.

**Fix:**
```dart
// ❌ WRONG
class ButtonMeta {
  final MyCustomType value;  // Not allowed
}

// ✅ CORRECT
class ButtonMeta {
  final String value;  // Use standard type
}
```

---

### Error: "Component name cannot be empty"

**Full error:**
```
Exception: Component name cannot be empty
```

**Cause:**
No explicit name provided and class name doesn't end with "Meta".

**Fix:**
```dart
// ❌ WRONG
@SyntaxComponent()
class Button { }  // Doesn't end with 'Meta'

// ✅ CORRECT - Option 1: Use explicit name
@SyntaxComponent(name: 'AppButton')
class Button { }

// ✅ CORRECT - Option 2: Use 'Meta' suffix
@SyntaxComponent()
class ButtonMeta { }  // Will become 'AppButton'
```

---

### Error: "Screen file already exists"

**Message:**
```
⊘ Skipping lib/screens/login_screen.dart (already exists)
```

**Not an error!** This is expected behavior.

**Explanation:**
Screens are generated once, then you can edit them. Syntaxify won't overwrite your changes.

**To regenerate:**
```bash
rm lib/screens/login_screen.dart
dart run syntaxify build
```

**⚠️ Warning:** This will lose your edits!

---

## Runtime Errors

### Error: "type '_InternalLinkedHashMap<String, dynamic>' is not a subtype"

**Full error:**
```
type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'String' in type cast
```

**Cause:**
Callback name is not a string in AST definition.

**Fix:**
```dart
// ❌ WRONG
App.button(
  label: 'Submit',
  onPressed: handleSubmit,  // Function reference
)

// ✅ CORRECT
App.button(
  label: 'Submit',
  onPressed: 'handleSubmit',  // String name
)
```

---

### Error: "A RenderFlex overflowed"

**Full error:**
```
A RenderFlex overflowed by 123 pixels on the bottom.
```

**Cause:**
Layout is too big for the screen, usually in a Column.

**Fix:**

**Option 1: Add scrolling**
```dart
// Wrap Column in SingleChildScrollView
SingleChildScrollView(
  child: Column(
    children: [
      // ... many children
    ],
  ),
)
```

**Option 2: Add Expanded**
```dart
Column(
  children: [
    AppText(text: 'Header'),
    Expanded(  // Takes remaining space
      child: ListView(...),
    ),
    AppButton(label: 'Footer'),
  ],
)
```

---

### Error: "setState() called after dispose()"

**Full error:**
```
setState() or markNeedsBuild() called after dispose()
```

**Cause:**
Async operation completed after widget was disposed.

**Fix:**
```dart
// ❌ WRONG
Future<void> loadData() async {
  final data = await api.fetchData();
  setState(() {
    _data = data;  // Widget might be disposed!
  });
}

// ✅ CORRECT
Future<void> loadData() async {
  final data = await api.fetchData();
  if (mounted) {  // Check if still mounted
    setState(() {
      _data = data;
    });
  }
}
```

---

## Rendering Issues

### Issue: Component looks different than expected

**Symptoms:**
- Button doesn't match design
- Colors are wrong
- Spacing is off

**Debug steps:**

**1. Check which style is active:**
```dart
@override
Widget build(BuildContext context) {
  final style = AppTheme.of(context).style;
  print('Current style: ${style.runtimeType}');  // MaterialStyle? CupertinoStyle?
  return ...;
}
```

**2. Check tokens:**
```dart
@override
Widget renderButton({...}) {
  final tokens = buttonTokens;
  print('Button tokens: $tokens');
  // Check if values are what you expect
}
```

**3. Verify renderer is being used:**
```dart
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer,  // Is this mixin added?
         MaterialTextRenderer {
}
```

---

### Issue: Hot reload doesn't update styles

**Symptoms:**
- Changed renderer code
- Hot reloaded
- No visible change

**Cause:**
Design system files are not hot-reload friendly.

**Fix:**

**Option 1: Hot restart**
```
Press 'R' in terminal (not 'r')
```

**Option 2: Stop and restart**
```bash
# Stop the app
flutter run  # Start again
```

---

### Issue: Text is invisible/wrong color

**Symptoms:**
- Text renders but is invisible
- Wrong color

**Check:**

**1. Text color in tokens:**
```dart
@override
TextTokens get textTokens => const TextTokens(
  // Check if textColor is set
  textColor: Colors.black,  // Not Colors.transparent!
);
```

**2. Background color contrast:**
```dart
// ❌ BAD
backgroundColor: Colors.white,
textColor: Colors.white,  // Invisible!

// ✅ GOOD
backgroundColor: Colors.white,
textColor: Colors.black,  // Visible
```

**3. Theme brightness:**
```dart
// Dark theme needs light text
backgroundColor: Colors.black,
textColor: Colors.white,  // Visible on dark background
```

---

## Testing Issues

### Issue: Tests fail on Windows but pass on Mac/Linux

**Symptoms:**
- "Expected: 'lib/screens/home.dart' Actual: 'lib\screens\home.dart'"
- Path selection logic fails.

**Cause:**
Hardcoded path separators (`/`) or assuming POSIX paths. Windows uses backslashes (`\`) by default.

**Fix:**
Always use the `path` package, especially `path.posix` if working with URIs or internal generator assertions.

```dart
import 'package:path/path.dart' as p;

// ❌ WRONG
final path = 'lib/screens/$name.dart';

// ✅ CORRECT (System agnostic)
final path = p.join('lib', 'screens', '$name.dart');

// ✅ CORRECT (For internal generator logic/URIs)
final uri = p.posix.join('lib', 'screens', '$name.dart');
```

---

### Issue: Golden tests failed after generator update

**Symptoms:**
```
Test failed. ... matchesGoldenFile ...
```

**Cause:**
You updated the generator (e.g., changed default padding, updated a token value), which slightly altered the pixel-perfect rendering of the output widgets.

**Fix:**
This is expected!
1.  Verify the change is intentional.
2.  Run: `flutter test --update-goldens`

---

### Error: "Test failed to load"

**Full error:**
```
Failed to load test: test/parser/meta_parser_test.dart
```

**Cause:**
Test file has syntax errors or missing imports.

**Fix:**

**1. Check syntax:**
```bash
dart analyze test/parser/meta_parser_test.dart
```

**2. Check imports:**
```dart
import 'package:test/test.dart';  // Required!
import 'package:syntaxify/src/parser/meta_parser.dart';
```

---

### Error: "Expected: equals 'AppButton' Actual: 'Button'"

**Full error:**
```
Expected: equals 'AppButton'
  Actual: 'Button'
```

**Cause:**
Component name doesn't match expectation.

**Debug:**
```dart
test('parses component name', () {
  final component = parser.parse('test/fixtures/button.meta.dart');

  // Debug: Print actual value
  print('Actual name: ${component.name}');

  expect(component.name, equals('AppButton'));
});
```

**Fix:**
Update test expectation or fix meta file.

---

### Issue: Tests pass locally but fail in CI

**Symptoms:**
- Tests pass on your machine
- Fail on GitHub Actions / CI

**Common causes:**

**1. File paths:**
```dart
// ❌ WRONG - Absolute path
final file = File('/Users/you/project/test/fixtures/button.meta.dart');

// ✅ CORRECT - Relative path
final file = File('test/fixtures/button.meta.dart');
```

**2. Line endings (Windows vs Unix):**
```dart
// Use normalized line endings
final content = file.readAsStringSync().replaceAll('\r\n', '\n');
```

**3. Timing issues:**
```dart
// ❌ FLAKY
await Future.delayed(Duration(milliseconds: 100));
expect(value, equals(expected));

// ✅ RELIABLE
await Future.delayed(Duration(milliseconds: 100));
await tester.pumpAndSettle();  // For widget tests
expect(value, equals(expected));
```

---

## Debugging Techniques

### 1. Print Debugging

**In generators:**
```dart
void generateComponent(ComponentDefinition component) {
  print('━' * 80);
  print('Generating component: ${component.name}');
  print('Properties: ${component.properties.map((p) => p.name).join(', ')}');
  print('━' * 80);

  // ... generation code
}
```

**In renderers:**
```dart
@override
Widget renderButton({...}) {
  print('renderButton called:');
  print('  label: $label');
  print('  variant: $variant');
  print('  onPressed: ${onPressed != null}');

  return ElevatedButton(...);
}
```

**In AST emission:**
```dart
Expression emit(App node) {
  print('Emitting node: ${node.runtimeType}');

  return node.map(
    button: (n) {
      print('  Button label: ${n.label}');
      return _emitButton(n);
    },
    // ...
  );
}
```

### 2. Debugging in VS Code

**Set breakpoints:**
1. Click left of line number
2. Red dot appears
3. Run in debug mode

**Watch variables:**
```dart
void generateComponent(ComponentDefinition component) {
  // Hover over 'component' while debugging
  final name = component.name;  // Set breakpoint here
  // ...
}
```

**Debug console:**
```dart
// Type expressions in debug console
component.properties.length
component.name.toUpperCase()
```

### 3. Flutter DevTools

**For widget debugging:**

```bash
# Run app
flutter run

# Open DevTools
# Click the link in terminal
# Or run:
dart devtools
```

**Widget Inspector:**
- View widget tree
- See widget properties
- Measure layout

**Performance:**
- Profile rendering
- Check rebuild count
- Find performance issues

### 4. Assertion Messages

**Add helpful assertions:**
```dart
void generateComponent(ComponentDefinition component) {
  assert(
    component.name.isNotEmpty,
    'Component name cannot be empty. Definition: $component',
  );

  assert(
    component.properties.isNotEmpty,
    'Component ${component.name} has no properties',
  );

  // ... generation code
}
```

### 5. Logging Levels

**Use different log levels:**
```dart
enum LogLevel { debug, info, warning, error }

void log(String message, {LogLevel level = LogLevel.info}) {
  final prefix = {
    LogLevel.debug: '🔍 DEBUG',
    LogLevel.info: 'ℹ️  INFO',
    LogLevel.warning: '⚠️  WARN',
    LogLevel.error: '❌ ERROR',
  }[level];

  print('$prefix: $message');
}

// Usage
log('Generating component: ${component.name}', level: LogLevel.debug);
log('Component generated successfully', level: LogLevel.info);
log('Missing property default value', level: LogLevel.warning);
log('Failed to generate component', level: LogLevel.error);
```

### 6. Diff Tool

**Compare generated code:**
```bash
# Generate
dart run syntaxify build

# Save output
cp lib/generated/components/app_button.dart app_button_before.dart

# Make changes and regenerate
dart run syntaxify build

# Compare
diff app_button_before.dart lib/generated/components/app_button.dart
```

---

## Common Pitfalls

### 1. Forgetting to Regenerate

**Problem:**
You modified `ast_node.dart` but forgot to run build_runner.

**Symptoms:**
```
Error: The getter 'cardNode' isn't defined for the class 'App'
```

**Fix:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 2. Mixing Generated and Manual Code

**Problem:**
Editing generated files.

**Symptoms:**
Your changes get overwritten on next build.

**Fix:**
- ✅ Only edit files in `lib/screens/` (screens are editable)
- ❌ Never edit `lib/generated/components/` (always regenerated)

### 3. Circular Dependencies

**Problem:**
File A imports File B, File B imports File A.

**Symptoms:**
```
Error: The library is cyclic
```

**Fix:**
Refactor to remove circular dependency. Use dependency inversion.

### 4. Not Checking Nullability

**Problem:**
Accessing potentially null values.

**Symptoms:**
```
Null check operator used on a null value
```

**Fix:**
```dart
// ❌ WRONG
final callback = component.onPressed!;  // Might be null

// ✅ CORRECT
if (component.onPressed != null) {
  final callback = component.onPressed!;
  // ...
}

// or
final callback = component.onPressed ?? defaultCallback;
```

---

## Getting More Help

**Still stuck?**

1. **Check existing issues:**
   - https://github.com/ihardk/syntaxify/issues

2. **Search discussions:**
   - https://github.com/ihardk/syntaxify/discussions

3. **Create new issue:**
   - Include error message
   - Include code that reproduces the issue
   - Include steps to reproduce
   - Include environment details (Flutter version, OS, etc.)

4. **Ask in discussions:**
   - For general questions
   - For "how do I..." questions
   - For feedback

---

## Quick Reference

### Common Commands

```bash
# Generate components and screens
dart run syntaxify build

# Clean generated files
dart run syntaxify clean

# Run tests
dart test

# Run specific test
dart test test/parser/meta_parser_test.dart

# Run analyzer
dart analyze

# Format code
dart format lib/ test/

# Regenerate freezed models
dart run build_runner build --delete-conflicting-outputs

# Run example app
cd example && flutter run

# Hot reload (in running app)
Press 'r'

# Hot restart (in running app)
Press 'R'
```

### Debug Checklist

When something goes wrong:

- [ ] Read the full error message
- [ ] Check stack trace
- [ ] Try to reproduce in minimal example
- [ ] Add print statements
- [ ] Check recent changes
- [ ] Run tests
- [ ] Check documentation
- [ ] Search existing issues
- [ ] Ask for help (if still stuck)

---

**Happy debugging!** 🐛🔍
