# Forge Generator CLI - Spec Requirements

> Spec: Forge Generator Foundation
> Created: 2025-12-16
> Phase: 1

## Overview

Build the foundational `forge` CLI tool that reads meta component definitions and generates production-ready Flutter widgets. This is the core engine that transforms design tokens + specs into code.

## User Stories

### CLI User Experience

As a Flutter developer, I want to run `forge build` so that my meta definitions generate ready-to-use Flutter components.

**Workflow:**
1. Define component in `meta/button.meta.dart`
2. Define tokens in `meta/button.tokens.dart`
3. Run `forge build`
4. Get `lib/generated/app_button.dart`

### Token-Driven Output

As a designer, I want to change token values and regenerate so that the entire app updates consistently.

## Spec Scope

1. **CLI Parser** - Parse command line arguments (build, clean, watch)
2. **Meta File Reader** - Read and parse `.meta.dart` files
3. **Token File Reader** - Read and parse `.tokens.dart` files
4. **Code Generator** - Output Flutter widget code from templates
5. **File Writer** - Write generated files with proper headers

## Out of Scope

- Multi-theme runtime switching (Phase 3)
- Form validation generation (Phase 4)
- Layout/Sliver generation (Phase 5-6)
- pub.dev publishing (Phase 7)

## Expected Deliverable

1. Running `forge build` generates `app_button.dart` from meta definition
2. Generated code compiles without errors
3. Generated code matches manual prototype quality
