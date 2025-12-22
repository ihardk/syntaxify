/// Text token definitions
///
/// Pure data class defining styling properties for the Text component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

/// Design tokens for the Text component
class TextTokens {
  final TextStyle displayLarge;
  final TextStyle headlineMedium;
  final TextStyle titleMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle labelSmall;

  const TextTokens({
    required this.displayLarge,
    required this.headlineMedium,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.labelSmall,
  });
}
