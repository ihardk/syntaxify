/// Shared design style definitions for Syntax components.
///
/// This is the canonical source for DesignStyle - imported by both
/// token files and generated theme files.
library;

/// Available design styles for Syntax components.
///
/// Each style provides a different visual appearance:
/// - [material]: Google Material Design styling
/// - [cupertino]: Apple iOS/macOS styling
/// - [neo]: Neo-brutalism/modern styling
enum DesignStyle {
  /// Material Design style (Google)
  material,

  /// Cupertino style (Apple iOS/macOS)
  cupertino,

  /// Neo-brutalism style (modern/bold)
  neo,
}
