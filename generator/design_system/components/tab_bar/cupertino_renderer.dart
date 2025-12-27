part of '../../design_system.dart';

mixin CupertinoTabBarRenderer on DesignStyle {
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
      color: tokens.backgroundColor,
      padding: tokens.labelPadding,
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: currentIndex,
        onValueChanged: (value) {
          if (value != null) {
            onTabChange(value);
          }
        },
        children: Map.fromIterable(
          List.generate(tabs.length, (i) => i),
          key: (i) => i as int,
          value: (i) {
            final tab = tabs[i as int];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: tab.icon != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(name: tab.icon!, size: 20),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: tokens.labelStyle.copyWith(
                            color: i == currentIndex
                                ? tokens.selectedLabelColor
                                : tokens.unselectedLabelColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      tab.label,
                      style: tokens.labelStyle.copyWith(
                        color: i == currentIndex
                            ? tokens.selectedLabelColor
                            : tokens.unselectedLabelColor,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
