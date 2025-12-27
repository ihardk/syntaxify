/// Icon component specification
///
/// Defines the API surface for the AppIcon widget.
/// Properties must match DesignStyle.renderIcon() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware icon component',
)
class IconMeta {
  /// The icon name from AppIcons
  final String name;

  /// Icon size in logical pixels
  @Optional()
  @Default('24.0')
  final double size;

  /// Icon color (overrides default)
  @Optional()
  final Color? color;

  /// Semantic label for accessibility
  @Optional()
  final String? semanticLabel;

  const IconMeta({
    required this.name,
    this.size = 24.0,
    this.color,
    this.semanticLabel,
  });
}
