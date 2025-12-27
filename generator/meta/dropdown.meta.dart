library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// A design-system-aware dropdown/select component.
///
/// Supports selecting a single value from a list of options with
/// design-system-specific rendering (Material, Cupertino, Neo).
@SyntaxComponent(
  description: 'A design-system-aware dropdown selector',
  variants: ['standard', 'outlined', 'underlined'],
)
class DropdownMeta<T> {
  const DropdownMeta({
    required this.value,
    required this.items,
    required this.onChanged,
    this.variant = DropdownVariant.standard,
    this.label,
    this.hint,
    this.enabled = true,
    this.errorText,
  });

  /// Currently selected value
  @Required()
  final T? value;

  /// List of dropdown items (value, label pairs)
  @Required()
  final List<DropdownItem<T>> items;

  /// Callback when value changes
  @Required()
  final ValueChanged<T?>? onChanged;

  /// Dropdown variant
  @Optional()
  @Default('DropdownVariant.standard')
  final DropdownVariant variant;

  /// Label text above dropdown
  @Optional()
  final String? label;

  /// Hint text when no value selected
  @Optional()
  final String? hint;

  /// Whether dropdown is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Error text to display
  @Optional()
  final String? errorText;
}

/// Dropdown item model
class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}
