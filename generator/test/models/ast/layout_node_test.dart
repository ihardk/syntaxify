import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';

void main() {
  group('App', () {
    test('instantiates ColumnNode', () {
      final node = App.column(
        children: [
          App.text(text: 'Hello'),
        ],
        mainAxisAlignment: MainAlignment.center,
      );

      // Verify it is a structural node
      node.map(
        structural: (s) {
          s.node.map(
            column: (col) {
              expect(col.children.length, 1);
              expect(col.mainAxisAlignment, equals(MainAlignment.center));
            },
            row: (_) => fail('Expected column, got row'),
            container: (_) => fail('Expected column, got container'),
            card: (_) => fail('Expected column, got card'),
            listView: (_) => fail('Expected column, got listView'),
            stack: (_) => fail('Expected column, got stack'),
            gridView: (_) => fail('Expected column, got gridView'),
            padding: (_) => fail('Expected column, got padding'),
            center: (_) => fail('Expected column, got center'),
          );
        },
        primitive: (_) => fail('Expected structural, got primitive'),
        interactive: (_) => fail('Expected structural, got interactive'),
        custom: (_) => fail('Expected structural, got custom'),
        appBar: (_) => fail('Expected structural, got appBar'),
      );
    });

    test('instantiates TextNode', () {
      final node = App.text(
        text: 'Hello World',
        variant: 'headlineMedium',
      );

      node.map(
        primitive: (p) {
          p.node.map(
            text: (t) {
              expect(t.text, equals('Hello World'));
              expect(t.variant, equals('headlineMedium'));
            },
            icon: (_) => fail('Expected text, got icon'),
            spacer: (_) => fail('Expected text, got spacer'),
            image: (_) => fail('Expected text, got image'),
            divider: (_) => fail('Expected text, got divider'),
            circularProgressIndicator: (_) =>
                fail('Expected text, got circularProgressIndicator'),
            sizedBox: (_) => fail('Expected text, got sizedBox'),
            expanded: (_) => fail('Expected text, got expanded'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates ButtonNode', () {
      final node = App.button(
        label: 'Click Me',
        variant: 'filled',
        onPressed: 'action:submit',
      );

      node.map(
        interactive: (i) {
          i.node.map(
            button: (b) {
              expect(b.label, equals('Click Me'));
              expect(b.onPressed, equals('action:submit'));
              expect(b.props?.variant, equals('filled'));
            },
            textField: (_) => fail('Expected button, got textField'),
            checkbox: (_) => fail('Expected button, got checkbox'),
            switchNode: (_) => fail('Expected button, got switchNode'),
            iconButton: (_) => fail('Expected button, got iconButton'),
            dropdown: (_) => fail('Expected button, got dropdown'),
            radio: (_) => fail('Expected button, got radio'),
            slider: (_) => fail('Expected button, got slider'),
          );
        },
        structural: (_) => fail('Expected interactive, got structural'),
        primitive: (_) => fail('Expected interactive, got primitive'),
        custom: (_) => fail('Expected interactive, got custom'),
        appBar: (_) => fail('Expected interactive, got appBar'),
      );
    });

    test('instantiates RowNode', () {
      final node = App.row(
        children: [
          App.text(text: 'Label'),
          App.icon(name: 'arrow_forward'),
        ],
        mainAxisAlignment: MainAlignment.spaceBetween,
      );

      node.map(
        structural: (s) {
          s.node.map(
            row: (row) {
              expect(row.children.length, 2);
              expect(row.mainAxisAlignment, equals(MainAlignment.spaceBetween));
            },
            column: (_) => fail('Expected row, got column'),
            container: (_) => fail('Expected row, got container'),
            card: (_) => fail('Expected row, got card'),
            listView: (_) => fail('Expected row, got listView'),
            stack: (_) => fail('Expected row, got stack'),
            gridView: (_) => fail('Expected row, got gridView'),
            padding: (_) => fail('Expected row, got padding'),
            center: (_) => fail('Expected row, got center'),
          );
        },
        primitive: (_) => fail('Expected structural, got primitive'),
        interactive: (_) => fail('Expected structural, got interactive'),
        custom: (_) => fail('Expected structural, got custom'),
        appBar: (_) => fail('Expected structural, got appBar'),
      );
    });

    test('instantiates TextFieldNode', () {
      final node = App.textField(
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
            checkbox: (_) => fail('Expected textField, got checkbox'),
            switchNode: (_) => fail('Expected textField, got switchNode'),
            iconButton: (_) => fail('Expected textField, got iconButton'),
            dropdown: (_) => fail('Expected textField, got dropdown'),
            radio: (_) => fail('Expected textField, got radio'),
            slider: (_) => fail('Expected textField, got slider'),
          );
        },
        structural: (_) => fail('Expected interactive, got structural'),
        primitive: (_) => fail('Expected interactive, got primitive'),
        custom: (_) => fail('Expected interactive, got custom'),
        appBar: (_) => fail('Expected interactive, got appBar'),
      );
    });

    test('instantiates IconNode', () {
      final node = App.icon(
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
            image: (_) => fail('Expected icon, got image'),
            divider: (_) => fail('Expected icon, got divider'),
            circularProgressIndicator: (_) =>
                fail('Expected icon, got circularProgressIndicator'),
            sizedBox: (_) => fail('Expected icon, got sizedBox'),
            expanded: (_) => fail('Expected icon, got expanded'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates SpacerNode', () {
      final node = App.spacer(
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
            image: (_) => fail('Expected spacer, got image'),
            divider: (_) => fail('Expected spacer, got divider'),
            circularProgressIndicator: (_) =>
                fail('Expected spacer, got circularProgressIndicator'),
            sizedBox: (_) => fail('Expected spacer, got sizedBox'),
            expanded: (_) => fail('Expected spacer, got expanded'),
          );
        },
        structural: (_) => fail('Expected primitive, got structural'),
        interactive: (_) => fail('Expected primitive, got interactive'),
        custom: (_) => fail('Expected primitive, got custom'),
        appBar: (_) => fail('Expected primitive, got appBar'),
      );
    });

    test('instantiates CustomNode', () {
      final node = App.custom(
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
      final textNode = App.text(text: 'Test');
      expect(App.fromJson(textNode.toJson()), equals(textNode));

      final colNode = App.column(children: [textNode]);
      expect(App.fromJson(colNode.toJson()), equals(colNode));

      final rowNode = App.row(children: [textNode]);
      expect(App.fromJson(rowNode.toJson()), equals(rowNode));

      final iconNode = App.icon(name: 'check');
      expect(App.fromJson(iconNode.toJson()), equals(iconNode));
    });
  });

  group('ScreenDefinition', () {
    test('instantiates ScreenDefinition', () {
      final screen = ScreenDefinition(
        id: 'home_screen',
        layout: App.column(children: []),
        appBar: App.appBar(title: 'Home') as AppBarNode,
      );

      expect(screen.id, equals('home_screen'));

      screen.layout.map(
        structural: (s) {
          s.node.map(
            column: (_) {},
            row: (_) => fail('Expected column'),
            container: (_) => fail('Expected column'),
            card: (_) => fail('Expected column'),
            listView: (_) => fail('Expected column'),
            stack: (_) => fail('Expected column'),
            gridView: (_) => fail('Expected column'),
            padding: (_) => fail('Expected column'),
            center: (_) => fail('Expected column'),
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
