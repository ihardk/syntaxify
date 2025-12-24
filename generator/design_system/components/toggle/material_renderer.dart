part of '../../design_system.dart';

mixin MaterialToggleRenderer on DesignStyle {
  @override
  ToggleTokens get toggleTokens => const ToggleTokens(
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.white,
      );

  @override
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = toggleTokens;

    return Switch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeTrackColor,
      inactiveTrackColor: tokens.inactiveTrackColor,
      inactiveThumbColor: tokens.thumbColor,
    );
  }
}
