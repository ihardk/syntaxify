import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/avatar_variant.dart';

class AvatarTokens {
  final Color defaultBackgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle textStyle;

  const AvatarTokens({
    required this.defaultBackgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.textStyle,
  });

  factory AvatarTokens.fromFoundation(
    FoundationTokens foundation, {
    required AvatarVariant variant,
  }) {
    switch (variant) {
      case AvatarVariant.circle:
        return AvatarTokens(
          defaultBackgroundColor: foundation.colorPrimary,
          textColor: foundation.colorOnPrimary,
          borderRadius: foundation.radiusFull,
          textStyle: TextStyle(
            fontSize: foundation.fontSizeMd,
            fontWeight: FontWeight.w600,
            color: foundation.colorOnPrimary,
          ),
        );
      case AvatarVariant.square:
        return AvatarTokens(
          defaultBackgroundColor: foundation.colorPrimary,
          textColor: foundation.colorOnPrimary,
          borderRadius: foundation.radiusMd,
          textStyle: TextStyle(
            fontSize: foundation.fontSizeMd,
            fontWeight: FontWeight.w600,
            color: foundation.colorOnPrimary,
          ),
        );
    }
  }
}
