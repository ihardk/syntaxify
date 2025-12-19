part of '../../design_system.dart';

mixin CupertinoTextRenderer on DesignStyle {
  @override
  TextTokens get textTokens => const TextTokens(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    TextStyle? style;
    if (variant != null) {
      switch (variant) {
        case TextVariant.displayLarge:
          style = textTokens.displayLarge;
          break;
        case TextVariant.headlineMedium:
          style = textTokens.headlineMedium;
          break;
        case TextVariant.titleMedium:
          style = textTokens.titleMedium;
          break;
        case TextVariant.bodyLarge:
          style = textTokens.bodyLarge;
          break;
        case TextVariant.bodyMedium:
          style = textTokens.bodyMedium;
          break;
        case TextVariant.labelSmall:
          style = textTokens.labelSmall;
          break;
      }
    }

    return Text(
      text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
