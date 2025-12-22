import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';
import 'package:syntaxify/src/plugins/syntaxify_plugin.dart';

/// The default plugin providing core Syntaxify layout emitters.
///
/// Note: With the unified meta-driven ComponentGenerator, component
/// generators are no longer needed in plugins. All components are
/// auto-generated from .meta.dart files.
class DefaultPlugin extends SyntaxifyPlugin {
  @override
  String get namespace => 'default';

  @override
  Map<String, IComponentGenerator> get componentGenerators => {
        // No specialized generators needed - ComponentGenerator handles all
      };

  @override
  Map<String, CustomEmitterHandler> get layoutEmitters => {
        // Core components are handled by specific methods in LayoutEmitter.
      };
}
