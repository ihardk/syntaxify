part of '../../design_system.dart';

mixin MaterialChipRenderer on DesignStyle {
  @override
  ChipTokens chipTokens(ChipVariant variant) {
    return ChipTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderChip({
    required String label,
    ChipVariant variant = ChipVariant.filled,
    String? icon,
    VoidCallback? onDeleted,
    bool selected = false,
  }) {
    final tokens = chipTokens(variant);

    return Chip(
      label: Text(label, style: TextStyle(color: tokens.labelColor)),
      avatar: icon != null ? AppIcon(name: icon, size: 18, color: tokens.labelColor) : null,
      onDeleted: onDeleted,
      backgroundColor: tokens.backgroundColor,
      side: tokens.borderColor != null
          ? BorderSide(color: tokens.borderColor!, width: tokens.borderWidth)
          : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      padding: tokens.padding,
    );
  }
}
