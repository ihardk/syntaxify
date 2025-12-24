import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/visitors/binding_collector.dart';
import 'package:test/test.dart';

void main() {
  group('BindingCollector', () {
    late BindingCollector collector;

    setUp(() {
      collector = BindingCollector();
    });

    test('collects checkbox binding', () {
      final node = App.interactive(
        node: InteractiveNode.checkbox(binding: 'rememberMe'),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 1);
      expect(bindings[0].bindingName, 'rememberMe');
      expect(bindings[0].type, 'bool');
      expect(bindings[0].fieldName, '_rememberMe');
    });

    test('collects switch binding', () {
      final node = App.interactive(
        node: InteractiveNode.toggleNode(binding: 'isDarkMode'),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 1);
      expect(bindings[0].bindingName, 'isDarkMode');
      expect(bindings[0].type, 'bool');
    });

    test('collects slider binding', () {
      final node = App.interactive(
        node: InteractiveNode.slider(binding: 'volume', min: 0, max: 100),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 1);
      expect(bindings[0].bindingName, 'volume');
      expect(bindings[0].type, 'double');
    });

    test('collects dropdown binding', () {
      final node = App.interactive(
        node: InteractiveNode.dropdown(
          binding: 'selectedCountry',
          items: ['USA', 'UK', 'Canada'],
        ),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 1);
      expect(bindings[0].bindingName, 'selectedCountry');
      expect(bindings[0].type, 'String?');
    });

    test('collects radio binding', () {
      final node = App.interactive(
        node: InteractiveNode.radio(binding: 'gender', value: 'male'),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 1);
      expect(bindings[0].bindingName, 'gender');
      expect(bindings[0].type, 'String?');
    });

    test('returns empty for non-binding nodes', () {
      final node = App.interactive(
        node: InteractiveNode.button(label: 'Click me'),
      );

      final bindings = collector.visit(node);

      expect(bindings, isEmpty);
    });

    test('traverses structural nodes recursively', () {
      final node = App.structural(
        node: StructuralNode.column(children: [
          App.interactive(node: InteractiveNode.checkbox(binding: 'check1')),
          App.structural(
              node: StructuralNode.row(children: [
            App.interactive(
                node: InteractiveNode.toggleNode(binding: 'switch1')),
          ])),
        ]),
      );

      final bindings = collector.visit(node);

      expect(bindings.length, 2);
      expect(
          bindings.map((b) => b.bindingName).toList(), ['check1', 'switch1']);
    });
  });
}
