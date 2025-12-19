import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_definition.freezed.dart';

/// Represents a parsed token definition
@freezed
sealed class TokenDefinition with _$TokenDefinition {
  const factory TokenDefinition({
    required String name,
    required String componentName,
    required List<TokenProperty> properties,
  }) = _TokenDefinition;
}

/// Represents a single token property
@freezed
sealed class TokenProperty with _$TokenProperty {
  const factory TokenProperty({
    required String name,
    required String type,
    String? defaultValue,
    String? description,
  }) = _TokenProperty;
}

/// Collection of tokens for a component
@freezed
sealed class ComponentTokens with _$ComponentTokens {
  const factory ComponentTokens({
    required String componentName,
    required Map<String, TokenDefinition> variantTokens,
  }) = _ComponentTokens;
}
