/// Tab bar item model
///
/// Represents a single tab in a tab bar.
class TabBarItem {
  const TabBarItem({
    required this.label,
    this.icon,
  });

  /// The display label for this tab
  final String label;

  /// Optional icon name for this tab
  final String? icon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabBarItem &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          icon == other.icon;

  @override
  int get hashCode => label.hashCode ^ icon.hashCode;

  @override
  String toString() => 'TabBarItem(label: $label, icon: $icon)';
}
