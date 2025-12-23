/// Radio component specification
///
/// Defines the API surface for the AppRadio widget.
/// Properties must match DesignStyle.renderRadio<T>() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware radio button component')
class RadioMeta<T> {
  /// The value this radio represents
  /// Maps to: App.radio(value: ...)
  final T value;

  /// The currently selected value in the group
  /// Maps to: App.radio(binding: ...) (wraps binding)
  final T? groupValue;

  /// Callback when this radio is selected
  /// Maps to: App.radio(onChanged: ...)
  final ValueChanged<T?>? onChanged;

  /// Whether the radio is enabled
  final bool enabled;

  /// Active/selected color
  final Color? activeColor;

  const RadioMeta({
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
