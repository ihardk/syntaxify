/// Card component specification
///
/// Defines the API surface for the AppCard widget.
/// Properties must match DesignStyle.renderCard() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware card container',
  variants: ['elevated', 'outlined', 'filled'],
)
class CardMeta {
  /// The widget to display inside the card
  final Widget child;

  /// Card variant - references CardVariant enum from design_system
  /// (elevated, outlined, filled)
  @Optional()
  @Default('CardVariant.elevated')
  final CardVariant variant;

  /// Card elevation (shadow depth)
  @Optional()
  @Default('2.0')
  final double elevation;

  /// Internal padding
  @Optional()
  @Default('EdgeInsets.all(16.0)')
  final EdgeInsets padding;

  /// Optional card color (overrides variant default)
  @Optional()
  final Color? backgroundColor;

  /// Optional border color (for outlined variant)
  @Optional()
  final Color? borderColor;

  /// Border width (for outlined variant)
  @Optional()
  @Default('1.0')
  final double borderWidth;

  const CardMeta({
    required this.child,
    this.variant = CardVariant.elevated,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
  });
}
