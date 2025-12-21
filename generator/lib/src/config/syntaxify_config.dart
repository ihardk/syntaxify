import 'package:freezed_annotation/freezed_annotation.dart';

part 'syntaxify_config.freezed.dart';
part 'syntaxify_config.g.dart';

/// Configuration for Syntaxify projects.
///
/// This can be loaded from `syntaxify.yaml` in the project root,
/// or constructed programmatically. CLI flags override config file values.
///
/// Example `syntaxify.yaml`:
/// ```yaml
/// meta: meta
/// output: lib/syntaxify
/// design_system: lib/syntaxify/design_system
/// tokens: lib/syntaxify/design_system
/// generate:
///   screens: true
///   components: true
/// ```
@freezed
sealed class SyntaxifyConfig with _$SyntaxifyConfig {
  const factory SyntaxifyConfig({
    /// Directory containing `.meta.dart` and `.screen.dart` files.
    @Default('meta') String metaDir,

    /// Output directory for generated code.
    @Default('lib/syntaxify') String outputDir,

    /// Design system directory path.
    @Default('lib/syntaxify/design_system') String designSystemDir,

    /// Tokens directory path.
    @Default('lib/syntaxify/design_system') String tokensDir,

    /// Whether to generate screens from `.screen.dart` files.
    @Default(true) bool generateScreens,

    /// Whether to generate components from `.meta.dart` files.
    @Default(true) bool generateComponents,
  }) = _SyntaxifyConfig;

  factory SyntaxifyConfig.fromJson(Map<String, dynamic> json) =>
      _$SyntaxifyConfigFromJson(json);
}
