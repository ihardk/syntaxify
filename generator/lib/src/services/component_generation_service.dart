import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:mason_logger/mason_logger.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/token_definition.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';
import 'package:syntaxify/src/generators/enum_generator.dart';
import 'package:syntaxify/src/use_cases/generate_component.dart';
import 'package:syntaxify/src/infrastructure/repositories/project_repository.dart';
import 'package:syntaxify/src/infrastructure/repositories/cache_repository.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

/// Service for component generation with caching and validation.
///
/// Handles the complete lifecycle of component generation:
/// - Cache checking (skip unchanged components)
/// - Component code generation
/// - Enum variant generation
/// - File writing via repositories
class ComponentGenerationService {
  final ProjectRepository _projectRepo;
  final CacheRepository _cacheRepo;
  final Logger _logger;
  final GenerateComponentUseCase _generateComponent;
  final EnumGenerator _enumGenerator;

  ComponentGenerationService({
    required ProjectRepository projectRepo,
    required CacheRepository cacheRepo,
    required GeneratorRegistry generatorRegistry,
    required Logger logger,
  })  : _projectRepo = projectRepo,
        _cacheRepo = cacheRepo,
        _logger = logger,
        _generateComponent = GenerateComponentUseCase(
          fileSystem: projectRepo.fileSystem,
          registry: generatorRegistry,
        ),
        _enumGenerator = EnumGenerator();

  /// Generate a single component with cache checking
  ///
  /// Returns the relative file path if generated, null if skipped (unchanged)
  Future<ComponentGenerationResult> generateComponent({
    required ComponentDefinition component,
    required String outputDir,
    TokenDefinition? tokens,
    bool enableCache = true,
  }) async {
    try {
      _logger.info('Generating: ${component.className}');

      // Calculate hash for cache checking
      final hash = _calculateComponentHash(component);

      // Check cache
      if (enableCache &&
          !_cacheRepo.hasComponentChanged(component.className, hash)) {
        _logger.detail(
          '${component.className} unchanged, skipping',
        );
        return ComponentGenerationResult.skipped(component.className);
      }

      // Generate component code
      final filePath = await _generateComponent.execute(
        component: component,
        outputDir: '$outputDir/generated',
        tokens: tokens,
      );

      // Update cache
      if (enableCache) {
        _cacheRepo.updateComponent(component.className, hash);
      }

      final relativePath = 'generated/$filePath';
      _logger.success('Generated: $relativePath');

      return ComponentGenerationResult.success(
        componentName: component.className,
        filesGenerated: [relativePath],
      );
    } catch (e, stackTrace) {
      _logger.err('Failed to generate ${component.className}: $e');
      return ComponentGenerationResult.failure(
        component.className,
        e.toString(),
        stackTrace,
      );
    }
  }

  /// Generate all components in batch
  Future<List<ComponentGenerationResult>> generateAllComponents({
    required List<ComponentDefinition> components,
    required List<TokenDefinition> tokens,
    required String outputDir,
    bool enableCache = true,
  }) async {
    final results = <ComponentGenerationResult>[];

    for (final component in components) {
      // Find matching tokens for this component
      final matchingTokens = tokens
          .where(
            (t) =>
                t.componentName.toLowerCase() ==
                component.className.replaceAll('Meta', '').toLowerCase(),
          )
          .firstOrNull;

      final result = await generateComponent(
        component: component,
        outputDir: outputDir,
        tokens: matchingTokens,
        enableCache: enableCache,
      );

      results.add(result);
    }

    return results;
  }

  /// Generate enum variants for components that have them
  Future<List<EnumGenerationResult>> generateEnumVariants({
    required List<ComponentDefinition> components,
    required String outputDir,
  }) async {
    final results = <EnumGenerationResult>[];

    for (final component in components) {
      if (component.variants.isEmpty) continue;

      try {
        final componentName = component.explicitName ??
            component.className.replaceAll('Meta', '');
        final enumCode = _enumGenerator.generate(
          componentName,
          component.variants,
        );
        final fileName =
            '${StringUtils.toSnakeCase(componentName)}_variant.dart';

        await _projectRepo.saveEnumVariant(
          fileName: fileName,
          code: enumCode,
          outputDir: outputDir,
        );

        final relativePath = 'generated/variants/$fileName';
        _logger.success('Generated enum: $relativePath');

        results.add(EnumGenerationResult.success(
          componentName: componentName,
          filePath: relativePath,
        ));
      } catch (e, stackTrace) {
        _logger.warn('Could not generate enum for ${component.className}: $e');
        results.add(EnumGenerationResult.failure(
          componentName: component.className,
          error: e.toString(),
          stackTrace: stackTrace,
        ));
      }
    }

    return results;
  }

  /// Calculate SHA-256 hash of component definition for cache checking
  String _calculateComponentHash(ComponentDefinition component) {
    // Manually serialize component for hashing since ComponentDefinition doesn't have toJson
    final Map<String, dynamic> componentMap = {
      'name': component.name,
      'className': component.className,
      'explicitName': component.explicitName,
      'variants': component.variants,
      'description': component.description,
      'typeParameters': component.typeParameters,
      'properties': component.properties
          .map((p) => {
                'name': p.name,
                'type': p.type,
                'isRequired': p.isRequired,
                'defaultValue': p.defaultValue,
                'description': p.description,
              })
          .toList(),
    };
    final content = jsonEncode(componentMap);
    final bytes = utf8.encode(content);
    return sha256.convert(bytes).toString();
  }
}

/// Result of component generation operation
class ComponentGenerationResult {
  final String componentName;
  final bool isSuccess;
  final bool isSkipped;
  final List<String> filesGenerated;
  final String? error;
  final StackTrace? stackTrace;

  const ComponentGenerationResult._({
    required this.componentName,
    required this.isSuccess,
    required this.isSkipped,
    required this.filesGenerated,
    this.error,
    this.stackTrace,
  });

  factory ComponentGenerationResult.success({
    required String componentName,
    required List<String> filesGenerated,
  }) =>
      ComponentGenerationResult._(
        componentName: componentName,
        isSuccess: true,
        isSkipped: false,
        filesGenerated: filesGenerated,
      );

  factory ComponentGenerationResult.skipped(String componentName) =>
      ComponentGenerationResult._(
        componentName: componentName,
        isSuccess: true,
        isSkipped: true,
        filesGenerated: const [],
      );

  factory ComponentGenerationResult.failure(
    String componentName,
    String error, [
    StackTrace? stackTrace,
  ]) =>
      ComponentGenerationResult._(
        componentName: componentName,
        isSuccess: false,
        isSkipped: false,
        filesGenerated: const [],
        error: error,
        stackTrace: stackTrace,
      );
}

/// Result of enum generation operation
class EnumGenerationResult {
  final String componentName;
  final bool isSuccess;
  final String? filePath;
  final String? error;
  final StackTrace? stackTrace;

  const EnumGenerationResult._({
    required this.componentName,
    required this.isSuccess,
    this.filePath,
    this.error,
    this.stackTrace,
  });

  factory EnumGenerationResult.success({
    required String componentName,
    required String filePath,
  }) =>
      EnumGenerationResult._(
        componentName: componentName,
        isSuccess: true,
        filePath: filePath,
      );

  factory EnumGenerationResult.failure({
    required String componentName,
    required String error,
    StackTrace? stackTrace,
  }) =>
      EnumGenerationResult._(
        componentName: componentName,
        isSuccess: false,
        error: error,
        stackTrace: stackTrace,
      );
}
