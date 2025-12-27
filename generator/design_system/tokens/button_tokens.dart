/// Button token definitions
///
/// Pure data class defining styling properties for the Button component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../variants/button_variant.dart';

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

  /// Create ButtonTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens
  /// based on the button variant.
  factory ButtonTokens.fromFoundation(
    FoundationTokens foundation, {
    required ButtonVariant variant,
  }) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: foundation.colorPrimary,
          textColor: foundation.colorOnPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
      case ButtonVariant.secondary:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: foundation.colorSecondary,
          textColor: foundation.colorOnSecondary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
      case ButtonVariant.outlined:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthMedium,
          bgColor: Colors.transparent,
          textColor: foundation.colorPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
          borderColor: foundation.colorPrimary,
        );
      case ButtonVariant.text:
        return ButtonTokens(
          radius: foundation.radiusMd,
          borderWidth: foundation.borderWidthNone,
          bgColor: Colors.transparent,
          textColor: foundation.colorPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingLg,
            vertical: foundation.spacingSm,
          ),
        );
    }
  }
}
