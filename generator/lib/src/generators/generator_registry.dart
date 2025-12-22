import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/generators/component/component_generator.dart';
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/plugins/syntaxify_plugin.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';

/// Registry of component generators.
///
/// With the unified meta-driven ComponentGenerator, this registry is
/// simplified. The single ComponentGenerator handles ALL component types
/// by reading properties from .meta.dart files.
///
/// Usage:
/// ```dart
/// final registry = GeneratorRegistry(variantEnums: parsedEnums);
/// final generator = registry.forComponent(metaComponent);
/// final code = generator.generate(component: meta, tokens: tokens);
/// ```
class GeneratorRegistry {
  GeneratorRegistry({Map<String, List<String>> variantEnums = const {}})
      : _componentGenerator = ComponentGenerator(variantEnums: variantEnums);

  final List<IComponentGenerator> _generators = [];
  final Map<String, CustomEmitterHandler> _customEmitters = {};

  // The ONE generator that handles everything
  final ComponentGenerator _componentGenerator;

  /// Register a component generator (for plugin extensions only).
  void register(IComponentGenerator generator) {
    _generators.add(generator);
  }

  /// Register a plugin.
  void registerPlugin(SyntaxifyPlugin plugin) {
    // Register component generators from plugins
    plugin.componentGenerators.forEach((type, generator) {
      register(generator);
    });

    // Register layout emitters
    _customEmitters.addAll(plugin.layoutEmitters);
  }

  /// Get the appropriate generator for a component.
  ///
  /// First checks if any registered plugin generator can handle it,
  /// otherwise uses the universal ComponentGenerator.
  IComponentGenerator forComponent(ComponentDefinition component) {
    // Check plugin generators first (for specialized overrides)
    for (final generator in _generators) {
      if (generator.canHandle(component)) {
        return generator;
      }
    }
    // Default: use the meta-driven ComponentGenerator
    return _componentGenerator;
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
