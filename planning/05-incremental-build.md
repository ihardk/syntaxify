# Issue #5: Incremental Build with Caching

## Status: ✅ IMPLEMENTED (Dec 2024)

## Problem Description

**Current Behavior:** Regenerates everything on every build, regardless of whether source files changed.

```bash
$ dart run syntaxify build
# Regenerates ALL components, even if nothing changed
# Slow for large projects
```

**Performance Impact:**

| Project Size | Components | Current Build Time | With Caching (Est.) |
| ------------ | ---------- | ------------------ | ------------------- |
| Small        | 5          | 2-3s               | 0.5s                |
| Medium       | 20         | 8-10s              | 1-2s                |
| Large        | 50+        | 20-30s             | 2-5s                |

**User Pain Points:**
1. Slow feedback loop during development
2. Wastes CPU cycles regenerating unchanged code
3. Git diffs show regenerated timestamps even when code identical
4. CI builds slower than necessary

## Current Implementation Analysis

### Build Flow (No Caching)

**File:** `lib/src/use_cases/build_all.dart:96-121`

```dart
// Generate each component
for (final component in components) {
  try {
    logger.info('Generating: ${component.className}');

    // ALWAYS generates, no cache check!
    final filePath = await _generateComponent.execute(
      component: component,
      outputDir: path.join(outputDir, 'generated'),
      tokens: matchingTokens,
    );

    generatedFiles.add('generated/$filePath');
    logger.success('Generated: generated/$filePath');
  } catch (e) {
    logger.err('Failed to generate ${component.className}: $e');
    errors.add('Failed to generate ${component.className}: $e');
  }
}
```

**Problems:**
- ❌ No timestamp checking
- ❌ No content hash comparison
- ❌ Regenerates even if meta file unchanged
- ❌ Regenerates even if output exists and is identical

### Screen Generation (Partial Skip Logic)

**File:** `lib/src/use_cases/generate_screen.dart`

```dart
// Screens ARE skipped if they exist (Line 87-88 in build_all.dart):
if (filePath != null) {
  generatedFiles.add(filePath);
  logger.success('Generated: $filePath');
} else {
  logger.detail('Skipped: screens/${screen.id}_screen.dart (already exists)');
}
```

**Good:** Screens check if file exists
**Bad:** No content-based checking (what if .screen.dart changed?)

## Proposed Solution

### Strategy 1: Timestamp-Based Caching (Fast, Simple)

Check file modification times:
```
If meta_file.lastModified > output_file.lastModified:
  Regenerate
Else:
  Skip
```

**Pros:**
- ✅ Fast (no file reading/hashing)
- ✅ Simple to implement
- ✅ Works with git (preserves mtimes)

**Cons:**
- ❌ Can be fooled by `touch` command
- ❌ Doesn't detect if generated code changed due to generator update

### Strategy 2: Content-Based Caching (Robust, Slower)

Hash meta file content and compare:
```
current_hash = sha256(meta_file_content + generator_version)
cached_hash = read_from_cache_file()

If current_hash != cached_hash:
  Regenerate
  Write current_hash to cache
Else:
  Skip
```

**Pros:**
- ✅ Detects content changes accurately
- ✅ Regenerates if generator version changes
- ✅ Immune to timestamp manipulation

**Cons:**
- ❌ Slightly slower (reads file content)
- ❌ Requires cache file management

### Recommended: Hybrid Approach

**Phase 1:** Timestamp check (fast path)
**Phase 2:** Content hash check (accurate path)

```dart
bool needsRegeneration(String metaFile, String outputFile, String cacheFile) {
  // Fast path: output doesn't exist
  if (!File(outputFile).exists()) return true;

  // Fast path: timestamp check
  final metaModified = File(metaFile).lastModifiedSync();
  final outputModified = File(outputFile).lastModifiedSync();

  if (metaModified.isBefore(outputModified)) {
    // Output is newer, but verify with content hash
    return !_hashMatches(metaFile, cacheFile);
  }

  // Meta file is newer, definitely regenerate
  return true;
}

bool _hashMatches(String metaFile, String cacheFile) {
  if (!File(cacheFile).exists()) return false;

  final currentHash = _computeHash(File(metaFile).readAsStringSync());
  final cachedHash = File(cacheFile).readAsStringSync();

  return currentHash == cachedHash;
}

String _computeHash(String content) {
  final versionedContent = '$content\n__VERSION__:$generatorVersion';
  return sha256.convert(utf8.encode(versionedContent)).toString();
}
```

## Implementation Plan

### Phase 1: Core Caching Infrastructure (4-5 hours)

**1. Create BuildCache Model**

**File:** `lib/src/models/build_cache.dart` (NEW)

```dart
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'build_cache.freezed.dart';
part 'build_cache.g.dart';

/// Represents the build cache for a single component
@freezed
class CacheEntry with _$CacheEntry {
  const factory CacheEntry({
    /// Content hash of the meta file
    required String contentHash,

    /// Generator version used
    required String generatorVersion,

    /// Timestamp of last generation
    required DateTime generatedAt,

    /// Output file path
    required String outputPath,
  }) = _CacheEntry;

  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);
}

/// Manages build cache storage and retrieval
class BuildCache {
  BuildCache({
    required this.cacheDir,
    required this.generatorVersion,
  });

  final String cacheDir;
  final String generatorVersion;

  /// Checks if regeneration is needed
  Future<bool> needsRegeneration({
    required String metaFilePath,
    required String outputFilePath,
  }) async {
    // Fast path: output doesn't exist
    final outputFile = File(outputFilePath);
    if (!await outputFile.exists()) return true;

    // Fast path: timestamp check
    final metaFile = File(metaFilePath);
    final metaModified = await metaFile.lastModified();
    final outputModified = await outputFile.lastModified();

    if (metaModified.isBefore(outputModified)) {
      // Output is newer, check content hash
      final entry = await _loadCacheEntry(metaFilePath);
      if (entry == null) return true;

      // Check if generator version changed
      if (entry.generatorVersion != generatorVersion) return true;

      // Check if content hash matches
      final currentHash = await _computeHash(metaFilePath);
      return currentHash != entry.contentHash;
    }

    // Meta file is newer than output
    return true;
  }

  /// Records successful generation in cache
  Future<void> recordGeneration({
    required String metaFilePath,
    required String outputFilePath,
  }) async {
    final hash = await _computeHash(metaFilePath);
    final entry = CacheEntry(
      contentHash: hash,
      generatorVersion: generatorVersion,
      generatedAt: DateTime.now(),
      outputPath: outputFilePath,
    );

    await _saveCacheEntry(metaFilePath, entry);
  }

  /// Clears all cache entries
  Future<void> clear() async {
    final dir = Directory(cacheDir);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  // Private methods

  Future<String> _computeHash(String filePath) async {
    final content = await File(filePath).readAsString();
    final versionedContent = '$content\n__VERSION__:$generatorVersion';
    final bytes = utf8.encode(versionedContent);
    return sha256.convert(bytes).toString();
  }

  Future<CacheEntry?> _loadCacheEntry(String metaFilePath) async {
    final cacheFile = _getCacheFilePath(metaFilePath);
    if (!await File(cacheFile).exists()) return null;

    try {
      final content = await File(cacheFile).readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;
      return CacheEntry.fromJson(json);
    } catch (e) {
      // Invalid cache file, treat as no cache
      return null;
    }
  }

  Future<void> _saveCacheEntry(String metaFilePath, CacheEntry entry) async {
    await Directory(cacheDir).create(recursive: true);

    final cacheFile = _getCacheFilePath(metaFilePath);
    final json = jsonEncode(entry.toJson());
    await File(cacheFile).writeAsString(json);
  }

  String _getCacheFilePath(String metaFilePath) {
    // Create cache filename from meta file path
    // Example: meta/button.meta.dart -> .syntaxify-cache/button_meta.json
    final basename = metaFilePath.split('/').last.replaceAll('.dart', '.json');
    return '$cacheDir/$basename';
  }
}
```

**2. Integrate with BuildAllUseCase**

**File:** `lib/src/use_cases/build_all.dart`

```dart
import 'package:syntaxify/src/models/build_cache.dart';

class BuildAllUseCase {
  // ...

  Future<BuildResult> execute({
    required List<ComponentDefinition> components,
    required List<ScreenDefinition> screens,
    required List<TokenDefinition> tokens,
    required String outputDir,
    required String metaDirectoryPath,
    String? designSystemDir,
    bool useCache = true,  // NEW: Allow disabling cache
  }) async {
    // ...

    // NEW: Initialize build cache
    final cache = BuildCache(
      cacheDir: '.syntaxify-cache',
      generatorVersion: '0.1.0-alpha.8',  // From pubspec
    );

    // Generate each component
    for (final component in components) {
      try {
        final metaFilePath = '$metaDirectoryPath/${component.className.toLowerCase()}.meta.dart';
        final componentName = component.explicitName ?? component.className.replaceAll('Meta', '');
        final outputFilePath = path.join(
          outputDir,
          'generated',
          'components',
          'app_${componentName.toLowerCase()}.dart',
        );

        // NEW: Check cache
        if (useCache && !await cache.needsRegeneration(
          metaFilePath: metaFilePath,
          outputFilePath: outputFilePath,
        )) {
          logger.detail('Cached: ${component.className}');
          generatedFiles.add('generated/components/app_${componentName.toLowerCase()}.dart');
          continue;
        }

        logger.info('Generating: ${component.className}');

        final matchingTokens = tokens.where((t) =>
          t.componentName.toLowerCase() ==
          component.className.replaceAll('Meta', '').toLowerCase(),
        ).firstOrNull;

        final filePath = await _generateComponent.execute(
          component: component,
          outputDir: path.join(outputDir, 'generated'),
          tokens: matchingTokens,
        );

        // NEW: Record in cache
        await cache.recordGeneration(
          metaFilePath: metaFilePath,
          outputFilePath: outputFilePath,
        );

        generatedFiles.add('generated/$filePath');
        logger.success('Generated: generated/$filePath');
      } catch (e) {
        logger.err('Failed to generate ${component.className}: $e');
        errors.add('Failed to generate ${component.className}: $e');
      }
    }

    // ... rest of code
  }
}
```

**3. Add CLI Options**

**File:** `lib/src/cli/build_command.dart`

```dart
BuildCommand({required this.logger}) {
  argParser
    // ... existing options
    ..addFlag(
      'no-cache',
      help: 'Disable build cache (regenerate everything)',
      negatable: false,
      defaultsTo: false,
    )
    ..addFlag(
      'clean-cache',
      help: 'Clear build cache before building',
      negatable: false,
      defaultsTo: false,
    );
}

Future<int> run() async {
  final useCache = !(argResults?['no-cache'] as bool? ?? false);
  final cleanCache = argResults?['clean-cache'] as bool? ?? false;

  // NEW: Clean cache if requested
  if (cleanCache) {
    logger.info('Cleaning build cache...');
    final cache = BuildCache(
      cacheDir: '.syntaxify-cache',
      generatorVersion: '0.1.0-alpha.8',
    );
    await cache.clear();
    logger.success('Cache cleared');
  }

  // ... existing build code

  final result = await generator.build(
    component: component,
    theme: theme,
    useCache: useCache,  // NEW
  );

  // ...
}
```

**4. Update .gitignore**

**File:** `.gitignore` (UPDATE)

```
# Existing entries...

# Syntaxify build cache
.syntaxify-cache/
```

### Phase 2: Enhanced Caching (2-3 hours)

**5. Add Cache Statistics**

```dart
class BuildResult {
  // ... existing fields
  final int cachedFiles;  // NEW
  final int regeneratedFiles;  // NEW
}
```

Show stats after build:
```bash
$ dart run syntaxify build
✓ Generated 2 files, cached 15 files (120ms)
```

**6. Add Cache Debugging**

```bash
$ dart run syntaxify build --verbose
Checking cache for button.meta.dart...
  ✓ Output exists
  ✓ Timestamp: output newer
  ✓ Content hash matches
  → Using cached version

Checking cache for text.meta.dart...
  ✗ Generator version changed (0.1.0 → 0.1.1)
  → Regenerating
```

### Phase 3: Advanced Features (Low Priority)

**7. Parallel Cache Checking**

Use `Future.wait()` to check cache for multiple files in parallel:

```dart
final cacheChecks = await Future.wait(
  components.map((c) => cache.needsRegeneration(
    metaFilePath: '...',
    outputFilePath: '...',
  )),
);
```

**8. Dependency Tracking**

Track when design system files change:

```dart
class CacheEntry {
  // ...
  final List<String> dependencies;  // NEW
}

// Invalidate cache if design system changed
if (designSystemModified) {
  await cache.clear();
}
```

## Testing Strategy

**File:** `test/build_cache_test.dart` (NEW)

```dart
import 'package:test/test.dart';
import 'package:syntaxify/src/models/build_cache.dart';
import 'dart:io';

void main() {
  late Directory tempDir;
  late BuildCache cache;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cache_test_');
    cache = BuildCache(
      cacheDir: '${tempDir.path}/.cache',
      generatorVersion: '1.0.0',
    );
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('BuildCache', () {
    test('needsRegeneration returns true when output missing', () async {
      final metaFile = File('${tempDir.path}/button.meta.dart');
      await metaFile.writeAsString('class ButtonMeta {}');

      final needsRegen = await cache.needsRegeneration(
        metaFilePath: metaFile.path,
        outputFilePath: '${tempDir.path}/app_button.dart',
      );

      expect(needsRegen, isTrue);
    });

    test('needsRegeneration returns false when cache valid', () async {
      final metaFile = File('${tempDir.path}/button.meta.dart');
      await metaFile.writeAsString('class ButtonMeta {}');

      final outputFile = File('${tempDir.path}/app_button.dart');
      await outputFile.writeAsString('class AppButton {}');

      // Record generation
      await cache.recordGeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      // Wait to ensure timestamp difference
      await Future.delayed(Duration(milliseconds: 100));

      // Touch output file to make it newer
      await outputFile.setLastModified(DateTime.now());

      final needsRegen = await cache.needsRegeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      expect(needsRegen, isFalse);
    });

    test('needsRegeneration returns true when content changes', () async {
      final metaFile = File('${tempDir.path}/button.meta.dart');
      await metaFile.writeAsString('class ButtonMeta {}');

      final outputFile = File('${tempDir.path}/app_button.dart');
      await outputFile.writeAsString('class AppButton {}');

      await cache.recordGeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      // Modify meta file
      await metaFile.writeAsString('class ButtonMeta { String label; }');

      final needsRegen = await cache.needsRegeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      expect(needsRegen, isTrue);
    });

    test('needsRegeneration returns true when generator version changes', () async {
      final metaFile = File('${tempDir.path}/button.meta.dart');
      await metaFile.writeAsString('class ButtonMeta {}');

      final outputFile = File('${tempDir.path}/app_button.dart');
      await outputFile.writeAsString('class AppButton {}');

      await cache.recordGeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      // Create cache with different version
      final newCache = BuildCache(
        cacheDir: '${tempDir.path}/.cache',
        generatorVersion: '2.0.0',  // Different version!
      );

      final needsRegen = await newCache.needsRegeneration(
        metaFilePath: metaFile.path,
        outputFilePath: outputFile.path,
      );

      expect(needsRegen, isTrue);
    });
  });
}
```

## Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  crypto: ^3.0.3  # For SHA-256 hashing
```

## CLI Usage

**Default (with caching):**
```bash
$ dart run syntaxify build
✓ Generated 3 files, cached 15 files (800ms)
```

**Force regenerate everything:**
```bash
$ dart run syntaxify build --no-cache
✓ Generated 18 files (2.4s)
```

**Clean cache and rebuild:**
```bash
$ dart run syntaxify build --clean-cache
Cleaning build cache...
✓ Cache cleared
✓ Generated 18 files (2.5s)
```

**Verbose output:**
```bash
$ dart run syntaxify build --verbose
Checking cache for button.meta.dart...
  ✓ Using cached version
Checking cache for text.meta.dart...
  ✗ Content changed
  → Regenerating
...
```

## Benefits

1. ✅ **Faster builds** - 5-10x faster for unchanged projects
2. ✅ **Better DX** - Quick iteration during development
3. ✅ **CI optimization** - Faster CI builds
4. ✅ **Explicit control** - `--no-cache` when needed
5. ✅ **Accurate** - Content-based caching detects real changes

## Edge Cases

### 1. Git Checkout Changes Branch
**Problem:** Timestamps might be wrong after git checkout
**Solution:** Content hash catches this

### 2. Generator Updated
**Problem:** New generator version might produce different code
**Solution:** Version is part of cache key, forces regeneration

### 3. Design System Files Change
**Problem:** Component code depends on design system
**Solution:** Track design system as dependency (Phase 3)

### 4. Manual Edits to Generated Files
**Problem:** User edits generated component (bad practice)
**Solution:** Regeneration overwrites, same as current behavior

## Performance Benchmarks (Estimated)

**Test Project:** 20 components, no changes

| Approach           | Time | Speedup |
| ------------------ | ---- | ------- |
| No cache (current) | 10s  | 1x      |
| Timestamp check    | 1.5s | 6.7x    |
| Content hash       | 2s   | 5x      |
| Hybrid (proposed)  | 1.2s | 8.3x    |

**Test Project:** 20 components, 1 changed

| Approach           | Time |
| ------------------ | ---- |
| No cache (current) | 10s  |
| With cache         | 1.8s |

## Conclusion

**NEEDS IMPLEMENTATION** - Medium Priority

This is a quality-of-life improvement that becomes critical as projects scale.

**Estimated effort:** 9-11 hours for full implementation
**Priority:** Medium (works fine without it, but significantly improves DX)

**Recommended approach:**
1. Start with Phase 1 (core caching) - immediate value
2. Add Phase 2 (statistics) - nice to have
3. Phase 3 (advanced) - only if users request

## Files to Create/Modify

**New:**
1. `lib/src/models/build_cache.dart`
2. `test/build_cache_test.dart`

**Modified:**
3. `lib/src/use_cases/build_all.dart`
4. `lib/src/cli/build_command.dart`
5. `pubspec.yaml` (add crypto dependency)
6. `.gitignore` (add .syntaxify-cache/)
