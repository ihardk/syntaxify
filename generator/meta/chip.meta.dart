library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
  description: 'A design-system-aware chip component',
  variants: ['filled', 'outlined'],
)
class ChipMeta {
  const ChipMeta({
    required this.label,
    this.variant = ChipVariant.filled,
    this.icon,
    this.onDeleted,
    this.selected = false,
  });

  @Required()
  final String label;

  @Optional()
  @Default('ChipVariant.filled')
  final ChipVariant variant;

  @Optional()
  final String? icon;

  @Optional()
  final VoidCallback? onDeleted;

  @Optional()
  @Default('false')
  final bool selected;
}
