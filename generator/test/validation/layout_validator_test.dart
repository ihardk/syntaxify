import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';

void main() {
  group('LayoutValidator', () {
    late LayoutValidator validator;

    setUp(() {
      validator = const LayoutValidator();
    });

    group('ButtonNode Validation', () {
      test('validates button with empty label', () {
        final node = App.button(
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
        final node = App.button(
          label: '   ',
          onPressed: 'handleClick',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates button with invalid callback name', () {
        final node = App.button(
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
        final node = App.button(
          label: 'Click',
          onPressed: 'handle click',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates button with callback starting with number', () {
        final node = App.button(
          label: 'Click',
          onPressed: '1handleClick',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates button with Dart keyword as callback', () {
        final node = App.button(
          label: 'Click',
          onPressed: 'class',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('accepts button with valid camelCase callback', () {
        final node = App.button(
          label: 'Click',
          onPressed: 'handleButtonClick',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts button with underscore in callback', () {
        final node = App.button(
          label: 'Click',
          onPressed: '_handleClick',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts button with null callback', () {
        final node = App.button(
          label: 'Click',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates button with multiple errors', () {
        final node = App.button(
          label: '',
          onPressed: 'invalid-name',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(2));
      });
    });

    group('TextNode Validation', () {
      test('validates text with empty content', () {
        final node = App.text(text: '');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('Text content cannot be empty'));
        expect(errors.first.fieldName, equals('text'));
      });

      test('validates text with whitespace-only content', () {
        final node = App.text(text: '   \n\t  ');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates text with negative maxLines', () {
        final node = App.text(
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
        final node = App.text(
          text: 'Hello',
          maxLines: 0,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('validates text with conflicting overflow and maxLines', () {
        final node = App.text(
          text: 'Hello',
          maxLines: 1,
          overflow: SyntaxTextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type,
            equals(ValidationErrorType.conflictingProperties));
        expect(errors.first.message, contains('clip'));
        expect(errors.first.severity, equals(ErrorSeverity.info));
      });

      test('accepts text with maxLines and ellipsis', () {
        final node = App.text(
          text: 'Hello',
          maxLines: 2,
          overflow: SyntaxTextOverflow.ellipsis,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts text with valid content', () {
        final node = App.text(
          text: 'Hello World',
          variant: TextVariant.headlineMedium,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('TextFieldNode Validation', () {
      test('validates textField with empty label and no hint', () {
        final node = App.textField();

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates textField with negative maxLength', () {
        final node = App.textField(
          label: 'Name',
          maxLength: -1,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.fieldName, equals('maxLength'));
      });

      test('validates textField with zero maxLength', () {
        final node = App.textField(
          label: 'Name',
          maxLength: 0,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('validates textField with negative maxLines', () {
        final node = App.textField(
          label: 'Name',
          maxLines: -1,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.fieldName, equals('maxLines'));
      });

      test('validates textField with invalid onChanged callback', () {
        final node = App.textField(
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
        final node = App.textField(
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
        final node = App.textField(
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
        final node = App.textField(
          label: 'Email',
          onChanged: 'handleEmailChanged',
          onSubmitted: 'handleSubmit',
          binding: 'emailController',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts textField with positive maxLength and maxLines', () {
        final node = App.textField(
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
        final node = App.icon(name: '');

        final errors = validator.validate(node);

        expect(errors.isNotEmpty, isTrue);
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('empty'));
        expect(errors.first.fieldName, equals('name'));
      });

      test('validates icon with whitespace-only name', () {
        final node = App.icon(name: '  ');

        final errors = validator.validate(node);

        expect(errors.isNotEmpty, isTrue);
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('accepts icon with valid name', () {
        final node = App.icon(name: 'home');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts icon with underscores and numbers', () {
        final node = App.icon(name: 'arrow_forward_ios');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('AppBarNode Validation', () {
      test('validates appBar with empty title', () {
        final node = App.appBar(title: '');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.message, contains('should have a title'));
        expect(errors.first.fieldName, equals('title'));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates appBar with invalid onLeadingPressed', () {
        final node = App.appBar(
          title: 'Home',
          leadingIcon: 'arrow_back',
          onLeadingPressed: 'handle-back',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('onLeadingPressed'));
      });

      test('accepts appBar with valid title and onLeadingPressed', () {
        final node = App.appBar(
          title: 'Home',
          leadingIcon: 'arrow_back', // Added dependency
          onLeadingPressed: 'handleBack',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('SpacerNode Validation', () {
      test('validates spacer with negative flex', () {
        final node = App.spacer(flex: -1);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.message, contains('positive number'));
        expect(errors.first.fieldName, equals('flex'));
      });

      test('validates spacer with zero flex', () {
        final node = App.spacer(flex: 0);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('accepts spacer with positive flex', () {
        final node = App.spacer(flex: 2);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts spacer with size', () {
        final node = App.spacer(size: SpacerSize.lg);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('ColumnNode Validation', () {
      test('validates column with empty children', () {
        final node = App.column(children: []);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyChildren));
        expect(errors.first.message, contains('no children'));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates nested errors in column children', () {
        final node = App.column(
          children: [
            App.text(text: ''),
            App.button(label: '', onPressed: 'invalid-name'),
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
        final node = App.column(
          children: [
            App.text(text: 'Hello'),
            App.button(label: 'Click', onPressed: 'handleClick'),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates deeply nested structure', () {
        final node = App.column(
          children: [
            App.row(
              children: [
                App.column(
                  children: [
                    App.text(text: ''),
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
        final node = App.row(children: []);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyChildren));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates nested errors in row children', () {
        final node = App.row(
          children: [
            App.icon(name: ''),
            App.text(text: '', maxLines: -1),
          ],
        );

        final errors = validator.validate(node);

        expect(errors.length, greaterThan(1));
        expect(errors.any((e) => e.message.contains('Icon name')), isTrue);
        expect(errors.any((e) => e.message.contains('Text content')), isTrue);
        expect(errors.any((e) => e.message.contains('maxLines')), isTrue);
      });

      test('accepts row with valid children', () {
        final node = App.row(
          children: [
            App.icon(name: 'home'),
            App.text(text: 'Home'),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    group('Path Tracking', () {
      test('tracks error paths correctly for nested nodes', () {
        final node = App.column(
          children: [
            App.row(
              children: [
                App.button(label: ''),
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
        final node = App.column(
          children: [
            App.text(text: ''),
          ],
        );

        final errors = validator.validate(node, 'screen.layout');

        expect(errors.first.nodePath, startsWith('screen.layout'));
      });
    });

    group('Error Severity', () {
      test('returns error severity for empty required fields', () {
        final node = App.button(label: '');

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.error));
      });

      test('returns warning severity for empty containers', () {
        final node = App.column(children: []);

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('returns info severity for property conflicts', () {
        final node = App.text(
          text: 'Hello',
          maxLines: 1,
          overflow: SyntaxTextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.first.severity, equals(ErrorSeverity.info));
      });
    });

    group('Suggestions', () {
      test('provides helpful suggestions for empty values', () {
        final node = App.button(label: '');

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('non-empty'));
      });

      test('provides suggestions for invalid identifiers', () {
        final node = App.button(
          label: 'Click',
          onPressed: 'handle-click',
        );

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('camelCase'));
      });

      test('provides suggestions for conflicting properties', () {
        final node = App.text(
          text: 'Hello',
          maxLines: 1,
          overflow: SyntaxTextOverflow.clip,
        );

        final errors = validator.validate(node);

        expect(errors.first.suggestion, isNotNull);
        expect(errors.first.suggestion, contains('ellipsis'));
      });
    });

    group('Edge Cases', () {
      test('handles nodes with all null optional fields', () {
        final node = App.button(label: 'Click');

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('handles complex nested structures', () {
        final node = App.column(
          children: [
            App.appBar(title: 'App'),
            App.row(
              children: [
                App.icon(name: 'menu'),
                App.column(
                  children: [
                    App.text(text: 'Title'),
                    App.text(text: 'Subtitle'),
                  ],
                ),
                App.spacer(flex: 1),
                App.button(label: 'Action', onPressed: 'handleAction'),
              ],
            ),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates extremely long nested structures', () {
        App createDeepNesting(int depth) {
          if (depth == 0) {
            return App.text(text: 'Deep');
          }
          return App.column(
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
          (i) => App.text(text: 'Item $i'),
        );

        final node = App.column(children: children);

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('collects all errors from large invalid structures', () {
        final children = List.generate(
          50,
          (i) => App.button(label: '', onPressed: 'invalid-$i'),
        );

        final node = App.column(children: children);

        final errors = validator.validate(node);

        // Each button should have 2 errors (empty label + invalid callback)
        expect(errors.length, greaterThanOrEqualTo(100));
      });
    });

    // ============================================================
    // NEW STRUCTURAL NODE VALIDATION TESTS
    // ============================================================

    group('New Structural Node Validation', () {
      test('validates Container with child recursively', () {
        final node = App.container(
          child: App.button(label: '', onPressed: 'invalid-name'),
        );

        final errors = validator.validate(node);

        expect(errors.length, greaterThanOrEqualTo(2));
      });

      test('validates Card with empty children', () {
        final node = App.card(children: []);

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.severity, equals(ErrorSeverity.warning));
      });

      test('validates ListView with invalid children', () {
        final node = App.listView(
          children: [
            App.text(text: ''),
            App.button(label: ''),
          ],
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(2));
      });

      test('validates Stack with children recursively', () {
        final node = App.stack(
          children: [
            App.text(text: 'Valid'),
            App.text(text: ''),
          ],
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('validates GridView with zero crossAxisCount', () {
        final node = App.gridView(
          children: [App.text(text: 'Item')],
          crossAxisCount: 0,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
        expect(errors.first.fieldName, equals('crossAxisCount'));
      });

      test('validates GridView with negative crossAxisCount', () {
        final node = App.gridView(
          children: [App.text(text: 'Item')],
          crossAxisCount: -2,
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.negativeNumber));
      });

      test('validates Padding with empty padding value', () {
        final node = App.padding(
          padding: '',
          child: App.text(text: 'Content'),
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.fieldName, equals('padding'));
      });

      test('validates Center with invalid child', () {
        final node = App.center(
          child: App.button(label: ''),
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
      });

      test('accepts valid Container', () {
        final node = App.container(
          width: 100,
          height: 50,
          color: ColorSemantic.primary,
          child: App.text(text: 'Valid'),
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid GridView', () {
        final node = App.gridView(
          crossAxisCount: 2,
          children: [
            App.text(text: 'Item 1'),
            App.text(text: 'Item 2'),
          ],
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    // ============================================================
    // NEW PRIMITIVE NODE VALIDATION TESTS
    // ============================================================

    group('New Primitive Node Validation', () {
      test('validates Image with empty src', () {
        final node = App.image(src: '');

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.fieldName, equals('src'));
      });

      test('accepts valid Image with network URL', () {
        final node = App.image(
          src: 'https://example.com/image.png',
          width: 100,
          height: 100,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('validates SizedBox with child recursively', () {
        final node = App.sizedBox(
          width: 100,
          child: App.text(text: ''),
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
      });

      test('validates Expanded with invalid child', () {
        final node = App.expanded(
          child: App.button(label: ''),
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
      });

      test('accepts valid Divider', () {
        final node = App.divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid CircularProgressIndicator', () {
        final node = App.circularProgressIndicator(
          value: 0.5,
          strokeWidth: 4,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });

    // ============================================================
    // NEW INTERACTIVE NODE VALIDATION TESTS
    // ============================================================

    group('New Interactive Node Validation', () {
      test('validates Checkbox with invalid binding', () {
        final node = App.checkbox(
          binding: 'invalid-binding',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
        expect(errors.first.fieldName, equals('binding'));
      });

      test('validates Switch with empty binding', () {
        final node = App.switchWidget(
          binding: '',
        );

        final errors = validator.validate(node);

        expect(errors.length, greaterThanOrEqualTo(1));
      });

      test('validates IconButton with empty icon', () {
        final node = App.iconButton(
          icon: '',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(errors.first.type, equals(ValidationErrorType.emptyValue));
        expect(errors.first.fieldName, equals('icon'));
      });

      test('validates Dropdown with invalid binding', () {
        final node = App.dropdown(
          binding: 'class', // Dart keyword
          items: ['Option1', 'Option2'],
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates Radio with invalid binding', () {
        final node = App.radio(
          binding: '123invalid',
          value: 'option1',
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('validates Slider with invalid binding', () {
        final node = App.slider(
          binding: 'void', // Dart keyword
        );

        final errors = validator.validate(node);

        expect(errors.length, equals(1));
        expect(
            errors.first.type, equals(ValidationErrorType.invalidIdentifier));
      });

      test('accepts valid Checkbox', () {
        final node = App.checkbox(
          binding: 'isAccepted',
          label: 'Accept terms',
          onChanged: 'onTermsChanged',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid Switch', () {
        final node = App.switchWidget(
          binding: 'notificationsEnabled',
          label: 'Enable notifications',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid IconButton', () {
        final node = App.iconButton(
          icon: 'settings',
          onPressed: 'openSettings',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid Dropdown', () {
        final node = App.dropdown(
          binding: 'selectedCountry',
          items: ['USA', 'Canada', 'UK'],
          label: 'Select Country',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid Radio', () {
        final node = App.radio(
          binding: 'selectedOption',
          value: 'option1',
          label: 'Option 1',
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });

      test('accepts valid Slider', () {
        final node = App.slider(
          binding: 'volume',
          min: 0,
          max: 100,
          divisions: 10,
        );

        final errors = validator.validate(node);

        expect(errors, isEmpty);
      });
    });
  });
}
