import 'package:test/test.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/ast/custom/custom_node.dart';

void main() {
  group('LayoutNode', () {
    test('instantiates ColumnNode', () {
      final node = LayoutNode.column(
        children: [
          LayoutNode.text(text: 'Hello'),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      // Verify it is a structural node
      node.map(
        structural: (s) {
          s.node.map(
            column: (col) {
              expect(col.children.length, 1);
              expect(col.mainAxisAlignment, equals(MainAxisAlignment.center));
            },
            row: (_) => fail('Expected column, got row'),
          );
        },
        primitive: (_) => fail('Expected structural, got primitive'),
        interactive: (_) => fail('Expected structural, got interactive'),
        custom: (_) => fail('Expected structural, got custom'),
        appBar: (_) => fail('Expected structural, got appBar'),
      );
    });

    test('instantiates TextNode', () {
      final node = LayoutNode.text(
        text: 'Hello World',
        variant: TextVariant.headlineMedium,
      );

      node.map(
        primitive: (p) {
          p.node.map(
            text: (t) {
              expect(t.text, equals('Hello World'));
              expect(t.variant, equals(TextVariant.headlineMedium));
            },
            icon: (_) => fail('Expected text, got icon'),
            spacer: (_) => fail('Expected text, got spacer'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates ButtonNode', () {
      final node = LayoutNode.button(
        label: 'Click Me',
        variant: ButtonVariant.filled,
        onPressed: 'action:submit',
      );

      node.map(
        interactive: (i) {
          i.node.map(
            button: (b) {
              expect(b.label, equals('Click Me'));
              expect(b.onPressed, equals('action:submit'));
              expect(b.props?.variant, equals(ButtonVariant.filled));
            },
            textField: (_) => fail('Expected button, got textField'),
          );
        },
        structural: (_) => fail('Expected interactive, got structural'),
        primitive: (_) => fail('Expected interactive, got primitive'),
        custom: (_) => fail('Expected interactive, got custom'),
        appBar: (_) => fail('Expected interactive, got appBar'),
      );
    });

    test('instantiates RowNode', () {
      final node = LayoutNode.row(
        children: [
          LayoutNode.text(text: 'Label'),
          LayoutNode.icon(name: 'arrow_forward'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );

      node.map(
        structural: (s) {
          s.node.map(
            row: (row) {
              expect(row.children.length, 2);
              expect(row.mainAxisAlignment,
                  equals(MainAxisAlignment.spaceBetween));
            },
            column: (_) => fail('Expected row, got column'),
          );
        },
        primitive: (_) => fail('Expected structural, got primitive'),
        interactive: (_) => fail('Expected structural, got interactive'),
        custom: (_) => fail('Expected structural, got custom'),
        appBar: (_) => fail('Expected structural, got appBar'),
      );
    });

    test('instantiates TextFieldNode', () {
      final node = LayoutNode.textField(
        label: 'Username',
        hint: 'Enter your logic',
        keyboardType: KeyboardType.email,
        obscureText: false,
      );

      node.map(
        interactive: (i) {
          i.node.map(
            textField: (tf) {
              expect(tf.label, equals('Username'));
              expect(tf.props?.hint, equals('Enter your logic'));
              expect(tf.props?.keyboardType, equals(KeyboardType.email));
            },
            button: (_) => fail('Expected textField, got button'),
          );
        },
        structural: (_) => fail('Expected interactive, got structural'),
        primitive: (_) => fail('Expected interactive, got primitive'),
        custom: (_) => fail('Expected interactive, got custom'),
        appBar: (_) => fail('Expected interactive, got appBar'),
      );
    });

    test('instantiates IconNode', () {
      final node = LayoutNode.icon(
        name: 'person',
        size: IconSize.md,
      );

      node.map(
        primitive: (p) {
          p.node.map(
            icon: (icon) {
              expect(icon.name, equals('person'));
              expect(icon.size, equals(IconSize.md));
            },
            text: (_) => fail('Expected icon, got text'),
            spacer: (_) => fail('Expected icon, got spacer'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates SpacerNode', () {
      final node = LayoutNode.spacer(
        flex: 2,
      );

      node.map(
        primitive: (p) {
          p.node.map(
            spacer: (spacer) {
              expect(spacer.flex, equals(2));
            },
            text: (_) => fail('Expected spacer, got text'),
            icon: (_) => fail('Expected spacer, got icon'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates CustomNode', () {
      final node = LayoutNode.custom(
        node: CustomNode(type: 'Carousel', props: {'items': []}),
      );

      node.map(
        custom: (c) {
          expect(c.node.type, equals('Carousel'));
          expect(c.node.props, equals({'items': []}));
        },
        structural: (_) => fail('Expected custom, got structural'),
        primitive: (_) => fail('Expected custom, got primitive'),
        interactive: (_) => fail('Expected custom, got interactive'),
        appBar: (_) => fail('Expected custom, got appBar'),
      );
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

      screen.layout.map(
        structural: (s) {
          s.node.map(
            column: (_) {},
            row: (_) => fail('Expected column'),
          );
        },
        primitive: (_) => fail('Layout root should be structural'),
        interactive: (_) => fail('Layout root should be structural'),
        custom: (_) => fail('Layout root should be structural'),
        appBar: (_) => fail('Layout root should be structural'),
      );

      expect(screen.appBar, isNotNull);
      screen.appBar!.map(
        appBar: (a) => expect(a.title, equals('Home')),
        structural: (_) => fail('Expected appBar'),
        primitive: (_) => fail('Expected appBar'),
        custom: (_) => fail('Expected appBar'),
        interactive: (_) => fail('Expected appBar'),
      );
    });
  });
}
