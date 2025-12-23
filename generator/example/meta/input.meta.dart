/// Input component specification
///
/// Defines the API surface for the AppInput widget.
/// Properties must match DesignStyle.renderInput() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
    description: 'A text input field with optional label, hint, and icons')
class InputMeta {
  /// Text editing controller
  /// Maps to: _fieldNameController (auto-generated from label)
  @Required()
  final TextEditingController? controller;

  /// The label text displayed above or inside the input
  /// Maps to: App.textField(label: ...)
  @Optional()
  final String? label;

  /// Hint text displayed when empty
  /// Maps to: App.textField(hint: ...)
  @Optional()
  final String? hint;

  /// Error text to display
  /// Maps to: App.textField(errorText: ...)
  @Optional()
  final String? errorText;

  /// Whether the text should be obscured (password)
  /// Maps to: App.textField(obscureText: ...)
  @Optional()
  @Default('false')
  final bool obscureText;

  /// Whether the input is enabled
  @Optional()
  @Default('true')
  final bool enabled;

  /// Callback when text changes
  /// Maps to: App.textField(onChanged: ...)
  @Optional()
  final ValueChanged<String>? onChanged;

  /// Callback when text is submitted
  /// Maps to: App.textField(onSubmitted: ...)
  @Optional()
  final ValueChanged<String>? onSubmitted;

  /// Leading icon name
  @Optional()
  final String? prefixIconName;

  /// Trailing icon name
  @Optional()
  final String? suffixIconName;

  /// Callback when prefix icon is tapped
  @Optional()
  final VoidCallback? onTapPrefix;

  /// Callback when suffix icon is tapped
  @Optional()
  final VoidCallback? onTapSuffix;

  /// Keyboard type
  /// Maps to: App.textField(keyboardType: ...)
  @Optional()
  final TextInputType? keyboardType;

  const InputMeta({
    required this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.prefixIconName,
    this.suffixIconName,
    this.onTapPrefix,
    this.onTapSuffix,
    this.keyboardType,
  });
}
