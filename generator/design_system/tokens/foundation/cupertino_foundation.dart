part of '../../design_system.dart';

/// iOS Human Interface Guidelines Foundation Tokens
///
/// Based on iOS design principles and San Francisco font system.
/// Uses native iOS colors and follows Apple's design guidelines.
///
/// Reference: https://developer.apple.com/design/human-interface-guidelines/
const cupertinoFoundation = FoundationTokens(
  // ========== COLORS (iOS System Colors) ==========
  colorPrimary: CupertinoColors.activeBlue,
  colorOnPrimary: CupertinoColors.white,
  colorPrimaryContainer: Color(0xFF007AFF), // iOS blue
  colorOnPrimaryContainer: CupertinoColors.white,

  colorSecondary: CupertinoColors.activeGreen,
  colorOnSecondary: CupertinoColors.white,

  colorSurface: CupertinoColors.systemBackground,
  colorOnSurface: CupertinoColors.label,
  colorSurfaceVariant: CupertinoColors.secondarySystemBackground,
  colorOnSurfaceVariant: CupertinoColors.secondaryLabel,

  colorError: CupertinoColors.systemRed,
  colorOnError: CupertinoColors.white,

  colorOutline: CupertinoColors.separator,
  colorShadow: Color(0x1F000000),

  colorBackground: CupertinoColors.systemBackground,
  colorOnBackground: CupertinoColors.label,

  // ========== TYPOGRAPHY (San Francisco) ==========
  displayLarge: TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.374,
  ),
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.364,
  ),
  displaySmall: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.352,
  ),

  headlineLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.38,
  ),
  headlineMedium: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.408,
  ),
  headlineSmall: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.24,
  ),

  titleLarge: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.408,
  ),
  titleMedium: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.24,
  ),
  titleSmall: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.078,
  ),

  bodyLarge: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.408,
  ),
  bodyMedium: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.24,
  ),
  bodySmall: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.078,
  ),

  labelLarge: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.078,
  ),
  labelMedium: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.066,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.12,
  ),

  // ========== SPACING (iOS spacing) ==========
  spacingXs: 4.0,
  spacingSm: 8.0,
  spacingMd: 16.0,
  spacingLg: 24.0,
  spacingXl: 32.0,
  spacing2Xl: 44.0, // iOS safe area
  spacing3Xl: 64.0,

  // ========== BORDER RADIUS (iOS prefers rounded corners) ==========
  radiusNone: 0.0,
  radiusSm: 6.0,
  radiusMd: 10.0,
  radiusLg: 14.0,
  radiusXl: 20.0,
  radiusFull: 9999.0,

  // ========== ELEVATION (iOS uses subtle shadows) ==========
  elevationLevel0: 0.0,
  elevationLevel1: 0.5,
  elevationLevel2: 1.0,
  elevationLevel3: 2.0,
  elevationLevel4: 4.0,
  elevationLevel5: 8.0,

  // ========== BORDER WIDTH ==========
  borderWidthNone: 0.0,
  borderWidthThin: 0.5, // Hairline on iOS
  borderWidthMedium: 1.0,
  borderWidthThick: 2.0,
);
