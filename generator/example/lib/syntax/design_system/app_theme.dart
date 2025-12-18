/// AppTheme InheritedWidget
part of 'design_system.dart';

/// Syntax theme provider using sealed DesignStyle pattern.
///
/// Usage:
/// ```dart
/// AppTheme(
///   style: MaterialStyle(),
///   child: MyApp(),
/// )
/// ```
///
/// Access tokens:
/// ```dart
/// final buttonTokens = AppTheme.of(context).style.button;
/// ```
class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.style,
    required super.child,
  });

  /// The design style providing all component tokens and rendering.
  final DesignStyle style;

  /// Get the current [AppTheme] from the widget tree.
  ///
  /// Throws if no [AppTheme] is found in the tree.
  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null,
        'No AppTheme found in context. Wrap your app with AppTheme.');
    return theme!;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return style.runtimeType != oldWidget.style.runtimeType;
  }
}
