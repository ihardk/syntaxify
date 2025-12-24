/// Slider component specification
///
/// Defines the API surface for the AppSlider widget.
/// Properties must match DesignStyle.renderSlider() signature.
library;

import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware slider component')
class SliderMeta {
  /// Current slider value
  /// Maps to: App.slider(binding: ...) (wraps binding)
  final double value;

  /// Callback when slider value changes
  /// Maps to: App.slider(onChanged: ...)
  final ValueChanged<double>? onChanged;

  /// Minimum value
  /// Maps to: App.slider(min: ...)
  final double min;

  /// Maximum value
  /// Maps to: App.slider(max: ...)
  final double max;

  /// Number of discrete divisions
  /// Maps to: App.slider(divisions: ...)
  final int? divisions;

  /// Label to display
  /// Maps to: App.slider(label: ...)
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
