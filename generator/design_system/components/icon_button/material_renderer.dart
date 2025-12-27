part of '../../design_system.dart';

mixin MaterialIconButtonRenderer on DesignStyle {
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
    final effectiveOnPressed = isDisabled ? null : onPressed;
    final effectiveColor = color ?? tokens.color;

    Widget button;

    switch (variant) {
      case IconButtonVariant.filled:
        button = IconButton.filled(
          onPressed: effectiveOnPressed,
          icon: AppIcon(name: icon, size: size, color: effectiveColor),
          style: IconButton.styleFrom(
            backgroundColor: tokens.backgroundColor,
            foregroundColor: effectiveColor,
          ),
        );
        break;
      case IconButtonVariant.outlined:
        button = IconButton.outlined(
          onPressed: effectiveOnPressed,
          icon: AppIcon(name: icon, size: size, color: effectiveColor),
          style: IconButton.styleFrom(
            side: BorderSide(
              color: tokens.borderColor ?? effectiveColor,
              width: tokens.borderWidth,
            ),
          ),
        );
        break;
      case IconButtonVariant.standard:
        button = IconButton(
          onPressed: effectiveOnPressed,
          icon: AppIcon(name: icon, size: size, color: effectiveColor),
        );
        break;
    }

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }
}
