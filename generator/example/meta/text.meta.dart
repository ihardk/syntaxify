/// Text component specification
///
/// Defines the API surface for the AppText widget.
/// Properties must match DesignStyle.renderText() signature.
library;

import 'package:example/syntaxify/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A customizable text component', variants: [
  'displayLarge',
  'headlineMedium',
  'titleMedium',
  'bodyMedium',
  'bodyLarge',
  'labelMedium',
  'labelSmall'
])
class TextMeta {
  final String text;
  final TextVariant? variant;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextMeta({
    required this.text,
    this.variant,
    this.align,
    this.maxLines,
    this.overflow,
  });
}
