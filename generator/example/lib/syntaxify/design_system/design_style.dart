/// DesignStyle Sealed Class
part of 'design_system.dart';

/// Base sealed class for all design styles.
sealed class DesignStyle {
  const DesignStyle();

  String get name =>
      runtimeType.toString().replaceAll('Style', '').toLowerCase();

  /// Foundation design tokens (colors, typography, spacing, etc.)
  ///
  /// Single source of truth for all design primitives.
  /// Component tokens reference these foundation values.
  FoundationTokens get foundation;

  /// Get tokens for a Button variant
  ButtonTokens buttonTokens(ButtonVariant variant);

  /// Get tokens for Checkbox component
  CheckboxTokens get checkboxTokens;

  /// Get tokens for Input component
  InputTokens get inputTokens;

  /// Get tokens for Radio component
  RadioTokens get radioTokens;

  /// Get tokens for Slider component
  SliderTokens get sliderTokens;

  /// Get tokens for SuperCard component
  SuperCardTokens get superCardTokens;

  /// Get tokens for a Text variant
  TextTokens textTokens(TextVariant variant);

  /// Get tokens for Toggle component
  ToggleTokens get toggleTokens;

  /// Render a Button widget
  Widget renderButton({
    required String label,
    ButtonVariant variant = ButtonVariant.primary,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  });

  /// Render a Checkbox widget
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a Input widget
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

  /// Render a Radio widget
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a Slider widget
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  });

  /// Render a SuperCard widget
  Widget renderSuperCard({bool value = true});

  /// Render a Text widget
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  });

  /// Render a Toggle widget
  Widget renderToggle({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });
}
