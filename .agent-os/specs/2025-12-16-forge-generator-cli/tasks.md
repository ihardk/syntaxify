# Tasks Checklist

Tasks for spec: @.agent-os/specs/2025-12-16-forge-generator-cli/spec.md

## Phase 1 Tasks

### 1. Project Setup
- [ ] Create `generator/` folder
- [ ] Initialize Dart project with `dart create`
- [ ] Set up pubspec.yaml with dependencies
- [ ] Create folder structure (bin, lib, test)

### 2. CLI Parser
- [ ] Create `bin/forge.dart` entry point
- [ ] Implement argument parsing with `args` package
- [ ] Add `build` command handler
- [ ] Add `clean` command handler
- [ ] Add `--component` flag support

### 3. Meta File Parser
- [ ] Create `parser/meta_parser.dart`
- [ ] Parse class definition from source
- [ ] Extract `@MetaComponent` annotation
- [ ] Extract field definitions with annotations
- [ ] Handle `@Required`, `@Optional`, `@Variant`

### 4. Token File Parser
- [ ] Create `parser/token_parser.dart`
- [ ] Parse token class from source
- [ ] Extract token properties with types

### 5. Code Generator
- [ ] Create `generator/widget_generator.dart`
- [ ] Create file header template
- [ ] Create widget class template
- [ ] Create build method template
- [ ] Interpolate tokens into template

### 6. File Writer
- [ ] Create `writer/file_writer.dart`
- [ ] Write to `lib/generated/` folder
- [ ] Generate checksum for header
- [ ] Format output with dart format

### 7. Integration
- [ ] Connect all components in main CLI
- [ ] Test with Button component
- [ ] Verify output matches manual prototype

### 8. Testing
- [ ] Unit tests for parser
- [ ] Unit tests for generator
- [ ] Integration test for full flow
