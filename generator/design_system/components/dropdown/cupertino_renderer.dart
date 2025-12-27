part of '../../design_system.dart';

mixin CupertinoDropdownRenderer on DesignStyle {
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
    final selectedItem = value != null
        ? items.firstWhere(
            (item) => item.value == value,
            orElse: () => items.first,
          )
        : null;

    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: enabled
              ? () async {
                  // Show Cupertino picker modal
                  await showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 250,
                      color: CupertinoColors.systemBackground
                          .resolveFrom(context),
                      child: Column(
                        children: [
                          // Header with done button
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CupertinoColors.separator
                                      .resolveFrom(context),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                  child: const Text('Done'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                          // Picker
                          Expanded(
                            child: CupertinoPicker(
                              itemExtent: 44,
                              scrollController: FixedExtentScrollController(
                                initialItem: selectedItem != null
                                    ? items.indexOf(selectedItem)
                                    : 0,
                              ),
                              onSelectedItemChanged: (index) {
                                if (onChanged != null) {
                                  onChanged(items[index].value);
                                }
                              },
                              children: items
                                  .map((item) =>
                                      Center(child: Text(item.label)))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              : null,
          child: Container(
            padding: tokens.padding,
            decoration: BoxDecoration(
              color: tokens.backgroundColor,
              border: variant == DropdownVariant.outlined ||
                      variant == DropdownVariant.underlined
                  ? Border.all(
                      color: tokens.borderColor ??
                          CupertinoColors.separator.resolveFrom(context),
                      width: tokens.borderWidth,
                    )
                  : null,
              borderRadius: variant == DropdownVariant.underlined
                  ? null
                  : BorderRadius.circular(tokens.borderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: tokens.hintColor,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedItem != null
                            ? selectedItem.label
                            : hint ?? '',
                        style: TextStyle(
                          color: selectedItem != null
                              ? tokens.textColor
                              : tokens.hintColor,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                      color: tokens.iconColor,
                    ),
                  ],
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      errorText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
