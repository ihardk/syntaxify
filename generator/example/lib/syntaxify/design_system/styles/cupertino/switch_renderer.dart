part of '../../design_system.dart';

/// Cupertino switch renderer
mixin CupertinoSwitchRenderer on DesignStyle {
  @override
  Widget renderSwitch({
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
