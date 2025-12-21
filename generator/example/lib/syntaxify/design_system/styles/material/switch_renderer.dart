part of '../../design_system.dart';

/// Material switch renderer
mixin MaterialSwitchRenderer on DesignStyle {
  @override
  Widget renderSwitch({
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
