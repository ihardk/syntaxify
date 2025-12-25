part of '../../design_system.dart';

mixin MaterialInputRenderer on DesignStyle {
  @override
  InputTokens get inputTokens => InputTokens.fromFoundation(foundation);

  @override
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
  }) {
    final prefixIconData = AppIcons.get(prefixIconName);
    final suffixIconData = AppIcons.get(suffixIconName);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputTokens.borderRadius),
        ),
        prefixIcon: prefixIconData != null
            ? _buildIcon(prefixIconData, onTapPrefix)
            : null,
        suffixIcon: suffixIconData != null
            ? _buildIcon(suffixIconData, onTapSuffix)
            : null,
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback? onTap) {
    if (onTap != null) {
      return IconButton(icon: Icon(icon), onPressed: onTap);
    }
    return Icon(icon);
  }
}
