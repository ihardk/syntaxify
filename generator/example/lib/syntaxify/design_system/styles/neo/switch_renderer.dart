part of '../../design_system.dart';

/// Neo brutalist switch renderer
mixin NeoSwitchRenderer on DesignStyle {
  @override
  Widget renderSwitch({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: Container(
        width: 56,
        height: 28,
        decoration: BoxDecoration(
          color:
              value ? (activeColor ?? const Color(0xFFFFD700)) : Colors.white,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: enabled
              ? const [BoxShadow(offset: Offset(2, 2), color: Colors.black)]
              : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
