part of '../../design_system.dart';

mixin MaterialCheckboxRenderer on DesignStyle {
  @override
  CheckboxTokens get checkboxTokens => const CheckboxTokens(
        activeColor: Colors.blue,
        checkColor: Colors.white,
        borderColor: Colors.grey,
        borderWidth: 2.0,
        borderRadius: 4.0,
      );

  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = checkboxTokens;

    return Checkbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeColor,
      checkColor: tokens.checkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
    );
  }
}
