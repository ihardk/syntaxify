import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late StructuralEmitStrategy strategy;

  setUp(() {
    strategy = StructuralEmitStrategy();
  });

  EmitContext createContext() {
    return EmitContext(
      emitChild: (_) => refer('Placeholder').call([]),
    );
  }

  String emitToString(Expression expr) {
    return expr.accept(DartEmitter()).toString();
  }

  group('StructuralEmitStrategy', () {
    test('emits Column widget', () {
      final context = createContext();
      final node = StructuralNode.column(children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Column'));
    });

    test('emits Row widget', () {
      final context = createContext();
      final node = StructuralNode.row(children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Row'));
    });

    test('emits Container widget', () {
      final context = createContext();
      final node = StructuralNode.container();
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Container'));
    });

    test('emits Card widget', () {
      final context = createContext();
      final node = StructuralNode.card(children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Card'));
    });

    test('emits Stack widget', () {
      final context = createContext();
      final node = StructuralNode.stack(children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Stack'));
    });

    test('emits ListView widget', () {
      final context = createContext();
      final node = StructuralNode.listView(children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('ListView'));
    });

    test('emits GridView widget', () {
      final context = createContext();
      final node = StructuralNode.gridView(crossAxisCount: 2, children: []);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('GridView'));
    });

    test('emits Padding widget', () {
      final context = createContext();
      final node = StructuralNode.padding(
        padding: '16',
        child: App.primitive(node: PrimitiveNode.text(text: 'Test')),
      );
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Padding'));
    });

    test('emits Center widget', () {
      final context = createContext();
      final node = StructuralNode.center(
        child: App.primitive(node: PrimitiveNode.text(text: 'Test')),
      );
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Center'));
    });

    test('throws for non-structural node', () {
      final context = createContext();
      expect(
        () => strategy.emit('invalid', context),
        throwsArgumentError,
      );
    });
  });
}
