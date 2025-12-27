part of '../../design_system.dart';

mixin CupertinoIconButtonRenderer on DesignStyle {
  @override
  IconButtonTokens iconButtonTokens(IconButtonVariant variant) {
    return IconButtonTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderIconButton({
    required String icon,
    VoidCallback? onPressed,
    IconButtonVariant variant = IconButtonVariant.standard,
    double size = 24.0,
    Color? color,
    bool isDisabled = false,
    String? tooltip,
  }) {
    final tokens = iconButtonTokens(variant);
    final effectiveColor = color ?? tokens.color;

    Widget button = CupertinoButton(
      padding: EdgeInsets.all(tokens.padding),
      onPressed: isDisabled ? null : onPressed,
      child: Container(
        decoration: variant == IconButtonVariant.filled
            ? BoxDecoration(
                color: tokens.backgroundColor,
                borderRadius: BorderRadius.circular(tokens.borderRadius),
              )
            : variant == IconButtonVariant.outlined
                ? BoxDecoration(
                    border: Border.all(
                      color: tokens.borderColor ?? effectiveColor,
                      width: tokens.borderWidth,
                    ),
                    borderRadius: BorderRadius.circular(tokens.borderRadius),
                  )
                : null,
        padding: EdgeInsets.all(tokens.padding),
        child: AppIcon(name: icon, size: size, color: effectiveColor),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }
}
