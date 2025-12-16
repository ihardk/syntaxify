# Forge Tech Stack

## Core Technologies

| Technology | Version | Purpose |
|------------|---------|---------|
| Dart | 3.2+ | Generator language |
| Flutter | 3.16+ | Target framework |

## Generator Dependencies

```yaml
dependencies:
  args: ^2.4.0      # CLI parsing
  path: ^1.8.0      # File paths
  
dev_dependencies:
  test: ^1.24.0
  lints: ^3.0.0
```

## Generated Code Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Zero external dependencies!
```

## Project Structure

```
forge/
├── agents/        # AI agent definitions
├── planning/      # Architecture docs
├── generator/     # Forge CLI (to be built)
├── example/       # Demo app
└── .agent-os/     # Agent-OS config
```
