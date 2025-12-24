import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late InteractiveEmitStrategy strategy;

  setUp(() {
    strategy = InteractiveEmitStrategy();
  });

  EmitContext createContext({Map<String, String>? variableMap}) {
    return EmitContext(
      emitChild: (_) => refer('Placeholder').call([]),
      variableMap: variableMap ?? {},
    );
  }

  String emitToString(Expression expr) {
    return expr.accept(DartEmitter()).toString();
  }

  group('InteractiveEmitStrategy', () {
    test('emits AppButton widget', () {
      final context = createContext();
      final node = InteractiveNode.button(label: 'Submit');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppButton'));
    });

    test('emits AppInput widget for textField', () {
      final context = createContext();
      final node = InteractiveNode.textField(label: 'Email');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppInput'));
    });

    test('emits AppCheckbox widget', () {
      final context = createContext();
      final node = InteractiveNode.checkbox(binding: 'rememberMe');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppCheckbox'));
    });

    test('emits AppToggle widget', () {
      final context = createContext();
      final node = InteractiveNode.toggleNode(binding: 'isDarkMode');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppToggle'));
    });

    test('emits AppSlider widget', () {
      final context = createContext();
      final node = InteractiveNode.slider(
        binding: 'volume',
        min: 0,
        max: 100,
      );
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('AppSlider'));
    });

    test('emits IconButton widget', () {
      final context = createContext();
      final node = InteractiveNode.iconButton(icon: 'menu');
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('IconButton'));
    });

    test('emits DropdownButton widget', () {
      final context = createContext();
      final node = InteractiveNode.dropdown(
        binding: 'country',
        items: ['USA', 'UK'],
      );
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('DropdownButton'));
    });

    test('emits Radio widget', () {
      final context = createContext();
      final node = InteractiveNode.radio(
        binding: 'gender',
        value: 'male',
      );
      final result = emitToString(strategy.emit(node, context));

      expect(result, contains('Radio'));
    });

    test('throws for non-interactive node', () {
      final context = createContext();
      expect(
        () => strategy.emit('invalid', context),
        throwsArgumentError,
      );
    });
  });
}
