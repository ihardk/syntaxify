import 'package:test/test.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';

void main() {
  group('AstNode', () {
    test('instantiates ColumnNode', () {
      final node = AstNode.column(
        children: [
          AstNode.text(text: 'Hello'),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      expect(node, isA<ColumnNode>());
      expect((node as ColumnNode).children.length, 1);
      expect(node.mainAxisAlignment, equals(MainAxisAlignment.center));
    });

    test('instantiates TextNode', () {
      final node = AstNode.text(
        text: 'Hello World',
        variant: TextVariant.headlineMedium,
      );

      expect(node, isA<TextNode>());
      expect((node as TextNode).text, equals('Hello World'));
      expect(node.variant, equals(TextVariant.headlineMedium));
    });

    test('instantiates ButtonNode', () {
      final node = AstNode.button(
        label: 'Click Me',
        variant: ButtonVariant.filled,
        onPressed: 'action:submit',
      );

      expect(node, isA<ButtonNode>());
      expect((node as ButtonNode).label, equals('Click Me'));
      expect(node.variant, equals(ButtonVariant.filled));
    });

    test('instantiates RowNode', () {
      final node = AstNode.row(
        children: [
          AstNode.text(text: 'Label'),
          AstNode.icon(name: 'arrow_forward'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );

      expect(node, isA<RowNode>());
      expect((node as RowNode).children.length, 2);
      expect(node.mainAxisAlignment, equals(MainAxisAlignment.spaceBetween));
    });

    test('instantiates TextFieldNode', () {
      final node = AstNode.textField(
        label: 'Username',
        hint: 'Enter your logic',
        keyboardType: KeyboardType.email,
        textInputAction: TextInputAction.next,
        obscureText: false,
      );

      expect(node, isA<TextFieldNode>());
      expect((node as TextFieldNode).label, equals('Username'));
      expect(node.keyboardType, equals(KeyboardType.email));
    });

    test('instantiates IconNode', () {
      final node = AstNode.icon(
        name: 'person',
        size: IconSize.md,
        semantic: ColorSemantic.primary,
      );

      expect(node, isA<IconNode>());
      expect((node as IconNode).name, equals('person'));
      expect(node.semantic, equals(ColorSemantic.primary));
    });

    test('instantiates SpacerNode', () {
      final node = AstNode.spacer(
        flex: 2,
        size: SpacerSize.md,
      );

      expect(node, isA<SpacerNode>());
      expect((node as SpacerNode).flex, equals(2));
      expect(node.size, equals(SpacerSize.md));
    });

    test('serialization works for all types', () {
      final textNode = AstNode.text(text: 'Test');
      expect(AstNode.fromJson(textNode.toJson()), equals(textNode));

      final colNode = AstNode.column(children: [textNode]);
      expect(AstNode.fromJson(colNode.toJson()), equals(colNode));

      final rowNode = AstNode.row(children: [textNode]);
      expect(AstNode.fromJson(rowNode.toJson()), equals(rowNode));

      final iconNode = AstNode.icon(name: 'check');
      expect(AstNode.fromJson(iconNode.toJson()), equals(iconNode));
    });
  });

  group('ScreenDefinition', () {
    test('instantiates ScreenDefinition', () {
      final screen = ScreenDefinition(
        id: 'home_screen',
        layout: AstNode.column(children: []),
        appBar: AstNode.appBar(title: 'Home') as AppBarNode,
      );

      expect(screen.id, equals('home_screen'));
      expect(screen.layout, isA<ColumnNode>());
      expect((screen.appBar as AppBarNode?)?.title, equals('Home'));
    });
  });
}
