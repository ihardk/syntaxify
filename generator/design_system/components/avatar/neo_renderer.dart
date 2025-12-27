part of '../../design_system.dart';

mixin NeoAvatarRenderer on DesignStyle {
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
    final effectiveBackgroundColor = backgroundColor ?? Colors.yellow;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: imageSrc == null ? effectiveBackgroundColor : null,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: variant == AvatarVariant.circle
            ? BorderRadius.circular(size / 2)
            : null,
        boxShadow: const [
          BoxShadow(offset: Offset(4, 4), color: Colors.black)
        ],
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
                  ? Text(
                      initials,
                      style: tokens.textStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: size * 0.6,
                      color: Colors.black,
                    ),
            )
          : null,
    );
  }
}
