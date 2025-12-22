import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:file/file.dart' as f;

/// Parses enum definitions from Dart files.
///
/// Used to extract variant enums from user's design system files
/// so the generator can create helper constructors dynamically.
class EnumParser {
  /// Parses all enums marked with @Variant from files in the directory.
  ///
  /// Returns a map of enum name -> list of values.
  /// e.g., {'ButtonVariant': ['primary', 'secondary', 'outlined', 'text']}
  Future<Map<String, List<String>>> parseVariantEnums(
    f.Directory designSystemDir,
  ) async {
    final enums = <String, List<String>>{};

    if (!await designSystemDir.exists()) {
      return enums;
    }

    // Scan all .dart files in design system directory
    await for (final entity in designSystemDir.list(recursive: true)) {
      if (entity is f.File && entity.path.endsWith('.dart')) {
        final parsed = await _parseFile(entity);
        enums.addAll(parsed);
      }
    }

    return enums;
  }

  Future<Map<String, List<String>>> _parseFile(f.File file) async {
    final enums = <String, List<String>>{};

    try {
      final content = await file.readAsString();
      final result = parseString(content: content);
      final unit = result.unit;

      final visitor = _EnumVisitor();
      unit.visitChildren(visitor);

      enums.addAll(visitor.enums);
    } catch (e) {
      // Skip files that can't be parsed
    }

    return enums;
  }
}

/// AST visitor that extracts @Variant annotated enum declarations.
class _EnumVisitor extends RecursiveAstVisitor<void> {
  final Map<String, List<String>> enums = {};

  @override
  void visitEnumDeclaration(analyzer.EnumDeclaration node) {
    // Check if this enum has @Variant annotation
    final hasVariantAnnotation = node.metadata.any((annotation) {
      final name = annotation.name.name;
      return name == 'Variant';
    });

    if (hasVariantAnnotation) {
      final name = node.name.lexeme;
      final values = node.constants.map((c) => c.name.lexeme).toList();
      enums[name] = values;
    }

    super.visitEnumDeclaration(node);
  }
}
