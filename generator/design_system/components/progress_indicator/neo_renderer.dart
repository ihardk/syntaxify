part of '../../design_system.dart';

mixin NeoProgressIndicatorRenderer on DesignStyle {
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
      return Container(
        height: 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          color: effectiveBgColor,
        ),
        child: ClipRect(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(effectiveColor),
            minHeight: 8.0,
          ),
        ),
      );
    }

    // Neo circular with bold styling
    return SizedBox(
      width: strokeWidth * 6,
      height: strokeWidth * 6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
          ),
          // Progress
          CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation(effectiveColor),
            backgroundColor: effectiveBgColor,
          ),
        ],
      ),
    );
  }
}
