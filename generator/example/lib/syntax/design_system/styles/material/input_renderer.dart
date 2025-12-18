part of '../../design_system.dart';

mixin MaterialInputRenderer on DesignStyle {
  @override
  InputTokens get inputTokens => const InputTokens(
        textStyle: TextStyle(fontSize: 16, color: Colors.black87),
        hintStyle: TextStyle(fontSize: 16, color: Colors.black54),
        backgroundColor: Colors.transparent,
        borderColor: Colors.black54,
        focusBorderColor: Colors.blue,
        errorColor: Colors.red,
        borderWidth: 1.0,
        borderRadius: 4.0,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      );

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
    // Resolve icons from registry
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
