import 'package:flutter/material.dart';
import '../design_system.dart';

/// AppRadio - Design system radio wrapper
///
/// Uses the active design style to render the radio.
/// Switch styles by changing `AppTheme.style`.
class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderRadio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          enabled: enabled,
          activeColor: activeColor,
        );
  }
}
