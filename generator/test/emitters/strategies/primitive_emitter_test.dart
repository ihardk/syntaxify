import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late PrimitiveEmitStrategy strategy;

  setUp(() {
    strategy = PrimitiveEmitStrategy();
  });

  EmitContext createContext() {
    return EmitContext(
      emitChild: (_) => refer('Placeholder').call([]),
    );
  }

  String emitToString(Expression expr) {
    return expr.accept(DartEmitter()).toString();
  }

  group('PrimitiveEmitStrategy', () {
    test('emits AppText widget', () {
      final context = createContext();
      final node = PrimitiveNode.text(text: 'Hello World');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppText'));
    });

    test('emits Icon widget', () {
      final context = createContext();
      final node = PrimitiveNode.icon(name: 'home');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Icon'));
    });

    test('emits Spacer widget', () {
      final context = createContext();
      final node = PrimitiveNode.spacer();
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Spacer'));
    });

    test('emits SizedBox for sized spacer', () {
      final context = createContext();
      final node = PrimitiveNode.spacer(size: SpacerSize.md);
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('SizedBox'));
    });

    test('emits Image for local images', () {
      final context = createContext();
      final node = PrimitiveNode.image(src: 'assets/logo.png');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Image'));
    });

    test('emits Image for URL images', () {
      final context = createContext();
      final node = PrimitiveNode.image(src: 'https://example.com/image.png');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Image'));
    });

    test('emits Divider widget', () {
      final context = createContext();
      final node = PrimitiveNode.divider();
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Divider'));
    });

    test('emits CircularProgressIndicator', () {
      final context = createContext();
      final node = PrimitiveNode.circularProgressIndicator();
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('CircularProgressIndicator'));
    });

    test('throws for non-primitive node', () {
      final context = createContext();
      expect(
        () => strategy.emit('invalid', context),
        throwsArgumentError,
      );
    });
  });
}
