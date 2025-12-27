part of '../../design_system.dart';

mixin CupertinoBadgeRenderer on DesignStyle {
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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: variant == BadgeVariant.count
                ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                : null,
            decoration: BoxDecoration(
              color: tokens.backgroundColor,
              shape: variant == BadgeVariant.dot
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius: variant == BadgeVariant.count
                  ? BorderRadius.circular(10)
                  : null,
            ),
            constraints: BoxConstraints(
              minWidth: tokens.size,
              minHeight: tokens.size,
            ),
            child: variant == BadgeVariant.count && count != null
                ? Center(
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: tokens.textStyle,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
