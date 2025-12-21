import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';

/// Abstract base class for Syntaxify plugins.
///
/// Plugins allow extending Syntaxify with new component kits and custom layout nodes.
///
/// Minimal implementation:
/// ```dart
/// class MyPlugin extends SyntaxifyPlugin {
///   @override
///   String get namespace => 'my_kit';
///
///   @override
///   Map<String, ComponentGenerator> get componentGenerators => {
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
  Map<String, ComponentGenerator> get componentGenerators;

  /// Map of custom node type (e.g., 'Carousel') to its Emitter.
  /// These emitters generate the code that USES the component in a screen.
  Map<String, CustomEmitterHandler> get layoutEmitters;
}
