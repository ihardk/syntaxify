part of '../../design_system.dart';

mixin CupertinoToggleRenderer on DesignStyle {
  @override
  ToggleTokens get toggleTokens => const ToggleTokens(
        activeTrackColor: CupertinoColors.activeGreen,
        inactiveTrackColor: CupertinoColors.systemGrey,
        thumbColor: CupertinoColors.white,
      );

  @override
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = toggleTokens;

    return CupertinoSwitch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeTrackColor,
      trackColor: tokens.inactiveTrackColor,
      thumbColor: tokens.thumbColor,
    );
  }
}
