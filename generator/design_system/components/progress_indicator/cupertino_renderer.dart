part of '../../design_system.dart';

mixin CupertinoProgressIndicatorRenderer on DesignStyle {
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

    if (variant == ProgressIndicatorVariant.linear) {
      // Cupertino doesn't have a built-in linear progress indicator
      // Use Material's LinearProgressIndicator with Cupertino styling
      final effectiveColor = color ?? tokens.color;
      final effectiveBgColor = backgroundColor ?? tokens.backgroundColor.withValues(alpha: 0.3);

      return LinearProgressIndicator(
        value: value,
        backgroundColor: effectiveBgColor,
        valueColor: AlwaysStoppedAnimation(effectiveColor),
        minHeight: 2.0, // Thinner for iOS
      );
    }

    // Circular uses CupertinoActivityIndicator (iOS native)
    // Note: CupertinoActivityIndicator doesn't support progress value
    return CupertinoActivityIndicator(
      radius: strokeWidth * 2.5, // Approximate sizing
      color: color,
    );
  }
}
