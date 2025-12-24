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

    // Analyze constructor for defaults and required parameters
    final constructorDefaults = <String, String>{};
    final constructorRequired = <String>{};

    for (final member in classNode.members) {
      if (member is analyzer.ConstructorDeclaration &&
          (member.name == null || member.name!.lexeme.isEmpty)) {
        for (final param in member.parameters.parameters) {
          final paramName = param.name?.lexeme;
          if (paramName == null) continue;

          // Check for default value
          if (param is analyzer.DefaultFormalParameter) {
            if (param.defaultValue != null) {
              constructorDefaults[paramName] = param.defaultValue!.toSource();
            }
          }

          // Check for 'required' keyword
          var p = param;
          if (p is analyzer.DefaultFormalParameter) {
            p = p.parameter;
          }

          if (p is analyzer.NormalFormalParameter) {
            if (p.requiredKeyword != null) {
              constructorRequired.add(paramName);
            }
          }
        }
      }
    }

    // Update properties with constructor information
    final updatedProperties = properties.map((prop) {
      var isRequired = prop.isRequired;
      String? defaultValue = prop.defaultValue;

      if (constructorDefaults.containsKey(prop.name)) {
        defaultValue = constructorDefaults[prop.name];
        isRequired = false;
      }

      if (constructorRequired.contains(prop.name)) {
        isRequired = true;
      } else if (defaultValue != null) {
        isRequired = false;
      }

      return prop.copyWith(
        isRequired: isRequired,
        defaultValue: defaultValue,
      );
    }).toList();

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
      properties: updatedProperties,
      variants: variants,
      description: _propertyExtractor.extractDocComment(classNode),
      typeParameters: typeParameters,
    );
  }
}
