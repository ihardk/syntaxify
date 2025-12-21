import 'package:flutter/material.dart';
import '../design_system.dart';

/// A design-system-aware switch widget.
///
/// [AppSwitch] automatically adapts its appearance based on the active
/// design style. It delegates rendering to [DesignStyle.renderSwitch].
///
/// ## Usage
///
/// ```dart
/// AppSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
/// )
/// ```
///
/// ## Styling
///
/// - **Material**: Standard [Switch]
/// - **Cupertino**: Native [CupertinoSwitch] with green active color
/// - **Neo**: Brutalist toggle with shadow and square edges
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
