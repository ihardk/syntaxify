import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntax/src/emitters/layout_emitter.dart';
import 'package:syntax/src/models/ast/nodes.dart';
import 'package:test/test.dart';

void main() {
  final emitter = DartEmitter(useNullSafetySyntax: true);
  final formatter = DartFormatter();
  const layoutEmitter = LayoutEmitter();

  String emit(AstNode node) {
    final expression = layoutEmitter.emit(node);
    // Wrap in a statement so DartFormatter can handle it
    final statement = expression.assignFinal('w').statement;
    return formatter.format('${statement.accept(emitter)}');
  }

  group('LayoutEmitter', () {
    test('emits Text widget', () {
      final node = AstNode.text(
        text: 'Hello World',
        variant: TextVariant.headlineMedium,
      );

      final code = emit(node);
      expect(code, contains("'Hello World'"));
      // Updated expectation for Design System usage
      expect(
          code, contains("DesignSystem.of(context).typography.headlineMedium"));
    });

    test('emits Button widget (Filled)', () {
      final node = AstNode.button(
        label: 'Submit',
        variant: ButtonVariant.filled,
        onPressed: 'submitData',
      );

      final code = emit(node);
      // Updated expectation for AppButton
      expect(code, contains('AppButton('));
      expect(code, contains("'Submit'"));
      // variant: ButtonVariant.filled is default, so it's not emitted
      expect(code, contains("onPressed: submitData"));
    });

    test('emits TextField widget', () {
      final node = AstNode.textField(
        label: 'Username',
        hint: 'Enter here',
        obscureText: true,
      );

      final code = emit(node);
      // Updated expectation for AppInput
      expect(code, contains('AppInput('));
      expect(code, contains("label: 'Username'"));
      expect(code, contains("hint: 'Enter here'"));
      expect(code, contains("obscureText: true"));
    });
  });
}
