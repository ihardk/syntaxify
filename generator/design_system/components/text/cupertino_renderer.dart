part of '../../design_system.dart';

mixin CupertinoTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    switch (variant) {
      case TextVariant.displayLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
          color: CupertinoColors.label,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        );
      case TextVariant.headlineMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          color: CupertinoColors.label,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        );
      case TextVariant.titleMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          color: CupertinoColors.label,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        );
      case TextVariant.bodyLarge:
        return const TextTokens(
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          color: CupertinoColors.label,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        );
      case TextVariant.bodyMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          color: CupertinoColors.label,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        );
      case TextVariant.labelMedium:
        return const TextTokens(
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          color: CupertinoColors.secondaryLabel,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        );
      case TextVariant.labelSmall:
        return const TextTokens(
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          color: CupertinoColors.secondaryLabel,
          fontSize: 11,
          fontWeight: FontWeight.w500,
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
