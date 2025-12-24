part of '../../design_system.dart';

mixin CupertinoCheckboxRenderer on DesignStyle {
  @override
  CheckboxTokens get checkboxTokens => const CheckboxTokens(
        activeColor: CupertinoColors.activeBlue,
        checkColor: CupertinoColors.white,
        borderColor: CupertinoColors.systemGrey,
        borderWidth: 1.0,
        borderRadius: 6.0,
      );

  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = checkboxTokens;

    return CupertinoCheckbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeColor,
      checkColor: tokens.checkColor,
    );
  }
}
