import 'package:syntaxify/src/models/component_definition.dart';

/// Utilities for computing component names with explicit contract support.
class ComponentNaming {
  /// Gets the output component name from a ComponentDefinition.
  ///
  /// Uses explicit name from @SyntaxComponent(name: '...') if provided,
  /// otherwise falls back to className.replaceAll('Meta', '').
  ///
  /// Example:
  /// - @SyntaxComponent(name: 'AppButton') → 'AppButton'
  /// - ButtonMeta (no explicit name) → 'AppButton' (legacy fallback)
  static String getComponentName(ComponentDefinition component) {
    if (component.explicitName != null && component.explicitName!.isNotEmpty) {
      return component.explicitName!;
    }

    // Legacy fallback: strip 'Meta' suffix
    return component.className.replaceAll('Meta', '');
  }

  /// Gets the component type identifier (lowercase name).
  ///
  /// Example: 'AppButton' → 'button'
  static String getComponentType(ComponentDefinition component) {
    final name = getComponentName(component);

    // Strip 'App' prefix if present
    final withoutApp = name.startsWith('App') ? name.substring(3) : name;

    return withoutApp.toLowerCase();
  }
}
