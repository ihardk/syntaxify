import 'package:flutter/material.dart';
import '../design_system.dart';

/// AppSwitch - Design system switch wrapper
///
/// Uses the active design style to render the switch.
/// Switch styles by changing `AppTheme.style`.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return AppTheme.of(context).style.renderSwitch(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
          activeColor: activeColor,
        );
  }
}
