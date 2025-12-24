/// Radio token definitions
///
/// Pure data class defining styling properties for the Radio component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

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
}
