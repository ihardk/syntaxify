part of '../../design_system.dart';

mixin MaterialAppBarRenderer on DesignStyle {
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

    return AppBar(
      title: Text(title, style: tokens.titleStyle),
      backgroundColor: tokens.backgroundColor,
      foregroundColor: tokens.foregroundColor,
      elevation: tokens.elevation,
      centerTitle: centerTitle,
      leading: leading != null
          ? IconButton(
              icon: AppIcon(name: leading),
              onPressed: () {},
            )
          : null,
      actions: actions
          ?.map((icon) => IconButton(
                icon: AppIcon(name: icon),
                onPressed: () {},
              ))
          .toList(),
    );
  }
}
