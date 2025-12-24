import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/parser/extractors/property_extractor.dart';

/// Extracts ComponentEnum from enum declarations.
class EnumExtractor {
  EnumExtractor({PropertyExtractor? propertyExtractor})
      : _propertyExtractor = propertyExtractor ?? PropertyExtractor();

  final PropertyExtractor _propertyExtractor;

  /// Extracts enum information from an enum declaration.
  ComponentEnum extract(analyzer.EnumDeclaration node) {
    final values = node.constants.map((c) => c.name.lexeme).toList();

    return ComponentEnum(
      name: node.name.lexeme,
      values: values,
      description: _propertyExtractor.extractDocComment(node),
    );
  }
}
