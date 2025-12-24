/// Syntaxify annotations for defining meta components.
///
/// These annotations are used in `.meta.dart` files to define
/// component specifications that the Syntaxify generator will process.
library syntax_annotations;

/// Marks a class as a Syntaxify component specification.
///
/// The generator will create a Flutter widget from this spec.
/// Marks a class as a Syntaxify component specification.
class SyntaxComponent {
  /// Explicit name for the generated component (e.g., 'AppButton').
  /// If not provided, defaults to className without 'Meta' suffix.
  final String? name;

  /// Optional description of the component.
  final String? description;

  /// Variant values for this component.
  /// The generator will create an enum and convenience constructors.
  /// Example: `variants: ['primary', 'secondary', 'outlined']`
  final List<String>? variants;

  const SyntaxComponent({this.name, this.description, this.variants});
}

/// Marks a field as required in the generated widget.
///
/// **Deprecated:** Use non-nullable types instead (e.g., `String` instead of `String?`).
@Deprecated(
    'Use non-nullable types instead. String → required, String? → optional')
class Required {
  /// Optional documentation for the field.
  final String? doc;

  const Required({this.doc});
}

/// Marks a field as optional in the generated widget.
///
/// **Deprecated:** Use nullable types instead (e.g., `String?`).
@Deprecated('Use nullable types instead. String? → optional')
class Optional {
  /// Optional documentation for the field.
  final String? doc;

  const Optional({this.doc});
}

/// Specifies a default value for an optional field.
///
/// **Deprecated:** Use constructor default values instead.
@Deprecated('Use constructor default values instead: this.field = defaultValue')
class Default {
  /// The default value as a string (will be parsed appropriately).
  final String value;

  const Default(this.value);
}

/// Marks a field as internal state (not a constructor parameter).
class ComponentState {
  /// Possible state values.
  final List<String> values;

  const ComponentState(this.values);
}

/// Marks a class as an Icon Registry.
class IconRegistry {
  const IconRegistry();
}

/// Maps a constant to a specific IconData string (e.g., 'Icons.home').
class IconMapping {
  final String iconData;

  const IconMapping(this.iconData);
}

/// Marks a class as an Image Registry.
class ImageRegistry {
  const ImageRegistry();
}

/// Maps a constant to a specific image path (asset or network URL).
class ImageMapping {
  final String path;

  const ImageMapping(this.path);
}

/// Marks an enum as a Variant type.
///
/// **Deprecated:** Use @SyntaxComponent(variants: [...]) instead.
/// Variants defined in @SyntaxComponent will automatically generate enums.
///
/// Enums marked with @Variant will have helper constructors generated
/// for each value. For example:
///
/// ```dart
/// @Variant()
/// enum ButtonVariant { primary, secondary, outlined, text }
/// ```
///
/// Will generate: `AppButton.primary()`, `AppButton.secondary()`, etc.
@Deprecated('Use @SyntaxComponent(variants: [...]) instead')
class Variant {
  const Variant();
}
