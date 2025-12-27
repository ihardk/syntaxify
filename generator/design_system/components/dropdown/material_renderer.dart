part of '../../design_system.dart';

mixin MaterialDropdownRenderer on DesignStyle {
  @override
  DropdownTokens dropdownTokens(DropdownVariant variant) {
    return DropdownTokens.fromFoundation(foundation, variant: variant);
  }

  @override
  Widget renderDropdown<T>({
    required T? value,
    required List<DropdownItem<T>> items,
    required ValueChanged<T?>? onChanged,
    DropdownVariant variant = DropdownVariant.standard,
    String? label,
    String? hint,
    bool enabled = true,
    String? errorText,
  }) {
    final tokens = dropdownTokens(variant);
    final effectiveOnChanged = enabled ? onChanged : null;

    Widget dropdown = DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item.value,
                child: Text(item.label),
              ))
          .toList(),
      onChanged: effectiveOnChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        filled: variant == DropdownVariant.standard,
        fillColor: tokens.backgroundColor,
        border: variant == DropdownVariant.outlined
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(tokens.borderRadius),
                borderSide: BorderSide(
                  color: tokens.borderColor ?? Colors.grey,
                  width: tokens.borderWidth,
                ),
              )
            : variant == DropdownVariant.underlined
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: tokens.borderColor ?? Colors.grey,
                      width: tokens.borderWidth,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(tokens.borderRadius),
                    borderSide: BorderSide.none,
                  ),
        contentPadding: tokens.padding,
      ),
      dropdownColor: tokens.backgroundColor,
      icon: Icon(Icons.arrow_drop_down, color: tokens.iconColor),
      style: TextStyle(color: tokens.textColor),
    );

    return dropdown;
  }
}
