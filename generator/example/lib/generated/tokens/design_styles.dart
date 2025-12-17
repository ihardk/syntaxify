/// Forge Design Style System
///
/// Unified theme and style system with renderer pattern:
/// - Sealed DesignStyle provides tokens AND rendering for all components
/// - AppTheme InheritedWidget provides the style to the widget tree
/// - Adding new style = ONE new class extending DesignStyle
/// - Dart's exhaustive checking ensures all renderers are provided

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'button_tokens.dart';

// ============================================
// APP THEME (InheritedWidget)
// ============================================

/// Forge theme provider using sealed DesignStyle pattern.
///
/// Usage:
/// ```dart
/// AppTheme(
///   style: MaterialStyle(),
///   child: MyApp(),
/// )
/// ```
///
/// Access tokens:
/// ```dart
/// final buttonTokens = AppTheme.of(context).style.button;
/// ```
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  /// The design style providing all component tokens and rendering.
  final DesignStyle style;

  /// Get the current [AppTheme] from the widget tree.
  ///
  /// Throws if no [AppTheme] is found in the tree.
  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null,
        'No AppTheme found in context. Wrap your app with AppTheme.');
    return theme!;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return style.runtimeType != oldWidget.style.runtimeType;
  }
}

// ============================================
// VARIANT ENUMS
// ============================================

/// Button component variants
enum ButtonVariant {
  /// Primary action button (emphasized)
  primary,

  /// Secondary action button (less emphasis)
  secondary,

  /// Outlined button (transparent background)
  outlined,
}

// ============================================
// SEALED DESIGN STYLE
// ============================================

/// Base sealed class for all design styles.
///
/// Each style implementation provides:
/// - Token values for each component × variant
/// - Render methods for each component (HOW it looks)
///
/// To add a new style:
/// 1. Create: `class GlassStyle extends DesignStyle { ... }`
/// 2. Implement all `render*()` methods
/// 3. That's it! All components automatically get the new style.
sealed class DesignStyle {
  const DesignStyle();

  /// Style identifier (uses class name automatically)
  String get name =>
      runtimeType.toString().replaceAll('Style', '').toLowerCase();

  /// Get tokens for a button variant
  ButtonTokens buttonTokens(ButtonVariant variant);

  /// Render a button widget (HOW)
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  });
}

// ============================================
// MATERIAL STYLE
// ============================================

/// Material Design style (Google)
class MaterialStyle extends DesignStyle {
  const MaterialStyle();

  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return const ButtonTokens(
          radius: 8,
          borderWidth: 0,
          bgColor: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.secondary:
        return const ButtonTokens(
          radius: 8,
          borderWidth: 0,
          bgColor: Colors.grey,
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.outlined:
        return const ButtonTokens(
          radius: 8,
          borderWidth: 2,
          bgColor: Colors.transparent,
          textColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Colors.blue,
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

    if (isLoading) {
      return ElevatedButton(
        onPressed: null,
        style: _buttonStyle(tokens, variant),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
      case ButtonVariant.secondary:
        return FilledButton.tonal(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
    }
  }

  ButtonStyle _buttonStyle(ButtonTokens tokens, ButtonVariant variant) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return tokens.bgColor.withOpacity(0.5);
        }
        return tokens.bgColor;
      }),
      foregroundColor: WidgetStateProperty.all(tokens.textColor),
      padding: WidgetStateProperty.all(tokens.padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius),
          side: tokens.borderWidth > 0
              ? BorderSide(
                  color: tokens.borderColor ?? tokens.textColor,
                  width: tokens.borderWidth)
              : BorderSide.none,
        ),
      ),
    );
  }
}

// ============================================
// CUPERTINO STYLE
// ============================================

/// Cupertino style (Apple iOS/macOS)
class CupertinoStyle extends DesignStyle {
  const CupertinoStyle();

  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 0,
          bgColor: Color(0xFF007AFF),
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.secondary:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 0,
          bgColor: Color(0xFFE5E5EA),
          textColor: Color(0xFF007AFF),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.outlined:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 1,
          bgColor: Colors.transparent,
          textColor: Color(0xFF007AFF),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Color(0xFF007AFF),
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

    if (isLoading) {
      return CupertinoButton(
        onPressed: null,
        color: tokens.bgColor,
        borderRadius: BorderRadius.circular(tokens.radius),
        child: const CupertinoActivityIndicator(color: Colors.white),
      );
    }

    switch (variant) {
      case ButtonVariant.primary:
        return CupertinoButton.filled(
          onPressed: effectiveOnPressed,
          borderRadius: BorderRadius.circular(tokens.radius),
          child: Text(label),
        );
      case ButtonVariant.secondary:
        return CupertinoButton(
          onPressed: effectiveOnPressed,
          color: tokens.bgColor,
          borderRadius: BorderRadius.circular(tokens.radius),
          child: Text(label, style: TextStyle(color: tokens.textColor)),
        );
      case ButtonVariant.outlined:
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: tokens.borderColor!, width: tokens.borderWidth),
            borderRadius: BorderRadius.circular(tokens.radius),
          ),
          child: CupertinoButton(
            onPressed: effectiveOnPressed,
            child: Text(label, style: TextStyle(color: tokens.textColor)),
          ),
        );
    }
  }
}

// ============================================
// NEO STYLE
// ============================================

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
          bgColor: Color(0xFFFFD700),
          textColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Colors.black,
        );
      case ButtonVariant.secondary:
        return const ButtonTokens(
          radius: 0,
          borderWidth: 3,
          bgColor: Color(0xFFFF6B6B),
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
