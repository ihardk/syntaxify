/// Divider token definitions
///
/// Pure data class defining styling properties for the Divider component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the Divider component
class DividerTokens {
  final double thickness;
  final Color color;
  final double horizontalMargin;
  final double verticalMargin;

  const DividerTokens({
    required this.thickness,
    required this.color,
    required this.horizontalMargin,
    required this.verticalMargin,
  });

  /// Create DividerTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens.
  factory DividerTokens.fromFoundation(FoundationTokens foundation) {
    return DividerTokens(
      thickness: 1.0,
      color: foundation.colorBorder,
      horizontalMargin: foundation.spacingMd,
      verticalMargin: foundation.spacingXs,
    );
  }
}
