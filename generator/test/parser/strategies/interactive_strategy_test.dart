import 'package:syntaxify/src/parser/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late InteractiveNodeStrategy strategy;

  setUp(() {
    strategy = InteractiveNodeStrategy();
  });

  group('InteractiveNodeStrategy', () {
    group('canParse', () {
      test('returns true for textField', () {
        expect(strategy.canParse('textField'), isTrue);
      });

      test('returns true for checkbox', () {
        expect(strategy.canParse('checkbox'), isTrue);
      });

      test('returns true for toggle', () {
        expect(strategy.canParse('toggle'), isTrue);
      });

      test('returns true for slider', () {
        expect(strategy.canParse('slider'), isTrue);
      });

      test('returns true for radio', () {
        expect(strategy.canParse('radio'), isTrue);
      });

      test('returns false for text', () {
        expect(strategy.canParse('text'), isFalse);
      });

      test('returns false for column', () {
        expect(strategy.canParse('column'), isFalse);
      });

      test('returns false for button', () {
        expect(strategy.canParse('button'), isFalse);
      });
    });
  });
}
