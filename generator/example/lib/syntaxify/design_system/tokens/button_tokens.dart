/// Button token definitions
///
/// Pure data class defining styling properties for the Button component.
/// Used by DesignStyle implementations to provide style-specific tokens.
library;

import 'package:flutter/material.dart';

/// Design tokens for the Button component
class ButtonTokens {
  final double radius;
  final double borderWidth;
  final Color bgColor;
  final Color textColor;
  final EdgeInsets padding;
  final Color? borderColor;

  const ButtonTokens({
    required this.radius,
    required this.borderWidth,
    required this.bgColor,
    required this.textColor,
    required this.padding,
    this.borderColor,
  });
}
