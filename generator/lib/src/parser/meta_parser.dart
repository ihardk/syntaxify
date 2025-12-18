import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/models/component_definition.dart';
import 'package:forge/src/models/ast/nodes.dart';
import 'ast_node_parser.dart';

/// Parses meta component files using the Dart analyzer
class MetaParser {
  MetaParser({required this.logger});

  final Logger logger;

  /// Parse a single meta file
  Future<ComponentDefinition?> parseFile(File file) async {
    // ... (This method only returns ComponentDefinition, ignored for now)
    return null;
  }

  /// Parse all meta files in a directory
  Future<ParseResult> parseDirectory(Directory directory) async {
    final components = <ComponentDefinition>[];
    final screens = <ScreenDefinition>[];
    final enums = <ComponentEnum>[];
    final errors = <String>[];

    if (!await directory.exists()) {
      errors.add('Directory does not exist: ${directory.path}');
      return ParseResult(components: components, enums: enums, errors: errors);
    }

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        // We now parse .dart files for Screens too, not just .meta.dart
        // But for P0 optimization, let's look for .meta.dart OR .screen.dart
        if (entity.path.endsWith('.meta.dart') ||
            entity.path.endsWith('.screen.dart')) {
          final content = await entity.readAsString();
          final unitResult = parseString(content: content);

          final visitor = _AstNodeVisitor();
          unitResult.unit.visitChildren(visitor);

          if (visitor.component != null) {
            components.add(visitor.component!);
          }

          screens.addAll(visitor.screens);
          enums.addAll(visitor.enums);
        }
      }
    }

    return ParseResult(
        components: components, screens: screens, enums: enums, errors: errors);
  }
}

// ... (MetaParser class remains mostly same, just imports and delegation)
// Actually we need to remove _AstNodeVisitor's internal methods and delegate.

/// AST visitor that extracts meta component information
class _AstNodeVisitor extends RecursiveAstVisitor<void> {
  ComponentDefinition? component;
  final screens = <ScreenDefinition>[];
  final enums = <ComponentEnum>[];

  final _nodeParser = const AstNodeParser();

  @override
  void visitEnumDeclaration(analyzer.EnumDeclaration node) {
    final values = node.constants.map((c) => c.name.lexeme).toList();

    enums.add(ComponentEnum(
      name: node.name.lexeme,
      values: values,
      description: _extractDocComment(node),
    ));

    super.visitEnumDeclaration(node);
  }

  @override
  void visitClassDeclaration(analyzer.ClassDeclaration classNode) {
    // Check for @ForgeComponent annotation
    final hasMetaAnnotation = classNode.metadata.any((annotation) {
      final name = annotation.name.toSource();
      return name == 'ForgeComponent' || name == 'MetaComponent';
    });

    if (hasMetaAnnotation) {
      final properties = <ComponentProp>[];
      final variants = <String>[];

      // Extract properties from class members
      for (final member in classNode.members) {
        if (member is analyzer.FieldDeclaration) {
          for (final variable in member.fields.variables) {
            final prop = _extractProperty(variable, member);
            if (prop != null) {
              properties.add(prop);
            }

            // Check for @Variant annotation
            final variantAnnotation = member.metadata
                .where(
                  (a) => a.name.toSource() == 'Variant',
                )
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
          }
        }
      }

      component = ComponentDefinition(
        name: _toSnakeCase(classNode.name.lexeme),
        className: classNode.name.lexeme,
        properties: properties,
        variants: variants,
        description: _extractDocComment(classNode),
      );
    }

    super.visitClassDeclaration(classNode);
  }

  ComponentProp? _extractProperty(analyzer.VariableDeclaration variable,
      analyzer.FieldDeclaration declaration) {
    final isRequired = declaration.metadata.any(
      (a) => a.name.toSource() == 'Required',
    );

    final typeNode = declaration.fields.type;
    final typeName = typeNode?.toSource() ?? 'dynamic';

    return ComponentProp(
      name: variable.name.lexeme,
      type: typeName,
      isRequired: isRequired,
      defaultValue: variable.initializer?.toSource(),
      description: _extractDocComment(declaration),
    );
  }

  String? _extractDocComment(analyzer.AnnotatedNode node) {
    final comment = node.documentationComment;
    if (comment == null) return null;

    return comment.tokens
        .map((t) => t.lexeme.replaceFirst('///', '').trim())
        .where((s) => s.isNotEmpty)
        .join(' ');
  }

  String _toSnakeCase(String input) {
    return input
        .replaceAllMapped(
          RegExp('([A-Z])'),
          (match) => '_${match.group(1)!.toLowerCase()}',
        )
        .replaceFirst('_', '');
  }

  @override
  void visitTopLevelVariableDeclaration(
      analyzer.TopLevelVariableDeclaration node) {
    for (final variable in node.variables.variables) {
      final initializer = variable.initializer;

      if (initializer is analyzer.InstanceCreationExpression) {
        final typeName = initializer.constructorName.type.name2.lexeme;
        if (typeName == 'ScreenDefinition') {
          _tryParseScreen(initializer, variable.name.lexeme);
        }
      } else if (initializer is analyzer.MethodInvocation) {
        final name = initializer.methodName.name;
        if (name == 'ScreenDefinition') {
          _tryParseScreen(initializer, variable.name.lexeme);
        }
      }
    }
    super.visitTopLevelVariableDeclaration(node);
  }

  void _tryParseScreen(analyzer.Expression expression, String varName) {
    try {
      final screen = _nodeParser.parseScreenFromExpression(expression, varName);
      screens.add(screen);
    } catch (e) {
      print('Error parsing screen $varName: $e');
    }
  }
}
