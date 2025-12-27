/// ProgressIndicator token definitions
///
/// Pure data class defining styling properties for the ProgressIndicator component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the ProgressIndicator component
class ProgressIndicatorTokens {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double minHeight;

  const ProgressIndicatorTokens({
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.minHeight,
  });

  /// Create ProgressIndicatorTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens.
  factory ProgressIndicatorTokens.fromFoundation(FoundationTokens foundation) {
    return ProgressIndicatorTokens(
      color: foundation.colorPrimary,
      backgroundColor: foundation.colorSurfaceVariant,
      strokeWidth: 4.0,
      minHeight: 4.0,
    );
  }
}
