/// Forge UI code generator
///
/// Produces production-ready Flutter widgets from design tokens.
library forge;

// Annotations
export 'src/annotations/forge_annotations.dart';

// Models
export 'src/models/meta_component.dart';
export 'src/models/token_definition.dart';
export 'src/models/build_result.dart';

// Parsers
export 'src/parser/meta_parser.dart';
export 'src/parser/token_parser.dart';

// Generators
export 'src/generator/widget_generator.dart';
export 'src/generator/theme_generator.dart';
export 'src/generator/forge_generator.dart';

// CLI
export 'src/cli/build_command.dart';
export 'src/cli/clean_command.dart';
