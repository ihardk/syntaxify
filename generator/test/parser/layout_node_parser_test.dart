import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/parser/layout_node_parser.dart';

import 'package:test/test.dart';

void main() {
  const parser = LayoutNodeParser();

  Expression parseExpression(String code) {
    final result = parseString(content: 'final x = $code;');
    final decl = result.unit.declarations.first as TopLevelVariableDeclaration;
    return decl.variables.variables.first.initializer!;
  }

  group('LayoutNodeParser', () {
    test('parses ButtonNode properties', () {
      final code = '''
        LayoutNode.button(
          label: 'Click Me',
          variant: ButtonVariant.outlined,
          size: ButtonSize.lg,
          icon: 'add',
          onPressed: 'onSubmit',
          isDisabled: true,
        )
      ''';

      final expression = parseExpression(code);
      final node = parser.parseLayoutNode(expression);

      node.map(
        interactive: (i) {
          i.node.map(
            button: (b) {
              expect(b.label, 'Click Me');
              expect(b.props?.variant, ButtonVariant.outlined);
              expect(b.props?.size, ButtonSize.lg);
              expect(b.props?.icon, 'add');
              expect(b.onPressed, 'onSubmit');
              expect(b.props?.isDisabled, true);
            },
            textField: (_) => fail('Expected button'),
          );
        },
        structural: (_) => fail('Expected interactive'),
        primitive: (_) => fail('Expected interactive'),
        custom: (_) => fail('Expected interactive'),
        appBar: (_) => fail('Expected interactive'),
      );
    });

    test('parses TextFieldNode properties', () {
      final code = '''
        LayoutNode.textField(
          label: 'Username',
          hint: 'Enter your username',
          obscureText: true,
          keyboardType: KeyboardType.email,
        )
      ''';

      final expression = parseExpression(code);
      final node = parser.parseLayoutNode(expression);

      node.map(
        interactive: (i) {
          i.node.map(
            textField: (tf) {
              expect(tf.label, 'Username');
              expect(tf.props?.hint, 'Enter your username');
              expect(tf.props?.obscureText, true);
              expect(tf.props?.keyboardType, KeyboardType.email);
            },
            button: (_) => fail('Expected textField'),
          );
        },
        structural: (_) => fail('Expected interactive'),
        primitive: (_) => fail('Expected interactive'),
        custom: (_) => fail('Expected interactive'),
        appBar: (_) => fail('Expected interactive'),
      );
    });

    test('parses defaults correctly', () {
      final code = "LayoutNode.button(label: 'Simple')";
      final expression = parseExpression(code);
      final node = parser.parseLayoutNode(expression);

      node.map(
        interactive: (i) {
          i.node.map(
            button: (b) {
              expect(b.props?.variant, ButtonVariant.filled); // Default
              expect(b.props?.size, null);
              expect(b.props?.isDisabled, false);
            },
            textField: (_) => fail('Expected button'),
          );
        },
        structural: (_) => fail('Expected interactive'),
        primitive: (_) => fail('Expected interactive'),
        custom: (_) => fail('Expected interactive'),
        appBar: (_) => fail('Expected interactive'),
      );
    });
  });
}
