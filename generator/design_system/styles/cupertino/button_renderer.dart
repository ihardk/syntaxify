part of '../../design_system.dart';

mixin CupertinoButtonRenderer on DesignStyle {
  @override
  ButtonTokens buttonTokens(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 0,
          bgColor: Color(0xFF007AFF),
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.secondary:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 0,
          bgColor: Color(0xFFE5E5EA),
          textColor: Color(0xFF007AFF),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
      case ButtonVariant.outlined:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 1,
          bgColor: Colors.transparent,
          textColor: Color(0xFF007AFF),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderColor: Color(0xFF007AFF),
        );
      case ButtonVariant.text:
        return const ButtonTokens(
          radius: 100,
          borderWidth: 0,
          bgColor: Colors.transparent,
          textColor: Color(0xFF007AFF),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );
    }
  }

  @override
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
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
