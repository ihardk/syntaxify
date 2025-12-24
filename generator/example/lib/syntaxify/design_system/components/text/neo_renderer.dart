part of '../../design_system.dart';

mixin NeoTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    switch (variant) {
      case TextVariant.displayLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
          color: Colors.black,
          fontSize: 60,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          height: 1.1,
        );
      case TextVariant.headlineMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.2,
        );
      case TextVariant.titleMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.4,
        );
      case TextVariant.bodyLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          height: 1.6,
        );
      case TextVariant.bodyMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
          height: 1.5,
        );
      case TextVariant.labelMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          color: Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          height: 1.35,
        );
      case TextVariant.labelSmall:
        return const TextTokens(
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          height: 1.3,
        );
    }
  }

  @override
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final effectiveVariant = variant ?? TextVariant.bodyMedium;
    final tokens = textTokens(effectiveVariant);

    return Text(
      text,
      style: tokens.style.copyWith(
        color: tokens.color,
        letterSpacing: tokens.letterSpacing,
        height: tokens.height,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
