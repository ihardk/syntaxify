/// Icon token definitions
///
/// Pure data class defining styling properties for the Icon component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the Icon component
class IconTokens {
  final double defaultSize;
  final Color defaultColor;
  final double smallSize;
  final double mediumSize;
  final double largeSize;

  const IconTokens({
    required this.defaultSize,
    required this.defaultColor,
    required this.smallSize,
    required this.mediumSize,
    required this.largeSize,
  });

  /// Create IconTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens.
  factory IconTokens.fromFoundation(FoundationTokens foundation) {
    return IconTokens(
      defaultSize: 24.0,
      defaultColor: foundation.colorOnSurface,
      smallSize: 16.0,
      mediumSize: 24.0,
      largeSize: 32.0,
    );
  }
}
