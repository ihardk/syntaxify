import 'package:flutter/material.dart';
import '../design_system.dart';

/// A design-system-aware radio button widget.
///
/// [AppRadio] automatically adapts its appearance based on the active
/// design style. It delegates rendering to [DesignStyle.renderRadio].
///
/// ## Usage
///
/// ```dart
/// AppRadio<String>(
///   value: 'option1',
///   groupValue: selectedOption,
///   onChanged: (value) => setState(() => selectedOption = value),
/// )
/// ```
///
/// ## Styling
///
/// - **Material**: Standard [Radio]
/// - **Cupertino**: Styled Radio with iOS colors
/// - **Neo**: Brutalist square radio with gold fill and shadow
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
