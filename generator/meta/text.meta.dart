/// Text component specification
///
/// Defines the API surface for the AppText widget.
/// This file is read by the Syntax generator.

// This is a SPECIFICATION file, not runtime code.
// The generator parses these annotations to create the widget.

import 'package:syntax/syntax.dart';

@SyntaxComponent(description: 'A customizable text component')
class TextMeta {
  /// The text content to display
  @Required()
  final String text;

  /// Text variant (displayLarge, headlineMedium, bodyMedium, etc)
  @Optional()
  final String? variant;

  /// Text alignment
  @Optional()
  final String? align;

  /// Maximum number of lines
  @Optional()
  final int? maxLines;

  /// Text overflow behavior
  @Optional()
  final String? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}
