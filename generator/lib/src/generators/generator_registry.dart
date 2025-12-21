import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/generators/component/generic_generator.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/plugins/syntaxify_plugin.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';

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
  GeneratorRegistry();

  final List<ComponentGenerator> _generators = [];
  final Map<String, CustomEmitterHandler> _customEmitters = {};
  final GenericGenerator _fallback = GenericGenerator();

  /// Register a component generator.
  void register(ComponentGenerator generator) {
    _generators.add(generator);
  }

  /// Register a plugin.
  void registerPlugin(SyntaxifyPlugin plugin) {
    // Register component generators
    plugin.componentGenerators.forEach((type, generator) {
      register(generator);
    });

    // Register layout emitters
    _customEmitters.addAll(plugin.layoutEmitters);
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

  /// Get the appropriate custom emitter handler for a custom node type.
  CustomEmitterHandler? getCustomEmitter(String type) {
    return _customEmitters[type];
  }
}
