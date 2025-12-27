/// ProgressIndicator component specification
///
/// Defines the API surface for the AppProgressIndicator widget.
/// Properties must match DesignStyle.renderProgressIndicator() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware loading indicator',
  variants: ['circular', 'linear'],
)
class ProgressIndicatorMeta {
  /// Indicator variant (circular or linear)
  @Optional()
  @Default('ProgressIndicatorVariant.circular')
  final ProgressIndicatorVariant variant;

  /// Progress value (0.0 to 1.0), null for indeterminate
  @Optional()
  final double? value;

  /// Indicator color (overrides default)
  @Optional()
  final Color? color;

  /// Background/track color (for linear variant)
  @Optional()
  final Color? backgroundColor;

  /// Stroke width (for circular variant)
  @Optional()
  @Default('4.0')
  final double strokeWidth;

  const ProgressIndicatorMeta({
    this.variant = ProgressIndicatorVariant.circular,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
  });
}
