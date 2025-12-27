/// Text token definitions
///
/// Pure data class defining styling properties for the Text component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../variants/text_variant.dart';

/// Design tokens for the Text component
class TextTokens {
  final TextStyle style;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double? height;

  const TextTokens({
    required this.style,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.letterSpacing = 0.0,
    this.height,
  });

  /// Create TextTokens from foundation tokens
  factory TextTokens.fromFoundation(
    FoundationTokens foundation, {
    required TextVariant variant,
  }) {
    final TextStyle baseStyle;
    switch (variant) {
      case TextVariant.displayLarge:
        baseStyle = foundation.displayLarge;
        break;
      case TextVariant.headlineMedium:
        baseStyle = foundation.headlineMedium;
        break;
      case TextVariant.titleMedium:
        baseStyle = foundation.titleMedium;
        break;
      case TextVariant.bodyMedium:
        baseStyle = foundation.bodyMedium;
        break;
      case TextVariant.bodyLarge:
        baseStyle = foundation.bodyLarge;
        break;
      case TextVariant.labelMedium:
        baseStyle = foundation.labelMedium;
        break;
      case TextVariant.labelSmall:
        baseStyle = foundation.labelSmall;
        break;
    }

    return TextTokens(
      style: baseStyle.copyWith(color: foundation.colorOnSurface),
      color: foundation.colorOnSurface,
      fontSize: baseStyle.fontSize ?? 14,
      fontWeight: baseStyle.fontWeight ?? FontWeight.normal,
      letterSpacing: baseStyle.letterSpacing ?? 0.0,
      height: baseStyle.height,
    );
  }
}
