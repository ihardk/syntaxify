# Forge Coding Standards

## Language & Framework

- **Language:** Dart 3.2+
- **Framework:** Flutter 3.16+
- **Style:** Follow official Dart style guide

## Project Structure

```
forge/
├── agents/       # AI agent role definitions
├── planning/     # Architecture and design docs
├── example/      # Demo app with manual prototype
├── generator/    # The forge CLI tool (to be built)
└── .agent-os/    # Agent-OS configuration
```

## Naming Conventions

### Files
- Dart: `snake_case.dart`
- Generated: `app_{component}.dart`
- Tests: `{name}_test.dart`

### Classes
- Specs: `Meta{Component}Spec`
- Tokens: `{Component}Tokens`
- Renderers: `{Component}Renderer`
- Generated: `App{Component}`

### Callbacks
- Action: `onPressed`, `onChanged`, `onSubmitted`
- State: `onEnabledChanged`, `onValidationChanged`

## Code Quality

- All public APIs have dartdoc comments
- No dynamic typing
- Generated code is `dart format` compliant
- Build time < 2s for 10 components

## Testing

- Unit tests for token resolution (100% coverage)
- Widget tests for component rendering
- Golden tests for visual regression
