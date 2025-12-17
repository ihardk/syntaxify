import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

import 'package:forge/src/models/build_result.dart';
import 'package:forge/src/parser/meta_parser.dart';
import 'package:forge/src/parser/token_parser.dart';
import 'package:forge/src/generator/widget_generator.dart';
import 'package:forge/src/generator/theme_generator.dart';

/// Main Forge generator that orchestrates the build process.
///
/// Follows the architecture from planning docs:
/// - Reads meta files (component specs)
/// - Reads token files (styling values)
/// - Generates widgets that use AppTheme.of(context)
/// - Generates AppTheme provider
class ForgeGenerator {
  ForgeGenerator({
    required this.metaDirectory,
    required this.tokensDirectory,
    required this.outputDirectory,
    required this.logger,
  });

  final String metaDirectory;
  final String tokensDirectory;
  final String outputDirectory;
  final Logger logger;

  late final MetaParser _metaParser = MetaParser(logger: logger);
  late final TokenParser _tokenParser = TokenParser(logger: logger);
  late final WidgetGenerator _widgetGenerator = WidgetGenerator();
  late final ThemeGenerator _themeGenerator = ThemeGenerator();

  /// Build components from meta definitions
  Future<BuildResult> build({
    String? component,
    String? theme,
  }) async {
    final stopwatch = Stopwatch()..start();
    final generatedFiles = <String>[];
    final warnings = <String>[];
    final errors = <String>[];

    try {
      // Parse meta files
      logger.info('Scanning meta directory: $metaDirectory');
      final metaDir = Directory(metaDirectory);
      final parseResult = await _metaParser.parseDirectory(metaDir);

      if (parseResult.hasErrors) {
        errors.addAll(parseResult.errors);
      }

      var components = parseResult.components;
      logger.info('Found ${components.length} component(s)');

      // Filter by component name if specified
      if (component != null) {
        components = components
            .where((c) => c.name == component || c.className == component)
            .toList();

        if (components.isEmpty) {
          errors.add('Component not found: $component');
        }
      }

      // Parse token files
      logger.info('Scanning tokens directory: $tokensDirectory');
      final tokensDir = Directory(tokensDirectory);
      final tokens = await _tokenParser.parseDirectory(tokensDir);
      logger.info('Found ${tokens.length} token definition(s)');

      // Create output directories
      final componentsDir = Directory(path.join(outputDirectory, 'components'));
      final themeDir = Directory(path.join(outputDirectory, 'theme'));
      final tokensOutDir = Directory(path.join(outputDirectory, 'tokens'));

      if (!await componentsDir.exists()) {
        await componentsDir.create(recursive: true);
      }
      if (!await themeDir.exists()) {
        await themeDir.create(recursive: true);
      }
      if (!await tokensOutDir.exists()) {
        await tokensOutDir.create(recursive: true);
      }

      // Generate widget for each component
      for (final comp in components) {
        try {
          logger.info('Generating: ${comp.className}');

          // Find matching token definition
          final matchingTokens = tokens
              .where((t) =>
                  t.componentName.toLowerCase() ==
                  comp.className.replaceAll('Meta', '').toLowerCase())
              .firstOrNull;

          final code = _widgetGenerator.generate(
            component: comp,
            tokens: matchingTokens,
          );

          // Strip Meta suffix for output filename
          final componentName =
              comp.className.replaceAll('Meta', '').toLowerCase();
          final fileName = 'app_$componentName.dart';
          final filePath = path.join(componentsDir.path, fileName);

          await File(filePath).writeAsString(code);
          generatedFiles.add('components/$fileName');

          logger.success('Generated: components/$fileName');
        } catch (e, stackTrace) {
          logger.err('Failed to generate ${comp.name}: $e');
          logger.detail(stackTrace.toString());
          errors.add('Failed to generate ${comp.name}: $e');
        }
      }

      // Generate theme if we have tokens
      if (tokens.isNotEmpty) {
        try {
          logger.info('Generating theme provider');

          final themeCode = _themeGenerator.generate(tokens: tokens);
          final themeFilePath = path.join(themeDir.path, 'app_theme.dart');

          await File(themeFilePath).writeAsString(themeCode);
          generatedFiles.add('theme/app_theme.dart');

          logger.success('Generated: theme/app_theme.dart');
        } catch (e, stackTrace) {
          logger.err('Failed to generate theme: $e');
          logger.detail(stackTrace.toString());
          errors.add('Failed to generate theme: $e');
        }
      }

      // Copy token files to output
      for (final token in tokens) {
        try {
          final componentName = token.componentName.toLowerCase();
          final srcPath =
              path.join(tokensDirectory, '$componentName.tokens.dart');
          final destPath =
              path.join(tokensOutDir.path, '${componentName}_tokens.dart');

          final srcFile = File(srcPath);
          if (await srcFile.exists()) {
            await srcFile.copy(destPath);
            generatedFiles.add('tokens/${componentName}_tokens.dart');
            logger.success('Copied: tokens/${componentName}_tokens.dart');
          }
        } catch (e) {
          warnings
              .add('Could not copy token file for ${token.componentName}: $e');
        }
      }

      // Generate barrel file
      await _generateBarrelFile(generatedFiles);
      generatedFiles.add('index.dart');

      stopwatch.stop();

      return BuildResult(
        filesGenerated: generatedFiles.length,
        generatedFiles: generatedFiles,
        duration: stopwatch.elapsed,
        warnings: warnings,
        errors: errors,
      );
    } catch (e) {
      stopwatch.stop();
      errors.add('Build failed: $e');

      return BuildResult(
        filesGenerated: 0,
        generatedFiles: [],
        duration: stopwatch.elapsed,
        errors: errors,
      );
    }
  }

  Future<void> _generateBarrelFile(List<String> files) async {
    final exports = files
        .where((f) => f.endsWith('.dart') && !f.endsWith('index.dart'))
        .map((f) => "export '$f';")
        .join('\n');

    final content = '''
// ============================================
// GENERATED BY FORGE v${_widgetGenerator.version}
// DO NOT MODIFY - Regenerated on build
// Barrel file exporting all generated code
// ============================================

$exports
''';

    final indexPath = path.join(outputDirectory, 'index.dart');
    await File(indexPath).writeAsString(content);
  }
}
