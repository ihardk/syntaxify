/// Checkbox token definitions
///
/// Pure data class defining styling properties for the Checkbox component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

/// Design tokens for the Checkbox component
class CheckboxTokens {
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color? inactiveColor;
  final BoxShadow? shadow;

  const CheckboxTokens({
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.borderWidth,
    this.borderRadius = 4.0,
    this.inactiveColor,
    this.shadow,
  });
}
