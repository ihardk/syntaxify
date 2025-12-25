/// Slider token definitions
///
/// Pure data class defining styling properties for the Slider component.
/// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

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

  /// Create SliderTokens from foundation tokens
  factory SliderTokens.fromFoundation(FoundationTokens foundation) {
    return SliderTokens(
      activeTrackColor: foundation.colorPrimary,
      inactiveTrackColor: foundation.colorSurfaceVariant,
      thumbColor: foundation.colorPrimary,
      overlayColor: foundation.colorPrimary.withOpacity(0.12),
      trackHeight: foundation.borderWidthMedium * 2,
      thumbRadius: foundation.spacingSm + 2,
    );
  }
}
