/// Button component specification
///
/// Defines the API surface for the AppButton widget.
/// This file is read by the Forge generator.

// This is a SPECIFICATION file, not runtime code.
// The generator parses these annotations to create the widget.

import 'package:forge/src/annotations/forge_annotations.dart';

@MetaComponent(description: 'A customizable button component')
class ButtonMeta {
  /// The button label text
  @Required()
  final String label;

  /// Callback when button is pressed
  @Optional()
  final void Function()? onPressed;

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
    this.isLoading = false,
    this.isDisabled = false,
  });
}
