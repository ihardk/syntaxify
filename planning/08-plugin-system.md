# Issue #8: No Plugin System

## Status: ❌ NOT IMPLEMENTED (Medium Priority)

## Problem

Users can't add custom generators without forking the codebase.

**Current:** To add a Card generator, user must:
1. Fork syntaxify repo
2. Create `lib/src/generators/component/card_generator.dart`
3. Register in `generator_registry.dart`
4. Maintain fork

**Should be:**
```dart
// my_project/plugins/card_generator.dart
class CardGenerator implements ComponentGenerator {
  @override
  String generate(ComponentDefinition def, TokenDefinition? tokens) {
    // Custom card generation
  }
}

// Register in project
// syntaxify.yaml
plugins:
  - plugins/card_generator.dart
```

Or:
```dart
// API in code
void main() {
  Syntaxify()
    ..registerGenerator('Card', CardGenerator())
    ..build();
}
```

## Design Options

### Option 1: Dart Plugin Files

Users write Dart files implementing `ComponentGenerator` interface.

**Pros:**
- Type-safe
- Full Dart language support
- Can use packages

**Cons:**
- Requires compilation
- Complex loading mechanism

### Option 2: Configuration-Based Plugins

YAML/JSON templates that define generation rules.

**Pros:**
- No compilation needed
- Simpler for basic cases

**Cons:**
- Limited expressiveness
- Can't handle complex logic

### Recommended: Option 1 (Dart Plugins)

## Implementation Plan

1. **Define plugin interface**
   ```dart
   abstract class SyntaxifyPlugin {
     String get name;
     String get version;
     ComponentGenerator? createGenerator(String componentType);
   }
   ```

2. **Add plugin loader**
   ```dart
   class PluginLoader {
     Future<List<SyntaxifyPlugin>> load(String pluginDir);
   }
   ```

3. **Integrate with registry**
   ```dart
   final registry = GeneratorRegistry();

   // Load built-in generators
   registry.register(ButtonGenerator());

   // Load plugins
   final plugins = await PluginLoader().load('plugins/');
   for (final plugin in plugins) {
     registry.register(plugin.createGenerator());
   }
   ```

4. **Add CLI support**
   ```bash
   syntaxify build --plugins=plugins/
   ```

**Files:**
- NEW: `lib/src/plugins/plugin_interface.dart`
- NEW: `lib/src/plugins/plugin_loader.dart`
- MODIFY: `lib/src/generators/generator_registry.dart`
- MODIFY: `lib/src/cli/build_command.dart`

**Effort:** 8-10 hours
**Priority:** Medium (extends functionality significantly)
**Complexity:** High (requires isolate loading or similar)
