/// DesignStyle Sealed Class
part of 'design_system.dart';

/// Base sealed class for all design styles.
///
/// Each style implementation provides render methods that define HOW
/// components look in that style. The Syntaxify design system supports
/// three built-in styles:
/// - [MaterialStyle] - Google Material Design
/// - [CupertinoStyle] - Apple Human Interface Guidelines
/// - [NeoStyle] - Neo-brutalism with sharp corners and bold colors
///
/// ## Supported Components (7)
///
/// | Component | Render Method |
/// |-----------|---------------|
/// | Button | [renderButton] |
/// | Input | [renderInput] |
/// | Text | [renderText] |
/// | Checkbox | [renderCheckbox] |
/// | Toggle | [renderSwitch] |
/// | Slider | [renderSlider] |
/// | Radio | [renderRadio] |
///
/// ## Adding a New Style
///
/// 1. Create a new file in `styles/` folder
/// 2. Add `part of 'design_system.dart';` at top
/// 3. Create mixins for each component renderer
/// 4. Create a style class that extends `DesignStyle` with all mixins
/// 5. Add the part file to `design_system.dart`
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
    ButtonVariant variant = ButtonVariant.primary,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  });

  /// Get tokens for input component
  InputTokens get inputTokens;

  /// Render an input widget (HOW)
  Widget renderInput({
    required TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    bool obscureText = false,
    bool enabled = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? prefixIconName,
    String? suffixIconName,
    VoidCallback? onTapPrefix,
    VoidCallback? onTapSuffix,
    TextInputType? keyboardType,
  });

  /// Get tokens for a text variant
  TextTokens textTokens(TextVariant variant);

  /// Render a text widget (HOW)
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  });

  // --- Interactive Component Renderers ---

  /// Render a checkbox widget
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a switch widget
  Widget renderSwitch({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a slider widget
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  });

  /// Render a radio widget
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });
}
