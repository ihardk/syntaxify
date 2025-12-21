/// Syntaxify UI code generator
///
/// Produces production-ready Flutter widgets from design tokens.
library syntaxify;

// Package Configuration (Single Source of Truth)
export 'src/config/package_config.dart';

// Core Interfaces (Dependency Inversion)
export 'src/core/interfaces/component_generator.dart';
export 'src/core/interfaces/file_system.dart';
export 'src/core/interfaces/code_formatter.dart';

// Models (Domain Layer)
export 'src/models/component_definition.dart';
export 'src/models/token_definition.dart';
export 'src/models/ast/nodes.dart';
export 'src/models/build_result.dart';
export 'src/models/build_cache.dart';
export 'src/models/validation_error.dart';

// Annotations
export 'src/annotations/syntax_annotations.dart';

// Parsers (Data Layer)
export 'src/parser/meta_parser.dart';
export 'src/parser/token_parser.dart';

// Generators (Strategy Pattern)
export 'src/generators/generator_registry.dart';
export 'src/generators/component/button_generator.dart';
export 'src/generators/component/generic_generator.dart';
export 'src/generator/theme_generator.dart';
export 'src/generator/syntax_generator.dart';

// Infrastructure
export 'src/infrastructure/local_file_system.dart';
export 'src/infrastructure/memory_file_system.dart';
export 'src/infrastructure/dart_code_formatter.dart';
export 'src/infrastructure/build_cache_manager.dart';

// Validation
export 'src/validation/layout_validator.dart';

// Use Cases (Clean Architecture)
export 'src/use_cases/generate_component.dart';
export 'src/use_cases/build_all.dart';

// CLI
export 'src/cli/build_command.dart';
export 'src/cli/clean_command.dart';
