# Refactor Plan: Single-File Architecture (Freezed Pattern)

**Goal:** Migrate from scattered multi-folder architecture to single-file Freezed-pattern architecture.

**Impact:** Major refactor affecting generator core, file structure, and build pipeline.

---

## Executive Summary

### Current State
- Components scattered across 10+ files
- Unclear separation between editable/generated
- Multiple directories (meta/, design_system/, generated/)
- 240+ files for 20 components

### Target State
- 2 files per component (component.dart + component.generated.dart)
- Clear Freezed-like pattern
- 42 files for 20 components (82% reduction)
- Simple mental model

### Timeline
- **Phase 1:** Foundation work (1-2 days)
- **Phase 2:** Generator refactor (2-3 days)
- **Phase 3:** Migration (1 day)
- **Phase 4:** Testing & validation (1 day)
- **Total:** 5-7 days

### Risk Level
- **Medium-High** - Major architectural change
- **Mitigation:** Phased rollout, maintain backward compatibility during transition

---

## Current State Analysis

### File Organization (Text Component Example)

```
Current Structure:
generator/
├── meta/
│   └── text.meta.dart                              # 1 file
├── design_system/
│   ├── variants/
│   │   └── text_variant.dart                       # 1 file (manual)
│   ├── tokens/
│   │   └── text_tokens.dart                        # 1 file (copied)
│   ├── components/text/
│   │   ├── material_renderer.dart                  # 1 file (copied)
│   │   ├── cupertino_renderer.dart                 # 1 file (copied)
│   │   └── neo_renderer.dart                       # 1 file (copied)
│   ├── design_system.dart                          # 1 file (generated)
│   ├── design_style.dart                           # 1 file (generated)
│   └── styles/
│       ├── material_style.dart                     # 1 file (generated)
│       ├── cupertino_style.dart                    # 1 file (generated)
│       └── neo_style.dart                          # 1 file (generated)
└── example/lib/syntaxify/
    ├── generated/
    │   ├── components/
    │   │   └── app_text.dart                       # 1 file (generated)
    │   └── variants/
    │       └── text_variant.dart                   # 1 file (generated)
    └── design_system/
        └── (copied from generator/design_system/)

Total: 12 files per component
```

### Current Build Pipeline

```
BuildAllUseCase.execute()
  ├─ Phase 1: Generate Components (generateAllComponents)
  │   └─ Generates: generated/components/app_text.dart
  │
  ├─ Phase 2: Generate Enum Variants (generateEnumVariants)
  │   └─ Generates: design_system/variants/text_variant.dart (BUG: wrong path)
  │
  ├─ Phase 3: Copy Design System Files (copyDesignSystemFiles)
  │   └─ Copies: design_system/ entire directory
  │
  ├─ Phase 4: Generate Design System Code (generateDesignSystemCode)
  │   └─ Generates: design_system.dart, design_style.dart, styles/*.dart
  │
  └─ Phase 5: Handle Tokens (handleTokens)
      └─ Copies: token files with import path updates
```

---

## Target State Design

### File Organization (Text Component Example)

```
Target Structure:
example/lib/syntaxify/
├── foundation.dart                                  # ✏️ All foundations
├── foundation.generated.dart                        # 🤖 Generated helpers
│
├── text.dart                                        # ✏️ Meta + Tokens + Renderers
├── text.generated.dart                              # 🤖 Variant + AppText wrapper
│
├── button.dart                                      # ✏️ Everything for button
├── button.generated.dart                            # 🤖 Generated
│
└── design_system.generated.dart                     # 🤖 Integration

Total: 2 files per component + 3 shared files
```

### text.dart Structure

```dart
// lib/syntaxify/text.dart
import 'package:flutter/material.dart';
part 'text.generated.dart';

// Section 1: Meta (from meta/text.meta.dart)
@SyntaxComponent(variants: [...])
class TextMeta { }

// Section 2: Tokens (from design_system/tokens/text_tokens.dart)
class TextTokens {
  factory TextTokens.fromFoundation(...) { }
}

// Section 3: Renderers (from design_system/components/text/*.dart)
mixin MaterialTextRenderer on DesignStyle { }
mixin CupertinoTextRenderer on DesignStyle { }
mixin NeoTextRenderer on DesignStyle { }
```

### text.generated.dart Structure

```dart
// lib/syntaxify/text.generated.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'text.dart';

// Section 1: Variant Enum (from variants/text_variant.dart)
enum TextVariant { displayLarge, bodyMedium, ... }

// Section 2: Component Wrapper (from generated/components/app_text.dart)
class AppText extends StatelessWidget { }
```

### New Build Pipeline

```
BuildAllUseCase.execute()
  └─ For each component:
      ├─ Parse meta file
      ├─ Read template (if exists in generator/templates/)
      ├─ Generate component.dart (merge meta + template)
      └─ Generate component.generated.dart (variant + wrapper)

  └─ Generate integration:
      ├─ foundation.generated.dart
      └─ design_system.generated.dart
```

---

## Migration Strategy

### Phase 1: Foundation Work (Preparation)

**Goal:** Set up new structure without breaking existing code.

#### 1.1 Create Template System

**New directory:**
```
generator/
└── templates/
    ├── foundation.template.dart
    ├── text.template.dart
    ├── button.template.dart
    └── ... (templates for each component)
```

**Template format (text.template.dart):**
```dart
// TEMPLATE: Text Component
// Merged with meta/text.meta.dart during generation

import 'package:flutter/material.dart';
part '{component_name}.generated.dart';

// Tokens implementation
class {ComponentName}Tokens {
  factory {ComponentName}Tokens.fromFoundation(
    FoundationTokens foundation, {
    required {ComponentName}Variant variant,
  }) {
    // Template implementation
  }
}

// Material Renderer
mixin Material{ComponentName}Renderer on DesignStyle {
  @override
  Widget render{ComponentName}({...}) {
    // Template implementation
  }
}

// Cupertino Renderer
mixin Cupertino{ComponentName}Renderer on DesignStyle {
  // Template implementation
}

// Neo Renderer
mixin Neo{ComponentName}Renderer on DesignStyle {
  // Template implementation
}
```

**Tasks:**
- [ ] Create `generator/templates/` directory
- [ ] Extract token logic from existing `design_system/tokens/*.dart` to templates
- [ ] Extract renderer logic from existing `design_system/components/*/*.dart` to templates
- [ ] Create template merger utility

**Files affected:**
- New: `generator/templates/` (20 files)
- New: `lib/src/services/template_service.dart`

---

#### 1.2 Create Foundation Consolidation

**Consolidate all foundation tokens into one file:**

```dart
// generator/templates/foundation.template.dart

import 'package:flutter/material.dart';
part 'foundation.generated.dart';

class FoundationTokens {
  // All token properties
}

// Material Foundation
final materialFoundation = FoundationTokens(...);

// Cupertino Foundation
final cupertinoFoundation = FoundationTokens(...);

// Neo Foundation
final neoFoundation = FoundationTokens(...);
```

**Tasks:**
- [ ] Create consolidated `foundation.template.dart`
- [ ] Merge from: `design_system/tokens/foundation/*.dart`
- [ ] Test foundation tokens work identically

**Files affected:**
- New: `generator/templates/foundation.template.dart`
- Read from: `design_system/tokens/foundation/foundation_tokens.dart`
- Read from: `design_system/tokens/foundation/material_foundation.dart`
- Read from: `design_system/tokens/foundation/cupertino_foundation.dart`
- Read from: `design_system/tokens/foundation/neo_foundation.dart`

---

#### 1.3 Update Meta Parser

**Enhance ComponentExtractor to extract additional metadata:**

```dart
class ComponentDefinition {
  // Existing fields
  final String name;
  final List<String> variants;
  final List<PropertyDefinition> properties;

  // New fields
  final List<String> supportedDesignSystems;  // For selective implementation
  final String? templatePath;                  // Path to template file
  final Map<String, dynamic> templateConfig;   // Template-specific config
}
```

**Tasks:**
- [ ] Add `supportedDesignSystems` to `@SyntaxComponent` annotation
- [ ] Update `ComponentExtractor` to parse new fields
- [ ] Add template path resolution logic

**Files affected:**
- Modify: `lib/src/parser/extractors/component_extractor.dart`
- Modify: `lib/src/models/component_definition.dart`
- Modify: `lib/syntaxify.dart` (annotation)

---

### Phase 2: Generator Refactor

**Goal:** Build new generators without breaking existing ones.

#### 2.1 Create SingleFileComponentGenerator

**New generator that produces component.dart:**

```dart
class SingleFileComponentGenerator {
  /// Generate component.dart from meta + template
  ///
  /// Steps:
  /// 1. Parse meta file (get @SyntaxComponent, properties, variants)
  /// 2. Load template (text.template.dart)
  /// 3. Merge meta + template
  /// 4. Output component.dart
  String generate({
    required ComponentDefinition component,
    String? templatePath,
  }) {
    final template = _loadTemplate(templatePath ?? _defaultTemplate(component));
    final merged = _mergeMetaAndTemplate(component, template);
    return _formatCode(merged);
  }

  String _mergeMetaAndTemplate(ComponentDefinition component, Template template) {
    return '''
// lib/syntaxify/${component.name.toLowerCase()}.dart
import 'package:flutter/material.dart';
part '${component.name.toLowerCase()}.generated.dart';

// META (from meta/${component.name.toLowerCase()}.meta.dart)
@SyntaxComponent(
  variants: ${component.variants},
)
class ${component.className} {
  ${_generateProperties(component.properties)}
}

// TOKENS (from template)
${template.tokensSection}

// RENDERERS (from template)
${template.renderersSection}
''';
  }
}
```

**Tasks:**
- [ ] Create `lib/src/generators/single_file_component_generator.dart`
- [ ] Implement template loading
- [ ] Implement meta + template merging
- [ ] Add code formatting

**Files affected:**
- New: `lib/src/generators/single_file_component_generator.dart`
- New: `lib/src/generators/template_merger.dart`

---

#### 2.2 Update ComponentGeneratedFileGenerator

**Enhance existing generator to produce component.generated.dart:**

```dart
class ComponentGeneratedFileGenerator {
  /// Generate component.generated.dart
  ///
  /// Contains:
  /// 1. Variant enum (from meta variants: [...])
  /// 2. AppComponent wrapper (from meta properties)
  String generate({
    required ComponentDefinition component,
  }) {
    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
part of '${component.name.toLowerCase()}.dart';

// VARIANT ENUM
${_generateVariantEnum(component)}

// COMPONENT WRAPPER
${_generateComponentWrapper(component)}
''';
  }
}
```

**Tasks:**
- [ ] Refactor existing component generator
- [ ] Split into two outputs: `.dart` and `.generated.dart`
- [ ] Add part/part of directives

**Files affected:**
- Modify: `lib/src/generators/component_generator.dart`

---

#### 2.3 Create IntegrationGenerator

**Generate design_system.generated.dart:**

```dart
class IntegrationGenerator {
  /// Generate design_system.generated.dart
  ///
  /// Contains:
  /// 1. All component imports
  /// 2. All component exports
  /// 3. DesignStyle sealed class
  /// 4. Style classes (Material, Cupertino, Neo, ...)
  /// 5. AppTheme widget
  String generate({
    required List<ComponentDefinition> components,
  }) {
    final designSystems = _detectDesignSystems(components);

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
library design_system;

// Component imports
${_generateImports(components)}

// Component exports
${_generateExports(components)}

// DesignStyle sealed class
${_generateDesignStyle(components)}

// Style classes
${_generateStyleClasses(components, designSystems)}

// AppTheme
${_generateAppTheme()}
''';
  }

  Set<String> _detectDesignSystems(List<ComponentDefinition> components) {
    // Scan for *Renderer mixins
    // Extract design system names (Material, Cupertino, Neo, Fluent, ...)
    // Return unique set
  }
}
```

**Tasks:**
- [ ] Create `lib/src/generators/integration_generator.dart`
- [ ] Implement design system detection (scan for `*Renderer` mixins)
- [ ] Generate style classes dynamically
- [ ] Add AppTheme widget generation

**Files affected:**
- New: `lib/src/generators/integration_generator.dart`

---

#### 2.4 Update BuildAllUseCase

**Refactor build pipeline:**

```dart
class BuildAllUseCase {
  Future<BuildResult> execute({
    required List<ComponentDefinition> components,
    required String outputDir,
  }) async {
    final generatedFiles = <String>[];

    // Step 1: Generate foundation files
    final foundationFiles = await _generateFoundation(outputDir);
    generatedFiles.addAll(foundationFiles);

    // Step 2: Generate component files
    for (final component in components) {
      // Generate component.dart (meta + template)
      final componentFile = await _singleFileGenerator.generate(
        component: component,
        outputPath: '$outputDir/${component.name.toLowerCase()}.dart',
      );
      generatedFiles.add(componentFile);

      // Generate component.generated.dart (variant + wrapper)
      final generatedFile = await _componentGeneratedGenerator.generate(
        component: component,
        outputPath: '$outputDir/${component.name.toLowerCase()}.generated.dart',
      );
      generatedFiles.add(generatedFile);
    }

    // Step 3: Generate integration file
    final integrationFile = await _integrationGenerator.generate(
      components: components,
      outputPath: '$outputDir/design_system.generated.dart',
    );
    generatedFiles.add(integrationFile);

    return BuildResult(filesGenerated: generatedFiles);
  }
}
```

**Tasks:**
- [ ] Refactor `BuildAllUseCase.execute()`
- [ ] Remove old phases (copyDesignSystemFiles, handleTokens, etc.)
- [ ] Add new generators (SingleFileComponentGenerator, IntegrationGenerator)
- [ ] Update file output paths

**Files affected:**
- Modify: `lib/src/use_cases/build_all.dart`
- Remove: `lib/src/services/design_system_service.dart` (obsolete)

---

### Phase 3: Migration

**Goal:** Migrate existing components to new structure.

#### 3.1 Create Migration Script

**Automated migration tool:**

```dart
// tool/migrate_to_single_file.dart

void main() async {
  final migrator = ComponentMigrator();

  // Migrate each component
  for (final component in ['text', 'button', 'card', ...]) {
    await migrator.migrate(component);
  }

  print('Migration complete!');
}

class ComponentMigrator {
  Future<void> migrate(String componentName) async {
    // 1. Read meta file
    final meta = await _readMeta('meta/${componentName}.meta.dart');

    // 2. Read tokens
    final tokens = await _readTokens(
      'design_system/tokens/${componentName}_tokens.dart'
    );

    // 3. Read renderers
    final renderers = await _readRenderers(
      'design_system/components/$componentName/'
    );

    // 4. Create component.dart (merge meta + tokens + renderers)
    await _createComponentFile(
      'lib/syntaxify/${componentName}.dart',
      meta: meta,
      tokens: tokens,
      renderers: renderers,
    );

    // 5. Delete old files
    await _deleteOldFiles(componentName);

    print('✅ Migrated $componentName');
  }
}
```

**Tasks:**
- [ ] Create migration script
- [ ] Test on one component (text)
- [ ] Run migration on all 20 components
- [ ] Verify generated files are identical

**Files affected:**
- New: `tool/migrate_to_single_file.dart`

---

#### 3.2 Update Example App

**Rebuild example app with new structure:**

```bash
cd generator/example
rm -rf lib/syntaxify/  # Clean slate
cd ..
dart run syntaxify build  # Regenerate with new architecture
```

**Tasks:**
- [ ] Clean example app
- [ ] Run new build
- [ ] Verify all components work
- [ ] Test theme switching
- [ ] Run all screens

**Files affected:**
- Regenerate: `example/lib/syntaxify/` (entire directory)

---

#### 3.3 Update Documentation

**Update all docs to reflect new structure:**

- [ ] README.md - Update file structure examples
- [ ] CLAUDE.md - Update architecture section
- [ ] docs/user_manual.md - Update "Adding Components" section
- [ ] docs/developer_manual.md - Update generator architecture
- [ ] docs/api-reference.md - Update import paths

**Files affected:**
- Modify: `README.md`
- Modify: `CLAUDE.md`
- Modify: `docs/*.md`

---

### Phase 4: Testing & Validation

**Goal:** Ensure new architecture works correctly.

#### 4.1 Unit Tests

**Test new generators:**

```dart
// test/generators/single_file_component_generator_test.dart
test('generates component.dart correctly', () {
  final component = ComponentDefinition(...);
  final generator = SingleFileComponentGenerator();

  final result = generator.generate(component: component);

  expect(result, contains('part \'text.generated.dart\';'));
  expect(result, contains('class TextMeta'));
  expect(result, contains('class TextTokens'));
  expect(result, contains('mixin MaterialTextRenderer'));
});
```

**Tasks:**
- [ ] Test SingleFileComponentGenerator
- [ ] Test ComponentGeneratedFileGenerator
- [ ] Test IntegrationGenerator
- [ ] Test template merging
- [ ] Test design system detection

**Files affected:**
- New: `test/generators/single_file_component_generator_test.dart`
- New: `test/generators/integration_generator_test.dart`

---

#### 4.2 Integration Tests

**Test full build pipeline:**

```dart
// test/integration/single_file_build_test.dart
test('full build generates correct structure', () async {
  final buildUseCase = BuildAllUseCase(...);

  final result = await buildUseCase.execute(
    components: [textComponent, buttonComponent],
    outputDir: tempDir,
  );

  expect(File('$tempDir/text.dart').existsSync(), true);
  expect(File('$tempDir/text.generated.dart').existsSync(), true);
  expect(File('$tempDir/design_system.generated.dart').existsSync(), true);
});
```

**Tasks:**
- [ ] Test full build
- [ ] Verify file structure
- [ ] Verify imports/exports
- [ ] Test with all 20 components

**Files affected:**
- New: `test/integration/single_file_build_test.dart`

---

#### 4.3 Example App Validation

**Manual testing:**

- [ ] Run example app
- [ ] Test all 5 tabs
- [ ] Test theme switching (Material/Cupertino/Neo)
- [ ] Test all 3 generated screens
- [ ] Test all interactive components
- [ ] Check console for errors

---

## Rollback Strategy

### If Migration Fails

**Option 1: Git Revert**
```bash
git revert <migration-commit>
```

**Option 2: Feature Flag**
```dart
// lib/src/config/feature_flags.dart
const useSingleFileArchitecture = false;  // Disable new architecture

// lib/src/use_cases/build_all.dart
Future<BuildResult> execute(...) {
  if (useSingleFileArchitecture) {
    return _executeSingleFileMode();
  } else {
    return _executeLegacyMode();  // Old behavior
  }
}
```

**Tasks:**
- [ ] Keep old generators in codebase (don't delete immediately)
- [ ] Add feature flag support
- [ ] Test rollback on example app

---

## File Change Summary

### New Files (28)

**Templates:**
- `generator/templates/foundation.template.dart`
- `generator/templates/text.template.dart`
- `generator/templates/button.template.dart`
- ... (20 component templates)

**Generators:**
- `lib/src/generators/single_file_component_generator.dart`
- `lib/src/generators/integration_generator.dart`
- `lib/src/generators/template_merger.dart`

**Tools:**
- `tool/migrate_to_single_file.dart`

**Tests:**
- `test/generators/single_file_component_generator_test.dart`
- `test/generators/integration_generator_test.dart`
- `test/integration/single_file_build_test.dart`

### Modified Files (15)

**Core:**
- `lib/src/use_cases/build_all.dart`
- `lib/src/models/component_definition.dart`
- `lib/src/parser/extractors/component_extractor.dart`
- `lib/src/generators/component_generator.dart`
- `lib/syntaxify.dart`

**Docs:**
- `README.md`
- `CLAUDE.md`
- `docs/user_manual.md`
- `docs/developer_manual.md`
- `docs/api-reference.md`

**Example:**
- `example/pubspec.yaml`
- `example/lib/main.dart`

### Deleted Files (After Migration) (100+)

**Old structure (can delete after successful migration):**
- `generator/design_system/variants/*.dart` (11 files)
- `generator/design_system/tokens/*.dart` (20 files)
- `generator/design_system/components/*/*.dart` (60 files)
- `lib/src/services/design_system_service.dart`

---

## Risk Assessment

### High Risk

1. **Breaking existing projects** - Users with existing Syntaxify projects
   - **Mitigation:** Provide migration guide, maintain backward compatibility temporarily

2. **Complex generator logic** - Template merging, design system detection
   - **Mitigation:** Extensive testing, start with one component

3. **Import path changes** - All user code needs to update imports
   - **Mitigation:** Auto-migration script, clear upgrade guide

### Medium Risk

1. **Performance regression** - New generators might be slower
   - **Mitigation:** Benchmark before/after, optimize if needed

2. **Template maintenance** - 20+ templates to maintain
   - **Mitigation:** Extract common template logic, use inheritance

3. **Test coverage gaps** - New code needs comprehensive tests
   - **Mitigation:** Aim for 80%+ coverage on new generators

### Low Risk

1. **Documentation out of sync** - Docs might not match implementation
   - **Mitigation:** Update docs as part of each phase

2. **Example app issues** - Example might break during migration
   - **Mitigation:** Keep example app simple, test thoroughly

---

## Success Criteria

### Must Have (P0)

- [ ] All 20 components migrated to single-file structure
- [ ] Build generates correct file structure (2 files per component)
- [ ] Example app runs without errors
- [ ] All existing tests pass
- [ ] Documentation updated

### Should Have (P1)

- [ ] Migration script works automatically
- [ ] New generators have 80%+ test coverage
- [ ] Build performance same or better than before
- [ ] Clear upgrade guide for existing users

### Nice to Have (P2)

- [ ] Feature flag for gradual rollout
- [ ] Comparison tool (old vs new generated code)
- [ ] Video tutorial showing migration

---

## Timeline

### Week 1: Foundation + Generator

**Day 1-2: Phase 1 (Foundation Work)**
- Create template system
- Consolidate foundation tokens
- Update meta parser

**Day 3-5: Phase 2 (Generator Refactor)**
- Create SingleFileComponentGenerator
- Update ComponentGeneratedFileGenerator
- Create IntegrationGenerator
- Update BuildAllUseCase

### Week 2: Migration + Testing

**Day 6: Phase 3 (Migration)**
- Create migration script
- Migrate all components
- Update example app
- Update documentation

**Day 7: Phase 4 (Testing)**
- Write unit tests
- Run integration tests
- Validate example app
- Performance benchmarks

---

## Next Steps

1. **Review this plan** - Get feedback, adjust timeline
2. **Create feature branch** - `feature/single-file-architecture`
3. **Start Phase 1.1** - Create template system
4. **Daily standups** - Track progress, adjust as needed

---

## Questions to Resolve

1. **Backward compatibility:** Should we support both architectures temporarily?
2. **Template format:** Plain Dart files or use a template engine (mustache, jinja)?
3. **Design system detection:** Convention-based or explicit metadata?
4. **Fallback strategy:** Material as universal base or throw errors?
5. **Migration path:** Automated script or manual guide for users?

---

## Appendix: Code Snippets

### Template Example

```dart
// generator/templates/text.template.dart

// This template is merged with meta/text.meta.dart during generation

import 'package:flutter/material.dart';
part '{{component_name}}.generated.dart';

// {{SECTION: META}}
// Meta definition will be injected here from .meta.dart file

// {{SECTION: TOKENS}}
class {{ComponentName}}Tokens {
  final TextStyle style;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double? height;

  const {{ComponentName}}Tokens({
    required this.style,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.letterSpacing = 0.0,
    this.height,
  });

  factory {{ComponentName}}Tokens.fromFoundation(
    FoundationTokens foundation, {
    required {{ComponentName}}Variant variant,
  }) {
    // Template logic
    // This will be customized per component
  }
}

// {{SECTION: RENDERERS}}
mixin Material{{ComponentName}}Renderer on DesignStyle {
  @override
  {{ComponentName}}Tokens {{componentName}}Tokens({{ComponentName}}Variant variant) {
    return {{ComponentName}}Tokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget render{{ComponentName}}({{PARAMETERS}}) {
    // Material implementation
  }
}

mixin Cupertino{{ComponentName}}Renderer on DesignStyle {
  // Cupertino implementation
}

mixin Neo{{ComponentName}}Renderer on DesignStyle {
  // Neo implementation
}
```

### Generated File Example

```dart
// lib/syntaxify/text.dart (after generation)

import 'package:flutter/material.dart';
part 'text.generated.dart';

// META (from meta/text.meta.dart)
@SyntaxComponent(
  description: 'A customizable text component',
  variants: ['displayLarge', 'headlineMedium', 'titleMedium',
             'bodyLarge', 'bodyMedium', 'labelMedium', 'labelSmall'],
)
class TextMeta {
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}

// TOKENS (from template)
class TextTokens {
  // ... (template logic)
}

// RENDERERS (from template)
mixin MaterialTextRenderer on DesignStyle {
  // ... (template logic)
}

mixin CupertinoTextRenderer on DesignStyle {
  // ... (template logic)
}

mixin NeoTextRenderer on DesignStyle {
  // ... (template logic)
}
```

---

**End of Refactor Plan**
