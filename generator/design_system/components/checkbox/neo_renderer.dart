part of '../../design_system.dart';

mixin NeoCheckboxRenderer on DesignStyle {
  @override
  CheckboxTokens get checkboxTokens => CheckboxTokens.fromFoundation(foundation);

  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = checkboxTokens;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value
              ? (activeColor ?? tokens.activeColor)
              : (tokens.inactiveColor ?? Colors.white),
          border: Border.all(
            color: tokens.borderColor,
            width: tokens.borderWidth,
          ),
          borderRadius: BorderRadius.circular(tokens.borderRadius),
          boxShadow: enabled && tokens.shadow != null ? [tokens.shadow!] : null,
        ),
        child: value
            ? Icon(Icons.check, size: 16, color: tokens.checkColor)
            : null,
      ),
    );
  }
}
