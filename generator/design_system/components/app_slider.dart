import 'package:flutter/material.dart';
import '../design_system.dart';

/// AppSlider - Design system slider wrapper
///
/// Uses the active design style to render the slider.
/// Switch styles by changing `AppTheme.style`.
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
