import 'dart:io';
import 'package:yaml/yaml.dart';
import 'syntaxify_config.dart';

/// Loads Syntaxify configuration from `syntaxify.yaml`.
///
/// Provides cascading configuration with the following priority (high to low):
/// 1. CLI flags (passed as overrides)
/// 2. `syntaxify.yaml` in project root
/// 3. Default values
class ConfigLoader {
  const ConfigLoader();

  /// Default config filename.
  static const String configFileName = 'syntaxify.yaml';

  /// Loads configuration from `syntaxify.yaml` if present.
  ///
  /// [cwd] - Current working directory (defaults to `Directory.current.path`)
  ///
  /// Returns [SyntaxifyConfig] with values from file merged with defaults.
  SyntaxifyConfig load({String? cwd}) {
    final workingDir = cwd ?? Directory.current.path;
    final configFile = File('$workingDir/$configFileName');

    if (!configFile.existsSync()) {
      return const SyntaxifyConfig();
    }

    try {
      final yamlString = configFile.readAsStringSync();
      final yamlMap = loadYaml(yamlString) as YamlMap?;

      if (yamlMap == null) {
        return const SyntaxifyConfig();
      }

      return _parseConfig(yamlMap);
    } catch (e) {
      // If parsing fails, return defaults
      return const SyntaxifyConfig();
    }
  }

  /// Merges CLI overrides with file config.
  ///
  /// CLI values take precedence over file values.
  SyntaxifyConfig merge(
    SyntaxifyConfig fileConfig, {
    String? metaDir,
    String? outputDir,
    String? designSystemDir,
    String? tokensDir,
  }) {
    return SyntaxifyConfig(
      metaDir: metaDir ?? fileConfig.metaDir,
      outputDir: outputDir ?? fileConfig.outputDir,
      designSystemDir: designSystemDir ?? fileConfig.designSystemDir,
      tokensDir: tokensDir ?? fileConfig.tokensDir,
      generateScreens: fileConfig.generateScreens,
      generateComponents: fileConfig.generateComponents,
    );
  }

  /// Parses YAML map into SyntaxifyConfig.
  SyntaxifyConfig _parseConfig(YamlMap yaml) {
    return SyntaxifyConfig(
      metaDir: yaml['meta'] as String? ?? 'meta',
      outputDir: yaml['output'] as String? ?? 'lib/syntaxify',
      designSystemDir:
          yaml['design_system'] as String? ?? 'lib/syntaxify/design_system',
      tokensDir: yaml['tokens'] as String? ?? 'lib/syntaxify/design_system',
      generateScreens: _parseBool(yaml['generate']?['screens'], true),
      generateComponents: _parseBool(yaml['generate']?['components'], true),
    );
  }

  bool _parseBool(dynamic value, bool defaultValue) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return defaultValue;
  }
}
