/// Neo-Brutalism Style (Modern/Bold)
///
/// Implements neo-brutalism design language with:
/// - No border radius (sharp corners)
/// - Bold 3px black borders
/// - Hard drop shadows (4px offset)
/// - Vibrant colors (gold, coral)
/// - Uppercase text with heavy font weight

import 'package:flutter/material.dart';

import '../button_tokens.dart';
import '../button_variant.dart';
import '../design_style.dart';

/// Neo-brutalism style (modern/bold)
class NeoStyle extends DesignStyle {
  const NeoStyle();

  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return const ButtonTokens(
          radius: 0,
          borderWidth: 3,
          bgColor: Color(0xFFFFD700), // Gold
          textColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Colors.black,
        );
      case ButtonVariant.secondary:
        return const ButtonTokens(
          radius: 0,
          borderWidth: 3,
          bgColor: Color(0xFFFF6B6B), // Coral
          textColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Colors.black,
        );
      case ButtonVariant.outlined:
        return const ButtonTokens(
          radius: 0,
          borderWidth: 3,
          bgColor: Colors.white,
          textColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Colors.black,
        );
    }
  }

  @override
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    final tokens = buttonTokens(variant);
    final effectiveOnPressed = isDisabled ? null : onPressed;

    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: effectiveOnPressed,
        child: Container(
          padding: tokens.padding,
          decoration: BoxDecoration(
            color:
                isDisabled ? tokens.bgColor.withOpacity(0.5) : tokens.bgColor,
            border: Border.all(color: Colors.black, width: tokens.borderWidth),
            boxShadow: isDisabled
                ? null
                : const [BoxShadow(offset: Offset(4, 4), color: Colors.black)],
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: tokens.textColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}
