part of '../../design_system.dart';

mixin CupertinoToggleRenderer on DesignStyle {
  @override
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return CupertinoSwitch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeTrackColor: activeColor ?? CupertinoColors.activeGreen,
    );
  }
}
