/// Card token definitions
///
/// Pure data class defining styling properties for the Card component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../generated/variants/card_variant.dart';

/// Design tokens for the Card component
class CardTokens {
  final double radius;
  final double elevation;
  final Color bgColor;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final BoxShadow? shadow;

  const CardTokens({
    required this.radius,
    required this.elevation,
    required this.bgColor,
    this.borderColor,
    required this.borderWidth,
    required this.padding,
    this.shadow,
  });

  /// Create CardTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens
  /// based on the card variant.
  factory CardTokens.fromFoundation(
    FoundationTokens foundation, {
    required CardVariant variant,
  }) {
    switch (variant) {
      case CardVariant.elevated:
        return CardTokens(
          radius: foundation.radiusLg,
          elevation: foundation.elevationMd,
          bgColor: foundation.colorSurface,
          borderWidth: foundation.borderWidthNone,
          padding: EdgeInsets.all(foundation.spacingMd),
          shadow: BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        );
      case CardVariant.outlined:
        return CardTokens(
          radius: foundation.radiusLg,
          elevation: 0,
          bgColor: foundation.colorSurface,
          borderColor: foundation.colorBorder,
          borderWidth: foundation.borderWidthMedium,
          padding: EdgeInsets.all(foundation.spacingMd),
        );
      case CardVariant.filled:
        return CardTokens(
          radius: foundation.radiusLg,
          elevation: 0,
          bgColor: foundation.colorSurfaceVariant,
          borderWidth: foundation.borderWidthNone,
          padding: EdgeInsets.all(foundation.spacingMd),
        );
    }
  }
}
