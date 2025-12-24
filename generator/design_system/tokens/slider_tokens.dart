/// Slider token definitions
///
/// Pure data class defining styling properties for the Slider component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';

/// Design tokens for the Slider component
class SliderTokens {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final Color overlayColor;
  final double trackHeight;
  final double thumbRadius;
  final BoxShadow? thumbShadow;

  const SliderTokens({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
    required this.overlayColor,
    this.trackHeight = 4.0,
    this.thumbRadius = 10.0,
    this.thumbShadow,
  });
}
