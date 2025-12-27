part of '../../design_system.dart';

mixin NeoIconButtonRenderer on DesignStyle {
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
    final effectiveColor = color ?? Colors.black;

    Widget button = GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(tokens.padding),
        decoration: BoxDecoration(
          color: variant == IconButtonVariant.filled
              ? tokens.backgroundColor
              : Colors.transparent,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: !isDisabled && variant == IconButtonVariant.filled
              ? const [BoxShadow(offset: Offset(4, 4), color: Colors.black)]
              : null,
        ),
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
