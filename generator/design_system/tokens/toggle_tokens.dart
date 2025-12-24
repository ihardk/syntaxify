/// Toggle token definitions
///
/// Pure data class defining styling properties for the Toggle component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

/// Design tokens for the Toggle component
class ToggleTokens {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final double trackBorderWidth;
  final Color? trackBorderColor;
  final BoxShadow? shadow;

  const ToggleTokens({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
    this.trackBorderWidth = 0.0,
    this.trackBorderColor,
    this.shadow,
  });
}
