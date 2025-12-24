part of '../../design_system.dart';

mixin MaterialTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    switch (variant) {
      case TextVariant.displayLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
          color: Colors.black87,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        );
      case TextVariant.headlineMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          color: Colors.black87,
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        );
      case TextVariant.titleMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.50,
        );
      case TextVariant.bodyLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.50,
        );
      case TextVariant.bodyMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        );
      case TextVariant.labelMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        );
      case TextVariant.labelSmall:
        return const TextTokens(
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          color: Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
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
