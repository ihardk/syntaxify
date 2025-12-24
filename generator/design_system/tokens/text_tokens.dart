/// Text token definitions
///
/// Pure data class defining styling properties for the Text component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

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
}
