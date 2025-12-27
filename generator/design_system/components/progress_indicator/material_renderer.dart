part of '../../design_system.dart';

mixin MaterialProgressIndicatorRenderer on DesignStyle {
  @override
  ProgressIndicatorTokens get progressIndicatorTokens =>
      ProgressIndicatorTokens.fromFoundation(foundation);

  @override
  Widget renderProgressIndicator({
    ProgressIndicatorVariant variant = ProgressIndicatorVariant.circular,
    double? value,
    Color? color,
    Color? backgroundColor,
    double strokeWidth = 4.0,
  }) {
    final tokens = progressIndicatorTokens;
    final effectiveColor = color ?? tokens.color;
    final effectiveBgColor = backgroundColor ?? tokens.backgroundColor;

    if (variant == ProgressIndicatorVariant.linear) {
      return LinearProgressIndicator(
        value: value,
        backgroundColor: effectiveBgColor,
        valueColor: AlwaysStoppedAnimation(effectiveColor),
        minHeight: tokens.minHeight,
      );
    }

    return CircularProgressIndicator(
      value: value,
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation(effectiveColor),
      backgroundColor: backgroundColor,
    );
  }
}
