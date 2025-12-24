part of '../../design_system.dart';

mixin MaterialSliderRenderer on DesignStyle {
  @override
  SliderTokens get sliderTokens => SliderTokens.fromFoundation(foundation);

  @override
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  }) {
    final tokens = sliderTokens;

    return Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      activeColor: tokens.activeTrackColor,
      inactiveColor: tokens.inactiveTrackColor,
      thumbColor: tokens.thumbColor,
    );
  }
}
