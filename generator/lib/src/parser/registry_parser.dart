import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

class RegistryDefinition {
  final String className;
  // Map of FieldName -> IconDataString (e.g. 'search' -> 'Icons.search')
  final Map<String, String> mappings;

  RegistryDefinition({required this.className, required this.mappings});
}

class RegistryParser {
  RegistryParser({required this.logger});

  final Logger logger;

  Future<RegistryDefinition?> parseFile(File file) async {
    try {
      final content = await file.readAsString();
      final result = parseString(content: content);

      final visitor = _RegistryVisitor();
      result.unit.visitChildren(visitor);

      if (visitor.definition != null) {
        logger.success('Parsed registry: ${visitor.definition!.className}');
      }

      return visitor.definition;
    } catch (e) {
      logger.detail('Failed to parse registry ${file.path}: $e');
      return null;
    }
  }

  Future<List<RegistryDefinition>> parseDirectory(Directory directory) async {
    final registries = <RegistryDefinition>[];

    if (!await directory.exists()) return registries;

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        // Skip hidden files or deeply nested implementation details if needed
        // For now, parse all dart files in search of @IconRegistry
        final reg = await parseFile(entity);
        if (reg != null) registries.add(reg);
      }
    }

    return registries;
  }
}

class _RegistryVisitor extends RecursiveAstVisitor<void> {
  RegistryDefinition? definition;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Check for @IconRegistry annotation
    final hasAnnotation = node.metadata.any((annotation) {
      return annotation.name.toSource() == 'IconRegistry';
    });

    if (hasAnnotation) {
      final mappings = <String, String>{};

      for (final member in node.members) {
        if (member is FieldDeclaration) {
          // Check for @IconMapping annotation
          final mappingAnnotation = member.metadata
              .where((a) => a.name.toSource() == 'IconMapping')
              .firstOrNull;

          if (mappingAnnotation != null) {
            final args = mappingAnnotation.arguments?.arguments;
            if (args != null && args.isNotEmpty) {
              final firstArg = args.first;
              if (firstArg is StringLiteral) {
                final iconData = firstArg.stringValue;

                // Find field name
                for (final variable in member.fields.variables) {
                  if (iconData != null) {
                    mappings[variable.name.lexeme] = iconData;
                  }
                }
              }
            }
          }
        }
      }

      definition = RegistryDefinition(
        className: node.name.lexeme,
        mappings: mappings,
      );
    }
  }
}
