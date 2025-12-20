# Contributing Guide 🤝

**How to contribute to Syntaxify**

Welcome! This guide will help you set up your development environment and make your first contribution.

---

## Table of Contents

1. [Setting Up](#setting-up)
2. [Development Workflow](#development-workflow)
3. [Running Tests](#running-tests)
4. [Code Style](#code-style)
5. [Submitting Changes](#submitting-changes)
6. [Review Process](#review-process)

---

## Setting Up

### Prerequisites

- ✅ Flutter SDK (latest stable)
- ✅ Dart SDK (latest stable)
- ✅ Git
- ✅ A code editor (VS Code, Android Studio, etc.)

**Check your setup:**
```bash
flutter --version
dart --version
git --version
```

### Fork and Clone

**1. Fork the repository:**
- Go to https://github.com/ihardk/syntaxify
- Click "Fork" button

**2. Clone your fork:**
```bash
git clone https://github.com/YOUR_USERNAME/syntaxify.git
cd syntaxify
```

**3. Add upstream remote:**
```bash
git remote add upstream https://github.com/ihardk/syntaxify.git
```

### Install Dependencies

**Generator package:**
```bash
cd generator
dart pub get
```

**Example app:**
```bash
cd example
flutter pub get
```

**Root package:**
```bash
cd ../..
cd syntaxify
dart pub get
```

### Verify Setup

**Run the example:**
```bash
cd generator/example
flutter run
```

**Run tests:**
```bash
cd generator
dart test
```

If everything works, you're ready to contribute! 🎉

---

## Development Workflow

### 1. Create a Branch

**Always work on a feature branch:**
```bash
git checkout -b feature/my-new-feature
```

**Branch naming:**
- `feature/add-card-component` - New features
- `fix/button-rendering-bug` - Bug fixes
- `docs/improve-readme` - Documentation
- `refactor/simplify-parser` - Refactoring

### 2. Make Changes

**Follow these principles:**

**✅ DO:**
- Write clean, readable code
- Add tests for new features
- Update documentation
- Keep commits focused and atomic
- Test your changes thoroughly

**❌ DON'T:**
- Make unrelated changes in one PR
- Skip writing tests
- Forget to update docs
- Break existing functionality
- Commit generated files (unless necessary)

### 3. Test Your Changes

**Run all tests:**
```bash
cd generator
dart test
```

**Run specific test:**
```bash
dart test test/parser/meta_parser_test.dart
```

**Test the example app:**
```bash
cd example
flutter run
```

**Try all styles:**
```dart
// In example/lib/main.dart
AppTheme(style: MaterialStyle(), ...)   // Test Material
AppTheme(style: CupertinoStyle(), ...)  // Test Cupertino
AppTheme(style: NeoStyle(), ...)        // Test Neo
```

### 4. Commit Your Changes

**Write good commit messages:**
```bash
git add .
git commit -m "feat: Add Card component with Material, Cupertino, and Neo renderers"
```

**Commit message format:**
```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation only
- `style:` - Code style (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

**Examples:**
```bash
git commit -m "feat: Add Card component"
git commit -m "fix: Button rendering on iOS"
git commit -m "docs: Update AST system guide"
git commit -m "refactor: Simplify meta parser"
git commit -m "test: Add tests for layout emitter"
```

---

## Running Tests

### All Tests

```bash
cd generator
dart test
```

### Specific Test File

```bash
dart test test/parser/meta_parser_test.dart
```

### With Coverage

```bash
dart test --coverage=coverage
dart pub global activate coverage
dart pub global run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --report-on=lib
```

**View coverage:**
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Writing Tests

**Example test:**
```dart
// test/parser/meta_parser_test.dart
import 'package:test/test.dart';
import 'package:syntaxify/src/parser/meta_parser.dart';

void main() {
  group('MetaParser', () {
    test('parses component with required properties', () {
      final parser = MetaParser();

      final component = parser.parse('test/fixtures/button.meta.dart');

      expect(component.name, equals('AppButton'));
      expect(component.properties.length, equals(2));
      expect(component.properties[0].name, equals('label'));
      expect(component.properties[0].isRequired, isTrue);
    });

    test('parses component with optional properties', () {
      // Test optional properties
    });

    test('throws on invalid meta file', () {
      // Test error handling
    });
  });
}
```

**Test fixtures:**

Create test fixtures in `test/fixtures/`:

```dart
// test/fixtures/button.meta.dart
@SyntaxComponent(name: 'AppButton')
class ButtonMeta {
  final String label;
  final VoidCallback? onPressed;
}
```

---

## Code Style

### Dart Style

**Use `dart format`:**
```bash
dart format lib/ test/
```

**Check formatting:**
```bash
dart format --set-exit-if-changed lib/ test/
```

### Linting

**Run analyzer:**
```bash
dart analyze
```

**Fix issues:**
```bash
dart fix --apply
```

### Code Conventions

**Naming:**
```dart
// Classes: PascalCase
class MetaParser { }
class ComponentDefinition { }

// Functions/Methods: camelCase
void parseFile() { }
String getComponentName() { }

// Variables: camelCase
final componentName = 'AppButton';
final isRequired = true;

// Constants: camelCase
const defaultPadding = 16.0;

// Private: _prefixed
class _PrivateClass { }
void _privateMethod() { }
final _privateVar = 'secret';
```

**File names:**
```
snake_case.dart
meta_parser.dart
component_definition.dart
```

**Documentation:**
```dart
/// Parses component meta files.
///
/// Extracts [ComponentDefinition] from files annotated with [@SyntaxComponent].
///
/// Example:
/// ```dart
/// final parser = MetaParser();
/// final component = parser.parse('meta/button.meta.dart');
/// ```
class MetaParser {
  /// Parses the meta file at [filePath].
  ///
  /// Throws [ParseException] if the file is invalid.
  ComponentDefinition parse(String filePath) {
    // ...
  }
}
```

**Imports:**
```dart
// 1. Dart imports
import 'dart:io';

// 2. Package imports
import 'package:flutter/material.dart';
import 'package:analyzer/dart/analysis/results.dart';

// 3. Relative imports
import '../models/component_definition.dart';
import '../utils/component_naming.dart';
```

---

## Submitting Changes

### 1. Update Your Branch

**Before submitting, sync with upstream:**
```bash
git checkout main
git pull upstream main
git checkout feature/my-new-feature
git rebase main
```

**Resolve conflicts if any:**
```bash
git add .
git rebase --continue
```

### 2. Push Your Branch

```bash
git push origin feature/my-new-feature
```

### 3. Create Pull Request

**Go to GitHub:**
- https://github.com/YOUR_USERNAME/syntaxify
- Click "New Pull Request"
- Select your branch
- Fill in the template

**PR Title:**
```
feat: Add Card component with multi-style support
```

**PR Description:**

```markdown
## Description
Adds a new Card component with support for Material, Cupertino, and Neo styles.

## Changes
- Added `CardMeta` in `meta/card.meta.dart`
- Added `CardNode` to AST
- Implemented `MaterialCardRenderer`
- Implemented `CupertinoCardRenderer`
- Implemented `NeoCardRenderer`
- Updated layout emitter
- Added tests

## Testing
- [x] All tests pass
- [x] Tested with Material style
- [x] Tested with Cupertino style
- [x] Tested with Neo style
- [x] Added unit tests
- [x] Updated documentation

## Screenshots
![Material Card](screenshots/material-card.png)
![Cupertino Card](screenshots/cupertino-card.png)
![Neo Card](screenshots/neo-card.png)

## Checklist
- [x] Code follows style guidelines
- [x] Tests added/updated
- [x] Documentation updated
- [x] No breaking changes
- [x] Commits are clean and atomic
```

### 4. Respond to Review

**When reviewers comment:**
- ✅ Respond promptly
- ✅ Make requested changes
- ✅ Push updates to same branch
- ✅ Mark conversations as resolved

**Making changes:**
```bash
# Make changes
git add .
git commit -m "fix: Address review comments"
git push origin feature/my-new-feature
```

**Squashing commits (if requested):**
```bash
git rebase -i main
# Mark commits to squash
git push --force origin feature/my-new-feature
```

---

## Review Process

### What Reviewers Look For

**1. Code Quality**
- Clean, readable code
- Follows Dart conventions
- Properly documented
- No unnecessary complexity

**2. Tests**
- New features have tests
- Tests are comprehensive
- Tests pass consistently

**3. Documentation**
- README updated if needed
- Code is documented
- Examples provided
- Learning docs updated

**4. Functionality**
- Works as intended
- No breaking changes
- Handles edge cases
- Good error handling

**5. Design**
- Fits project architecture
- Doesn't introduce tech debt
- Reusable and maintainable

### Review Timeline

- **Initial review:** Within 2-3 days
- **Follow-up reviews:** Within 1-2 days
- **Merge:** After approval from maintainers

### After Merge

**Cleanup:**
```bash
git checkout main
git pull upstream main
git branch -d feature/my-new-feature
```

**Celebrate!** 🎉 You're now a Syntaxify contributor!

---

## Common Contribution Types

### Adding a Component

**See:** [09-adding-new-component.md](09-adding-new-component.md)

**Steps:**
1. Create meta file
2. Add to AST (if needed)
3. Create tokens
4. Implement renderers
5. Add tests
6. Update docs
7. Submit PR

**PR Template:**
```
feat: Add [ComponentName] component

- Implemented Material renderer
- Implemented Cupertino renderer
- Implemented Neo renderer
- Added comprehensive tests
- Updated documentation
```

### Fixing a Bug

**Steps:**
1. Create issue (if not exists)
2. Write failing test
3. Fix the bug
4. Verify test passes
5. Submit PR

**PR Template:**
```
fix: [Brief description of bug]

Fixes #[issue-number]

- Fixed [specific issue]
- Added test to prevent regression
```

### Improving Documentation

**Steps:**
1. Identify unclear/missing docs
2. Make improvements
3. Submit PR

**PR Template:**
```
docs: Improve [topic] documentation

- Clarified [specific point]
- Added examples
- Fixed typos
```

### Adding Tests

**Steps:**
1. Identify untested code
2. Write tests
3. Verify coverage improves
4. Submit PR

**PR Template:**
```
test: Add tests for [component/feature]

- Added unit tests for [feature]
- Increased coverage from X% to Y%
```

---

## Development Tips

### 1. Use Hot Reload

While developing renderers, use Flutter's hot reload:
```bash
cd generator/example
flutter run
# Make changes to renderers
# Press 'r' to hot reload
```

### 2. Use Logging

Add debug prints:
```dart
void generateComponent(ComponentDefinition component) {
  print('Generating ${component.name}...');
  // ...
}
```

### 3. Test Edge Cases

Don't just test the happy path:
```dart
test('handles null values', () { });
test('throws on invalid input', () { });
test('handles empty lists', () { });
```

### 4. Keep PRs Small

Small PRs get reviewed faster:
- ✅ One feature per PR
- ✅ Focus on specific issue
- ❌ Don't combine unrelated changes

### 5. Ask Questions

Not sure about something? Ask!
- Open a discussion on GitHub
- Comment on the issue
- Ask in the PR

---

## Getting Help

**Stuck? Need help?**

1. **Check existing docs:**
   - [README.md](../README.md)
   - [learning/](.) - This directory
   - [planning/](../planning/) - Implementation plans

2. **Search existing issues:**
   - https://github.com/ihardk/syntaxify/issues

3. **Ask in discussions:**
   - https://github.com/ihardk/syntaxify/discussions

4. **Create new issue:**
   - https://github.com/ihardk/syntaxify/issues/new

---

## Project Structure Quick Reference

```
syntaxify/
├── generator/               # Main package
│   ├── lib/
│   │   ├── src/
│   │   │   ├── commands/   # CLI commands
│   │   │   ├── use_cases/  # Business logic
│   │   │   ├── parser/     # Meta file parsing
│   │   │   ├── generators/ # Code generation
│   │   │   ├── emitters/   # Code emission
│   │   │   └── models/     # Data models
│   │   └── cli.dart        # CLI entry point
│   │
│   ├── design_system/      # Runtime system
│   │   ├── tokens/         # Design tokens
│   │   └── styles/         # Style implementations
│   │
│   ├── meta/               # Component definitions
│   ├── example/            # Example app
│   └── test/               # Tests
│
└── learning/               # Documentation (you are here!)
```

---

## Checklist Before Submitting

- [ ] Code follows style guidelines
- [ ] All tests pass (`dart test`)
- [ ] Analyzer has no errors (`dart analyze`)
- [ ] Code is formatted (`dart format`)
- [ ] New tests added for new features
- [ ] Documentation updated
- [ ] Commits are clean and well-messaged
- [ ] PR description is clear
- [ ] No breaking changes (or documented)
- [ ] Tested with all three styles (if applicable)

---

## Recognition

**Contributors are recognized in:**
- Project README
- Release notes
- Contributor list on GitHub

**Thank you for contributing to Syntaxify!** 🙏

---

## Next Steps

**Ready to contribute?**

1. **Start small:**
   - Fix typos in docs
   - Add tests
   - Improve error messages

2. **Then try:**
   - Add a simple component
   - Implement a feature from the planning docs
   - Fix a reported bug

3. **Advanced:**
   - Design system improvements
   - Parser enhancements
   - New CLI features

**Good first issues:**
- https://github.com/ihardk/syntaxify/labels/good-first-issue

**Happy contributing!** 🚀
