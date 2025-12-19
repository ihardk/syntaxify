# Syntaxify Generator 🔨

A powerful CLI tool that generates production-ready, type-safe Flutter widgets from "Meta" definitions and Design Tokens.

## 🚀 Getting Started

### 1. Add Dependency
Add Syntaxify to your project:

```yaml
dev_dependencies:
  syntaxify:
    git:
      url: https://github.com/ihardk/syntaxify.git
      ref: v0.1.0
      path: generator
```

### 2. Initialize Project
Scaffold the required directories:

```bash
syntaxify init
```

*Note: If you skip this step, `syntaxify build` will detect missing files and ask to initialize for you.*

### 3. Build Components
Generate your Flutter widgets:

```bash
syntaxify build
```

### 🔧 For Contributors
Run from source (in generator directory):

```bash
dart run bin/syntaxify.dart build
```

### 📱 Update Example App
To regenerate the example app (from root):

```bash
cd example
syntaxify build
```

---

## 💻 CLI Commands

### `build`
Generates Flutter widgets.

| Option        | Alias | Default         | Description                                          |
| ------------- | ----- | --------------- | ---------------------------------------------------- |
| `--output`    | `-o`  | `lib/syntaxify` | Output directory for generated code                  |
| `--meta`      | `-m`  | `meta`          | Directory containing user definitions (`.meta.dart`) |
| `--tokens`    |       | `design_system` | Directory containing token files                     |
| `--component` | `-c`  | *All*           | Build only a specific component (e.g., `AppButton`)  |
| `--theme`     | `-t`  | *All*           | Build only a specific theme (e.g., `material`)       |

### `clean`
Removes generated artifacts.

| Option     | Alias | Default         | Description        |
| ---------- | ----- | --------------- | ------------------ |
| `--output` | `-o`  | `lib/syntaxify` | Directory to clean |

---

## 🗺️ Codebase Walkthrough

The generator follows a **SOLID**, 5-layer architecture. Here is how to navigate the code:

### 1. 🏭 CLI Layer (`lib/src/cli/`)
*Entry point for all commands.*
- **`build_command.dart`**: Parses arguments (output dir, flags) and orchestrates the build.
- **`clean_command.dart`**: Logic for removing files.

### 2. 🧠 Use Cases (`lib/src/use_cases/`)
*High-level business logic.*
- **`build_all.dart`**: The main director. It coordinates reading tokens, generating components, and copying design system files.
- **`generate_component_usecase.dart`**: The logic to build a *single* component.

### 3. 🧩 Generators (`lib/src/generators/`)
*Visual rendering logic (The "Renderer" Pattern).*
- **`component/`**: Separate class for each widget (e.g., `ButtonGenerator`, `CardGenerator`).
- **`generator_registry.dart`**: Factory that maps a component name ('button') to its generator (`ButtonGenerator`).

### 4. 🧱 Core (`lib/src/core/`)
*Domain entities and interfaces.*
- **`models/`**: Data structures like `MetaComponent` (parsed input) and `TokenDefinition`.
- **`interfaces/`**: Contracts for `FileSystem`, `Parser`, etc.

### 5. 🔌 Infrastructure (`lib/src/infrastructure/`)
*Low-level implementations.*
- **`file_system_impl.dart`**: Real disk I/O.
- **`parsers/`**: Logic to parse `.meta.dart` files (using `analyzer` package).

---

## 🧠 How it Works (The Flow)

1.  **Parse**: `MetaParser` reads `meta/button.meta.dart` -> creates `MetaComponent` model.
2.  **Lookup**: `GeneratorRegistry` finds `ButtonGenerator`.
3.  **Generate**: `ButtonGenerator` produces Dart code strings (imports, class definition, `build` method).
4.  **Write**: `BuildAllUseCase` writes the file to `lib/syntaxify/generated/components/app_button.dart`.

---

## 📂 Key Directories

| Path                            | Purpose                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------- |
| `bin/syntaxify.dart`            | **Main Entrypoint**. Run this to start.                                       |
| `design_system/`                | **Templates**. Files copied directly to user project (e.g. `app_theme.dart`). |
| `lib/src/generators/component/` | **Widget Logic**. Edit these files to change how widgets look.                |
