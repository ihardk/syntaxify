part of '../../design_system.dart';

mixin CupertinoAvatarRenderer on DesignStyle {
  @override
  AvatarTokens avatarTokens(AvatarVariant variant) {
    return AvatarTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderAvatar({
    AvatarVariant variant = AvatarVariant.circle,
    String? imageSrc,
    String? initials,
    double size = 40.0,
    Color? backgroundColor,
  }) {
    final tokens = avatarTokens(variant);
    final effectiveBackgroundColor = backgroundColor ?? tokens.defaultBackgroundColor;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: imageSrc == null ? effectiveBackgroundColor : null,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        image: imageSrc != null
            ? DecorationImage(
                image: NetworkImage(imageSrc),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageSrc == null
          ? Center(
              child: initials != null
                  ? Text(initials, style: tokens.textStyle)
                  : Icon(
                      CupertinoIcons.person_fill,
                      size: size * 0.6,
                      color: tokens.textColor,
                    ),
            )
          : null,
    );
  }
}
