import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/models/meta_component.dart';

/// Parses meta component files using the Dart analyzer
class MetaParser {
  MetaParser({required this.logger});

  final Logger logger;

  /// Parse a single meta file
  Future<MetaComponent?> parseFile(File file) async {
    try {
      logger.info('Parsing file: ${file.path}');
      final content = await file.readAsString();
      final result = parseString(content: content);

      final visitor = _MetaComponentVisitor();
      result.unit.visitChildren(visitor);

      if (visitor.component != null) {
        logger.success('Parsed component: ${visitor.component!.name}');
      } else {
        logger.warn('No @MetaComponent annotation found in ${file.path}');
      }

      return visitor.component;
    } catch (e, stackTrace) {
      logger.err('Failed to parse ${file.path}: $e');
      logger.detail(stackTrace.toString());
      return null;
    }
  }

  /// Parse all meta files in a directory
  Future<ParseResult> parseDirectory(Directory directory) async {
    final components = <MetaComponent>[];
    final errors = <String>[];

    if (!await directory.exists()) {
      errors.add('Directory does not exist: ${directory.path}');
      return ParseResult(components: components, errors: errors);
    }

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.meta.dart')) {
        final component = await parseFile(entity);
        if (component != null) {
          components.add(component);
        } else {
          errors.add('Failed to parse: ${entity.path}');
        }
      }
    }

    return ParseResult(components: components, errors: errors);
  }
}

/// AST visitor that extracts meta component information
class _MetaComponentVisitor extends RecursiveAstVisitor<void> {
  MetaComponent? component;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Check for @ForgeComponent annotation - check annotation name using toSource
    final hasMetaAnnotation = node.metadata.any((annotation) {
      final name = annotation.name.toSource();
      return name == 'ForgeComponent' || name == 'MetaComponent';
    });

    if (hasMetaAnnotation) {
      final fields = <MetaField>[];
      final variants = <String>[];

      // Extract fields from class members
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          for (final variable in member.fields.variables) {
            final field = _extractField(variable, member);
            if (field != null) {
              fields.add(field);
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

      component = MetaComponent(
        name: _toSnakeCase(node.name.lexeme),
        className: node.name.lexeme,
        fields: fields,
        variants: variants,
        description: _extractDocComment(node),
      );
    }

    super.visitClassDeclaration(node);
  }

  MetaField? _extractField(
      VariableDeclaration variable, FieldDeclaration declaration) {
    final isRequired = declaration.metadata.any(
      (a) => a.name.toSource() == 'Required',
    );

    final typeNode = declaration.fields.type;
    final typeName = typeNode?.toSource() ?? 'dynamic';

    return MetaField(
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
