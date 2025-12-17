import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_component.freezed.dart';

/// Represents a parsed meta component definition
@freezed
class MetaComponent with _$MetaComponent {
  const factory MetaComponent({
    required String name,
    required String className,
    required List<MetaField> fields,
    required List<String> variants,
    String? description,
  }) = _MetaComponent;
}

/// Represents a field in a meta component
@freezed
class MetaField with _$MetaField {
  const factory MetaField({
    required String name,
    required String type,
    required bool isRequired,
    String? defaultValue,
    String? description,
  }) = _MetaField;
}

/// Represents the result of parsing meta files
@freezed
class ParseResult with _$ParseResult {
  const factory ParseResult({
    required List<MetaComponent> components,
    required List<String> errors,
  }) = _ParseResult;

  const ParseResult._();

  bool get hasErrors => errors.isNotEmpty;
}
