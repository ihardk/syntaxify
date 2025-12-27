part of '../../design_system.dart';

mixin CupertinoBottomNavRenderer on DesignStyle {
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

    return CupertinoTabBar(
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: AppIcon(name: item.icon, size: tokens.iconSize),
                label: showLabels ? item.label : null,
              ))
          .toList(),
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: tokens.backgroundColor,
      activeColor: tokens.selectedItemColor,
      inactiveColor: tokens.unselectedItemColor,
    );
  }
}
