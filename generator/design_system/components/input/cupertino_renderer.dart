part of '../../design_system.dart';

mixin CupertinoInputRenderer on DesignStyle {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: CupertinoColors.black),
          ),
          const SizedBox(height: 8),
        ],
        CupertinoTextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          placeholder: hint,
          padding: inputTokens.contentPadding,
          decoration: BoxDecoration(
            color: inputTokens.backgroundColor,
            borderRadius: BorderRadius.circular(inputTokens.borderRadius),
            border: Border.all(
              color: errorText != null
                  ? inputTokens.errorColor
                  : inputTokens.borderColor,
            ),
          ),
          prefix: prefixIconData != null
              ? _buildIcon(prefixIconData, onTapPrefix)
              : null,
          suffix: suffixIconData != null
              ? _buildIcon(suffixIconData, onTapSuffix)
              : null,
          prefixMode: prefixIconData != null
              ? OverlayVisibilityMode.always
              : OverlayVisibilityMode.editing,
          suffixMode: suffixIconData != null
              ? OverlayVisibilityMode.always
              : OverlayVisibilityMode.editing,
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: TextStyle(color: inputTokens.errorColor, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback? onTap) {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(icon, size: 20, color: CupertinoColors.systemGrey),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }
    return widget;
  }
}
