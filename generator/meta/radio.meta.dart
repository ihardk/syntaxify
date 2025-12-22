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
  /// Maps to: LayoutNode.radio(value: ...)
  @Required()
  final T value;

  /// The currently selected value in the group
  /// Maps to: LayoutNode.radio(binding: ...) (wraps binding)
  @Required()
  final T? groupValue;

  /// Callback when this radio is selected
  /// Maps to: LayoutNode.radio(onChanged: ...)
  @Optional()
  final ValueChanged<T?>? onChanged;

  /// Whether the radio is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Active/selected color
  @Optional()
  final Color? activeColor;

  const RadioMeta({
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.enabled = true,
    this.activeColor,
  });
}
