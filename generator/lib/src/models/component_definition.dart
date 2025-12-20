import 'package:freezed_annotation/freezed_annotation.dart';
import 'ast/screen_definition.dart';

part 'component_definition.freezed.dart';

/// Represents a parsed component definition (from a .meta.dart file)
@freezed
sealed class ComponentDefinition with _$ComponentDefinition {
  const factory ComponentDefinition({
    required String name,
    required String className,
    /// Explicit component name from @SyntaxComponent(name: '...')
    /// If null, falls back to className.replaceAll('Meta', '')
    String? explicitName,
    required List<ComponentProp> properties,
    required List<String> variants,
    String? description,
  }) = _ComponentDefinition;
}

/// Represents a property in a component definition
@freezed
sealed class ComponentProp with _$ComponentProp {
  const factory ComponentProp({
    required String name,
    required String type,
    required bool isRequired,
    String? defaultValue,
    String? description,
  }) = _ComponentProp;
}

/// Represents an Enum definition found in the component file
@freezed
sealed class ComponentEnum with _$ComponentEnum {
  const factory ComponentEnum({
    required String name,
    required List<String> values,
    String? description,
  }) = _ComponentEnum;
}

/// Represents the result of parsing component files
@freezed
sealed class ParseResult with _$ParseResult {
  const factory ParseResult({
    required List<ComponentDefinition> components,
    @Default([]) List<ScreenDefinition> screens,
    @Default([]) List<ComponentEnum> enums,
    required List<String> errors,
  }) = _ParseResult;

  const ParseResult._();

  bool get hasErrors => errors.isNotEmpty;
}
