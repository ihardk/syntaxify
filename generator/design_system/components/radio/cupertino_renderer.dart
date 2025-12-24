part of '../../design_system.dart';

/// Note: Flutter doesn't have CupertinoRadio, so we use custom styled Radio
mixin CupertinoRadioRenderer on DesignStyle {
  @override
  RadioTokens get radioTokens => const RadioTokens(
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey4,
        borderColor: CupertinoColors.systemGrey,
        borderWidth: 1.0,
      );

  @override
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final tokens = radioTokens;

    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? tokens.activeColor,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeColor ?? tokens.activeColor;
        }
        return tokens.inactiveColor;
      }),
    );
  }
}
