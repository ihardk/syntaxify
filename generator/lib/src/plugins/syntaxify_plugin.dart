import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';

/// Abstract base class for Syntaxify plugins.
///
/// Plugins allow extending Syntaxify with custom component generators
/// and layout emitters for specialized component kits.
///
/// Note: With the unified ComponentGenerator, most components are
/// auto-generated from .meta.dart files. Plugins are only needed for
/// specialized generators that need custom behavior.
///
/// Example:
/// ```dart
/// class MyPlugin extends SyntaxifyPlugin {
///   @override
///   String get namespace => 'my_kit';
///
///   @override
///   Map<String, IComponentGenerator> get componentGenerators => {
///     'carousel': CarouselGenerator(),
///   };
///
///   @override
///   Map<String, CustomEmitterHandler> get layoutEmitters => {
///     'Carousel': CarouselEmitter(),
///   };
/// }
/// ```
abstract class SyntaxifyPlugin {
  /// Unique namespace for this plugin (e.g., 'material', 'bootstrap').
  /// Used to prefix generated assets or avoid collisions.
  String get namespace;

  /// Map of component type (e.g., 'button') to its Generator.
  /// These generators create the component files in the project.
  Map<String, IComponentGenerator> get componentGenerators;

  /// Map of custom node type (e.g., 'Carousel') to its Emitter.
  /// These emitters generate the code that USES the component in a screen.
  Map<String, CustomEmitterHandler> get layoutEmitters;
}
