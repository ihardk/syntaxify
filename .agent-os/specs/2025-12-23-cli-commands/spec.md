# Spec Requirements Document

> Spec: cli-creation-commands
> Created: 2025-12-23

## Overview

Implement `syntaxify create` commands to scaffold new components, screens, and design styles. This eliminates manual file creation and ensures new files follow the correct naming conventions and directory structure (`meta/` for definitions, `design_system/` for styles).

## User Stories

### Create Component
As a developer, I want to run `syntaxify create component ProfileCard` so that a new `meta/profile_card.meta.dart` file is created with a basic component template.

### Create Screen
As a developer, I want to run `syntaxify create screen Login` so that a new `meta/login.screen.dart` file is created with a basic screen template.

### Create Design Style
As a developer, I want to run `syntaxify create style Glass` so that a new `lib/syntaxify/design_system/styles/glass_style.dart` is created with all required renderer mixins pre-populated.

## Spec Scope

1.  **`create component <name>`** - Scaffolds `meta/<name>.meta.dart` with `@SyntaxComponent`.
2.  **`create screen <name>`** - Scaffolds `meta/<name>.screen.dart` with `Screen` definition.
3.  **`create style <name>`** - Scaffolds `lib/.../styles/<name>_style.dart` and prints instructions to register it in `design_system.dart`.
4.  **Templating** - Use internal string templates (no external dependencies like Mason) to keep the generator lightweight.

## Out of Scope

- Interactive mode (prompts for properties). V1 will just create a shell file.
- Automatic registration in `design_system.dart` (too risky for V1 string parsing; will prompt user to add `part` directive).
- Deleting or renaming components via CLI.

## Expected Deliverable

1.  `syntaxify create component <Name>` creates a valid meta file.
2.  `syntaxify create screen <Name>` creates a valid screen file.
3.  `syntaxify create style <Name>` creates a valid style class.
4.  Tests verifying file creation and content accuracy.
