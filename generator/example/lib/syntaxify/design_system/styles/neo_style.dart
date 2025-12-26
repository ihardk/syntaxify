/// Neo Style
part of '../design_system.dart';

class NeoStyle extends DesignStyle
    with
        NeoButtonRenderer,
        NeoCheckboxRenderer,
        NeoInputRenderer,
        NeoRadioRenderer,
        NeoSliderRenderer,
        NeoSuperCardRenderer,
        NeoTextRenderer,
        NeoToggleRenderer {
  const NeoStyle();

  @override
  FoundationTokens get foundation => neoFoundation;
}
