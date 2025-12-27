part of '../../design_system.dart';

mixin NeoBadgeRenderer on DesignStyle {
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
          right: -6,
          top: -6,
          child: Container(
            padding: variant == BadgeVariant.count
                ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                : null,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(offset: Offset(2, 2), color: Colors.black)
              ],
            ),
            constraints: BoxConstraints(
              minWidth: tokens.size,
              minHeight: tokens.size,
            ),
            child: variant == BadgeVariant.count && count != null
                ? Center(
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: tokens.textStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
