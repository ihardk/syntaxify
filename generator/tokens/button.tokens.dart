/// Button token definitions
///
/// Pure data class defining all styling properties for the Button component.
/// The generator uses this to create the theme tokens.

import 'package:flutter/material.dart';

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
}

/// Token library providing tokens for each design style
class ButtonTokensLibrary {
  /// Material Design style tokens
  static ButtonTokens material() => const ButtonTokens(
        radius: 8,
        borderWidth: 0,
        bgColor: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      );

  /// iOS/Cupertino style tokens
  static ButtonTokens cupertino() => const ButtonTokens(
        radius: 100, // Pill shape
        borderWidth: 0,
        bgColor: Color(0xFF007AFF),
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      );

  /// Neo-brutalism style tokens
  static ButtonTokens neo() => const ButtonTokens(
        radius: 0,
        borderWidth: 3,
        bgColor: Color(0xFFFFD700), // Gold
        textColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        borderColor: Colors.black,
      );

  /// Get tokens for a specific design style
  static ButtonTokens forStyle(DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return material();
      case DesignStyle.cupertino:
        return cupertino();
      case DesignStyle.neo:
        return neo();
    }
  }
}

/// Available design styles
enum DesignStyle {
  material,
  cupertino,
  neo,
}
