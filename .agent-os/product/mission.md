# Product Mission

## Pitch

Forge is a developer tool that automates the translation of Design Systems into production-ready Flutter code, eliminating boilerplate and ensuring strict token compliance without runtime overhead.

## Users

### Primary Customers

- **Design System Teams**: Architects who define the tokens and components.
- **Flutter Developers**: Engineers consuming the components for application development.

### User Personas

**Alex (Senior Flutter Dev)** (25-35 years old)
- **Role**: Lead Developer
- **Context**: Building large-scale apps with strict brand guidelines.
- **Pain Points**: Manually updating 50 button variants when design changes, inconsistencies between Figma and Code.
- **Goals**: Automate the boring parts, ensure pixel-perfect implementation.

## The Problem

### Design-Code Drift

Design systems evolve in Figma, but codebases often lag behind, leading to visual inconsistencies and duplicate implementation efforts. Manual synchronization is error-prone and tedious.

**Our Solution:** Define components once in abstract "meta" files and generate the exact Flutter implementation automatically.

### Runtime Overhead

Many solutions use extensive runtime libraries or "magic" that bloats the app size and complicates debugging.

**Our Solution:** Generate pure, readable Dart code that looks hand-written, with zero runtime dependencies.

## Differentiators

### Zero Runtime Magic

Unlike other UI frameworks that require heavy dependencies, Forge generates standard Flutter widgets. You can commit the code and uninstall Forge, and it still works.

### Type-Safe Token Enforcement

Forge ensures that components can ONLY use defined tokens (colors, typography), making it impossible to "hardcode" arbitrary values.

## Key Features

### Core Features

- **Meta-Definition Schema**: Framework-agnostic definition of components.
- **Token Engine**: Strongly typed design tokens generated from verified sources.
- **Multi-Renderer Support**: Generate Material, Cupertino, or custom "Neo-Brutalism" implementations from the same definition.

### Developer Experience

- **Component CLI**: Simple `init` and `build` commands.
- **Smart Scaffolding**: Auto-detection of uninitialized projects.
