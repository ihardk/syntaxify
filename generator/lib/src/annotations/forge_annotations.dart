/// Forge annotations for defining meta components.
///
/// These annotations are used in `.meta.dart` files to define
/// component specifications that the Forge generator will process.
library forge_annotations;

/// Marks a class as a Forge component specification.
///
/// The generator will create a Flutter widget from this spec.
class MetaComponent {
  /// Optional description of the component.
  final String? description;

  const MetaComponent({this.description});
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
