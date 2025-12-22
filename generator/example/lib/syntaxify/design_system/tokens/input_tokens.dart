/// Input token definitions
///
/// Pure data class defining styling properties for the Input (TextField) component.
/// Used by DesignStyle implementations to provide style-specific tokens.
library;

import 'package:flutter/material.dart';

/// Design tokens for the Input component
class InputTokens {
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final Color backgroundColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color errorColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets contentPadding;

  const InputTokens({
    required this.textStyle,
    required this.hintStyle,
    required this.backgroundColor,
    required this.borderColor,
    required this.focusBorderColor,
    required this.errorColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.contentPadding,
  });
}
