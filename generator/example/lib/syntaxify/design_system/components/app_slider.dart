import 'package:flutter/material.dart';
import '../design_system.dart';

/// A design-system-aware slider widget.
///
/// [AppSlider] automatically adapts its appearance based on the active
/// design style. It delegates rendering to [DesignStyle.renderSlider].
///
/// ## Usage
///
/// ```dart
/// AppSlider(
///   value: volume,
///   min: 0.0,
///   max: 100.0,
///   divisions: 10,
///   onChanged: (value) => setState(() => volume = value),
/// )
/// ```
///
/// ## Styling
///
/// - **Material**: Standard [Slider]
/// - **Cupertino**: Native [CupertinoSlider]
/// - **Neo**: Brutalist slider with square thumb and bold track
class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderSlider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
        );
  }
}
