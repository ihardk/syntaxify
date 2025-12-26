/// Cupertino Style
part of '../design_system.dart';

class CupertinoStyle extends DesignStyle
    with
        CupertinoButtonRenderer,
        CupertinoCheckboxRenderer,
        CupertinoInputRenderer,
        CupertinoRadioRenderer,
        CupertinoSliderRenderer,
        CupertinoSuperCardRenderer,
        CupertinoTextRenderer,
        CupertinoToggleRenderer {
  const CupertinoStyle();

  @override
  FoundationTokens get foundation => cupertinoFoundation;
}
