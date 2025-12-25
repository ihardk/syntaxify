part of '../../design_system.dart';

mixin NeoButtonRenderer on DesignStyle {
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

    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: effectiveOnPressed,
        child: Container(
          padding: tokens.padding,
          decoration: BoxDecoration(
            color: isDisabled
                ? tokens.bgColor.withValues(alpha: 0.5)
                : tokens.bgColor,
            border: Border.all(color: Colors.black, width: tokens.borderWidth),
            boxShadow: isDisabled
                ? null
                : const [BoxShadow(offset: Offset(4, 4), color: Colors.black)],
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: tokens.textColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}
