import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/bottom_nav_variant.dart';

class BottomNavTokens {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double elevation;
  final EdgeInsets itemPadding;
  final double iconSize;

  const BottomNavTokens({
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.elevation,
    required this.itemPadding,
    required this.iconSize,
  });

  factory BottomNavTokens.fromFoundation(
    FoundationTokens foundation, {
    required BottomNavVariant variant,
  }) {
    switch (variant) {
      case BottomNavVariant.standard:
        return BottomNavTokens(
          backgroundColor: foundation.colorSurface,
          selectedItemColor: foundation.colorPrimary,
          unselectedItemColor: foundation.colorOnSurfaceVariant,
          elevation: foundation.elevationMd,
          itemPadding: EdgeInsets.symmetric(vertical: foundation.spacingXs),
          iconSize: 24.0,
        );
      case BottomNavVariant.floating:
        return BottomNavTokens(
          backgroundColor: foundation.colorSurface,
          selectedItemColor: foundation.colorPrimary,
          unselectedItemColor: foundation.colorOnSurfaceVariant,
          elevation: foundation.elevationLg,
          itemPadding: EdgeInsets.all(foundation.spacingSm),
          iconSize: 24.0,
        );
    }
  }
}
