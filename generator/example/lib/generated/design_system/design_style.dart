/// DesignStyle Sealed Class
part of 'design_system.dart';

/// Base sealed class for all design styles.
///
/// Each style implementation provides:
/// - Token values for each component × variant
/// - Render methods for each component (HOW it looks)
///
/// To add a new style:
/// 1. Create a new file in `styles/` folder
/// 2. Add `part of 'design_system.dart';` at top
/// 3. Extend `DesignStyle`
/// 4. Add the part file to `design_system.dart`
sealed class DesignStyle {
  const DesignStyle();

  /// Style identifier (uses class name automatically)
  String get name =>
      runtimeType.toString().replaceAll('Style', '').toLowerCase();

  /// Get tokens for a button variant
  ButtonTokens buttonTokens(ButtonVariant variant);

  /// Render a button widget (HOW)
  Widget renderButton({
    required String label,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  });
}
