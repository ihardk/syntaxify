import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:forge/src/models/token_definition.dart';

/// Parses token definition files using the Dart analyzer
class TokenParser {
  TokenParser({required this.logger});

  final Logger logger;

  /// Parse a single token file
  Future<TokenDefinition?> parseFile(File file) async {
    try {
      final content = await file.readAsString();
      final result = parseString(content: content);

      final visitor = _TokenVisitor();
      result.unit.visitChildren(visitor);

      if (visitor.tokenDefinition != null) {
        logger.detail('Parsed tokens: ${visitor.tokenDefinition!.name}');
      }

      return visitor.tokenDefinition;
    } catch (e) {
      logger.err('Failed to parse ${file.path}: $e');
      return null;
    }
  }

  /// Parse all token files in a directory
  Future<List<TokenDefinition>> parseDirectory(Directory directory) async {
    final tokens = <TokenDefinition>[];

    if (!await directory.exists()) {
      return tokens;
    }

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('_tokens.dart')) {
        final tokenDef = await parseFile(entity);
        if (tokenDef != null) {
          tokens.add(tokenDef);
        }
      }
    }

    return tokens;
  }
}

/// AST visitor that extracts token definitions
class _TokenVisitor extends RecursiveAstVisitor<void> {
  TokenDefinition? tokenDefinition;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Check if class name ends with 'Tokens'
    if (node.name.lexeme.endsWith('Tokens')) {
      final properties = <TokenProperty>[];

      for (final member in node.members) {
        if (member is FieldDeclaration) {
          for (final variable in member.fields.variables) {
            final typeNode = member.fields.type;

            properties.add(TokenProperty(
              name: variable.name.lexeme,
              type: typeNode?.toSource() ?? 'dynamic',
              defaultValue: variable.initializer?.toSource(),
              description: _extractDocComment(member),
            ));
          }
        }
      }

      // Extract component name (remove 'Tokens' suffix)
      final componentName = node.name.lexeme.replaceAll('Tokens', '');

      tokenDefinition = TokenDefinition(
        name: node.name.lexeme,
        componentName: componentName,
        properties: properties,
      );
    }

    super.visitClassDeclaration(node);
  }

  String? _extractDocComment(AnnotatedNode node) {
    final comment = node.documentationComment;
    if (comment == null) return null;

    return comment.tokens
        .map((t) => t.lexeme.replaceFirst('///', '').trim())
        .where((s) => s.isNotEmpty)
        .join(' ');
  }
}
