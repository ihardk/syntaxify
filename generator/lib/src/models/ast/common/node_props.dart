import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums.dart';

part 'node_props.freezed.dart';
part 'node_props.g.dart';

/// Properties for Button components.
@freezed
sealed class ButtonProps with _$ButtonProps {
  const factory ButtonProps({
    String? variant,
    ButtonSize? size,
    String? icon,
    IconPosition? iconPosition,
    @Default(false) bool isLoading,
    @Default(false) bool isDisabled,
    @Default(false) bool fullWidth,
  }) = _ButtonProps;

  factory ButtonProps.fromJson(Map<String, dynamic> json) =>
      _$ButtonPropsFromJson(json);
}

/// Properties for TextField components.
@freezed
sealed class TextFieldProps with _$TextFieldProps {
  const factory TextFieldProps({
    String? hint,
    String? helperText,
    String? prefixIcon,
    String? suffixIcon,
    KeyboardType? keyboardType,
    TextInputAction? textInputAction,
    @Default(false) bool obscureText,
    String? errorText,
    int? maxLines,
    int? maxLength,
    String? variant,
  }) = _TextFieldProps;

  factory TextFieldProps.fromJson(Map<String, dynamic> json) =>
      _$TextFieldPropsFromJson(json);
}
