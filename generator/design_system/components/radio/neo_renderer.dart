part of '../../design_system.dart';

mixin NeoRadioRenderer on DesignStyle {
  @override
  RadioTokens get radioTokens => const RadioTokens(
        activeColor: Color(0xFFFFD700), // Gold
        inactiveColor: Colors.white,
        borderColor: Colors.black,
        borderWidth: 3.0,
        shadow: BoxShadow(offset: Offset(2, 2), color: Colors.black),
      );

  @override
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  }) {
    final isSelected = value == groupValue;
    final tokens = radioTokens;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(value) : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: tokens.inactiveColor,
          border: Border.all(
            color: tokens.borderColor,
            width: tokens.borderWidth,
          ),
          boxShadow: enabled && tokens.shadow != null ? [tokens.shadow!] : null,
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  color: activeColor ?? tokens.activeColor,
                ),
              )
            : null,
      ),
    );
  }
}
