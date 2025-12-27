part of '../../design_system.dart';

mixin MaterialTabBarRenderer on DesignStyle {
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

    return DefaultTabController(
      length: tabs.length,
      initialIndex: currentIndex,
      child: Container(
        color: tokens.backgroundColor,
        child: TabBar(
          isScrollable: isScrollable,
          onTap: onTabChange,
          indicatorColor: tokens.indicatorColor,
          indicatorWeight: tokens.indicatorWeight,
          labelColor: tokens.selectedLabelColor,
          unselectedLabelColor: tokens.unselectedLabelColor,
          labelStyle: tokens.labelStyle,
          labelPadding: tokens.labelPadding,
          tabs: tabs.map((tab) {
            return Tab(
              text: tab.label,
              icon: tab.icon != null
                  ? AppIcon(name: tab.icon!, size: 20)
                  : null,
              iconMargin: tab.icon != null
                  ? const EdgeInsets.only(bottom: 4)
                  : EdgeInsets.zero,
            );
          }).toList(),
        ),
      ),
    );
  }
}
