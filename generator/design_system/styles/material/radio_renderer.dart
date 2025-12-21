part of '../../design_system.dart';

/// Material radio renderer
mixin MaterialRadioRenderer on DesignStyle {
  @override
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: enabled ? onChanged : null,
      activeColor: activeColor ?? Colors.blue,
    );
  }
}
