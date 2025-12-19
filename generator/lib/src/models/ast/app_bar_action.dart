import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bar_action.freezed.dart';
part 'app_bar_action.g.dart';

/// Represents an action button in an app bar.
///
/// Used in [AstNode.appBar] to define action buttons:
/// ```dart
/// AstNode.appBar(
///   title: 'My Screen',
///   actions: [
///     AppBarAction(icon: 'search', onPressed: 'handleSearch'),
///     AppBarAction(icon: 'settings', onPressed: 'openSettings'),
///   ],
/// )
/// ```
@freezed
sealed class AppBarAction with _$AppBarAction {
  const factory AppBarAction({
    required String icon,
    required String onPressed,
    String? tooltip,
  }) = _AppBarAction;

  factory AppBarAction.fromJson(Map<String, dynamic> json) =>
      _$AppBarActionFromJson(json);
}
