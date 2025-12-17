import 'package:forge/src/annotations/forge_annotations.dart';
import 'app_icons.dart';

/// Text Input component specification
@ForgeComponent(
    description: 'A text input field with optional label, hint, and icons')
class InputMeta {
  /// The label text displayed above or inside the input
  @Required()
  final String label;

  /// Hint text displayed when empty
  @Optional()
  final String? hint;

  /// Error text to display
  @Optional()
  final String? errorText;

  /// Whether the text should be obscured (password)
  @Optional()
  @Default('false')
  final bool obscureText;

  /// Leading icon name
  @Optional()
  final String? prefixIcon;

  /// Trailing icon name
  @Optional()
  final String? suffixIcon;

  const InputMeta({
    required this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });
}
