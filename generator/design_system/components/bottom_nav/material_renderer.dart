part of '../../design_system.dart';

mixin MaterialBottomNavRenderer on DesignStyle {
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

    return BottomNavigationBar(
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: AppIcon(name: item.icon, size: tokens.iconSize),
                label: showLabels ? item.label : null,
              ))
          .toList(),
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: tokens.backgroundColor,
      selectedItemColor: tokens.selectedItemColor,
      unselectedItemColor: tokens.unselectedItemColor,
      elevation: tokens.elevation,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: showLabels,
      showUnselectedLabels: showLabels,
    );
  }
}
