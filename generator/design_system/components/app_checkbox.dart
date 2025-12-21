import 'package:flutter/material.dart';
import '../design_system.dart';

/// AppCheckbox - Design system checkbox wrapper
///
/// Uses the active design style to render the checkbox.
/// Switch styles by changing `AppTheme.style`.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderCheckbox(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
          activeColor: activeColor,
        );
  }
}
