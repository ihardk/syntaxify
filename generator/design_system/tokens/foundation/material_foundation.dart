part of '../../design_system.dart';

/// Material Design 3 Foundation Tokens
///
/// Based on Material Design 3 color system and typography scale.
/// Uses Roboto font family and follows Material Design 3 specifications.
///
/// Reference: https://m3.material.io/foundations/design-tokens
const materialFoundation = FoundationTokens(
  // ========== COLORS (Material Design 3) ==========
  colorPrimary: Color(0xFF6200EE),
  colorOnPrimary: Color(0xFFFFFFFF),
  colorPrimaryContainer: Color(0xFFBB86FC),
  colorOnPrimaryContainer: Color(0xFF3700B3),

  colorSecondary: Color(0xFF03DAC6),
  colorOnSecondary: Color(0xFF000000),

  colorSurface: Color(0xFFFFFFFF),
  colorOnSurface: Color(0xFF1C1B1F),
  colorSurfaceVariant: Color(0xFFE7E0EC),
  colorOnSurfaceVariant: Color(0xFF49454F),

  colorError: Color(0xFFB00020),
  colorOnError: Color(0xFFFFFFFF),

  colorOutline: Color(0xFF79747E),
  colorShadow: Color(0xFF000000),

  colorBackground: Color(0xFFFFFBFE),
  colorOnBackground: Color(0xFF1C1B1F),

  // ========== TYPOGRAPHY (Roboto) ==========
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
  ),

  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
  ),

  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  ),

  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  ),

  // ========== SPACING (8dp grid) ==========
  spacingXs: 4.0,
  spacingSm: 8.0,
  spacingMd: 16.0,
  spacingLg: 24.0,
  spacingXl: 32.0,
  spacing2Xl: 48.0,
  spacing3Xl: 64.0,

  // ========== BORDER RADIUS ==========
  radiusNone: 0.0,
  radiusSm: 4.0,
  radiusMd: 8.0,
  radiusLg: 16.0,
  radiusXl: 24.0,
  radiusFull: 9999.0,

  // ========== ELEVATION ==========
  elevationLevel0: 0.0,
  elevationLevel1: 1.0,
  elevationLevel2: 3.0,
  elevationLevel3: 6.0,
  elevationLevel4: 8.0,
  elevationLevel5: 12.0,

  // ========== BORDER WIDTH ==========
  borderWidthNone: 0.0,
  borderWidthThin: 1.0,
  borderWidthMedium: 2.0,
  borderWidthThick: 4.0,
);
