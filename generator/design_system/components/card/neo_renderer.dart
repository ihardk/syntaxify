part of '../../design_system.dart';

mixin NeoCardRenderer on DesignStyle {
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
    final effectiveBorderColor = borderColor ?? tokens.borderColor ?? Colors.black;

    // Neo style with hard shadows and borders
    return Container(
      decoration: BoxDecoration(
        color: effectiveBgColor,
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: variant == CardVariant.elevated
            ? const [
                BoxShadow(
                  offset: Offset(4, 4),
                  color: Colors.black,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );
  }
}
