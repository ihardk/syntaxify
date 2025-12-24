part of '../../design_system.dart';

mixin CupertinoSliderRenderer on DesignStyle {
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

    return CupertinoSlider(
      value: value,
      onChanged: onChanged ?? (_) {},
      min: min,
      max: max,
      divisions: divisions,
      activeColor: tokens.activeTrackColor,
      thumbColor: tokens.thumbColor,
    );
  }
}
