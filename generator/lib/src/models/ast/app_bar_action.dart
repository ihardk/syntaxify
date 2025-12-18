import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bar_action.freezed.dart';
part 'app_bar_action.g.dart';

@freezed
class AppBarAction with _$AppBarAction {
  const factory AppBarAction({
    required String icon,
    required String onPressed,
    String? tooltip,
  }) = _AppBarAction;

  factory AppBarAction.fromJson(Map<String, dynamic> json) =>
      _$AppBarActionFromJson(json);
}
