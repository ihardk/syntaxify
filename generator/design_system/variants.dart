/// Design System Enums
///
/// Enums used by the design system components.
part of 'design_system.dart';

/// Text style variants
@Variant()
enum TextVariant {
  displayLarge,
  headlineMedium,
  titleMedium,
  bodyLarge,
  bodyMedium,
  labelSmall
}

/// Button component variants
@Variant()
enum ButtonVariant {
  /// Primary action button (emphasized)
  primary,

  /// Secondary action button (less emphasis)
  secondary,

  /// Outlined button (transparent background)
  outlined,

  /// Text-only button (no background)
  text,
}
