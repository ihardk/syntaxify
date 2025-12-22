/// Switch component specification
///
/// Defines the API surface for the AppSwitch widget.
/// Properties must match DesignStyle.renderSwitch() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware switch component')
class SwitchMeta {
  /// Whether the switch is on
  /// Maps to: LayoutNode.switchWidget(binding: ...) (wraps binding)
  @Required()
  final bool value;

  /// Callback when switch value changes
  /// Maps to: LayoutNode.switchWidget(onChanged: ...)
  @Optional()
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Active/on color
  @Optional()
  final Color? activeColor;

  const SwitchMeta({
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
