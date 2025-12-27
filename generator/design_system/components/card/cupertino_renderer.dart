part of '../../design_system.dart';

mixin CupertinoCardRenderer on DesignStyle {
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
    final effectivePadding = padding ?? tokens.padding;
    final effectiveBgColor = backgroundColor ?? tokens.bgColor;
    final effectiveBorderColor =
        borderColor ?? tokens.borderColor ?? Colors.transparent;

    // Cupertino style uses subtle shadows and rounded corners
    return Container(
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(tokens.radius),
        border: tokens.borderWidth > 0
            ? Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: variant == CardVariant.elevated && tokens.shadow != null
            ? [tokens.shadow!]
            : null,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );
  }
}
