/// Divider component specification
///
/// Defines the API surface for the AppDivider widget.
/// Properties must match DesignStyle.renderDivider() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware divider line',
  variants: ['horizontal', 'vertical'],
)
class DividerMeta {
  /// Divider orientation (horizontal or vertical)
  @Optional()
  @Default('DividerOrientation.horizontal')
  final DividerOrientation orientation;

  /// Divider thickness in logical pixels
  @Optional()
  @Default('1.0')
  final double thickness;

  /// Divider color (overrides default)
  @Optional()
  final Color? color;

  /// Indent from leading edge
  @Optional()
  @Default('0.0')
  final double indent;

  /// Indent from trailing edge
  @Optional()
  @Default('0.0')
  final double endIndent;

  const DividerMeta({
    this.orientation = DividerOrientation.horizontal,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });
}
