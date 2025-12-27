part of '../../design_system.dart';

mixin NeoChipRenderer on DesignStyle {
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
        color: selected ? Colors.yellow : tokens.backgroundColor,
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: const [BoxShadow(offset: Offset(2, 2), color: Colors.black)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            AppIcon(name: icon, size: 18, color: Colors.black),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (onDeleted != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDeleted,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
