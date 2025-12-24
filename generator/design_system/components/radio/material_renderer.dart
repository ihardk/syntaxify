part of '../../design_system.dart';

mixin MaterialRadioRenderer on DesignStyle {
  @override
  RadioTokens get radioTokens => RadioTokens.fromFoundation(foundation);

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
    );
  }
}
