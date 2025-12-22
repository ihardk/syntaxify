part of '../../design_system.dart';

mixin CupertinoCheckboxRenderer on DesignStyle {
  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return CupertinoCheckbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? CupertinoColors.activeBlue,
    );
  }
}
