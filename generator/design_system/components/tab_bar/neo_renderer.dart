part of '../../design_system.dart';

mixin NeoTabBarRenderer on DesignStyle {
  @override
  TabBarTokens tabBarTokens(TabBarVariant variant) {
    return TabBarTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderTabBar({
    required List<TabBarItem> tabs,
    required int currentIndex,
    required ValueChanged<int> onTabChange,
    TabBarVariant variant = TabBarVariant.primary,
    bool isScrollable = false,
  }) {
    final tokens = tabBarTokens(variant);

    return Container(
      decoration: BoxDecoration(
        color: tokens.backgroundColor,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 3),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == currentIndex;

            return GestureDetector(
              onTap: () => onTabChange(index),
              child: Container(
                padding: tokens.labelPadding,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.yellow : Colors.transparent,
                  border: const Border(
                    left: BorderSide(color: Colors.black, width: 3),
                    right: BorderSide(color: Colors.black, width: 3),
                  ),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.black,
                          ),
                        ]
                      : null,
                ),
                child: tab.icon != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(
                            name: tab.icon!,
                            size: 20,
                            color: isSelected
                                ? tokens.selectedLabelColor
                                : tokens.unselectedLabelColor,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: tokens.labelStyle.copyWith(
                              color: isSelected
                                  ? tokens.selectedLabelColor
                                  : tokens.unselectedLabelColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        tab.label,
                        style: tokens.labelStyle.copyWith(
                          color: isSelected
                              ? tokens.selectedLabelColor
                              : tokens.unselectedLabelColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
