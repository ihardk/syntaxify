part of '../../design_system.dart';

mixin NeoDividerRenderer on DesignStyle {
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
    // Neo style uses thicker, bolder dividers
    final neoThickness = (thickness ?? tokens.thickness) * 2;
    final effectiveColor = color ?? Colors.black;

    if (orientation == DividerOrientation.vertical) {
      return Container(
        width: neoThickness,
        margin: EdgeInsets.only(top: indent, bottom: endIndent),
        decoration: BoxDecoration(
          color: effectiveColor,
          border: Border.all(color: Colors.black, width: 1),
        ),
      );
    }

    return Container(
      height: neoThickness,
      margin: EdgeInsets.only(left: indent, right: endIndent),
      decoration: BoxDecoration(
        color: effectiveColor,
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }
}
