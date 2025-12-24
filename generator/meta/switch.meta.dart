/// Toggle component specification
///
/// Defines the API surface for the AppSwitch widget.
/// Properties must match DesignStyle.renderSwitch() signature.
library;

import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware switch component')
class SwitchMeta {
  /// Whether the switch is on
  /// Maps to: App.toggle(binding: ...) (wraps binding)
  final bool value;

  /// Callback when switch value changes
  /// Maps to: App.toggle(onChanged: ...)
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is enabled
  final bool enabled;

  /// Active/on color
  final Color? activeColor;

  const SwitchMeta({
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
