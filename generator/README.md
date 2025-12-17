# Forge Generator 🔨

A powerful CLI tool that generates production-ready, type-safe Flutter widgets from "Meta" definitions and Design Tokens.

## 🚀 Getting Started

### 1. Prerequisites
- Dart SDK installed
### 1. Add Dependency
Add `forge` to your project's `dev_dependencies`:

```bash
flutter pub add dev:forge
# OR
dart pub add dev:forge
```

### 2. Initialize Project
Scaffold the required directories (`meta/` and `design_system/`):

```bash
dart run forge init
```

### 3. Build Components
Generate your Flutter widgets:

```bash
dart run forge build
``` --output=lib/forge

### 🔧 Method 2: Local Script (For Contributors)
Run the script directly from the source code:

```bash
# In repo root
dart run generator/bin/forge.dart build --output=lib/forge
```

### ⚡ Shortcuts (Windows)
We have provided batch scripts for common tasks:

- `.\forge.bat` -> Wraps `dart run generator/bin/forge.dart`
- `.\test_build.bat` -> Builds to `lib/forge` (Verification)
- `.\update_example.bat` -> Builds to `generator/example/lib/forge` (Example App)

### 📱 Update Example App
To regenerate the code used by the example app:

```bash
dart run generator/bin/forge.dart build \
  --meta=generator/meta \
  --design-system=generator/design_system \
  --tokens=generator/design_system \
  --output=generator/example/lib/forge
```

---

## 💻 CLI Commands

### `build`
Generates Flutter widgets.

| Option        | Alias | Default         | Description                                          |
| ------------- | ----- | --------------- | ---------------------------------------------------- |
| `--output`    | `-o`  | `lib/forge`     | Output directory for generated code                  |
| `--meta`      | `-m`  | `meta`          | Directory containing user definitions (`.meta.dart`) |
| `--tokens`    |       | `design_system` | Directory containing token files                     |
| `--component` | `-c`  | *All*           | Build only a specific component (e.g., `button`)     |
| `--theme`     | `-t`  | *All*           | Build only a specific theme (e.g., `neo`)            |

### `clean`
Removes generated artifacts.

| Option     | Alias | Default     | Description        |
| ---------- | ----- | ----------- | ------------------ |
| `--output` | `-o`  | `lib/forge` | Directory to clean |

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
4.  **Write**: `BuildAllUseCase` writes the file to `lib/forge/generated/components/app_button.dart`.

---

## 📂 Key Directories

| Path                            | Purpose                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------- |
| `bin/forge.dart`                | **Main Entrypoint**. Run this to start.                                       |
| `design_system/`                | **Templates**. Files copied directly to user project (e.g. `app_theme.dart`). |
| `lib/src/generators/component/` | **Widget Logic**. Edit these files to change how widgets look.                |
