import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/component_definition.dart';

/// Extracts property information from field declarations.
class PropertyExtractor {
  /// Extracts a ComponentProp from a variable declaration.
  ComponentProp? extract(
    analyzer.VariableDeclaration variable,
    analyzer.FieldDeclaration declaration,
  ) {
    // Check for explicit @Required or @Optional annotations first
    final hasRequiredAnnotation = declaration.metadata.any(
      (a) => a.name.toSource() == 'Required',
    );
    final hasOptionalAnnotation = declaration.metadata.any(
      (a) => a.name.toSource() == 'Optional',
    );

    // Check for @Default annotation
    String? defaultValue = variable.initializer?.toSource();
    for (final annotation in declaration.metadata) {
      if (annotation.name.toSource() == 'Default') {
        final args = annotation.arguments?.arguments;
        if (args != null && args.isNotEmpty) {
          final firstArg = args.first;
          if (firstArg is analyzer.StringLiteral) {
            defaultValue = firstArg.stringValue;
          } else {
            defaultValue = firstArg.toSource();
          }
        }
      }
    }

    final typeNode = declaration.fields.type;
    final typeName = typeNode?.toSource() ?? 'dynamic';

    // Convention-based parsing:
    // 1. If @Required annotation exists → required
    // 2. If @Optional annotation exists → optional
    // 3. Otherwise, use type nullability: String? → optional, String → required
    bool isRequired;
    if (hasRequiredAnnotation) {
      isRequired = true;
    } else if (hasOptionalAnnotation) {
      isRequired = false;
    } else {
      isRequired = !typeName.endsWith('?');
    }

    return ComponentProp(
      name: variable.name.lexeme,
      type: typeName,
      isRequired: isRequired,
      defaultValue: defaultValue,
      description: extractDocComment(declaration),
    );
  }

  /// Extracts variants from @Variant annotation on a field.
  List<String> extractVariants(analyzer.FieldDeclaration declaration) {
    final variants = <String>[];
    final variantAnnotation = declaration.metadata
        .where((a) => a.name.toSource() == 'Variant')
        .firstOrNull;

    if (variantAnnotation != null) {
      final args = variantAnnotation.arguments?.arguments;
      if (args != null && args.isNotEmpty) {
        final listLiteral = args.first;
        if (listLiteral is analyzer.ListLiteral) {
          for (final element in listLiteral.elements) {
            if (element is analyzer.StringLiteral) {
              variants.add(element.stringValue ?? '');
            }
          }
        }
      }
    }
    return variants;
  }

  /// Extracts documentation comment from an annotated node.
  String? extractDocComment(analyzer.AnnotatedNode node) {
    final comment = node.documentationComment;
    if (comment == null) return null;

    return comment.tokens
        .map((t) => t.lexeme.replaceFirst('///', '').trim())
        .where((s) => s.isNotEmpty)
        .join(' ');
  }
}
