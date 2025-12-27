library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// A design-system-aware bottom navigation bar component.
///
/// Provides bottom navigation with design-system-specific rendering.
@SyntaxComponent(
  description: 'A design-system-aware bottom navigation bar',
  variants: ['standard', 'floating'],
)
class BottomNavMeta {
  const BottomNavMeta({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.variant = BottomNavVariant.standard,
    this.showLabels = true,
  });

  /// List of navigation items
  @Required()
  final List<BottomNavItem> items;

  /// Currently selected item index
  @Required()
  final int currentIndex;

  /// Callback when item is tapped
  @Required()
  final ValueChanged<int> onTap;

  /// Bottom navigation variant
  @Optional()
  @Default('BottomNavVariant.standard')
  final BottomNavVariant variant;

  /// Whether to show labels
  @Optional()
  @Default('true')
  final bool showLabels;
}

/// Bottom navigation item model
class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.badge,
  });

  final String icon;
  final String label;
  final String? badge;
}
