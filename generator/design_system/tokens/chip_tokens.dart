import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/chip_variant.dart';

class ChipTokens {
  final Color backgroundColor;
  final Color labelColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;

  const ChipTokens({
    required this.backgroundColor,
    required this.labelColor,
    this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
  });

  factory ChipTokens.fromFoundation(
    FoundationTokens foundation, {
    required ChipVariant variant,
  }) {
    switch (variant) {
      case ChipVariant.filled:
        return ChipTokens(
          backgroundColor: foundation.colorPrimary,
          labelColor: foundation.colorOnPrimary,
          borderWidth: foundation.borderWidthNone,
          borderRadius: foundation.radiusFull,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingMd,
            vertical: foundation.spacingXs,
          ),
        );
      case ChipVariant.outlined:
        return ChipTokens(
          backgroundColor: Colors.transparent,
          labelColor: foundation.colorPrimary,
          borderColor: foundation.colorPrimary,
          borderWidth: foundation.borderWidthMedium,
          borderRadius: foundation.radiusFull,
          padding: EdgeInsets.symmetric(
            horizontal: foundation.spacingMd,
            vertical: foundation.spacingXs,
          ),
        );
    }
  }
}
