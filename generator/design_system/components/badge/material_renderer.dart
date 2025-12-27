part of '../../design_system.dart';

mixin MaterialBadgeRenderer on DesignStyle {
  @override
  BadgeTokens badgeTokens(BadgeVariant variant) {
    return BadgeTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderBadge({
    required Widget child,
    BadgeVariant variant = BadgeVariant.count,
    int? count,
    bool showBadge = true,
  }) {
    final tokens = badgeTokens(variant);

    if (!showBadge) return child;

    return Badge(
      label: variant == BadgeVariant.count && count != null
          ? Text(count > 99 ? '99+' : count.toString(), style: tokens.textStyle)
          : null,
      backgroundColor: tokens.backgroundColor,
      isLabelVisible: variant == BadgeVariant.count,
      smallSize: tokens.size,
      child: child,
    );
  }
}
