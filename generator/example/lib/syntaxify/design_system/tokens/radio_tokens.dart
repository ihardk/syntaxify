/// Radio token definitions
///
/// Pure data class defining styling properties for the Radio component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the Radio component
class RadioTokens {
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;
  final double borderWidth;
  final BoxShadow? shadow;

  const RadioTokens({
    required this.activeColor,
    required this.inactiveColor,
    required this.borderColor,
    this.borderWidth = 2.0,
    this.shadow,
  });

  /// Create RadioTokens from foundation tokens
  factory RadioTokens.fromFoundation(FoundationTokens foundation) {
    return RadioTokens(
      activeColor: foundation.colorPrimary,
      inactiveColor: foundation.colorSurfaceVariant,
      borderColor: foundation.colorOutline,
      borderWidth: foundation.borderWidthMedium,
    );
  }
}
