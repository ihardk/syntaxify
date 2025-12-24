import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/visitors/controller_collector.dart';
import 'package:test/test.dart';

void main() {
  group('ControllerCollector', () {
    late ControllerCollector collector;

    setUp(() {
      collector = ControllerCollector();
    });

    test('collects textField with label', () {
      final node = App.interactive(
        node: InteractiveNode.textField(label: 'Email'),
      );

      final controllers = collector.visit(node);

      expect(controllers.length, 1);
      expect(controllers[0].inputLabel, 'Email');
      expect(controllers[0].fieldName, '_emailController');
    });

    test('collects textField without label', () {
      final node = App.interactive(
        node: InteractiveNode.textField(),
      );

      final controllers = collector.visit(node);

      expect(controllers.length, 1);
      // Without label, collector uses 'input{index}' pattern
      expect(controllers[0].inputLabel, startsWith('input'));
      expect(controllers[0].fieldName, startsWith('_input'));
    });

    test('returns empty for non-textField interactive nodes', () {
      final node = App.interactive(
        node: InteractiveNode.button(label: 'Submit'),
      );

      final controllers = collector.visit(node);

      expect(controllers, isEmpty);
    });

    test('returns empty for primitive nodes', () {
      final node = App.primitive(
        node: PrimitiveNode.text(text: 'Hello'),
      );

      final controllers = collector.visit(node);

      expect(controllers, isEmpty);
    });

    test('traverses structural nodes recursively', () {
      final node = App.structural(
        node: StructuralNode.column(children: [
          App.interactive(node: InteractiveNode.textField(label: 'Username')),
          App.interactive(node: InteractiveNode.textField(label: 'Password')),
        ]),
      );

      final controllers = collector.visit(node);

      expect(controllers.length, 2);
      expect(controllers[0].inputLabel, 'Username');
      expect(controllers[1].inputLabel, 'Password');
    });

    test('traverses nested containers', () {
      final node = App.structural(
        node: StructuralNode.container(
          child: App.structural(
            node: StructuralNode.padding(
              padding: '16',
              child: App.interactive(
                  node: InteractiveNode.textField(label: 'Search')),
            ),
          ),
        ),
      );

      final controllers = collector.visit(node);

      expect(controllers.length, 1);
      expect(controllers[0].inputLabel, 'Search');
    });
  });
}
