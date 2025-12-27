/// IconButton component specification
///
/// Defines the API surface for the AppIconButton widget.
/// Properties must match DesignStyle.renderIconButton() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware icon-only button',
  variants: ['filled', 'outlined', 'standard'],
)
class IconButtonMeta {
  /// Icon name from AppIcons
  final String icon;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button variant
  @Optional()
  @Default('IconButtonVariant.standard')
  final IconButtonVariant variant;

  /// Icon size
  @Optional()
  @Default('24.0')
  final double size;

  /// Icon/button color (overrides default)
  @Optional()
  final Color? color;

  /// Whether the button is disabled
  @Optional()
  @Default('false')
  final bool isDisabled;

  /// Tooltip text
  @Optional()
  final String? tooltip;

  const IconButtonMeta({
    required this.icon,
    this.onPressed,
    this.variant = IconButtonVariant.standard,
    this.size = 24.0,
    this.color,
    this.isDisabled = false,
    this.tooltip,
  });
}
