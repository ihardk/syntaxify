part of '../../design_system.dart';

mixin MaterialToggleRenderer on DesignStyle {
  @override
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return Switch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? Colors.blue,
    );
  }
}
