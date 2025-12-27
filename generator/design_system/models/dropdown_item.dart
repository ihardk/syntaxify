/// Dropdown item model
///
/// Represents a single selectable item in a dropdown.
class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
  });

  /// The value associated with this item
  final T value;

  /// The display label for this item
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownItem<T> &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label;

  @override
  int get hashCode => value.hashCode ^ label.hashCode;

  @override
  String toString() => 'DropdownItem(value: $value, label: $label)';
}
