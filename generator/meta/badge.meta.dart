library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
  description: 'A design-system-aware badge component',
  variants: ['dot', 'count'],
)
class BadgeMeta {
  const BadgeMeta({
    required this.child,
    this.variant = BadgeVariant.count,
    this.count,
    this.showBadge = true,
  });

  @Required()
  final Widget child;

  @Optional()
  @Default('BadgeVariant.count')
  final BadgeVariant variant;

  @Optional()
  final int? count;

  @Optional()
  @Default('true')
  final bool showBadge;
}
