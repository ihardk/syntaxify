/// Syntaxify annotations for defining meta components.
///
/// These annotations are used in `.meta.dart` files to define
/// component specifications that the Syntaxify generator will process.
library syntax_annotations;

/// Marks a class as a Syntaxify component specification.
///
/// The generator will create a Flutter widget from this spec.
/// Note: Named SyntaxComponent to avoid collision with internal MetaComponent model.
class SyntaxComponent {
  /// Optional description of the component.
  final String? description;

  const SyntaxComponent({this.description});
}

/// Marks a field as required in the generated widget.
class Required {
  /// Optional documentation for the field.
  final String? doc;

  const Required({this.doc});
}

/// Marks a field as optional in the generated widget.
class Optional {
  /// Optional documentation for the field.
  final String? doc;

  const Optional({this.doc});
}

/// Specifies a default value for an optional field.
class Default {
  /// The default value as a string (will be parsed appropriately).
  final String value;

  const Default(this.value);
}

/// Marks a field as internal state (not a constructor parameter).
class State {
  /// Possible state values.
  final List<String> values;

  const State(this.values);
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
