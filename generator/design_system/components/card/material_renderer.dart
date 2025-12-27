part of '../../design_system.dart';

mixin MaterialCardRenderer on DesignStyle {
  @override
  CardTokens cardTokens(CardVariant variant) {
    return CardTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderCard({
    required Widget child,
    CardVariant variant = CardVariant.elevated,
    double? elevation,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
  }) {
    final tokens = cardTokens(variant);
    final effectiveElevation = elevation ?? tokens.elevation;
    final effectivePadding = padding ?? tokens.padding;
    final effectiveBgColor = backgroundColor ?? tokens.bgColor;
    final effectiveBorderColor =
        borderColor ?? tokens.borderColor ?? Colors.transparent;

    return Card(
      elevation: effectiveElevation,
      color: effectiveBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
        side: tokens.borderWidth > 0
            ? BorderSide(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : BorderSide.none,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );
  }
}
