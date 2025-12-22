part of '../../design_system.dart';

mixin NeoCheckboxRenderer on DesignStyle {
  @override
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color:
              value ? (activeColor ?? const Color(0xFFFFD700)) : Colors.white,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: enabled
              ? const [BoxShadow(offset: Offset(2, 2), color: Colors.black)]
              : null,
        ),
        child: value
            ? const Icon(Icons.check, size: 16, color: Colors.black)
            : null,
      ),
    );
  }
}
