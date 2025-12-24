part of '../../design_system.dart';

mixin NeoToggleRenderer on DesignStyle {
  @override
  ToggleTokens get toggleTokens => const ToggleTokens(
        activeTrackColor: Color(0xFFFFD700), // Gold
        inactiveTrackColor: Colors.white,
        thumbColor: Colors.black,
        trackBorderWidth: 3.0,
        trackBorderColor: Colors.black,
        shadow: BoxShadow(offset: Offset(2, 2), color: Colors.black),
      );

  @override
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = toggleTokens;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: Container(
        width: 56,
        height: 28,
        decoration: BoxDecoration(
          color: value
              ? (activeColor ?? tokens.activeTrackColor)
              : tokens.inactiveTrackColor,
          border: tokens.trackBorderColor != null
              ? Border.all(
                  color: tokens.trackBorderColor!,
                  width: tokens.trackBorderWidth,
                )
              : null,
          boxShadow: enabled && tokens.shadow != null ? [tokens.shadow!] : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: tokens.thumbColor,
              border: tokens.trackBorderColor != null
                  ? Border.all(
                      color: tokens.trackBorderColor!,
                      width: tokens.trackBorderWidth,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
