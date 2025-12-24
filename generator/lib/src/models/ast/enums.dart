/// Enums for Syntaxify AST nodes.
///
/// These enums are used to configure the behavior and appearance
/// of UI elements in screen definitions.
library enums;

/// Alignment of children along the main axis in Row/Column.
/// Alignment of children along the main axis in Row/Column.
enum MainAlignment {
  /// Align children at the start.
  start,

  /// Align children in the center.
  center,

  /// Align children at the end.
  end,

  /// Distribute space evenly between children.
  spaceBetween,

  /// Distribute space evenly around children.
  spaceAround,

  /// Distribute space evenly with equal space at ends.
  spaceEvenly
}

/// Alignment of children along the cross axis in Row/Column.
/// Alignment of children along the cross axis in Row/Column.
enum CrossAlignment {
  /// Align children at the start of the cross axis.
  start,

  /// Align children in the center of the cross axis.
  center,

  /// Align children at the end of the cross axis.
  end,

  /// Stretch children to fill the cross axis.
  stretch,

  /// Align children at the baseline of the cross axis.
  baseline
}

/// Alignment within a Stack widget.
enum StackAlignment {
  /// Top-left corner.
  topLeft,

  /// Top-center.
  topCenter,

  /// Top-right corner.
  topRight,

  /// Center-left.
  centerLeft,

  /// Center.
  center,

  /// Center-right.
  centerRight,

  /// Bottom-left corner.
  bottomLeft,

  /// Bottom-center.
  bottomCenter,

  /// Bottom-right corner.
  bottomRight
}

/// Orientation axis.
/// Orientation axis.
enum SyntaxAxis {
  /// Horizontal orientation.
  horizontal,

  /// Vertical orientation.
  vertical
}

/// Text horizontal alignment.
/// Text horizontal alignment.
enum SyntaxTextAlign {
  /// Align text to the left.
  left,

  /// Center align text.
  center,

  /// Align text to the right.
  right,

  /// Justify text.
  justify
}

/// Text overflow behavior.
/// Text overflow behavior.
enum SyntaxTextOverflow {
  visible,

  /// Clip overflowing text.
  clip,

  /// Show ellipsis (...) for overflow.
  ellipsis,

  /// Fade out overflowing text.
  fade
}

/// Button size variants.
enum ButtonSize {
  /// Small button.
  sm,

  /// Medium button (default).
  md,

  /// Large button.
  lg
}

/// Icon position relative to button label.
enum IconPosition {
  /// Icon before the label.
  leading,

  /// Icon after the label.
  trailing,

  /// Icon only, no label.
  only
}

/// Text field style variants.
enum TextFieldVariant {
  /// Outlined text field.
  outlined,

  /// Filled text field.
  filled
}

/// Keyboard type for text input.
enum KeyboardType {
  /// Default text keyboard.
  text,

  /// Email keyboard with @ symbol.
  email,

  /// Numeric keyboard.
  number,

  /// Phone number keyboard.
  phone,

  /// URL keyboard.
  url,

  /// Multiline text input.
  multiline
}

/// Input action button on keyboard.
enum TextInputAction {
  /// Done action.
  done,

  /// Next field action.
  next,

  /// Search action.
  search,

  /// Send action.
  send,

  /// Go action.
  go
}

/// Semantic color tokens.
enum ColorSemantic {
  /// Primary brand color.
  primary,

  /// Secondary brand color.
  secondary,

  /// Tertiary accent color.
  tertiary,

  /// Error/danger color.
  error,

  /// Warning color.
  warning,

  /// Success color.
  success,

  /// Info color.
  info,

  /// Surface background color.
  surface,

  /// Text on surface color.
  onSurface
}

/// Icon size variants.
enum IconSize {
  /// Extra small icon.
  xs,

  /// Small icon.
  sm,

  /// Medium icon (default).
  md,

  /// Large icon.
  lg,

  /// Extra large icon.
  xl
}

/// Image fit modes.
enum ImageFit {
  /// Cover the container, may crop.
  cover,

  /// Contain within bounds.
  contain,

  /// Fill the container, may distort.
  fill,

  /// Fit to width.
  fitWidth,

  /// Fit to height.
  fitHeight,

  /// No scaling.
  none
}

/// Spacer size variants.
enum SpacerSize {
  /// Extra small spacing.
  xs,

  /// Small spacing.
  sm,

  /// Medium spacing (default).
  md,

  /// Large spacing.
  lg,

  /// Extra large spacing.
  xl,

  /// Flexible spacer that expands.
  flex
}

/// Card style variants.
enum CardVariant {
  /// Elevated card with shadow.
  elevated,

  /// Outlined card with border.
  outlined,

  /// Filled card with background.
  filled
}

/// Container semantic background.
enum ContainerSemantic {
  /// Surface background.
  surface,

  /// Primary container background.
  primaryContainer,

  /// Secondary container background.
  secondaryContainer
}

/// How to size children in a Stack.
enum StackFit {
  /// Children are loose (can be smaller than stack).
  loose,

  /// Children are expanded to fill the stack.
  expand,

  /// Children maintain their size regardless of stack.
  passthrough
}

/// General alignment enum (for Center, Align, etc.).
enum AlignmentEnum {
  /// Top-left corner.
  topLeft,

  /// Top-center.
  topCenter,

  /// Top-right corner.
  topRight,

  /// Center-left.
  centerLeft,

  /// Center.
  center,

  /// Center-right.
  centerRight,

  /// Bottom-left corner.
  bottomLeft,

  /// Bottom-center.
  bottomCenter,

  /// Bottom-right corner.
  bottomRight
}
