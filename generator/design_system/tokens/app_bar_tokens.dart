import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/app_bar_variant.dart';

class AppBarTokens {
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final TextStyle titleStyle;

  const AppBarTokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.elevation,
    required this.titleStyle,
  });

  factory AppBarTokens.fromFoundation(
    FoundationTokens foundation, {
    required AppBarVariant variant,
  }) {
    switch (variant) {
      case AppBarVariant.primary:
        return AppBarTokens(
          backgroundColor: foundation.colorPrimary,
          foregroundColor: foundation.colorOnPrimary,
          elevation: foundation.elevationSm,
          titleStyle: TextStyle(
            fontSize: foundation.fontSizeLg,
            fontWeight: FontWeight.w600,
            color: foundation.colorOnPrimary,
          ),
        );
      case AppBarVariant.transparent:
        return AppBarTokens(
          backgroundColor: Colors.transparent,
          foregroundColor: foundation.colorOnSurface,
          elevation: 0,
          titleStyle: TextStyle(
            fontSize: foundation.fontSizeLg,
            fontWeight: FontWeight.w600,
            color: foundation.colorOnSurface,
          ),
        );
    }
  }
}
