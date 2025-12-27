import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/generators/design_system_generator.dart';
import 'package:syntaxify/src/generators/token_generator.dart';
import 'package:syntaxify/src/generators/registry/icon_registry_generator.dart';
import 'package:syntaxify/src/generators/registry/image_registry_generator.dart';
import 'package:syntaxify/src/parser/registry_parser.dart';

import 'package:syntaxify/src/infrastructure/repositories/project_repository.dart';
import 'package:syntaxify/src/core/interfaces/file_system.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

/// Service for design system operations (copying, generating, integrating).
class DesignSystemService {
  final ProjectRepository _projectRepo;
  final FileSystem _fileSystem;
  final Logger _logger;
  final p.Context _pathContext;
  final DesignSystemGenerator _designGen;
  final TokenGenerator _tokenGen;

  DesignSystemService({
    required ProjectRepository projectRepo,
    required FileSystem fileSystem,
    required Logger logger,
    p.Context? pathContext,
  })  : _projectRepo = projectRepo,
        _fileSystem = fileSystem,
        _logger = logger,
        _pathContext = pathContext ?? p.posix,
        _designGen = DesignSystemGenerator(),
        _tokenGen = TokenGenerator();

  /// Copy design system template files to project
  Future<List<String>> copyDesignSystemFiles({
    required String sourceDir,
    required String outputDir,
  }) async {
    final filesGenerated = <String>[];

    // Create directories
    await _fileSystem
        .createDirectory(_pathContext.join(outputDir, 'design_system'));
    await _fileSystem.createDirectory(
        _pathContext.join(outputDir, 'design_system', 'styles'));

    // Core files
    final coreFiles = [
      'design_system.dart',
      'app_theme.dart',
      'design_style.dart',
      'variants.dart'
    ];
    for (final file in coreFiles) {
      final src = _pathContext.join(sourceDir, file);
      if (await _fileSystem.exists(src)) {
        final dest = _pathContext.join(outputDir, 'design_system', file);
        await _fileSystem.copyFile(src, dest);
        filesGenerated.add('design_system/$file');
        _logger.success('Copied: design_system/$file');
      }
    }

    // Style files
    final styleFiles = [
      'material_style.dart',
      'cupertino_style.dart',
      'neo_style.dart'
    ];
    for (final file in styleFiles) {
      final src = _pathContext.join(sourceDir, 'styles', file);
      if (await _fileSystem.exists(src)) {
        final dest =
            _pathContext.join(outputDir, 'design_system', 'styles', file);
        await _fileSystem.copyFile(src, dest);
        filesGenerated.add('design_system/styles/$file');
        _logger.success('Copied: design_system/styles/$file');
      }
    }

    // Copy components recursively
    final componentsDir = Directory(_pathContext.join(sourceDir, 'components'));
    if (await componentsDir.exists()) {
      final destComponentsDir =
          _pathContext.join(outputDir, 'design_system', 'components');
      await _fileSystem.createDirectory(destComponentsDir);

      await for (final entity
          in componentsDir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          final relPath = p
              .relative(entity.path, from: componentsDir.path)
              .replaceAll(p.separator, '/');
          final destPath = _pathContext.join(destComponentsDir, relPath);
          final parentDir = _pathContext.dirname(destPath);
          await _fileSystem.createDirectory(parentDir);
          await _fileSystem.copyFile(entity.path, destPath);
          filesGenerated.add('design_system/components/$relPath');
          _logger.success('Copied: design_system/components/$relPath');
        }
      }
    }

    return filesGenerated;
  }

  /// Generate dynamic design system files (DesignStyle, etc.)
  Future<List<String>> generateDesignSystemCode({
    required List<ComponentDefinition> components,
    required String outputDir,
  }) async {
    final filesGenerated = <String>[];
    final styles = ['Material', 'Cupertino', 'Neo'];

    // Main library
    final mainLibCode = _designGen.generateMainLibrary(components);
    await _projectRepo.writeFile(
      _pathContext.join(outputDir, 'design_system', 'design_system.dart'),
      mainLibCode,
    );
    filesGenerated.add('design_system/design_system.dart');
    _logger.success('Generated: design_system/design_system.dart');

    // DesignStyle
    final designStyleCode = _designGen.generateDesignStyle(components);
    await _projectRepo.writeFile(
      _pathContext.join(outputDir, 'design_system', 'design_style.dart'),
      designStyleCode,
    );
    filesGenerated.add('design_system/design_style.dart');
    _logger.success('Generated: design_system/design_style.dart');

    // Concrete styles
    for (final style in styles) {
      final styleCode = _designGen.generateStyleClass(style, components);
      final fileName = '${style.toLowerCase()}_style.dart';
      await _projectRepo.writeFile(
        _pathContext.join(outputDir, 'design_system', 'styles', fileName),
        styleCode,
      );
      filesGenerated.add('design_system/styles/$fileName');
      _logger.success('Generated: design_system/styles/$fileName');
    }

    // Renderer stubs for custom components
    final standardComponents = {
      'Button',
      'Input',
      'Text',
      'Checkbox',
      'Toggle',
      'Slider',
      'Radio'
    };
    for (final component in components) {
      final baseName =
          component.explicitName ?? component.className.replaceAll('Meta', '');
      final cleanName =
          baseName.startsWith('App') ? baseName.substring(3) : baseName;

      if (standardComponents.contains(cleanName)) continue;

      final folderName = StringUtils.toSnakeCase(cleanName);
      final componentDir = _pathContext.join(
          outputDir, 'design_system', 'components', folderName);
      await _fileSystem.createDirectory(componentDir);

      for (final style in styles) {
        final stubCode = _designGen.generateRendererStub(component, style);
        final fileName = '${style.toLowerCase()}_renderer.dart';
        await _projectRepo.writeFile(
            _pathContext.join(componentDir, fileName), stubCode);
        filesGenerated.add('design_system/components/$folderName/$fileName');
        _logger.success(
            'Generated Stub: design_system/components/$folderName/$fileName');
      }
    }

    return filesGenerated;
  }

  /// Generate and copy token files
  ///
  /// Copies foundation tokens and generates component tokens if they don't exist.
  /// Also copies existing token files from designSystemDir to outputDir.
  Future<List<String>> handleTokens({
    required List<ComponentDefinition> components,
    required String designSystemDir,
    required String outputDir,
  }) async {
    final filesGenerated = <String>[];

    await _fileSystem.createDirectory(
        _pathContext.join(outputDir, 'design_system', 'tokens'));

    // Copy foundation tokens
    Directory foundationDir =
        Directory(_pathContext.join(designSystemDir, 'tokens', 'foundation'));
    if (!await foundationDir.exists()) {
      foundationDir = _getPackageBundledFoundationDir();
    }

    if (await foundationDir.exists()) {
      final destFoundationDir =
          _pathContext.join(outputDir, 'design_system', 'tokens', 'foundation');
      await _fileSystem.createDirectory(destFoundationDir);

      await for (final entity
          in foundationDir.list(recursive: false, followLinks: false)) {
        if (entity is File && entity.path.endsWith('.dart')) {
          final fileName =
              _pathContext.basename(entity.path.replaceAll('\\', '/'));
          final destPath = _pathContext.join(destFoundationDir, fileName);
          await _fileSystem.copyFile(
              entity.path.replaceAll('\\', '/'), destPath);
          filesGenerated.add('design_system/tokens/foundation/$fileName');
          _logger.success('Copied: design_system/tokens/foundation/$fileName');
        }
      }
    }

    // Generate component tokens (writes to designSystemDir, not outputDir)
    for (final component in components) {
      final baseName =
          component.explicitName ?? component.className.replaceAll('Meta', '');
      final cleanName =
          baseName.startsWith('App') ? baseName.substring(3) : baseName;
      final tokenFileName = '${StringUtils.toSnakeCase(cleanName)}_tokens.dart';
      final tokenPath =
          _pathContext.join(designSystemDir, 'tokens', tokenFileName);

      if (!await _fileSystem.exists(tokenPath)) {
        final tokenCode = _tokenGen.generate(component);
        await _fileSystem.writeFile(tokenPath, tokenCode);
        _logger.success('Generated: tokens/$tokenFileName');
      }
    }

    // Copy shared token files (icon_token.dart)
    try {
      final iconTokenPath =
          _pathContext.join(designSystemDir, 'tokens', 'icon_token.dart');
      if (await _fileSystem.exists(iconTokenPath)) {
        final destPath = _pathContext.join(
            outputDir, 'design_system', 'tokens', 'icon_token.dart');
        await _fileSystem.copyFile(iconTokenPath, destPath);
        filesGenerated.add('design_system/tokens/icon_token.dart');
        _logger.success('Copied: design_system/tokens/icon_token.dart');
      }
    } catch (e) {
      _logger.warn('Could not copy icon_token.dart: $e');
    }

    // Copy existing component token files from designSystemDir to outputDir
    for (final component in components) {
      try {
        final baseName = component.explicitName ??
            component.className.replaceAll('Meta', '');
        final cleanName =
            baseName.startsWith('App') ? baseName.substring(3) : baseName;
        final tokenFileName =
            '${StringUtils.toSnakeCase(cleanName)}_tokens.dart';
        final srcPath =
            _pathContext.join(designSystemDir, 'tokens', tokenFileName);
        final destPath = _pathContext.join(
          outputDir,
          'design_system',
          'tokens',
          tokenFileName,
        );

        if (await _fileSystem.exists(srcPath)) {
          await _fileSystem.copyFile(srcPath, destPath);
          filesGenerated.add('design_system/tokens/$tokenFileName');
          _logger.success('Copied: design_system/tokens/$tokenFileName');
        }
      } catch (e) {
        _logger
            .warn('Could not copy token file for ${component.className}: $e');
      }
    }

    return filesGenerated;
  }

  /// Generate icon/image registries
  ///
  /// If registry meta files exist, generates app_icons.dart and app_images.dart
  /// from the registry definitions. Otherwise, falls back to copying existing
  /// files from the designSystemDir if present.
  Future<List<String>> generateRegistries({
    required String metaDirectoryPath,
    required String outputDir,
    String? designSystemDir,
  }) async {
    final filesGenerated = <String>[];

    try {
      final registryParser = RegistryParser(logger: _logger);
      final registryDefs =
          await registryParser.parseDirectory(Directory(metaDirectoryPath));

      final iconRegistries =
          registryDefs.where((r) => r.type == RegistryType.icon).toList();
      final imageRegistries =
          registryDefs.where((r) => r.type == RegistryType.image).toList();

      if (iconRegistries.isNotEmpty) {
        final iconGen = IconRegistryGenerator();
        final lib = iconGen.build(iconRegistries.first);
        final emitter = DartEmitter(
            allocator: Allocator.simplePrefixing(), orderDirectives: true);
        final content = lib.accept(emitter).toString();

        await _fileSystem.writeFile(
          _pathContext.join(outputDir, 'design_system', 'app_icons.dart'),
          DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
              .format(content),
        );
        filesGenerated.add('design_system/app_icons.dart');
        _logger.success('Generated: design_system/app_icons.dart');
      } else if (designSystemDir != null) {
        // Fallback: Copy if exists in source
        final srcPath = _pathContext.join(designSystemDir, 'app_icons.dart');
        if (await _fileSystem.exists(srcPath)) {
          final destPath =
              _pathContext.join(outputDir, 'design_system', 'app_icons.dart');
          await _fileSystem.copyFile(srcPath, destPath);
          filesGenerated.add('design_system/app_icons.dart');
          _logger.success('Copied: design_system/app_icons.dart (Fallback)');
        }
      }

      if (imageRegistries.isNotEmpty) {
        final imageGen = ImageRegistryGenerator();
        final lib = imageGen.build(imageRegistries.first);
        final emitter = DartEmitter(
            allocator: Allocator.simplePrefixing(), orderDirectives: true);
        final content = lib.accept(emitter).toString();

        await _fileSystem.writeFile(
          _pathContext.join(outputDir, 'design_system', 'app_images.dart'),
          DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
              .format(content),
        );
        filesGenerated.add('design_system/app_images.dart');
        _logger.success('Generated: design_system/app_images.dart');
      } else if (designSystemDir != null) {
        // Fallback: Copy if exists in source
        final srcPath = _pathContext.join(designSystemDir, 'app_images.dart');
        if (await _fileSystem.exists(srcPath)) {
          final destPath =
              _pathContext.join(outputDir, 'design_system', 'app_images.dart');
          await _fileSystem.copyFile(srcPath, destPath);
          filesGenerated.add('design_system/app_images.dart');
          _logger.success('Copied: design_system/app_images.dart (Fallback)');
        }
      }
    } catch (e) {
      _logger.warn('Failed to handle registries: $e');
    }

    return filesGenerated;
  }

  Directory _getPackageBundledFoundationDir() {
    final scriptPath = Platform.script.toFilePath().replaceAll('\\', '/');
    var current = scriptPath;

    for (var i = 0; i < 20; i++) {
      final parent = p.posix.dirname(current);
      if (parent == current) break;

      final foundationDir = Directory(p.posix
          .join(parent, 'generator', 'design_system', 'tokens', 'foundation'));
      if (foundationDir.existsSync()) return foundationDir;

      final directFoundationDir = Directory(
          p.posix.join(parent, 'design_system', 'tokens', 'foundation'));
      if (directFoundationDir.existsSync()) return directFoundationDir;

      current = parent;
    }

    return Directory(p.posix.join(p.posix.dirname(p.posix.dirname(scriptPath)),
        'design_system', 'tokens', 'foundation'));
  }
}
