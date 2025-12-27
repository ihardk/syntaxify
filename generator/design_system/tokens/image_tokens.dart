/// Image token definitions
///
/// Pure data class defining styling properties for the Image component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the Image component
class ImageTokens {
  final double defaultBorderRadius;
  final Color? placeholderColor;
  final Color? errorColor;
  final BoxFit defaultFit;

  const ImageTokens({
    required this.defaultBorderRadius,
    this.placeholderColor,
    this.errorColor,
    required this.defaultFit,
  });

  /// Create ImageTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens.
  factory ImageTokens.fromFoundation(FoundationTokens foundation) {
    return ImageTokens(
      defaultBorderRadius: foundation.radiusMd,
      placeholderColor: foundation.colorSurfaceVariant,
      errorColor: foundation.colorError,
      defaultFit: BoxFit.cover,
    );
  }
}
