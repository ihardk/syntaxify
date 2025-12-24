import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/parser/extractors/property_extractor.dart';
import 'package:syntaxify/src/utils/string_utils.dart';

/// Extracts ComponentDefinition from @SyntaxComponent annotated classes.
class ComponentExtractor {
  ComponentExtractor({PropertyExtractor? propertyExtractor})
      : _propertyExtractor = propertyExtractor ?? PropertyExtractor();

  final PropertyExtractor _propertyExtractor;

  /// Attempts to extract a component definition from a class declaration.
  /// Returns null if the class doesn't have @SyntaxComponent annotation.
  ComponentDefinition? extract(analyzer.ClassDeclaration classNode) {
    final metaAnnotation = classNode.metadata.where((annotation) {
      final name = annotation.name.toSource();
      return name == 'SyntaxComponent';
    }).firstOrNull;

    if (metaAnnotation == null) return null;

    final properties = <ComponentProp>[];
    final variants = <String>[];

    // Extract explicit name and variants from annotation
    String? explicitName;
    final args = metaAnnotation.arguments?.arguments;
    if (args != null) {
      for (final arg in args) {
        if (arg is analyzer.NamedExpression) {
          final argName = arg.name.label.name;

          if (argName == 'name') {
            if (arg.expression is analyzer.StringLiteral) {
              explicitName =
                  (arg.expression as analyzer.StringLiteral).stringValue;
            }
          } else if (argName == 'variants') {
            if (arg.expression is analyzer.ListLiteral) {
              final listLiteral = arg.expression as analyzer.ListLiteral;
              for (final element in listLiteral.elements) {
                if (element is analyzer.StringLiteral) {
                  variants.add(element.stringValue ?? '');
                }
              }
            }
          }
        }
      }
    }

    // Extract properties from class members
    for (final member in classNode.members) {
      if (member is analyzer.FieldDeclaration) {
        for (final variable in member.fields.variables) {
          final prop = _propertyExtractor.extract(variable, member);
          if (prop != null) {
            properties.add(prop);
          }

          // Check for @Variant annotation on field
          variants.addAll(_propertyExtractor.extractVariants(member));
        }
      }
    }

    // Extract type parameters
    final typeParameters = <String>[];
    final typeParamList = classNode.typeParameters;
    if (typeParamList != null) {
      for (final typeParam in typeParamList.typeParameters) {
        typeParameters.add(typeParam.name.lexeme);
      }
    }

    return ComponentDefinition(
      name: StringUtils.toSnakeCase(classNode.name.lexeme),
      className: classNode.name.lexeme,
      explicitName: explicitName,
      properties: properties,
      variants: variants,
      description: _propertyExtractor.extractDocComment(classNode),
      typeParameters: typeParameters,
    );
  }
}
