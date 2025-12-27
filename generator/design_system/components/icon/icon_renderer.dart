part of '../../design_system.dart';

/// Shared icon renderer for all design styles
///
/// Icons are universal and don't need style-specific variations.
/// All styles (Material, Cupertino, Neo) use this same implementation.
mixin IconRenderer on DesignStyle {
  @override
  IconTokens get iconTokens => IconTokens.fromFoundation(foundation);

  @override
  Widget renderIcon({
    required String name,
    double? size,
    Color? color,
    String? semanticLabel,
  }) {
    final tokens = iconTokens;
    final effectiveSize = size ?? tokens.defaultSize;
    final effectiveColor = color ?? tokens.defaultColor;

    final iconData = AppIcons.getIcon(name);

    if (iconData == null) {
      // Return a placeholder if icon not found
      return Icon(
        Icons.error_outline,
        size: effectiveSize,
        color: Colors.red,
        semanticLabel: semanticLabel ?? 'Icon not found: $name',
      );
    }

    return Icon(
      iconData,
      size: effectiveSize,
      color: effectiveColor,
      semanticLabel: semanticLabel,
    );
  }
}
