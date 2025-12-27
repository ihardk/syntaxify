import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';
import '../../design_system/variants/badge_variant.dart';

class BadgeTokens {
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final TextStyle textStyle;

  const BadgeTokens({
    required this.backgroundColor,
    required this.textColor,
    required this.size,
    required this.textStyle,
  });

  factory BadgeTokens.fromFoundation(
    FoundationTokens foundation, {
    required BadgeVariant variant,
  }) {
    switch (variant) {
      case BadgeVariant.dot:
        return BadgeTokens(
          backgroundColor: foundation.colorError,
          textColor: foundation.colorOnError,
          size: 8.0,
          textStyle: const TextStyle(fontSize: 0),
        );
      case BadgeVariant.count:
        return BadgeTokens(
          backgroundColor: foundation.colorError,
          textColor: foundation.colorOnError,
          size: 20.0,
          textStyle: TextStyle(
            fontSize: foundation.fontSizeXs,
            fontWeight: FontWeight.w700,
            color: foundation.colorOnError,
          ),
        );
    }
  }
}
