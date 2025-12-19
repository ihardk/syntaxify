/// Button component specification
///
/// Defines the API surface for the AppButton widget.
/// This file is read by the Syntax generator.

// This is a SPECIFICATION file, not runtime code.
// The generator parses these annotations to create the widget.

import 'package:syntaxify/syntax.dart';

@SyntaxComponent(description: 'A customizable button component')
class ButtonMeta {
  /// The button label text
  @Required()
  final String label;

  /// The action to trigger (e.g. 'action:login')
  @Optional()
  final String? onPressed;

  /// Button variant (filled, outlined, etc)
  @Optional()
  final String? variant;

  /// Button size (sm, md, lg)
  @Optional()
  final String? size;

  /// Whether the button shows loading state
  @Optional()
  @Default('false')
  final bool isLoading;

  /// Whether the button is disabled
  @Optional()
  @Default('false')
  final bool isDisabled;

  const ButtonMeta({
    required this.label,
    this.onPressed,
    this.variant,
    this.size,
    this.isLoading = false,
    this.isDisabled = false,
  });
}
