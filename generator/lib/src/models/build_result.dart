import 'package:freezed_annotation/freezed_annotation.dart';

part 'build_result.freezed.dart';

/// Result of a build operation
@freezed
class BuildResult with _$BuildResult {
  const factory BuildResult({
    required int filesGenerated,
    required List<String> generatedFiles,
    required Duration duration,
    @Default([]) List<String> warnings,
    @Default([]) List<String> errors,
  }) = _BuildResult;

  const BuildResult._();

  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;
}
