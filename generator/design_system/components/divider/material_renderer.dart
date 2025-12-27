part of '../../design_system.dart';

mixin MaterialDividerRenderer on DesignStyle {
  @override
  DividerTokens get dividerTokens => DividerTokens.fromFoundation(foundation);

  @override
  Widget renderDivider({
    DividerOrientation orientation = DividerOrientation.horizontal,
    double? thickness,
    Color? color,
    double indent = 0.0,
    double endIndent = 0.0,
  }) {
    final tokens = dividerTokens;
    final effectiveThickness = thickness ?? tokens.thickness;
    final effectiveColor = color ?? tokens.color;

    if (orientation == DividerOrientation.vertical) {
      return VerticalDivider(
        thickness: effectiveThickness,
        color: effectiveColor,
        indent: indent,
        endIndent: endIndent,
      );
    }

    return Divider(
      thickness: effectiveThickness,
      color: effectiveColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
