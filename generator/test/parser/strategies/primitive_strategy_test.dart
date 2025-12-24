import 'package:syntaxify/src/parser/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late PrimitiveNodeStrategy strategy;

  setUp(() {
    strategy = PrimitiveNodeStrategy();
  });

  group('PrimitiveNodeStrategy', () {
    group('canParse', () {
      test('returns true for text', () {
        expect(strategy.canParse('text'), isTrue);
      });

      test('returns true for button', () {
        expect(strategy.canParse('button'), isTrue);
      });

      test('returns false for column', () {
        expect(strategy.canParse('column'), isFalse);
      });

      test('returns false for textField', () {
        expect(strategy.canParse('textField'), isFalse);
      });

      test('returns false for checkbox', () {
        expect(strategy.canParse('checkbox'), isFalse);
      });
    });
  });
}
