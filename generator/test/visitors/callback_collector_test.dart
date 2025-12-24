import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/visitors/callback_collector.dart';
import 'package:test/test.dart';

void main() {
  group('CallbackCollector', () {
    late CallbackCollector collector;

    setUp(() {
      collector = CallbackCollector();
    });

    test('collects button onPressed callback', () {
      final node = App.interactive(
        node:
            InteractiveNode.button(label: 'Submit', onPressed: 'handleSubmit'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 1);
      expect(callbacks[0].name, 'handleSubmit');
    });

    test('collects iconButton onPressed callback', () {
      final node = App.interactive(
        node: InteractiveNode.iconButton(icon: 'menu', onPressed: 'openMenu'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 1);
      expect(callbacks[0].name, 'openMenu');
    });

    test('collects textField onChanged callback', () {
      final node = App.interactive(
        node: InteractiveNode.textField(
            label: 'Search', onChanged: 'onSearchChanged'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 1);
      expect(callbacks[0].name, 'onSearchChanged');
    });

    test('collects textField onSubmitted callback', () {
      final node = App.interactive(
        node: InteractiveNode.textField(
            label: 'Search', onSubmitted: 'onSearchSubmit'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 1);
      expect(callbacks[0].name, 'onSearchSubmit');
    });

    test('collects multiple callbacks from textField', () {
      final node = App.interactive(
        node: InteractiveNode.textField(
          label: 'Search',
          onChanged: 'onSearchChanged',
          onSubmitted: 'onSearchSubmit',
        ),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 2);
      final names = callbacks.map((c) => c.name).toSet();
      expect(names, containsAll(['onSearchChanged', 'onSearchSubmit']));
    });

    test('returns empty for nodes without callbacks', () {
      final node = App.interactive(
        node: InteractiveNode.button(label: 'Static Button'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks, isEmpty);
    });

    test('returns empty for primitive nodes', () {
      final node = App.primitive(
        node: PrimitiveNode.text(text: 'Hello'),
      );

      final callbacks = collector.visit(node);

      expect(callbacks, isEmpty);
    });

    test('traverses structural nodes recursively', () {
      final node = App.structural(
        node: StructuralNode.column(children: [
          App.interactive(
            node: InteractiveNode.button(
                label: 'Login', onPressed: 'handleLogin'),
          ),
          App.interactive(
            node: InteractiveNode.button(
                label: 'Register', onPressed: 'handleRegister'),
          ),
        ]),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 2);
      final names = callbacks.map((c) => c.name).toSet();
      expect(names, containsAll(['handleLogin', 'handleRegister']));
    });

    test('traverses nested structural nodes', () {
      final node = App.structural(
        node: StructuralNode.container(
          child: App.structural(
            node: StructuralNode.row(children: [
              App.interactive(
                node: InteractiveNode.iconButton(
                    icon: 'back', onPressed: 'goBack'),
              ),
            ]),
          ),
        ),
      );

      final callbacks = collector.visit(node);

      expect(callbacks.length, 1);
      expect(callbacks[0].name, 'goBack');
    });
  });
}
