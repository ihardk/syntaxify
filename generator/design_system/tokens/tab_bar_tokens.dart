/// TabBar token definitions
///
/// Pure data class defining styling properties for the TabBar component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/tab_bar_variant.dart';

/// Design tokens for the TabBar component
class TabBarTokens {
  final Color indicatorColor;
  final Color selectedLabelColor;
  final Color unselectedLabelColor;
  final Color backgroundColor;
  final double indicatorWeight;
  final TextStyle labelStyle;
  final EdgeInsets labelPadding;

  const TabBarTokens({
    required this.indicatorColor,
    required this.selectedLabelColor,
    required this.unselectedLabelColor,
    required this.backgroundColor,
    required this.indicatorWeight,
    required this.labelStyle,
    required this.labelPadding,
  });

  /// Create TabBarTokens from foundation tokens
  ///
  /// Maps foundation design primitives to component-specific tokens
  /// based on the tab bar variant.
  factory TabBarTokens.fromFoundation(
    FoundationTokens foundation, {
    required TabBarVariant variant,
  }) {
    switch (variant) {
      case TabBarVariant.primary:
        return TabBarTokens(
          indicatorColor: foundation.colorPrimary,
          selectedLabelColor: foundation.colorPrimary,
          unselectedLabelColor: foundation.colorOnSurfaceVariant,
          backgroundColor: foundation.colorSurface,
          indicatorWeight: 3.0,
          labelStyle: TextStyle(
            fontSize: foundation.fontSizeMd,
            fontWeight: FontWeight.w600,
          ),
          labelPadding: EdgeInsets.symmetric(
            horizontal: foundation.spacingMd,
            vertical: foundation.spacingSm,
          ),
        );
      case TabBarVariant.secondary:
        return TabBarTokens(
          indicatorColor: foundation.colorOnSurface,
          selectedLabelColor: foundation.colorOnSurface,
          unselectedLabelColor: foundation.colorOnSurfaceVariant,
          backgroundColor: Colors.transparent,
          indicatorWeight: 2.0,
          labelStyle: TextStyle(
            fontSize: foundation.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
          labelPadding: EdgeInsets.symmetric(
            horizontal: foundation.spacingSm,
            vertical: foundation.spacingXs,
          ),
        );
    }
  }
}
