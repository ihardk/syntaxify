/// Material Design Style (Google)
part of '../design_system.dart';

// =============================================================================
// MATERIAL STYLE CLASS
// =============================================================================

/// Material Design style (Google)
///
/// Implements Google's Material Design language with:
/// - Rounded corners (8dp radius)
/// - Filled and outlined button variants
/// - Native Material widgets (ElevatedButton, FilledButton, OutlinedButton)
class MaterialStyle extends DesignStyle
    with
        MaterialButtonRenderer,
        MaterialInputRenderer,
        MaterialTextRenderer,
        MaterialCheckboxRenderer,
        MaterialSwitchRenderer,
        MaterialSliderRenderer,
        MaterialRadioRenderer,
        MaterialCardRenderer,
        IconRenderer {
  const MaterialStyle();

  @override
  FoundationTokens get foundation => materialFoundation;
}
