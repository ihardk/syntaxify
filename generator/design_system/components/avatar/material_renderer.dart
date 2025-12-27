part of '../../design_system.dart';

mixin MaterialAvatarRenderer on DesignStyle {
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

    if (imageSrc != null) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageSrc),
        backgroundColor: effectiveBackgroundColor,
      );
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: effectiveBackgroundColor,
      child: initials != null
          ? Text(initials, style: tokens.textStyle)
          : Icon(Icons.person, size: size * 0.6, color: tokens.textColor),
    );
  }
}
