part of '../../design_system.dart';

mixin NeoBottomNavRenderer on DesignStyle {
  @override
  BottomNavTokens bottomNavTokens(BottomNavVariant variant) {
    return BottomNavTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderBottomNav({
    required List<BottomNavItem> items,
    required int currentIndex,
    required ValueChanged<int> onTap,
    BottomNavVariant variant = BottomNavVariant.standard,
    bool showLabels = true,
  }) {
    final tokens = bottomNavTokens(variant);

    return Container(
      decoration: BoxDecoration(
        color: tokens.backgroundColor,
        border: const Border(top: BorderSide(color: Colors.black, width: 3)),
        boxShadow: const [BoxShadow(offset: Offset(0, -4), color: Colors.black)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: tokens.itemPadding,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.yellow : Colors.transparent,
                  border: const Border(
                    left: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(
                      name: item.icon,
                      size: tokens.iconSize,
                      color: isSelected
                          ? tokens.selectedItemColor
                          : tokens.unselectedItemColor,
                    ),
                    if (showLabels) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: isSelected
                              ? tokens.selectedItemColor
                              : tokens.unselectedItemColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
