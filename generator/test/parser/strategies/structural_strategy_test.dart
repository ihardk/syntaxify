import 'package:syntaxify/src/parser/strategies/strategies.dart';
import 'package:test/test.dart';

void main() {
  late StructuralNodeStrategy strategy;

  setUp(() {
    strategy = StructuralNodeStrategy();
  });

  group('StructuralNodeStrategy', () {
    group('canParse', () {
      test('returns true for column', () {
        expect(strategy.canParse('column'), isTrue);
      });

      test('returns true for row', () {
        expect(strategy.canParse('row'), isTrue);
      });

      test('returns true for card', () {
        expect(strategy.canParse('card'), isTrue);
      });

      test('returns true for spacer', () {
        expect(strategy.canParse('spacer'), isTrue);
      });

      test('returns false for text', () {
        expect(strategy.canParse('text'), isFalse);
      });

      test('returns false for button', () {
        expect(strategy.canParse('button'), isFalse);
      });

      test('returns false for textField', () {
        expect(strategy.canParse('textField'), isFalse);
      });
    });
  });
}
