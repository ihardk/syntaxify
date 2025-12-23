/// Text component specification
///
/// Defines the API surface for the AppText widget.
/// Properties must match DesignStyle.renderText() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A customizable text component')
class TextMeta {
  /// The text content to display
  /// Maps to: App.text(text: ...)
  final String text;

  /// Text variant (displayLarge, headlineMedium, bodyMedium, etc)
  /// Maps to: App.text(variant: ...)
  final TextVariant? variant;

  /// Text alignment
  /// Maps to: App.text(align: ...)
  final TextAlign? align;

  /// Maximum number of lines
  /// Maps to: App.text(maxLines: ...)
  final int? maxLines;

  /// Text overflow behavior
  /// Maps to: App.text(overflow: ...)
  final TextOverflow? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}
