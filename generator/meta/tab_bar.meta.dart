library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

/// A design-system-aware tab bar component for navigation.
///
/// Provides tabbed navigation with design-system-specific rendering.
@SyntaxComponent(
  description: 'A design-system-aware tab navigation bar',
  variants: ['primary', 'secondary'],
)
class TabBarMeta {
  const TabBarMeta({
    required this.tabs,
    required this.currentIndex,
    required this.onTabChange,
    this.variant = TabBarVariant.primary,
    this.isScrollable = false,
  });

  /// List of tab items (label and optional icon)
  @Required()
  final List<TabBarItem> tabs;

  /// Currently selected tab index
  @Required()
  final int currentIndex;

  /// Callback when tab changes
  @Required()
  final ValueChanged<int> onTabChange;

  /// Tab bar variant
  @Optional()
  @Default('TabBarVariant.primary')
  final TabBarVariant variant;

  /// Whether tabs are scrollable
  @Optional()
  @Default('false')
  final bool isScrollable;
}

/// Tab bar item model
class TabBarItem {
  const TabBarItem({
    required this.label,
    this.icon,
  });

  final String label;
  final String? icon;
}
