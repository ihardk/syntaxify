part of '../../design_system.dart';

mixin MaterialButtonRenderer on DesignStyle {
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
      return ElevatedButton(
        onPressed: null,
        style: _buttonStyle(tokens, variant),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
      case ButtonVariant.secondary:
        return FilledButton.tonal(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
      case ButtonVariant.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: _buttonStyle(tokens, variant),
          child: Text(label),
        );
    }
  }

  ButtonStyle _buttonStyle(ButtonTokens tokens, ButtonVariant variant) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return tokens.bgColor.withValues(alpha: 0.5);
        }
        return tokens.bgColor;
      }),
      foregroundColor: WidgetStateProperty.all(tokens.textColor),
      padding: WidgetStateProperty.all(tokens.padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius),
          side: tokens.borderWidth > 0
              ? BorderSide(
                  color: tokens.borderColor ?? tokens.textColor,
                  width: tokens.borderWidth,
                )
              : BorderSide.none,
        ),
      ),
    );
  }
}
