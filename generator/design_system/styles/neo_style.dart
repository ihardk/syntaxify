/// Neo Brutalist Design Style
part of '../design_system.dart';

// =============================================================================
// NEO STYLE CLASS
// =============================================================================

/// Neo Brutalist Design style
///
/// Implements neo-brutalism aesthetic with:
/// - Sharp corners (0 radius)
/// - Bold black borders (3px)
/// - Hard drop shadows
/// - Vibrant colors (gold, coral)
class NeoStyle extends DesignStyle
    with
        NeoButtonRenderer,
        NeoInputRenderer,
        NeoTextRenderer,
        NeoCheckboxRenderer,
        NeoSwitchRenderer,
        NeoSliderRenderer,
        NeoRadioRenderer,
        NeoCardRenderer,
        IconRenderer {
  const NeoStyle();

  @override
  FoundationTokens get foundation => neoFoundation;
}
