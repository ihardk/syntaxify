/// Material Design Style (Google)
part of '../design_system.dart';

/// Material Design style (Google)
///
/// Implements Google's Material Design language with:
/// - Rounded corners (8dp radius)
/// - Filled and outlined button variants
/// - Native Material widgets (ElevatedButton, FilledButton, OutlinedButton)
class MaterialStyle extends DesignStyle
    with MaterialButtonRenderer, MaterialInputRenderer {
  const MaterialStyle();
}
