# Issue #11: Config File Would Be Better

## Status: ❌ NOT IMPLEMENTED (Low Priority)

## Problem

Configuration only via CLI flags:

**Current:**
```bash
$ dart run syntaxify build \
    --meta=specs \
    --output=lib/gen \
    --design-system=lib/ds \
    --tokens=lib/ds
```

Gets tedious to type repeatedly.

**Should support:**
```yaml
# syntaxify.yaml
meta_dir: specs
output_dir: lib/gen
design_system_dir: lib/ds

components:
  - button
  - input
  - text

styles:
  - material
  - cupertino
  - custom: my_style.dart

validation:
  strict: true
  allow_empty_labels: false
```

Then:
```bash
$ dart run syntaxify build  # Reads syntaxify.yaml
```

## Benefits

1. **Cleaner commands** - No long flag lists
2. **Shareable config** - Commit to git, whole team uses same settings
3. **More options** - Can have options that are too complex for CLI flags
4. **Defaults** - Override only what you need

## Implementation Plan

### 1. Add YAML Dependency

**pubspec.yaml:**
```yaml
dependencies:
  yaml: ^3.1.2
```

### 2. Create Config Model

**File:** `lib/src/config/syntaxify_config.dart` (NEW)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';

part 'syntaxify_config.freezed.dart';

@freezed
class SyntaxifyConfig with _$SyntaxifyConfig {
  const factory SyntaxifyConfig({
    @Default('meta') String metaDir,
    @Default('lib/syntaxify') String outputDir,
    @Default('lib/syntaxify/design_system') String designSystemDir,
    @Default([]) List<String> components,
    @Default([]) List<String> styles,
    @Default(true) bool cache,
    @Default(false) bool strict,
  }) = _SyntaxifyConfig;

  /// Load config from syntaxify.yaml
  static SyntaxifyConfig load([String path = 'syntaxify.yaml']) {
    final file = File(path);

    if (!file.existsSync()) {
      return const SyntaxifyConfig();  // Use defaults
    }

    final yamlString = file.readAsStringSync();
    final yamlDoc = loadYaml(yamlString) as Map;

    return SyntaxifyConfig(
      metaDir: yamlDoc['meta_dir'] as String? ?? 'meta',
      outputDir: yamlDoc['output_dir'] as String? ?? 'lib/syntaxify',
      designSystemDir: yamlDoc['design_system_dir'] as String? ?? 'lib/syntaxify/design_system',
      components: (yamlDoc['components'] as List?)?.cast<String>() ?? [],
      styles: (yamlDoc['styles'] as List?)?.cast<String>() ?? [],
      cache: yamlDoc['cache'] as bool? ?? true,
      strict: yamlDoc['strict'] as bool? ?? false,
    );
  }

  /// Save config to syntaxify.yaml
  void save([String path = 'syntaxify.yaml']) {
    final yaml = '''
# Syntaxify Configuration
# Learn more: https://github.com/ihardk/syntaxify

# Directories
meta_dir: $metaDir
output_dir: $outputDir
design_system_dir: $designSystemDir

# Components to generate (empty = all)
components: ${components.isEmpty ? '[]' : '\n  - ${components.join('\n  - ')}'}

# Styles to include
styles: ${styles.isEmpty ? '[]' : '\n  - ${styles.join('\n  - ')}'}

# Build options
cache: $cache

# Validation
strict: $strict
''';

    File(path).writeAsStringSync(yaml);
  }
}
```

### 3. Integrate with BuildCommand

**File:** `lib/src/cli/build_command.dart`

```dart
Future<int> run() async {
  // NEW: Load config file
  final config = SyntaxifyConfig.load();

  // CLI flags override config file
  final metaDir = argResults?['meta'] as String? ?? config.metaDir;
  final outputDir = argResults?['output'] as String? ?? config.outputDir;
  final designSystemDir = argResults?['design-system'] as String? ?? config.designSystemDir;

  // ... rest of build logic
}
```

### 4. Add `init` Command to Generate Config

**File:** `lib/src/cli/init_command.dart`

```dart
Future<int> run() async {
  // ... existing init logic

  // NEW: Generate syntaxify.yaml
  if (logger.confirm('Generate syntaxify.yaml config file?')) {
    final config = SyntaxifyConfig();
    config.save();
    logger.success('Created syntaxify.yaml');
  }

  return 0;
}
```

## Example Config File

**syntaxify.yaml:**
```yaml
# Syntaxify Configuration
# Learn more: https://github.com/ihardk/syntaxify

# Directories
meta_dir: specs
output_dir: lib/generated
design_system_dir: lib/design_system

# Components to generate (empty = all)
components:
  - button
  - input
  - text
  - card

# Styles to include
styles:
  - material
  - cupertino
  - neo

# Build options
cache: true
watch: false

# Validation
strict: true
allow_empty_children: false

# Plugins (future feature)
plugins:
  - plugins/card_generator.dart
```

## Priority of Configuration

1. **CLI flags** (highest priority)
2. **syntaxify.yaml**
3. **Defaults** (lowest priority)

Example:
```bash
# Uses meta_dir from syntaxify.yaml, but overrides output_dir
$ dart run syntaxify build --output=lib/gen
```

## CLI Usage

**With config file:**
```bash
$ dart run syntaxify build  # Uses syntaxify.yaml
```

**Override specific options:**
```bash
$ dart run syntaxify build --no-cache
```

**Ignore config file:**
```bash
$ dart run syntaxify build --ignore-config
```

## Files to Create/Modify

**New:**
1. `lib/src/config/syntaxify_config.dart`
2. `lib/src/config/syntaxify_config.freezed.dart`
3. `docs/configuration.md` (documentation)

**Modified:**
4. `lib/src/cli/build_command.dart`
5. `lib/src/cli/init_command.dart`
6. `pubspec.yaml` (add yaml dependency)

**Effort:** 3-4 hours
**Priority:** Low (CLI works fine)
**User benefit:** Medium (convenience, not necessity)

## Alternative: Analysis Options Style

Use `analysis_options.yaml` style (dart convention):

**build.yaml:**
```yaml
syntaxify:
  meta_dir: specs
  output_dir: lib/gen
```

Pros: Familiar to Dart developers
Cons: Conflicts with build_runner's build.yaml
