/// IconButton token definitions
///
/// Pure data class defining styling properties for the IconButton component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../variants/icon_button_variant.dart';

/// Design tokens for the IconButton component
class IconButtonTokens {
  final Color color;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double padding;
  final double borderRadius;

  const IconButtonTokens({
    required this.color,
    required this.backgroundColor,
    this.borderColor,
    required this.borderWidth,
    required this.padding,
    required this.borderRadius,
  });

  /// Create IconButtonTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens
  /// based on the button variant.
  factory IconButtonTokens.fromFoundation(
    FoundationTokens foundation, {
    required IconButtonVariant variant,
  }) {
    switch (variant) {
      case IconButtonVariant.filled:
        return IconButtonTokens(
          color: foundation.colorOnPrimary,
          backgroundColor: foundation.colorPrimary,
          borderWidth: foundation.borderWidthNone,
          padding: foundation.spacingSm,
          borderRadius: foundation.radiusMd,
        );
      case IconButtonVariant.outlined:
        return IconButtonTokens(
          color: foundation.colorPrimary,
          backgroundColor: Colors.transparent,
          borderColor: foundation.colorPrimary,
          borderWidth: foundation.borderWidthMedium,
          padding: foundation.spacingSm,
          borderRadius: foundation.radiusMd,
        );
      case IconButtonVariant.standard:
        return IconButtonTokens(
          color: foundation.colorOnSurface,
          backgroundColor: Colors.transparent,
          borderWidth: foundation.borderWidthNone,
          padding: foundation.spacingSm,
          borderRadius: foundation.radiusMd,
        );
    }
  }
}
