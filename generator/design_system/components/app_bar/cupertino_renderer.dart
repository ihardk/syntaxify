part of '../../design_system.dart';

mixin CupertinoAppBarRenderer on DesignStyle {
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

    return CupertinoNavigationBar(
      middle: Text(title, style: tokens.titleStyle),
      backgroundColor: tokens.backgroundColor,
      leading: leading != null
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              child: AppIcon(name: leading, color: tokens.foregroundColor),
              onPressed: () {},
            )
          : null,
      trailing: actions != null && actions.isNotEmpty
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: actions
                  .map((icon) => CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: AppIcon(name: icon, color: tokens.foregroundColor),
                        onPressed: () {},
                      ))
                  .toList(),
            )
          : null,
    );
  }
}
