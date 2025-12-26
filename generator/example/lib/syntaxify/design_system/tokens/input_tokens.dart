/// Input token definitions
///
/// Pure data class defining styling properties for the Input (TextField) component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

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

  /// Create InputTokens from foundation tokens
  factory InputTokens.fromFoundation(FoundationTokens foundation) {
    return InputTokens(
      textStyle: foundation.bodyMedium.copyWith(color: foundation.colorOnSurface),
      hintStyle: foundation.bodyMedium.copyWith(color: foundation.colorOnSurfaceVariant),
      backgroundColor: foundation.colorSurface,
      borderColor: foundation.colorOutline,
      focusBorderColor: foundation.colorPrimary,
      errorColor: foundation.colorError,
      borderWidth: foundation.borderWidthThin,
      borderRadius: foundation.radiusMd,
      contentPadding: EdgeInsets.symmetric(
        horizontal: foundation.spacingMd,
        vertical: foundation.spacingSm,
      ),
    );
  }
}
