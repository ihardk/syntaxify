import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';
import 'package:syntaxify/src/validation/layout_validator.dart';
import 'package:syntaxify/src/models/validation_error.dart';
import 'package:syntaxify/src/models/ast/layout_node.dart';

void main() {
  group('LayoutValidator', () {
    late LayoutValidator validator;

    setUp(() {
      validator = const LayoutValidator();
    });

    group('ButtonNode Validation', () {
      test('validates button with empty label', () {
        final node = LayoutNode.button(
          label: '',
          onPressed: 'handleClick',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('label cannot be empty'));
        expect(errors.first.fieldName, equals('label'));
      });

      test('validates button with whitespace-only label', () {
        final node = LayoutNode.button(
          label: '   ',
          onPressed: 'handleClick',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates button with invalid callback name', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: 'handle-click',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.message, contains('valid Dart identifier'));
        expect(errors.first.fieldName, equals('onPressed'));
      });

      test('validates button with callback containing spaces', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: 'handle click',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates button with callback starting with number', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: '1handleClick',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates button with Dart keyword as callback', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: 'class',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('accepts button with valid camelCase callback', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: 'handleButtonClick',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts button with underscore in callback', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: '_handleClick',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts button with null callback', () {
        final node = LayoutNode.button(
          label: 'Click',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates button with multiple errors', () {
        final node = LayoutNode.button(
          label: '',
          onPressed: 'invalid-name',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(2));
      });
    });

    group('TextNode Validation', () {
      test('validates text with empty content', () {
        final node = LayoutNode.text(text: '');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('Text content cannot be empty'));
        expect(errors.first.fieldName, equals('text'));
      });

      test('validates text with whitespace-only content', () {
        final node = LayoutNode.text(text: '   \n\t  ');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates text with negative maxLines', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: -1,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.message, contains('positive number'));
        expect(errors.first.fieldName, equals('maxLines'));
      });

      test('validates text with zero maxLines', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: 0,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('validates text with conflicting overflow and maxLines', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: 1,
          overflow: TextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type,
            equals(ValidationErrorType.conflictingProperties));
        expect(errors.first.message, contains('clip'));
        expect(errors.first.severity, equals(ErrorSeverity.info));
      });

      test('accepts text with maxLines and ellipsis', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts text with valid content', () {
        final node = LayoutNode.text(
          text: 'Hello World',
          variant: TextVariant.headlineMedium,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('TextFieldNode Validation', () {
      test('validates textField with empty label and no hint', () {
        final node = LayoutNode.textField();

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates textField with negative maxLength', () {
        final node = LayoutNode.textField(
          label: 'Name',
          maxLength: -1,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.fieldName, equals('maxLength'));
      });

      test('validates textField with zero maxLength', () {
        final node = LayoutNode.textField(
          label: 'Name',
          maxLength: 0,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('validates textField with negative maxLines', () {
        final node = LayoutNode.textField(
          label: 'Name',
          maxLines: -1,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.fieldName, equals('maxLines'));
      });

      test('validates textField with invalid onChanged callback', () {
        final node = LayoutNode.textField(
          label: 'Name',
          onChanged: 'handle-change',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('onChanged'));
      });

      test('validates textField with invalid onSubmitted callback', () {
        final node = LayoutNode.textField(
          label: 'Name',
          onSubmitted: 'on submit',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('onSubmitted'));
      });

      test('validates textField with invalid binding', () {
        final node = LayoutNode.textField(
          label: 'Name',
          binding: 'my-controller',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('binding'));
      });

      test('accepts textField with valid callbacks', () {
        final node = LayoutNode.textField(
          label: 'Email',
          onChanged: 'handleEmailChanged',
          onSubmitted: 'handleSubmit',
          binding: 'emailController',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts textField with positive maxLength and maxLines', () {
        final node = LayoutNode.textField(
          label: 'Bio',
          maxLength: 500,
          maxLines: 5,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('IconNode Validation', () {
      test('validates icon with empty name', () {
        final node = LayoutNode.icon(name: '');

        final errors = validator.validate(node);

        expect(errors.isNotEmpty, isTrue);
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('empty'));
        expect(errors.first.fieldName, equals('name'));
      });

      test('validates icon with whitespace-only name', () {
        final node = LayoutNode.icon(name: '  ');

        final errors = validator.validate(node);

        expect(errors.isNotEmpty, isTrue);
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('accepts icon with valid name', () {
        final node = LayoutNode.icon(name: 'home');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts icon with underscores and numbers', () {
        final node = LayoutNode.icon(name: 'arrow_forward_ios');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('AppBarNode Validation', () {
      test('validates appBar with empty title', () {
        final node = LayoutNode.appBar(title: '');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('should have a title'));
        expect(errors.first.fieldName, equals('title'));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates appBar with invalid leadingAction', () {
        final node = LayoutNode.appBar(
          title: 'Home',
          leadingAction: 'handle-back',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('leadingAction'));
      });

      test('accepts appBar with valid title and leadingAction', () {
        final node = LayoutNode.appBar(
          title: 'Home',
          leadingAction: 'handleBack',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('SpacerNode Validation', () {
      test('validates spacer with negative flex', () {
        final node = LayoutNode.spacer(flex: -1);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.message, contains('positive number'));
        expect(errors.first.fieldName, equals('flex'));
      });

      test('validates spacer with zero flex', () {
        final node = LayoutNode.spacer(flex: 0);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('accepts spacer with positive flex', () {
        final node = LayoutNode.spacer(flex: 2);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts spacer with size', () {
        final node = LayoutNode.spacer(size: SpacerSize.lg);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('ColumnNode Validation', () {
      test('validates column with empty children', () {
        final node = LayoutNode.column(children: []);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyChildren));
        expect(errors.first.message, contains('no children'));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates nested errors in column children', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.text(text: ''),
            LayoutNode.button(label: '', onPressed: 'invalid-name'),
          ],
        );

        final errors = validator.validate(node);

        // Should have: empty children warning + empty text + empty button label + invalid callback
        expect(errors.length, greaterThan(1));
        expect(errors.any((e) => e.message.contains('Text content')), isTrue);
        expect(errors.any((e) => e.message.contains('Button label')), isTrue);
        expect(
            errors.any((e) => e.type == ValidationErrorType.invalidIdentifier),
            isTrue);
      });

      test('accepts column with valid children', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.text(text: 'Hello'),
            LayoutNode.button(label: 'Click', onPressed: 'handleClick'),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates deeply nested structure', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.row(
              children: [
                LayoutNode.column(
                  children: [
                    LayoutNode.text(text: ''),
                  ],
                ),
              ],
            ),
          ],
        );

        final errors = validator.validate(node);

        expect(errors.any((e) => e.message.contains('Text content')), isTrue);
      });
    });

    group('RowNode Validation', () {
      test('validates row with empty children', () {
        final node = LayoutNode.row(children: []);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyChildren));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates nested errors in row children', () {
        final node = LayoutNode.row(
          children: [
            LayoutNode.icon(name: ''),
            LayoutNode.text(text: '', maxLines: -1),
          ],
        );

        final errors = validator.validate(node);

        expect(errors.length, greaterThan(1));
        expect(errors.any((e) => e.message.contains('Icon name')), isTrue);
        expect(errors.any((e) => e.message.contains('Text content')), isTrue);
        expect(errors.any((e) => e.message.contains('maxLines')), isTrue);
      });

      test('accepts row with valid children', () {
        final node = LayoutNode.row(
          children: [
            LayoutNode.icon(name: 'home'),
            LayoutNode.text(text: 'Home'),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('Path Tracking', () {
      test('tracks error paths correctly for nested nodes', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.row(
              children: [
                LayoutNode.button(label: ''),
              ],
            ),
          ],
        );

        final errors = validator.validate(node);

        final buttonError = errors.firstWhere(
          (e) => e.message.contains('Button label'),
        );
        expect(buttonError.nodePath, contains('column'));
        expect(buttonError.nodePath, contains('row'));
        expect(buttonError.nodePath, contains('button'));
      });

      test('provides node path for validation errors', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.text(text: ''),
          ],
        );

        final errors = validator.validate(node, 'screen.layout');

        expect(errors.first.nodePath, startsWith('screen.layout'));
      });
    });

    group('Error Severity', () {
      test('returns error severity for empty required fields', () {
        final node = LayoutNode.button(label: '');

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.error));
      });

      test('returns warning severity for empty containers', () {
        final node = LayoutNode.column(children: []);

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('returns info severity for property conflicts', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: 1,
          overflow: TextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.info));
      });
    });

    group('Suggestions', () {
      test('provides helpful suggestions for empty values', () {
        final node = LayoutNode.button(label: '');

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('non-empty'));
      });

      test('provides suggestions for invalid identifiers', () {
        final node = LayoutNode.button(
          label: 'Click',
          onPressed: 'handle-click',
        );

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('camelCase'));
      });

      test('provides suggestions for conflicting properties', () {
        final node = LayoutNode.text(
          text: 'Hello',
          maxLines: 1,
          overflow: TextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('ellipsis'));
      });
    });

    group('Edge Cases', () {
      test('handles nodes with all null optional fields', () {
        final node = LayoutNode.button(label: 'Click');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('handles complex nested structures', () {
        final node = LayoutNode.column(
          children: [
            LayoutNode.appBar(title: 'App'),
            LayoutNode.row(
              children: [
                LayoutNode.icon(name: 'menu'),
                LayoutNode.column(
                  children: [
                    LayoutNode.text(text: 'Title'),
                    LayoutNode.text(text: 'Subtitle'),
                  ],
                ),
                LayoutNode.spacer(flex: 1),
                LayoutNode.button(label: 'Action', onPressed: 'handleAction'),
              ],
            ),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates extremely long nested structures', () {
        LayoutNode createDeepNesting(int depth) {
          if (depth == 0) {
            return LayoutNode.text(text: 'Deep');
          }
          return LayoutNode.column(
            children: [createDeepNesting(depth - 1)],
          );
        }

        final node = createDeepNesting(50);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('handles validation of large lists of children', () {
        final children = List.generate(
          100,
          (i) => LayoutNode.text(text: 'Item $i'),
        );

        final node = LayoutNode.column(children: children);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('collects all errors from large invalid structures', () {
        final children = List.generate(
          50,
          (i) => LayoutNode.button(label: '', onPressed: 'invalid-$i'),
        );

        final node = LayoutNode.column(children: children);

        final errors = validator.validate(node);

        // Each button should have 2 errors (empty label + invalid callback)
        expect(errors.length, greaterThanOrEqualTo(100));
      });
    });
  });
}
