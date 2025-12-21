part of '../../design_system.dart';

/// Cupertino slider renderer
mixin CupertinoSliderRenderer on DesignStyle {
  @override
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  }) {
    return CupertinoSlider(
      value: value,
      onChanged: onChanged ?? (_) {},
      min: min,
      max: max,
      divisions: divisions,
      activeColor: CupertinoColors.activeBlue,
    );
  }
}
