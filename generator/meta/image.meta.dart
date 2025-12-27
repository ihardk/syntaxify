/// Image component specification
///
/// Defines the API surface for the AppImage widget.
/// Properties must match DesignStyle.renderImage() signature.
library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

import 'package:$packageName/syntaxify/design_system/design_system.dart';

@SyntaxComponent(
  description: 'A design-system-aware image component with loading states',
)
class ImageMeta {
  /// Image source (asset path or network URL)
  final String src;

  /// Image width in logical pixels
  @Optional()
  final double? width;

  /// Image height in logical pixels
  @Optional()
  final double? height;

  /// How the image should fit within its bounds
  @Optional()
  @Default('ImageFit.cover')
  final ImageFit fit;

  /// Placeholder widget while loading (network images)
  @Optional()
  final Widget? placeholder;

  /// Error widget if image fails to load
  @Optional()
  final Widget? errorWidget;

  /// Border radius for rounded corners
  @Optional()
  @Default('0.0')
  final double borderRadius;

  const ImageMeta({
    required this.src,
    this.width,
    this.height,
    this.fit = ImageFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius = 0.0,
  });
}
