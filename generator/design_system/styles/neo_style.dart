/// Neo-Brutalism Style (Modern/Bold)
part of '../design_system.dart';

/// Neo-brutalism style (modern/bold)
///
/// Implements neo-brutalism design language with:
/// - No border radius (sharp corners)
/// - Bold 3px black borders
/// - Hard drop shadows (4px offset)
/// - Vibrant colors (gold, coral)
/// - Uppercase text with heavy font weight
class NeoStyle extends DesignStyle
    with
        NeoButtonRenderer,
        NeoInputRenderer,
        NeoTextRenderer,
        NeoCheckboxRenderer,
        NeoSwitchRenderer,
        NeoSliderRenderer,
        NeoRadioRenderer {
  const NeoStyle();
}
