import 'package:test/test.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';

void main() {
  group('LayoutNode', () {
    test('instantiates ColumnNode', () {
      final node = LayoutNode.column(
        children: [
          LayoutNode.text(text: 'Hello'),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      expect(node, isA<ColumnNode>());
      expect((node as ColumnNode).children.length, 1);
      expect(node.mainAxisAlignment, equals(MainAxisAlignment.center));
    });

    test('instantiates TextNode', () {
      final node = LayoutNode.text(
        text: 'Hello World',
        variant: TextVariant.headlineMedium,
      );

      expect(node, isA<TextNode>());
      expect((node as TextNode).text, equals('Hello World'));
      expect(node.variant, equals(TextVariant.headlineMedium));
    });

    test('instantiates ButtonNode', () {
      final node = LayoutNode.button(
        label: 'Click Me',
        variant: ButtonVariant.filled,
        onPressed: 'action:submit',
      );

      expect(node, isA<ButtonNode>());
      expect((node as ButtonNode).label, equals('Click Me'));
      expect(node.variant, equals(ButtonVariant.filled));
    });

    test('instantiates RowNode', () {
      final node = LayoutNode.row(
        children: [
          LayoutNode.text(text: 'Label'),
          LayoutNode.icon(name: 'arrow_forward'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );

      expect(node, isA<RowNode>());
      expect((node as RowNode).children.length, 2);
      expect(node.mainAxisAlignment, equals(MainAxisAlignment.spaceBetween));
    });

    test('instantiates TextFieldNode', () {
      final node = LayoutNode.textField(
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
      final node = LayoutNode.icon(
        name: 'person',
        size: IconSize.md,
        semantic: ColorSemantic.primary,
      );

      expect(node, isA<IconNode>());
      expect((node as IconNode).name, equals('person'));
      expect(node.semantic, equals(ColorSemantic.primary));
    });

    test('instantiates SpacerNode', () {
      final node = LayoutNode.spacer(
        flex: 2,
        size: SpacerSize.md,
      );

      expect(node, isA<SpacerNode>());
      expect((node as SpacerNode).flex, equals(2));
      expect(node.size, equals(SpacerSize.md));
    });

    test('serialization works for all types', () {
      final textNode = LayoutNode.text(text: 'Test');
      expect(LayoutNode.fromJson(textNode.toJson()), equals(textNode));

      final colNode = LayoutNode.column(children: [textNode]);
      expect(LayoutNode.fromJson(colNode.toJson()), equals(colNode));

      final rowNode = LayoutNode.row(children: [textNode]);
      expect(LayoutNode.fromJson(rowNode.toJson()), equals(rowNode));

      final iconNode = LayoutNode.icon(name: 'check');
      expect(LayoutNode.fromJson(iconNode.toJson()), equals(iconNode));
    });
  });

  group('ScreenDefinition', () {
    test('instantiates ScreenDefinition', () {
      final screen = ScreenDefinition(
        id: 'home_screen',
        layout: LayoutNode.column(children: []),
        appBar: LayoutNode.appBar(title: 'Home') as AppBarNode,
      );

      expect(screen.id, equals('home_screen'));
      expect(screen.layout, isA<ColumnNode>());
      expect((screen.appBar as AppBarNode?)?.title, equals('Home'));
    });
  });
}
