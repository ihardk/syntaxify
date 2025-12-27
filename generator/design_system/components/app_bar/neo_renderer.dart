part of '../../design_system.dart';

mixin NeoAppBarRenderer on DesignStyle {
  @override
  AppBarTokens appBarTokens(AppBarVariant variant) {
    return AppBarTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  PreferredSizeWidget renderAppBar({
    required String title,
    AppBarVariant variant = AppBarVariant.primary,
    String? leading,
    List<String>? actions,
    bool centerTitle = false,
  }) {
    final tokens = appBarTokens(variant);

    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        decoration: BoxDecoration(
          color: tokens.backgroundColor,
          border: const Border(bottom: BorderSide(color: Colors.black, width: 3)),
          boxShadow: const [BoxShadow(offset: Offset(0, 4), color: Colors.black)],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: centerTitle
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null)
              AppIcon(name: leading, color: tokens.foregroundColor, size: 24),
            if (!centerTitle && leading == null) const Spacer(),
            Text(title, style: tokens.titleStyle.copyWith(fontWeight: FontWeight.w900)),
            if (!centerTitle) const Spacer(),
            if (actions != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
                    .map((icon) => Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: AppIcon(
                            name: icon,
                            color: tokens.foregroundColor,
                            size: 24,
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
