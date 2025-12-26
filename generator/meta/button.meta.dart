/// Button component specification
///
/// Defines the API surface for the AppButton widget.
/// Properties must match DesignStyle.renderButton() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A customizable button component',
  variants: ['primary', 'secondary', 'outlined', 'text'],
)
class ButtonMeta {
  /// The button label text
  /// Maps to: App.button(label: ...)
  final String label;

  /// Button variant - references ButtonVariant enum from design_system
  /// (primary, secondary, outlined, text)
  /// Maps to: App.button(variant: ...)
  final ButtonVariant variant;

  /// Callback when button is pressed
  /// Maps to: App.button(onPressed: ...)
  final VoidCallback? onPressed;

  /// Whether the button shows loading state
  /// Maps to: App.button(isLoading: ...)
  @Optional()
  @Default('false')
  final bool isLoading;

  /// Whether the button is disabled
  /// Maps to: App.button(isDisabled: ...)
  @Optional()
  @Default('false')
  final bool isDisabled;

  const ButtonMeta({
    required this.label,
    this.variant = ButtonVariant.primary,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });
}
