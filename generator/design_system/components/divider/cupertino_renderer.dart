part of '../../design_system.dart';

mixin CupertinoDividerRenderer on DesignStyle {
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

    // Cupertino style uses thinner dividers
    final cupertinoThickness = effectiveThickness * 0.5;

    if (orientation == DividerOrientation.vertical) {
      return Container(
        width: cupertinoThickness,
        margin: EdgeInsets.only(top: indent, bottom: endIndent),
        color: effectiveColor.withValues(alpha: 0.3),
      );
    }

    return Container(
      height: cupertinoThickness,
      margin: EdgeInsets.only(left: indent, right: endIndent),
      color: effectiveColor.withValues(alpha: 0.3),
    );
  }
}
