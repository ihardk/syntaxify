part of '../../design_system.dart';

mixin CupertinoButtonRenderer on DesignStyle {
  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    return ButtonTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderButton({
    required String label,
    ButtonVariant variant = ButtonVariant.primary,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    final tokens = buttonTokens(variant);
    final effectiveOnPressed = isDisabled ? null : onPressed;

    if (isLoading) {
      return CupertinoButton(
        onPressed: null,
        color: tokens.bgColor,
        borderRadius: BorderRadius.circular(tokens.radius),
        child: const CupertinoActivityIndicator(color: Colors.white),
      );
    }

    switch (variant) {
      case ButtonVariant.primary:
        return CupertinoButton.filled(
          onPressed: effectiveOnPressed,
          borderRadius: BorderRadius.circular(tokens.radius),
          child: Text(label),
        );
      case ButtonVariant.secondary:
        return CupertinoButton(
          onPressed: effectiveOnPressed,
          color: tokens.bgColor,
          borderRadius: BorderRadius.circular(tokens.radius),
          child: Text(label, style: TextStyle(color: tokens.textColor)),
        );
      case ButtonVariant.outlined:
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: tokens.borderColor!,
              width: tokens.borderWidth,
            ),
            borderRadius: BorderRadius.circular(tokens.radius),
          ),
          child: CupertinoButton(
            onPressed: effectiveOnPressed,
            child: Text(label, style: TextStyle(color: tokens.textColor)),
          ),
        );
      case ButtonVariant.text:
        return CupertinoButton(
          onPressed: effectiveOnPressed,
          child: Text(label, style: TextStyle(color: tokens.textColor)),
        );
    }
  }
}
