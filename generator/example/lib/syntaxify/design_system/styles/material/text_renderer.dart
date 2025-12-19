part of '../../design_system.dart';

mixin MaterialTextRenderer on DesignStyle {
  @override
  TextTokens get textTokens => const TextTokens(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          height: 1.29,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.50,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.50,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
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
