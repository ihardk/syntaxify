import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

enum RegistryType { icon, image }

class RegistryDefinition {
  final String className;
  final RegistryType type;
  // Map of FieldName -> Value
  // For icons: 'search' -> 'Icons.search'
  // For images: 'logo' -> 'assets/images/logo.png'
  final Map<String, String> mappings;

  RegistryDefinition({
    required this.className,
    required this.type,
    required this.mappings,
  });
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
    // Check for @IconRegistry or @ImageRegistry annotation
    final iconAnnotation = node.metadata
        .where((a) => a.name.toSource() == 'IconRegistry')
        .firstOrNull;
    final imageAnnotation = node.metadata
        .where((a) => a.name.toSource() == 'ImageRegistry')
        .firstOrNull;

    if (iconAnnotation != null || imageAnnotation != null) {
      final isIcon = iconAnnotation != null;
      final mappingAnnotationName = isIcon ? 'IconMapping' : 'ImageMapping';
      final mappings = <String, String>{};

      for (final member in node.members) {
        if (member is FieldDeclaration) {
          // Check for @IconMapping or @ImageMapping annotation
          final mappingAnnotation = member.metadata
              .where((a) => a.name.toSource() == mappingAnnotationName)
              .firstOrNull;

          if (mappingAnnotation != null) {
            final args = mappingAnnotation.arguments?.arguments;
            if (args != null && args.isNotEmpty) {
              final firstArg = args.first;
              if (firstArg is StringLiteral) {
                final value = firstArg.stringValue;

                // Find field name
                for (final variable in member.fields.variables) {
                  if (value != null) {
                    mappings[variable.name.lexeme] = value;
                  }
                }
              }
            }
          }
        }
      }

      definition = RegistryDefinition(
        className: node.name.lexeme,
        type: isIcon ? RegistryType.icon : RegistryType.image,
        mappings: mappings,
      );
    }
  }
}
