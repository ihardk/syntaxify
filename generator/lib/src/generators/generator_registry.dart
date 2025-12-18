import 'package:forge/src/core/interfaces/component_generator.dart';
import 'package:forge/src/generators/component/button_generator.dart';
import 'package:forge/src/generators/component/input_generator.dart';
import 'package:forge/src/generators/component/text_generator.dart';
import 'package:forge/src/generators/component/generic_generator.dart';
import 'package:forge/src/models/component_definition.dart';

/// Registry of component generators.
///
/// Following Open/Closed principle:
/// - Open for extension: register new generators without modifying this class
/// - Closed for modification: existing code doesn't change when adding generators
///
/// Usage:
/// ```dart
/// final registry = GeneratorRegistry()
///   ..register(ButtonGenerator())
///   ..register(InputGenerator());
///
/// final generator = registry.forComponent(metaComponent);
/// final code = generator.generate(component: meta, tokens: tokens);
/// ```
class GeneratorRegistry {
  GeneratorRegistry() {
    // Register default generators
    register(ButtonGenerator());
    register(InputGenerator());
    register(TextGenerator());
  }

  final List<ComponentGenerator> _generators = [];
  final GenericGenerator _fallback = GenericGenerator();

  /// Register a component generator.
  void register(ComponentGenerator generator) {
    _generators.add(generator);
  }

  /// Get the appropriate generator for a component.
  ///
  /// Returns the first registered generator that can handle the component,
  /// or falls back to GenericGenerator.
  ComponentGenerator forComponent(ComponentDefinition component) {
    for (final generator in _generators) {
      if (generator.canHandle(component)) {
        return generator;
      }
    }
    return _fallback;
  }

  /// List all registered component types.
  List<String> get registeredTypes {
    return _generators.map((g) => g.componentType).toList();
  }

  /// Check if a specific component type has a dedicated generator.
  bool hasGenerator(String componentType) {
    return _generators.any((g) => g.componentType == componentType);
  }
}
