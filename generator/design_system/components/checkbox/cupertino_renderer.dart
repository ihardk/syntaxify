part of '../../design_system.dart';

mixin CupertinoCheckboxRenderer on DesignStyle {
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

    return CupertinoCheckbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeColor,
      checkColor: tokens.checkColor,
    );
  }
}
