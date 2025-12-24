part of '../../design_system.dart';

mixin CupertinoSliderRenderer on DesignStyle {
  @override
  SliderTokens get sliderTokens => const SliderTokens(
        activeTrackColor: CupertinoColors.activeBlue,
        inactiveTrackColor: CupertinoColors.systemGrey4,
        thumbColor: CupertinoColors.white,
        overlayColor: Color(0x1F007AFF), // blue with 12% alpha
        trackHeight: 2.0,
        thumbRadius: 14.0,
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
