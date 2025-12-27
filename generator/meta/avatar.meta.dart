library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(
  description: 'A design-system-aware avatar component',
  variants: ['circle', 'square'],
)
class AvatarMeta {
  const AvatarMeta({
    this.variant = AvatarVariant.circle,
    this.imageSrc,
    this.initials,
    this.size = 40.0,
    this.backgroundColor,
  });

  @Optional()
  @Default('AvatarVariant.circle')
  final AvatarVariant variant;

  @Optional()
  final String? imageSrc;

  @Optional()
  final String? initials;

  @Optional()
  @Default('40.0')
  final double size;

  @Optional()
  final Color? backgroundColor;
}
