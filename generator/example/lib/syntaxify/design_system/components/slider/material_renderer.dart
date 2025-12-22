part of '../../design_system.dart';

mixin MaterialSliderRenderer on DesignStyle {
  @override
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  }) {
    return Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      activeColor: Colors.blue,
      inactiveColor: Colors.blue.withValues(alpha: 0.3),
    );
  }
}
