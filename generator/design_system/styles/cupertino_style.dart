/// Cupertino Design Style (Apple)
part of '../design_system.dart';

// =============================================================================
// CUPERTINO STYLE CLASS
// =============================================================================

/// Cupertino Design style (Apple)
///
/// Implements Apple Human Interface Guidelines with:
/// - Pill-shaped buttons (full radius)
/// - iOS-native widgets (CupertinoButton, CupertinoTextField)
/// - System colors (CupertinoColors)
class CupertinoStyle extends DesignStyle
    with
        CupertinoButtonRenderer,
        CupertinoInputRenderer,
        CupertinoTextRenderer,
        CupertinoCheckboxRenderer,
        CupertinoSwitchRenderer,
        CupertinoSliderRenderer,
        CupertinoRadioRenderer,
        CupertinoCardRenderer,
        IconRenderer,
        CupertinoDividerRenderer,
        CupertinoImageRenderer,
        CupertinoProgressIndicatorRenderer,
        CupertinoIconButtonRenderer {
  const CupertinoStyle();

  @override
  FoundationTokens get foundation => cupertinoFoundation;
}
