part of '../../design_system.dart';

mixin NeoTextRenderer on DesignStyle {
  @override
  TextTokens get textTokens => const TextTokens(
        displayLarge: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          height: 1.1,
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
          height: 1.5,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          height: 1.3,
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
