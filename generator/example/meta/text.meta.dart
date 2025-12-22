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
  /// Maps to: LayoutNode.text(text: ...)
  @Required()
  final String text;

  /// Text variant (displayLarge, headlineMedium, bodyMedium, etc)
  /// Maps to: LayoutNode.text(variant: ...)
  @Optional()
  final TextVariant? variant;

  /// Text alignment
  /// Maps to: LayoutNode.text(align: ...)
  @Optional()
  final TextAlign? align;

  /// Maximum number of lines
  /// Maps to: LayoutNode.text(maxLines: ...)
  @Optional()
  final int? maxLines;

  /// Text overflow behavior
  /// Maps to: LayoutNode.text(overflow: ...)
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
