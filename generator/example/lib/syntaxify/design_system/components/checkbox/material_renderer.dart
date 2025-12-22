part of '../../design_system.dart';

mixin MaterialCheckboxRenderer on DesignStyle {
  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return Checkbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
