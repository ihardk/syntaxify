part of '../../design_system.dart';

/// Foundation design tokens
///
/// Single source of truth for colors, typography, spacing, elevation, and borders.
/// Each design style (Material, Cupertino, Neo) provides its own foundation values.
///
/// This class follows Material Design 3 token structure for consistency and
/// compatibility with industry-standard design systems.
///
/// Reference: https://m3.material.io/foundations/design-tokens
class FoundationTokens {
  // ========== COLOR SYSTEM ==========
  // Primary colors
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorPrimaryContainer;
  final Color colorOnPrimaryContainer;

  // Secondary colors
  final Color colorSecondary;
  final Color colorOnSecondary;

  // Surface colors
  final Color colorSurface;
  final Color colorOnSurface;
  final Color colorSurfaceVariant;
  final Color colorOnSurfaceVariant;

  // Utility colors
  final Color colorError;
  final Color colorOnError;
  final Color colorOutline;
  final Color colorShadow;

  // Background colors
  final Color colorBackground;
  final Color colorOnBackground;

  // ========== TYPOGRAPHY SCALE ==========
  // Display styles (largest)
  final TextStyle displayLarge; // 57sp
  final TextStyle displayMedium; // 45sp
  final TextStyle displaySmall; // 36sp

  // Headline styles
  final TextStyle headlineLarge; // 32sp
  final TextStyle headlineMedium; // 28sp
  final TextStyle headlineSmall; // 24sp

  // Title styles
  final TextStyle titleLarge; // 22sp
  final TextStyle titleMedium; // 16sp
  final TextStyle titleSmall; // 14sp

  // Body styles
  final TextStyle bodyLarge; // 16sp
  final TextStyle bodyMedium; // 14sp
  final TextStyle bodySmall; // 12sp

  // Label styles (smallest)
  final TextStyle labelLarge; // 14sp
  final TextStyle labelMedium; // 12sp
  final TextStyle labelSmall; // 11sp

  // ========== SPACING SCALE ==========
  // 8dp grid system
  final double spacingXs; // 4dp
  final double spacingSm; // 8dp
  final double spacingMd; // 16dp
  final double spacingLg; // 24dp
  final double spacingXl; // 32dp
  final double spacing2Xl; // 48dp
  final double spacing3Xl; // 64dp

  // ========== BORDER RADIUS SCALE ==========
  final double radiusNone; // 0dp
  final double radiusSm; // 4dp
  final double radiusMd; // 8dp
  final double radiusLg; // 16dp
  final double radiusXl; // 24dp
  final double radiusFull; // 9999dp (pill shape)

  // ========== ELEVATION/SHADOW SYSTEM ==========
  final double elevationLevel0; // 0dp
  final double elevationLevel1; // 1dp
  final double elevationLevel2; // 3dp
  final double elevationLevel3; // 6dp
  final double elevationLevel4; // 8dp
  final double elevationLevel5; // 12dp

  // ========== BORDER WIDTH SCALE ==========
  final double borderWidthNone; // 0dp
  final double borderWidthThin; // 1dp
  final double borderWidthMedium; // 2dp
  final double borderWidthThick; // 4dp

  const FoundationTokens({
    // Colors (16 properties)
    required this.colorPrimary,
    required this.colorOnPrimary,
    required this.colorPrimaryContainer,
    required this.colorOnPrimaryContainer,
    required this.colorSecondary,
    required this.colorOnSecondary,
    required this.colorSurface,
    required this.colorOnSurface,
    required this.colorSurfaceVariant,
    required this.colorOnSurfaceVariant,
    required this.colorError,
    required this.colorOnError,
    required this.colorOutline,
    required this.colorShadow,
    required this.colorBackground,
    required this.colorOnBackground,
    // Typography (15 properties)
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    // Spacing (7 properties)
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.spacingXl,
    required this.spacing2Xl,
    required this.spacing3Xl,
    // Border Radius (6 properties)
    required this.radiusNone,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radiusFull,
    // Elevation (6 properties)
    required this.elevationLevel0,
    required this.elevationLevel1,
    required this.elevationLevel2,
    required this.elevationLevel3,
    required this.elevationLevel4,
    required this.elevationLevel5,
    // Border Width (4 properties)
    required this.borderWidthNone,
    required this.borderWidthThin,
    required this.borderWidthMedium,
    required this.borderWidthThick,
  });
}
