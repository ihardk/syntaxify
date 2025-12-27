/// DesignStyle Sealed Class
part of 'design_system.dart';

/// Base sealed class for all design styles.
///
/// Each style implementation provides render methods that define HOW
/// components look in that style. The Syntaxify design system supports
/// three built-in styles:
/// - [MaterialStyle] - Google Material Design
/// - [CupertinoStyle] - Apple Human Interface Guidelines
/// - [NeoStyle] - Neo-brutalism with sharp corners and bold colors
///
/// ## Supported Components (7)
///
/// | Component | Render Method |
/// |-----------|---------------|
/// | Button | [renderButton] |
/// | Input | [renderInput] |
/// | Text | [renderText] |
/// | Checkbox | [renderCheckbox] |
/// | Toggle | [renderSwitch] |
/// | Slider | [renderSlider] |
/// | Radio | [renderRadio] |
///
/// ## Adding a New Style
///
/// 1. Create a new file in `styles/` folder
/// 2. Add `part of 'design_system.dart';` at top
/// 3. Create mixins for each component renderer
/// 4. Create a style class that extends `DesignStyle` with all mixins
/// 5. Add the part file to `design_system.dart`
sealed class DesignStyle {
  const DesignStyle();

  /// Style identifier (uses class name automatically)
  String get name =>
      runtimeType.toString().replaceAll('Style', '').toLowerCase();

  /// Foundation design tokens (colors, typography, spacing, etc.)
  ///
  /// Single source of truth for all design primitives.
  /// Component tokens reference these foundation values.
  FoundationTokens get foundation;

  /// Get tokens for a button variant
  ButtonTokens buttonTokens(ButtonVariant variant);

  /// Render a button widget (HOW)
  Widget renderButton({
    required String label,
    ButtonVariant variant = ButtonVariant.primary,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
  });

  /// Get tokens for input component
  InputTokens get inputTokens;

  /// Render an input widget (HOW)
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

  /// Get tokens for a text variant
  TextTokens textTokens(TextVariant variant);

  /// Render a text widget (HOW)
  Widget renderText({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  });

  // --- Interactive Component Tokens ---

  /// Get tokens for checkbox component
  CheckboxTokens get checkboxTokens;

  /// Get tokens for toggle component
  ToggleTokens get toggleTokens;

  /// Get tokens for slider component
  SliderTokens get sliderTokens;

  /// Get tokens for radio component
  RadioTokens get radioTokens;

  // --- Interactive Component Renderers ---

  /// Render a checkbox widget
  Widget renderCheckbox({
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a switch widget
  Widget renderSwitch({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Render a slider widget
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  });

  /// Render a radio widget
  Widget renderRadio<T>({
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Color? activeColor,
  });

  /// Get tokens for a card variant
  CardTokens cardTokens(CardVariant variant);

  /// Render a card widget
  Widget renderCard({
    required Widget child,
    CardVariant variant = CardVariant.elevated,
    double? elevation,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
  });

  /// Get tokens for icon component
  IconTokens get iconTokens;

  /// Render an icon widget
  Widget renderIcon({
    required String name,
    double? size,
    Color? color,
    String? semanticLabel,
  });

  /// Get tokens for divider component
  DividerTokens get dividerTokens;

  /// Render a divider widget
  Widget renderDivider({
    DividerOrientation orientation = DividerOrientation.horizontal,
    double? thickness,
    Color? color,
    double indent = 0.0,
    double endIndent = 0.0,
  });

  /// Get tokens for image component
  ImageTokens get imageTokens;

  /// Render an image widget
  Widget renderImage({
    required String src,
    double? width,
    double? height,
    BoxFit? fit,
    Widget? placeholder,
    Widget? errorWidget,
    double borderRadius = 0.0,
  });

  /// Get tokens for progress indicator component
  ProgressIndicatorTokens get progressIndicatorTokens;

  /// Render a progress indicator widget
  Widget renderProgressIndicator({
    ProgressIndicatorVariant variant = ProgressIndicatorVariant.circular,
    double? value,
    Color? color,
    Color? backgroundColor,
    double strokeWidth = 4.0,
  });

  /// Get tokens for an icon button variant
  IconButtonTokens iconButtonTokens(IconButtonVariant variant);

  /// Render an icon button widget
  Widget renderIconButton({
    required String icon,
    VoidCallback? onPressed,
    IconButtonVariant variant = IconButtonVariant.standard,
    double size = 24.0,
    Color? color,
    bool isDisabled = false,
    String? tooltip,
  });

  /// Get tokens for a dropdown variant
  DropdownTokens dropdownTokens(DropdownVariant variant);

  /// Render a dropdown widget
  Widget renderDropdown<T>({
    required T? value,
    required List<DropdownItem<T>> items,
    required ValueChanged<T?>? onChanged,
    DropdownVariant variant = DropdownVariant.standard,
    String? label,
    String? hint,
    bool enabled = true,
    String? errorText,
  });

  /// Get tokens for a tab bar variant
  TabBarTokens tabBarTokens(TabBarVariant variant);

  /// Render a tab bar widget
  Widget renderTabBar({
    required List<TabBarItem> tabs,
    required int currentIndex,
    required ValueChanged<int> onTabChange,
    TabBarVariant variant = TabBarVariant.primary,
    bool isScrollable = false,
  });

  /// Get tokens for a bottom nav variant
  BottomNavTokens bottomNavTokens(BottomNavVariant variant);

  /// Render a bottom navigation bar widget
  Widget renderBottomNav({
    required List<BottomNavItem> items,
    required int currentIndex,
    required ValueChanged<int> onTap,
    BottomNavVariant variant = BottomNavVariant.standard,
    bool showLabels = true,
  });

  /// Get tokens for an app bar variant
  AppBarTokens appBarTokens(AppBarVariant variant);

  /// Render an app bar widget
  PreferredSizeWidget renderAppBar({
    required String title,
    AppBarVariant variant = AppBarVariant.primary,
    String? leading,
    List<String>? actions,
    bool centerTitle = false,
  });

  /// Get tokens for a chip variant
  ChipTokens chipTokens(ChipVariant variant);

  /// Render a chip widget
  Widget renderChip({
    required String label,
    ChipVariant variant = ChipVariant.filled,
    String? icon,
    VoidCallback? onDeleted,
    bool selected = false,
  });

  /// Get tokens for a badge variant
  BadgeTokens badgeTokens(BadgeVariant variant);

  /// Render a badge widget
  Widget renderBadge({
    required Widget child,
    BadgeVariant variant = BadgeVariant.count,
    int? count,
    bool showBadge = true,
  });

  /// Get tokens for an avatar variant
  AvatarTokens avatarTokens(AvatarVariant variant);

  /// Render an avatar widget
  Widget renderAvatar({
    AvatarVariant variant = AvatarVariant.circle,
    String? imageSrc,
    String? initials,
    double size = 40.0,
    Color? backgroundColor,
  });
}
