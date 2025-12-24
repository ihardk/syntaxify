part of '../../design_system.dart';

mixin MaterialSliderRenderer on DesignStyle {
  @override
  SliderTokens get sliderTokens => const SliderTokens(
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Color(0x3D0000FF), // blue with 24% alpha
        thumbColor: Colors.blue,
        overlayColor: Color(0x1F0000FF), // blue with 12% alpha
        trackHeight: 4.0,
        thumbRadius: 10.0,
      );

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
