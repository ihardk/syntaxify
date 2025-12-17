import 'package:flutter/material.dart';

/// Registry for mapping string tokens to IconData.
/// This allows meta-definitions to reference icons by name (e.g. 'search')
/// without direct dependencies on Flutter libraries, enabling tree-shaking
/// and platform-specific swapping.
class AppIcons {
  static const Map<String, IconData> _registry = {
    'user': Icons.person,
    'search': Icons.search,
    'close': Icons.close,
    'visibility': Icons.visibility,
    'visibility_off': Icons.visibility_off,
    'email': Icons.email,
    'lock': Icons.lock,
  };

  /// Retrieve an icon by its token name.
  static IconData? get(String? name) => _registry[name];
}
