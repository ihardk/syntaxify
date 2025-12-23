/// Checkbox component specification
///
/// Defines the API surface for the AppCheckbox widget.
/// Properties must match DesignStyle.renderCheckbox() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware checkbox component')
class CheckboxMeta {
  /// Whether the checkbox is checked
  /// Maps to: App.checkbox(binding: ...) (wraps binding)
  @Required()
  final bool value;

  /// Callback when checkbox value changes
  /// Maps to: App.checkbox(onChanged: ...)
  @Optional()
  final ValueChanged<bool?>? onChanged;

  /// Whether the checkbox is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Active/checked color
  @Optional()
  final Color? activeColor;

  const CheckboxMeta({
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
