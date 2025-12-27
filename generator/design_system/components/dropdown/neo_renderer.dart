part of '../../design_system.dart';

mixin NeoDropdownRenderer on DesignStyle {
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

    Widget dropdown = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        color: tokens.backgroundColor,
        boxShadow: enabled
            ? const [BoxShadow(offset: Offset(4, 4), color: Colors.black)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 3),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          DropdownButtonFormField<T>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item.value,
                      child: Text(
                        item.label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ))
                .toList(),
            onChanged: effectiveOnChanged,
            decoration: InputDecoration(
              hintText: hint,
              errorText: errorText,
              border: InputBorder.none,
              contentPadding: tokens.padding,
              isDense: true,
            ),
            dropdownColor: Colors.white,
            icon: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 20,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return dropdown;
  }
}
