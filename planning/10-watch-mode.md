# Issue #10: No Watch Mode

## Status: ❌ NOT IMPLEMENTED (Low Priority - QoL)

## Problem

Users must manually run `syntaxify build` after each change.

**Current workflow:**
```bash
# Edit meta/button.meta.dart
$ dart run syntaxify build
# Edit meta/button.meta.dart again
$ dart run syntaxify build
# Repeat...
```

**Desired workflow:**
```bash
$ dart run syntaxify build --watch
Watching meta/ for changes...
✓ Generated 5 files (1.2s)

[meta/button.meta.dart changed]
✓ Regenerated app_button.dart (0.3s)

[meta/login.screen.dart changed]
✓ Regenerated login_screen.dart (0.4s)
```

## Implementation Plan

### Use `watcher` Package

**Add dependency:** `pubspec.yaml`
```yaml
dependencies:
  watcher: ^1.1.0
```

### Implementation

**File:** `lib/src/cli/build_command.dart`

```dart
import 'package:watcher/watcher.dart';

BuildCommand({required this.logger}) {
  argParser
    // ... existing options
    ..addFlag(
      'watch',
      abbr: 'w',
      help: 'Watch for file changes and rebuild automatically',
      negatable: false,
      defaultsTo: false,
    );
}

Future<int> run() async {
  final watch = argResults?['watch'] as bool? ?? false;

  if (watch) {
    return await _runWatch();
  } else {
    return await _runOnce();
  }
}

Future<int> _runOnce() async {
  // Existing build logic
}

Future<int> _runWatch() async {
  logger.info('👀 Watching $metaDir/ for changes...');
  logger.info('Press Ctrl+C to stop');
  logger.info('');

  // Initial build
  await _runOnce();

  // Watch for changes
  final watcher = DirectoryWatcher(metaDir);

  await for (final event in watcher.events) {
    if (event.type == ChangeType.MODIFY || event.type == ChangeType.ADD) {
      final fileName = event.path.split('/').last;

      if (fileName.endsWith('.meta.dart') || fileName.endsWith('.screen.dart')) {
        logger.info('');
        logger.info('📝 ${event.path} changed');

        try {
          await _runOnce();
        } catch (e) {
          logger.err('Build failed: $e');
          logger.info('Waiting for next change...');
        }
      }
    }
  }

  return 0;
}
```

## Enhanced Features (Optional)

### 1. Debouncing

Prevent multiple rebuilds if multiple files change quickly:

```dart
StreamSubscription? _buildTimer;

void _scheduleBuild() {
  _buildTimer?.cancel();
  _buildTimer = Future.delayed(Duration(milliseconds: 300), _runOnce);
}
```

### 2. Selective Rebuilding

Only rebuild changed component:

```dart
if (event.path.endsWith('button.meta.dart')) {
  await generator.build(component: 'AppButton');
} else {
  await generator.build();  // Full rebuild
}
```

### 3. Clear Terminal

Clear screen before each rebuild for cleaner output:

```dart
void _clearScreen() {
  if (Platform.isWindows) {
    Process.runSync('cls', [], runInShell: true);
  } else {
    Process.runSync('clear', [], runInShell: true);
  }
}
```

### 4. Show Timestamp

```dart
logger.info('[${DateTime.now().toString().substring(11, 19)}] ✓ Build completed');
```

## Example Output

```bash
$ dart run syntaxify build --watch

🔨 Syntaxify Build (Watch Mode)
   Meta:          meta/
   Output:        lib/syntaxify/

👀 Watching meta/ for changes...
Press Ctrl+C to stop

✓ Generated 5 files (1.2s)
[12:34:56] Watching for changes...

📝 meta/button.meta.dart changed
[12:35:12] Rebuilding...
✓ Regenerated app_button.dart (0.3s)
[12:35:12] Watching for changes...

📝 meta/login.screen.dart changed
[12:36:45] Rebuilding...
✗ Build failed: Validation error in button: empty label
[12:36:45] Waiting for next change...

📝 meta/login.screen.dart changed
[12:37:02] Rebuilding...
✓ Regenerated login_screen.dart (0.4s)
[12:37:02] Watching for changes...
```

## Integration with Hot Reload

Users can run both:

**Terminal 1:**
```bash
$ dart run syntaxify build --watch
```

**Terminal 2:**
```bash
$ flutter run
```

When meta file changes:
1. Syntaxify rebuilds component
2. Flutter hot reloads with new component
3. Instant feedback!

## Files to Modify

- **ADD:** Dependency on `watcher` package
- **MODIFY:** `lib/src/cli/build_command.dart`

**Effort:** 2-3 hours
**Priority:** Low (nice to have, not critical)
**User impact:** High (significantly improves DX)

## Alternative: IDE Integration

Instead of watch mode, create IDE plugins:

- VS Code extension
- IntelliJ/Android Studio plugin

These could trigger build on save automatically.

**Effort:** 20-40 hours (much more complex)
**Priority:** Future consideration
