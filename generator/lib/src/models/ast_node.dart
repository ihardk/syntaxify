import 'package:freezed_annotation/freezed_annotation.dart';

part 'ast_node.freezed.dart';

/// Represents a parsed AST node definition
@freezed
class AstNode with _$AstNode {
  const factory AstNode({
    required String name,
    required String className,
    required List<AstProp> properties,
    required List<String> variants,
    String? description,
  }) = _AstNode;
}

/// Represents a property in an AST node
@freezed
class AstProp with _$AstProp {
  const factory AstProp({
    required String name,
    required String type,
    required bool isRequired,
    String? defaultValue,
    String? description,
  }) = _AstProp;
}

/// Represents the result of parsing AST files
@freezed
class ParseResult with _$ParseResult {
  const factory ParseResult({
    required List<AstNode> nodes,
    required List<String> errors,
  }) = _ParseResult;

  const ParseResult._();

  bool get hasErrors => errors.isNotEmpty;
}
