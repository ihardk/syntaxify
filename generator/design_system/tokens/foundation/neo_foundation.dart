part of '../../design_system.dart';

/// Neo-Brutalism Foundation Tokens
///
/// Brutalist design system with bold colors, sharp edges, and thick borders.
/// Inspired by 90s web design and Memphis design movement.
///
/// Characteristics: High contrast, no gradients, thick borders, no shadows
const neoFoundation = FoundationTokens(
  // ========== COLORS (Brutalist Palette) ==========
  colorPrimary: Color(0xFFFFD700), // Gold
  colorOnPrimary: Color(0xFF000000), // Black
  colorPrimaryContainer: Color(0xFFFFA500), // Orange
  colorOnPrimaryContainer: Color(0xFF000000),

  colorSecondary: Color(0xFF00FF00), // Lime green
  colorOnSecondary: Color(0xFF000000),

  colorSurface: Color(0xFFFFFFFF), // White
  colorOnSurface: Color(0xFF000000), // Black
  colorSurfaceVariant: Color(0xFFF0F0F0), // Light gray
  colorOnSurfaceVariant: Color(0xFF000000),

  colorError: Color(0xFFFF0000), // Pure red
  colorOnError: Color(0xFFFFFFFF),

  colorOutline: Color(0xFF000000), // Black borders
  colorShadow: Color(0x00000000), // No shadows in brutalism

  colorBackground: Color(0xFFFFFFFF),
  colorOnBackground: Color(0xFF000000),

  // ========== TYPOGRAPHY (Bold and Direct) ==========
  displayLarge: TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w900, // Extra bold
    letterSpacing: -1.0,
    height: 1.0,
  ),
  displayMedium: TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.0,
  ),
  displaySmall: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 1.0,
  ),

  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.1,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.1,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.2,
  ),

  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
  ),
  titleSmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.5,
  ),

  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    height: 1.4,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    height: 1.4,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    height: 1.4,
  ),

  // ========== SPACING (Generous spacing for brutalism) ==========
  spacingXs: 4.0,
  spacingSm: 12.0, // More generous than Material
  spacingMd: 20.0,
  spacingLg: 32.0,
  spacingXl: 48.0,
  spacing2Xl: 64.0,
  spacing3Xl: 96.0,

  // ========== BORDER RADIUS (Sharp edges!) ==========
  radiusNone: 0.0, // Default for brutalism
  radiusSm: 0.0,
  radiusMd: 0.0,
  radiusLg: 2.0, // Minimal rounding if needed
  radiusXl: 4.0,
  radiusFull: 0.0, // Even "full" is sharp in brutalism

  // ========== ELEVATION (No shadows in brutalism) ==========
  elevationLevel0: 0.0,
  elevationLevel1: 0.0,
  elevationLevel2: 0.0,
  elevationLevel3: 0.0,
  elevationLevel4: 0.0,
  elevationLevel5: 0.0,

  // ========== BORDER WIDTH (Thick borders!) ==========
  borderWidthNone: 0.0,
  borderWidthThin: 2.0,
  borderWidthMedium: 4.0, // Bold and visible
  borderWidthThick: 6.0,
);
