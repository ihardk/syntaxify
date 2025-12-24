import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:mason_logger/mason_logger.dart';

import 'package:syntaxify/src/models/component_definition.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/extractors/extractors.dart';
import 'layout_node_parser.dart';

/// Parses meta component files using the Dart analyzer.
///
/// Uses focused extractors for different concerns:
/// - [ComponentExtractor] for @SyntaxComponent annotated classes
/// - [EnumExtractor] for enum declarations
/// - [PropertyExtractor] for field properties
class MetaParser {
  MetaParser({required this.logger});

  final Logger logger;

  /// Parse a single meta file
  Future<ComponentDefinition?> parseFile(File file) async {
    if (!await file.exists()) {
      logger.warn('File does not exist: ${file.path}');
      return null;
    }

    try {
      final content = await file.readAsString();
      final unitResult = parseString(content: content);

      final visitor = _MetaVisitor();
      unitResult.unit.visitChildren(visitor);

      return visitor.component;
    } catch (e) {
      logger.err('Failed to parse file ${file.path}: $e');
      return null;
    }
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
        if (entity.path.endsWith('.meta.dart') ||
            entity.path.endsWith('.screen.dart')) {
          final content = await entity.readAsString();
          final unitResult = parseString(content: content);

          final visitor = _MetaVisitor();
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

/// AST visitor that delegates extraction to focused extractors.
class _MetaVisitor extends RecursiveAstVisitor<void> {
  _MetaVisitor()
      : _componentExtractor = ComponentExtractor(),
        _enumExtractor = EnumExtractor(),
        _nodeParser = AppParser();

  final ComponentExtractor _componentExtractor;
  final EnumExtractor _enumExtractor;
  final AppParser _nodeParser;

  ComponentDefinition? component;
  final screens = <ScreenDefinition>[];
  final enums = <ComponentEnum>[];

  @override
  void visitEnumDeclaration(analyzer.EnumDeclaration node) {
    enums.add(_enumExtractor.extract(node));
    super.visitEnumDeclaration(node);
  }

  @override
  void visitClassDeclaration(analyzer.ClassDeclaration node) {
    final extracted = _componentExtractor.extract(node);
    if (extracted != null) {
      component = extracted;
    }
    super.visitClassDeclaration(node);
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
      // Log but don't fail - screen parsing errors shouldn't stop parsing
      print('Error parsing screen $varName: $e');
    }
  }
}
