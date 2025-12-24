/// Toggle component specification
///
/// Defines the API surface for the AppToggle widget.
/// Properties must match DesignStyle.renderToggle() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware switch component')
class ToggleMeta {
  /// Whether the switch is on
  /// Maps to: App.toggle(binding: ...) (wraps binding)
  @Required()
  final bool value;

  /// Callback when switch value changes
  /// Maps to: App.toggle(onChanged: ...)
  @Optional()
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Active/on color
  @Optional()
  final Color? activeColor;

  const ToggleMeta({
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
