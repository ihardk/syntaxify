import 'package:syntaxify/src/core/interfaces/component_generator.dart';
import 'package:syntaxify/src/generators/component/button_generator.dart';
import 'package:syntaxify/src/generators/component/input_generator.dart';
import 'package:syntaxify/src/generators/component/text_generator.dart';
import 'package:syntaxify/src/plugins/custom_emitter_handler.dart';
import 'package:syntaxify/src/plugins/syntaxify_plugin.dart';

/// The default plugin providing core Syntaxify components.
class DefaultPlugin extends SyntaxifyPlugin {
  @override
  String get namespace => 'default';

  @override
  Map<String, ComponentGenerator> get componentGenerators => {
        'button': ButtonGenerator(),
        'input': InputGenerator(),
        'text': TextGenerator(),
      };

  @override
  Map<String, CustomEmitterHandler> get layoutEmitters => {
        // Core components are handled by specific methods in LayoutEmitter currently.
        // In the future, we could migrate them to generic emitters too.
      };
}
