part of '../../design_system.dart';

/// Cupertino radio renderer
/// Note: Flutter doesn't have CupertinoRadio, so we use custom styled Radio
mixin CupertinoRadioRenderer on DesignStyle {
  @override
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    // Use Material Radio with Cupertino colors since there's no native CupertinoRadio
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? CupertinoColors.activeBlue,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeColor ?? CupertinoColors.activeBlue;
        }
        return CupertinoColors.systemGrey4;
      }),
    );
  }
}
