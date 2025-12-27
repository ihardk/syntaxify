library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
  description: 'A design-system-aware app bar component',
  variants: ['primary', 'transparent'],
)
class AppBarMeta {
  const AppBarMeta({
    required this.title,
    this.variant = AppBarVariant.primary,
    this.leading,
    this.actions,
    this.centerTitle = false,
  });

  @Required()
  final String title;

  @Optional()
  @Default('AppBarVariant.primary')
  final AppBarVariant variant;

  @Optional()
  final String? leading;

  @Optional()
  final List<String>? actions;

  @Optional()
  @Default('false')
  final bool centerTitle;
}
