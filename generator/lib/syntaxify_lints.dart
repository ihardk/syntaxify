import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'lints/layout_node_lints.dart';

/// Entry point for Syntaxify custom lint rules.
///
/// This plugin provides IDE-integrated validation for LayoutNode definitions,
/// showing errors and warnings as you type in .screen.dart files.
PluginBase createPlugin() => _SyntaxifyLintPlugin();

class _SyntaxifyLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        EmptyButtonLabelLint(),
        InvalidCallbackNameLint(),
        EmptyTextContentLint(),
        EmptyContainerLint(),
      ];
}
