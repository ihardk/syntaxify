import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:forge/src/models/ast/nodes.dart';
import 'package:forge/src/parser/ast_node_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = AstNodeParser();

  Expression parseExpression(String code) {
    final result = parseString(content: 'final x = $code;');
    final decl = result.unit.declarations.first as TopLevelVariableDeclaration;
    return decl.variables.variables.first.initializer!;
  }

  group('AstNodeParser', () {
    test('parses ButtonNode properties', () {
      final code = '''
        AstNode.button(
          label: 'Click Me',
          variant: ButtonVariant.outlined,
          size: ButtonSize.lg,
          icon: 'add',
          onPressed: 'onSubmit',
          isDisabled: true,
        )
      ''';

      final expression = parseExpression(code);
      final node = parser.parseAstNode(expression) as ButtonNode;

      expect(node.label, 'Click Me');
      expect(node.variant, ButtonVariant.outlined);
      expect(node.size, ButtonSize.lg);
      expect(node.icon, 'add');
      expect(node.onPressed, 'onSubmit');
      expect(node.isDisabled, true);
    });

    test('parses TextFieldNode properties', () {
      final code = '''
        AstNode.textField(
          label: 'Username',
          hint: 'Enter your username',
          obscureText: true,
          keyboardType: KeyboardType.email,
        )
      ''';

      final expression = parseExpression(code);
      final node = parser.parseAstNode(expression) as TextFieldNode;

      expect(node.label, 'Username');
      expect(node.hint, 'Enter your username');
      expect(node.obscureText, true);
      expect(node.keyboardType, KeyboardType.email);
    });

    test('parses defaults correctly', () {
      final code = "AstNode.button(label: 'Simple')";
      final expression = parseExpression(code);
      final node = parser.parseAstNode(expression) as ButtonNode;

      expect(node.variant, ButtonVariant.filled); // Default in parser logic
      expect(node.size, null); // Default is null (unspecified)
      expect(node.isDisabled, null);
    });
  });
}
