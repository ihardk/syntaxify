# Issue #12: No Dry-Run Mode

## Status: ❌ NOT IMPLEMENTED (Low Priority)

## Problem

Users can't preview what will be generated without actually generating it.

**Desired:**
```bash
$ dart run syntaxify build --dry-run

Dry run - no files will be written

Would generate:
  ✓ lib/syntaxify/generated/components/app_button.dart
  ✓ lib/syntaxify/generated/components/app_input.dart
  ✓ lib/syntaxify/generated/components/app_text.dart
  ✓ lib/screens/login_screen.dart

Would copy:
  ✓ lib/syntaxify/design_system/design_system.dart
  ✓ lib/syntaxify/design_system/app_theme.dart
  (... 15 more files)

Total: 18 files would be generated (0 errors, 2 warnings)

⚠ Warning: login_screen.dart already exists (would be skipped)
⚠ Warning: button.meta.dart has validation warnings

Run without --dry-run to generate files
```

## Use Cases

1. **Preview before committing** - See what will change
2. **Check for issues** - Validate without modifying files
3. **CI validation** - Verify meta files without generating
4. **Learning** - Understand what syntaxify does

## Implementation Plan

### Add Flag to BuildCommand

**File:** `lib/src/cli/build_command.dart`

```dart
BuildCommand({required this.logger}) {
  argParser
    // ... existing options
    ..addFlag(
      'dry-run',
      help: 'Show what would be generated without writing files',
      negatable: false,
      defaultsTo: false,
    );
}
```

### Add Dry-Run Mode to FileSystem

**File:** `lib/src/core/interfaces/file_system.dart`

```dart
abstract class FileSystem {
  // ... existing methods

  /// Set dry-run mode - methods return success but don't modify files
  void setDryRun(bool enabled);
}
```

**File:** `lib/src/infrastructure/local_file_system.dart`

```dart
class LocalFileSystem implements FileSystem {
  bool _dryRun = false;
  final List<String> _wouldCreate = [];
  final List<String> _wouldModify = [];

  @override
  void setDryRun(bool enabled) {
    _dryRun = enabled;
    if (!enabled) {
      _wouldCreate.clear();
      _wouldModify.clear();
    }
  }

  @override
  Future<void> writeFile(String path, String content) async {
    if (_dryRun) {
      if (await File(path).exists()) {
        _wouldModify.add(path);
      } else {
        _wouldCreate.add(path);
      }
      return;  // Don't actually write
    }

    // ... existing write logic
  }

  @override
  Future<void> createDirectory(String path) async {
    if (_dryRun) {
      if (!await Directory(path).exists()) {
        _wouldCreate.add(path);
      }
      return;
    }

    // ... existing create logic
  }

  List<String> getWouldCreate() => List.unmodifiable(_wouldCreate);
  List<String> getWouldModify() => List.unmodifiable(_wouldModify);
}
```

### Update BuildAllUseCase

**File:** `lib/src/use_cases/build_all.dart`

```dart
Future<BuildResult> execute({
  // ... existing params
  bool dryRun = false,
}) async {
  if (dryRun) {
    fileSystem.setDryRun(true);
    logger.info('🔍 Dry run - no files will be written');
    logger.info('');
  }

  // ... existing build logic

  stopwatch.stop();

  if (dryRun) {
    _printDryRunSummary();
  }

  return BuildResult(/* ... */);
}

void _printDryRunSummary() {
  final wouldCreate = (fileSystem as LocalFileSystem).getWouldCreate();
  final wouldModify = (fileSystem as LocalFileSystem).getWouldModify();

  logger.info('');
  logger.info('Would generate:');
  for (final file in wouldCreate) {
    logger.info('  ✓ $file (new)');
  }

  if (wouldModify.isNotEmpty) {
    logger.info('');
    logger.info('Would modify:');
    for (final file in wouldModify) {
      logger.warn('  ⚠ $file (exists)');
    }
  }

  logger.info('');
  logger.success('Total: ${wouldCreate.length} new files, ${wouldModify.length} existing');
  logger.info('Run without --dry-run to generate files');
}
```

## Enhanced Features

### Show Preview of Generated Code

```bash
$ dart run syntaxify build --dry-run --preview

Would generate app_button.dart:
─────────────────────────────────────
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  ...
}
─────────────────────────────────────

Preview 3 more files with --preview-all
```

### Compare with Existing

```bash
$ dart run syntaxify build --dry-run --diff

Would modify app_button.dart:
  - 12 lines added
  - 3 lines removed
  - 5 lines changed

Run with --show-diff to see detailed changes
```

## Example Outputs

### Simple Project

```bash
$ dart run syntaxify build --dry-run

🔍 Dry run - no files will be written

Would generate:
  ✓ lib/syntaxify/generated/components/app_button.dart (new)
  ✓ lib/syntaxify/generated/components/app_text.dart (new)
  ✓ lib/screens/login_screen.dart (new)

Would copy:
  ✓ lib/syntaxify/design_system/design_system.dart (new)
  (... 8 more files)

✓ Total: 11 new files (0 errors, 0 warnings)

Run without --dry-run to generate files
```

### With Warnings

```bash
$ dart run syntaxify build --dry-run

🔍 Dry run - no files will be written

Would generate:
  ✓ lib/syntaxify/generated/components/app_button.dart (new)
  ⚠ lib/screens/login_screen.dart (skipped - exists)

Validation warnings:
  ⚠ meta/button.meta.dart: Button label is empty (line 15)
  ⚠ meta/login.screen.dart: Column has no children (line 8)

✓ Total: 1 new files (0 errors, 2 warnings)

Run without --dry-run to generate files
```

### With Errors

```bash
$ dart run syntaxify build --dry-run

🔍 Dry run - no files will be written

Validation errors:
  ✗ meta/button.meta.dart: Invalid identifier 'on-pressed' (line 12)
  ✗ meta/text.meta.dart: Missing required field 'text' (line 8)

✗ Build would fail with 2 error(s)

Fix errors before building
```

## Files to Modify

**Modified:**
1. `lib/src/core/interfaces/file_system.dart`
2. `lib/src/infrastructure/local_file_system.dart`
3. `lib/src/use_cases/build_all.dart`
4. `lib/src/cli/build_command.dart`

**Effort:** 2-3 hours
**Priority:** Low (nice to have)
**User benefit:** Medium (useful for previewing changes)

## Alternative: Verbose Mode

Instead of --dry-run, enhance --verbose to show more detail:

```bash
$ dart run syntaxify build --verbose

[VERBOSE] Loading meta/button.meta.dart
[VERBOSE] Parsing ButtonMeta class
[VERBOSE] Found 5 properties
[VERBOSE] Generating app_button.dart
[VERBOSE] Writing lib/syntaxify/generated/components/app_button.dart (1234 bytes)
[VERBOSE] Done
```

Less useful than dry-run, but simpler to implement.
