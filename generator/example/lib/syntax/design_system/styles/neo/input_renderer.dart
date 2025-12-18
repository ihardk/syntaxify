part of '../../design_system.dart';

mixin NeoInputRenderer on DesignStyle {
  @override
  InputTokens get inputTokens => const InputTokens(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: 'Courier', // Brutalist mono vibes
        ),
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
        backgroundColor: Colors.white,
        borderColor: Colors.black,
        focusBorderColor: Colors.black,
        errorColor: Colors.redAccent,
        borderWidth: 3.0,
        borderRadius: 0.0, // Sharp aesthetic
        contentPadding: EdgeInsets.all(16),
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
    final prefixIconData = AppIcons.get(prefixIconName);
    final suffixIconData = AppIcons.get(suffixIconName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: inputTokens.backgroundColor,
            border: Border.all(
              color: inputTokens.borderColor,
              width: inputTokens.borderWidth,
            ),
            boxShadow: [
              // Hard shadow
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              if (prefixIconData != null)
                _buildIcon(prefixIconData, onTapPrefix),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  obscureText: obscureText,
                  enabled: enabled,
                  keyboardType: keyboardType,
                  style: inputTokens.textStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: inputTokens.hintStyle,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: inputTokens.contentPadding,
                  ),
                ),
              ),
              if (suffixIconData != null)
                _buildIcon(suffixIconData, onTapSuffix),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Container(
            color: inputTokens.errorColor,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          border: Border(
              // Separate icon with border if you want, or just spacing
              ),
        ),
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }
}
