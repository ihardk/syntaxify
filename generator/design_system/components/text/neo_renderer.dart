part of '../../design_system.dart';

mixin NeoTextRenderer on DesignStyle {
  @override
  TextTokens textTokens(TextVariant variant) {
    return TextTokens.fromFoundation(foundation, variant: variant);
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
