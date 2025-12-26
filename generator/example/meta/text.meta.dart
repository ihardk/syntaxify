/// Text component specification
///
/// Defines the API surface for the AppText widget.
/// Properties must match DesignStyle.renderText() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:example/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A customizable text component',
  variants: [
    'displayLarge',
    'headlineMedium',
    'titleMedium',
    'bodyLarge',
    'bodyMedium',
    'labelMedium',
    'labelSmall',
  ],
)
class TextMeta {
  /// The text content to display
  /// Maps to: App.text(text: ...)
  @Required()
  final String text;

  /// Text variant (displayLarge, headlineMedium, bodyMedium, etc)
  /// Maps to: App.text(variant: ...)
  @Optional()
  final TextVariant? variant;

  /// Text alignment
  /// Maps to: App.text(align: ...)
  @Optional()
  final TextAlign? align;

  /// Maximum number of lines
  /// Maps to: App.text(maxLines: ...)
  @Optional()
  final int? maxLines;

  /// Text overflow behavior
  /// Maps to: App.text(overflow: ...)
  @Optional()
  final TextOverflow? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}
