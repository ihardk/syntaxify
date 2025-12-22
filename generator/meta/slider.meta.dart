/// Slider component specification
///
/// Defines the API surface for the AppSlider widget.
/// Properties must match DesignStyle.renderSlider() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware slider component')
class SliderMeta {
  /// Current slider value
  /// Maps to: LayoutNode.slider(binding: ...) (wraps binding)
  @Required()
  final double value;

  /// Callback when slider value changes
  /// Maps to: LayoutNode.slider(onChanged: ...)
  @Optional()
  final ValueChanged<double>? onChanged;

  /// Minimum value
  /// Maps to: LayoutNode.slider(min: ...)
  @Optional()
  @Default('0.0')
  final double min;

  /// Maximum value
  /// Maps to: LayoutNode.slider(max: ...)
  @Optional()
  @Default('1.0')
  final double max;

  /// Number of discrete divisions
  /// Maps to: LayoutNode.slider(divisions: ...)
  @Optional()
  final int? divisions;

  /// Label to display
  /// Maps to: LayoutNode.slider(label: ...)
  @Optional()
  final String? label;

  const SliderMeta({
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
  });
}
