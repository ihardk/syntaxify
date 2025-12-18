import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart' hide AstNode;
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/models/ast_node.dart';

/// Parses meta component files using the Dart analyzer
class MetaParser {
  MetaParser({required this.logger});

  final Logger logger;

  /// Parse a single meta file
  Future<AstNode?> parseFile(File file) async {
    try {
      logger.info('Parsing file: ${file.path}');
      final content = await file.readAsString();
      final result = parseString(content: content);

      final visitor = _AstNodeVisitor();
      result.unit.visitChildren(visitor);

      if (visitor.node != null) {
        logger.success('Parsed component: ${visitor.node!.name}');
      } else {
        logger.warn('No @ForgeComponent annotation found in ${file.path}');
      }

      return visitor.node;
    } catch (e, stackTrace) {
      logger.err('Failed to parse ${file.path}: $e');
      logger.detail(stackTrace.toString());
      return null;
    }
  }

  /// Parse all meta files in a directory
  Future<ParseResult> parseDirectory(Directory directory) async {
    final nodes = <AstNode>[];
    final errors = <String>[];

    if (!await directory.exists()) {
      errors.add('Directory does not exist: ${directory.path}');
      return ParseResult(nodes: nodes, errors: errors);
    }

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.meta.dart')) {
        final node = await parseFile(entity);
        if (node != null) {
          nodes.add(node);
        } else {
          errors.add('Failed to parse: ${entity.path}');
        }
      }
    }

    return ParseResult(nodes: nodes, errors: errors);
  }
}

/// AST visitor that extracts meta component information
class _AstNodeVisitor extends RecursiveAstVisitor<void> {
  AstNode? node;

  @override
  void visitClassDeclaration(ClassDeclaration classNode) {
    // Check for @ForgeComponent annotation
    final hasMetaAnnotation = classNode.metadata.any((annotation) {
      final name = annotation.name.toSource();
      return name == 'ForgeComponent' || name == 'MetaComponent';
    });

    if (hasMetaAnnotation) {
      final properties = <AstProp>[];
      final variants = <String>[];

      // Extract properties from class members
      for (final member in classNode.members) {
        if (member is FieldDeclaration) {
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
                if (listLiteral is ListLiteral) {
                  for (final element in listLiteral.elements) {
                    if (element is StringLiteral) {
                      variants.add(element.stringValue ?? '');
                    }
                  }
                }
              }
            }
          }
        }
      }

      node = AstNode(
        name: _toSnakeCase(classNode.name.lexeme),
        className: classNode.name.lexeme,
        properties: properties,
        variants: variants,
        description: _extractDocComment(classNode),
      );
    }

    super.visitClassDeclaration(classNode);
  }

  AstProp? _extractProperty(
      VariableDeclaration variable, FieldDeclaration declaration) {
    final isRequired = declaration.metadata.any(
      (a) => a.name.toSource() == 'Required',
    );

    final typeNode = declaration.fields.type;
    final typeName = typeNode?.toSource() ?? 'dynamic';

    return AstProp(
      name: variable.name.lexeme,
      type: typeName,
      isRequired: isRequired,
      defaultValue: variable.initializer?.toSource(),
      description: _extractDocComment(declaration),
    );
  }

  String? _extractDocComment(AnnotatedNode node) {
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
}
