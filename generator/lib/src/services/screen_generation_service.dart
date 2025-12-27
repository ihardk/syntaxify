import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:mason_logger/mason_logger.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:syntaxify/src/use_cases/generate_screen.dart';
import 'package:syntaxify/src/infrastructure/repositories/project_repository.dart';
import 'package:syntaxify/src/infrastructure/repositories/cache_repository.dart';
import 'package:syntaxify/src/validation/layout_validator.dart';
import 'package:syntaxify/src/models/validation_error.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';

/// Service for screen generation with validation and caching.
class ScreenGenerationService {
  final ProjectRepository _projectRepo;
  final CacheRepository _cacheRepo;
  final GeneratorRegistry _generatorRegistry;
  final Logger _logger;
  final GenerateScreenUseCase _generateScreen;
  final LayoutValidator _validator;

  ScreenGenerationService({
    required ProjectRepository projectRepo,
    required CacheRepository cacheRepo,
    required GeneratorRegistry generatorRegistry,
    required Logger logger,
  })  : _projectRepo = projectRepo,
        _cacheRepo = cacheRepo,
        _generatorRegistry = generatorRegistry,
        _logger = logger,
        _generateScreen = GenerateScreenUseCase(
          fileSystem: projectRepo.fileSystem,
          registry: generatorRegistry,
        ),
        _validator = const LayoutValidator();

  /// Generate a single screen with validation and cache checking
  Future<ScreenGenerationResult> generateScreen({
    required ScreenDefinition screen,
    required String outputDir,
    String? packageName,
    bool enableCache = true,
  }) async {
    try {
      _logger.info('Validating Screen: ${screen.id}');

      // Validate screen layout
      final validationErrors = _validator.validate(screen.layout, 'screens/${screen.id}');
      if (screen.appBar != null) {
        validationErrors.addAll(_validator.validate(screen.appBar!, 'screens/${screen.id}.appBar'));
      }

      // Collect and report validation errors
      final errors = <String>[];
      final warnings = <String>[];

      for (final error in validationErrors) {
        final message = '${screen.id}: ${error.message} (${error.nodePath ?? "unknown"})';

        if (error.severity == ErrorSeverity.error) {
          _logger.err('  ✗ $message');
          if (error.suggestion != null) {
            _logger.detail('    💡 ${error.suggestion}');
          }
          errors.add(message);
        } else if (error.severity == ErrorSeverity.warning) {
          _logger.warn('  ⚠ $message');
          if (error.suggestion != null) {
            _logger.detail('    💡 ${error.suggestion}');
          }
          warnings.add(message);
        }
      }

      // Skip if validation failed
      if (errors.isNotEmpty) {
        _logger.err('Skipping screen ${screen.id} due to validation errors');
        return ScreenGenerationResult.validationFailed(
          screenName: screen.id,
          errors: errors,
          warnings: warnings,
        );
      }

      _logger.info('Generating Screen: ${screen.id}');

      // Generate screen code
      final filePath = await _generateScreen.execute(
        screen: screen,
        outputDir: outputDir,
        packageName: packageName,
      );

      if (filePath == null) {
        _logger.detail('Skipped: screens/${screen.id}_screen.dart (already exists)');
        return ScreenGenerationResult.skipped(screen.id);
      }

      // Update cache
      if (enableCache) {
        final hash = _calculateScreenHash(screen);
        _cacheRepo.updateScreen(screen.id, hash);
      }

      _logger.success('Generated: $filePath');

      return ScreenGenerationResult.success(
        screenName: screen.id,
        filePath: filePath,
        warnings: warnings,
      );
    } catch (e, stackTrace) {
      _logger.err('Failed to generate screen ${screen.id}: $e');
      return ScreenGenerationResult.failure(
        screenName: screen.id,
        error: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Generate all screens in batch
  Future<List<ScreenGenerationResult>> generateAllScreens({
    required List<ScreenDefinition> screens,
    required String outputDir,
    String? packageName,
    bool enableCache = true,
  }) async {
    final results = <ScreenGenerationResult>[];

    for (final screen in screens) {
      final result = await generateScreen(
        screen: screen,
        outputDir: outputDir,
        packageName: packageName,
        enableCache: enableCache,
      );
      results.add(result);
    }

    return results;
  }

  String _calculateScreenHash(ScreenDefinition screen) {
    final content = jsonEncode(screen.toJson());
    final bytes = utf8.encode(content);
    return sha256.convert(bytes).toString();
  }
}

/// Result of screen generation operation
class ScreenGenerationResult {
  final String screenName;
  final bool isSuccess;
  final bool isSkipped;
  final bool isValidationFailed;
  final String? filePath;
  final List<String> errors;
  final List<String> warnings;
  final String? error;
  final StackTrace? stackTrace;

  const ScreenGenerationResult._({
    required this.screenName,
    required this.isSuccess,
    required this.isSkipped,
    required this.isValidationFailed,
    this.filePath,
    this.errors = const [],
    this.warnings = const [],
    this.error,
    this.stackTrace,
  });

  factory ScreenGenerationResult.success({
    required String screenName,
    required String filePath,
    List<String> warnings = const [],
  }) =>
      ScreenGenerationResult._(
        screenName: screenName,
        isSuccess: true,
        isSkipped: false,
        isValidationFailed: false,
        filePath: filePath,
        warnings: warnings,
      );

  factory ScreenGenerationResult.skipped(String screenName) =>
      ScreenGenerationResult._(
        screenName: screenName,
        isSuccess: true,
        isSkipped: true,
        isValidationFailed: false,
      );

  factory ScreenGenerationResult.validationFailed({
    required String screenName,
    required List<String> errors,
    List<String> warnings = const [],
  }) =>
      ScreenGenerationResult._(
        screenName: screenName,
        isSuccess: false,
        isSkipped: false,
        isValidationFailed: true,
        errors: errors,
        warnings: warnings,
      );

  factory ScreenGenerationResult.failure({
    required String screenName,
    required String error,
    StackTrace? stackTrace,
  }) =>
      ScreenGenerationResult._(
        screenName: screenName,
        isSuccess: false,
        isSkipped: false,
        isValidationFailed: false,
        error: error,
        stackTrace: stackTrace,
      );
}
