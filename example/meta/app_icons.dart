import 'package:syntaxify/syntaxify.dart';

/// App Icon Registry
///
/// Define your semantic icon tokens here.
/// The @IconMapping annotation tells the generator which Flutter icon to use.
@IconRegistry()
class AppIcon {
  @IconMapping('Icons.search')
  static const search = 'search';

  @IconMapping('Icons.person')
  static const user = 'user';

  @IconMapping('Icons.home')
  static const home = 'home';

  @IconMapping('Icons.settings')
  static const settings = 'settings';
}
