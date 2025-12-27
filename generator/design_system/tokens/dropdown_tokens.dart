/// Dropdown token definitions
///
/// Pure data class defining styling properties for the Dropdown component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/dropdown_variant.dart';

/// Design tokens for the Dropdown component
class DropdownTokens {
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;
  final Color iconColor;
  final Color hintColor;
  final Color disabledColor;

  const DropdownTokens({
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.iconColor,
    required this.hintColor,
    required this.disabledColor,
  });

  /// Create DropdownTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens
  /// based on the dropdown variant.
  factory DropdownTokens.fromFoundation(
    FoundationTokens foundation, {
    required DropdownVariant variant,
  }) {
    switch (variant) {
      case DropdownVariant.standard:
        return DropdownTokens(
          textColor: foundation.colorOnSurface,
          backgroundColor: foundation.colorSurface,
          borderWidth: foundation.borderWidthNone,
          borderRadius: foundation.radiusMd,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingMd,
            vertical: foundation.spacingSm,
          ),
          iconColor: foundation.colorOnSurfaceVariant,
          hintColor: foundation.colorOnSurfaceVariant,
          disabledColor: foundation.colorOnSurface.withOpacity(0.38),
        );
      case DropdownVariant.outlined:
        return DropdownTokens(
          textColor: foundation.colorOnSurface,
          backgroundColor: Colors.transparent,
          borderColor: foundation.colorOutline,
          borderWidth: foundation.borderWidthMedium,
          borderRadius: foundation.radiusMd,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingMd,
            vertical: foundation.spacingSm,
          ),
          iconColor: foundation.colorOnSurfaceVariant,
          hintColor: foundation.colorOnSurfaceVariant,
          disabledColor: foundation.colorOnSurface.withOpacity(0.38),
        );
      case DropdownVariant.underlined:
        return DropdownTokens(
          textColor: foundation.colorOnSurface,
          backgroundColor: Colors.transparent,
          borderColor: foundation.colorOutline,
          borderWidth: foundation.borderWidthThin,
          borderRadius: foundation.borderRadiusNone,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingSm,
            vertical: foundation.spacingSm,
          ),
          iconColor: foundation.colorOnSurfaceVariant,
          hintColor: foundation.colorOnSurfaceVariant,
          disabledColor: foundation.colorOnSurface.withOpacity(0.38),
        );
    }
  }
}
