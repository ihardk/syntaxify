part of '../../design_system.dart';

mixin MaterialSwitchRenderer on DesignStyle {
  @override
  Widget renderSwitch({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return Toggle(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? Colors.blue,
    );
  }
}
