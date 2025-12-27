part of '../../design_system.dart';

mixin CupertinoChipRenderer on DesignStyle {
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

    return Container(
      padding: tokens.padding,
      decoration: BoxDecoration(
        color: tokens.backgroundColor,
        border: tokens.borderColor != null
            ? Border.all(color: tokens.borderColor!, width: tokens.borderWidth)
            : null,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            AppIcon(name: icon, size: 18, color: tokens.labelColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(color: tokens.labelColor, fontSize: 14),
          ),
          if (onDeleted != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                size: 18,
                color: tokens.labelColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
