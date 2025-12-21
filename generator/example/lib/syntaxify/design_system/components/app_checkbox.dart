import 'package:flutter/material.dart';
import '../design_system.dart';

/// A design-system-aware checkbox widget.
///
/// [AppCheckbox] automatically adapts its appearance based on the active
/// design style (Material, Cupertino, or Neo). It delegates rendering to
/// [DesignStyle.renderCheckbox].
///
/// ## Usage
///
/// ```dart
/// AppCheckbox(
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value ?? false),
/// )
/// ```
///
/// ## Styling
///
/// The checkbox appearance is controlled by the style set in [AppTheme]:
/// - **Material**: Standard [Checkbox] with rounded corners
/// - **Cupertino**: Native [CupertinoCheckbox]
/// - **Neo**: Brutalist square checkbox with bold border and shadow
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
