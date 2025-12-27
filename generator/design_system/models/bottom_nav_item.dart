class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.badge,
  });

  final String icon;
  final String label;
  final String? badge;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavItem &&
          icon == other.icon &&
          label == other.label &&
          badge == other.badge;

  @override
  int get hashCode => icon.hashCode ^ label.hashCode ^ badge.hashCode;
}
