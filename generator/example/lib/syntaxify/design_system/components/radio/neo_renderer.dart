part of '../../design_system.dart';

mixin NeoRadioRenderer on DesignStyle {
  @override
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(value) : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: enabled
              ? const [BoxShadow(offset: Offset(2, 2), color: Colors.black)]
              : null,
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  color: activeColor ?? const Color(0xFFFFD700),
                ),
              )
            : null,
      ),
    );
  }
}
