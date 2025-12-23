import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:test/test.dart';
import 'package:code_builder/code_builder.dart';

void main() {
  group('LayoutEmitter - Complete Coverage', () {
    late LayoutEmitter emitter;
    late DartEmitter dartEmitter;

    setUp(() {
      emitter = LayoutEmitter();
      dartEmitter = DartEmitter(useNullSafetySyntax: true);
    });

    String emitToString(App node) {
      final expression = emitter.emit(node);
      return expression.accept(dartEmitter).toString();
    }

    group('Column emission', () {
      test('emits basic Column', () {
        final node = App.column(children: []);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('children:'));
      });

      test('emits Column with children', () {
        final node = App.column(
          children: [
            App.text(text: 'Hello'),
            App.text(text: 'World'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('AppText'));
        expect(code, contains('Hello'));
        expect(code, contains('World'));
      });

      test('emits Column with mainAxisAlignment', () {
        final node = App.column(
          mainAxisAlignment: MainAlignment.center,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('mainAxisAlignment: MainAxisAlignment.center'));
      });

      test('emits Column with crossAxisAlignment', () {
        final node = App.column(
          crossAxisAlignment: CrossAlignment.start,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.start'));
      });

      test('emits Column with both alignments', () {
        final node = App.column(
          mainAxisAlignment: MainAlignment.spaceBetween,
          crossAxisAlignment: CrossAlignment.end,
          children: [],
        );

        final code = emitToString(node);

        expect(code,
            contains('mainAxisAlignment: MainAxisAlignment.spaceBetween'));
        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.end'));
      });
    });

    group('Row emission', () {
      test('emits basic Row', () {
        final node = App.row(children: []);

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('children:'));
      });

      test('emits Row with children', () {
        final node = App.row(
          children: [
            App.text(text: 'Left'),
            App.text(text: 'Right'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('Left'));
        expect(code, contains('Right'));
      });

      test('emits Row with mainAxisAlignment', () {
        final node = App.row(
          mainAxisAlignment: MainAlignment.spaceEvenly,
          children: [],
        );

        final code = emitToString(node);

        expect(
            code, contains('mainAxisAlignment: MainAxisAlignment.spaceEvenly'));
      });

      test('emits Row with crossAxisAlignment', () {
        final node = App.row(
          crossAxisAlignment: CrossAlignment.stretch,
          children: [],
        );

        final code = emitToString(node);

        expect(
            code, contains('crossAxisAlignment: CrossAxisAlignment.stretch'));
      });
    });

    group('Text emission', () {
      test('emits basic AppText', () {
        final node = App.text(text: 'Hello World');

        final code = emitToString(node);

        expect(code, contains('AppText'));
        expect(code, contains('text:'));
        expect(code, contains('Hello World'));
      });

      test('emits AppText with variant', () {
        final node = App.text(
          text: 'Title',
          variant: TextVariant.headlineMedium,
        );

        final code = emitToString(node);

        expect(code, contains('variant: TextVariant.headlineMedium'));
      });

      test('emits AppText with align', () {
        final node = App.text(
          text: 'Centered',
          align: SyntaxTextAlign.center,
        );

        final code = emitToString(node);

        expect(code, contains('align: TextAlign.center'));
      });

      test('emits AppText with maxLines', () {
        final node = App.text(
          text: 'Limited',
          maxLines: 2,
        );

        final code = emitToString(node);

        expect(code, contains('maxLines: 2'));
      });

      test('emits AppText with overflow', () {
        final node = App.text(
          text: 'Overflow',
          overflow: SyntaxTextOverflow.ellipsis,
        );

        final code = emitToString(node);

        expect(code, contains('overflow: TextOverflow.ellipsis'));
      });

      test('emits AppText with all parameters', () {
        final node = App.text(
          text: 'Full',
          variant: TextVariant.bodyLarge,
          align: SyntaxTextAlign.justify,
          maxLines: 3,
          overflow: SyntaxTextOverflow.fade,
        );

        final code = emitToString(node);

        expect(code, contains('variant: TextVariant.bodyLarge'));
        expect(code, contains('align: TextAlign.justify'));
        expect(code, contains('maxLines: 3'));
        expect(code, contains('overflow: TextOverflow.fade'));
      });
    });

    group('Button emission', () {
      test('emits basic AppButton', () {
        final node = App.button(label: 'Click Me');

        final code = emitToString(node);

        expect(code, contains('AppButton'));
        expect(code, contains('label:'));
        expect(code, contains('Click Me'));
      });

      test('emits AppButton with onPressed callback', () {
        final node = App.button(
          label: 'Submit',
          onPressed: 'handleSubmit',
        );

        final code = emitToString(node);

        expect(code, contains('onPressed: handleSubmit'));
      });

      test('emits AppButton with variant', () {
        final node = App.button(
          label: 'Secondary',
          variant: 'outlined',
        );

        final code = emitToString(node);

        expect(code, contains('variant: ButtonVariant.outlined'));
      });

      test('emits AppButton with all parameters', () {
        // Note: variant is not emitted when it's 'filled' (the default)
        final node = App.button(
          label: 'Action',
          onPressed: 'handleAction',
          variant: 'text',
        );

        final code = emitToString(node);

        expect(code, contains('label:'));
        expect(code, contains('onPressed: handleAction'));
        expect(code, contains('variant: ButtonVariant.text'));
      });
    });

    group('TextField emission', () {
      test('emits basic AppInput', () {
        final node = App.textField(label: 'Email');

        final code = emitToString(node);

        expect(code, contains('AppInput'));
        expect(code, contains('label:'));
        expect(code, contains('Email'));
      });

      test('emits AppInput with hint', () {
        final node = App.textField(
          label: 'Email',
          hint: 'you@example.com',
        );

        final code = emitToString(node);

        expect(code, contains('hint:'));
        expect(code, contains('you@example.com'));
      });

      test('emits AppInput with obscureText', () {
        final node = App.textField(
          label: 'Password',
          obscureText: true,
        );

        final code = emitToString(node);

        expect(code, contains('obscureText: true'));
      });

      test('emits AppInput with keyboardType', () {
        // Note: Emitter maps KeyboardType enum to TextInputType
        final node = App.textField(
          label: 'Email',
          keyboardType: KeyboardType.email,
        );

        final code = emitToString(node);

        // Emitter maps KeyboardType.email to TextInputType.emailAddress
        expect(code, contains('keyboardType: TextInputType.emailAddress'));
      });

      test('emits basic AppInput with just label', () {
        // Note: onChanged callback is not currently emitted by LayoutEmitter
        final node = App.textField(
          label: 'Name',
        );

        final code = emitToString(node);

        expect(code, contains('AppInput'));
        expect(code, contains('label:'));
        expect(code, contains('Name'));
      });

      test('emits AppInput with all parameters', () {
        final node = App.textField(
          label: 'Phone',
          hint: '+1234567890',
          keyboardType: KeyboardType.phone,
        );

        final code = emitToString(node);

        expect(code, contains('label:'));
        expect(code, contains('hint:'));
        // Emitter maps KeyboardType.phone to TextInputType.phone
        expect(code, contains('keyboardType: TextInputType.phone'));
      });
    });

    group('AppBar emission', () {
      test('emits basic AppBar', () {
        final node = App.appBar(title: 'Home');

        final code = emitToString(node);

        expect(code, contains('AppBar'));
        expect(code, contains('title:'));
        expect(code, contains('Home'));
      });

      test('emits AppBar with title only', () {
        // Note: actions are not currently emitted by LayoutEmitter
        final node = App.appBar(
          title: 'Profile',
          actions: [
            AppBarAction(icon: 'settings', onPressed: 'handleSettings'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('AppBar'));
        expect(code, contains('Profile'));
      });
    });

    group('Icon emission', () {
      test('emits basic Icon', () {
        final node = App.icon(name: 'home');

        final code = emitToString(node);

        expect(code, contains('Icon'));
        expect(code, contains('home'));
      });

      test('emits Icon with size parameter', () {
        // Note: emitter uses literal size value (24), not IconSize enum
        final node = App.icon(
          name: 'settings',
          size: IconSize.lg,
        );

        final code = emitToString(node);

        expect(code, contains('Icon'));
        expect(code, contains('size:'));
      });
    });

    group('Spacer emission', () {
      test('emits Spacer with default', () {
        final node = App.spacer();

        final code = emitToString(node);

        // Note: Default SpacerNode without flex/size defaults to SpacerSize.md (16px) -> SizedBox
        expect(code, contains('SizedBox'));
        expect(code, contains('height: 16'));
      });

      test('emits Spacer with flex', () {
        final node = App.spacer(flex: 2);

        final code = emitToString(node);

        expect(code, contains('flex: 2'));
      });

      test('emits Spacer with size', () {
        // Note: Spacer emitter currently only supports flex, not size enum
        final node = App.spacer(size: SpacerSize.lg);

        final code = emitToString(node);

        // lg = 24.0
        expect(code, contains('SizedBox'));
        expect(code, contains('height: 24'));
      });
    });

    group('Nested layouts', () {
      test('emits nested Column inside Column', () {
        final node = App.column(
          children: [
            App.text(text: 'Header'),
            App.column(
              children: [
                App.text(text: 'Nested 1'),
                App.text(text: 'Nested 2'),
              ],
            ),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Header'));
        expect(code, contains('Nested 1'));
        expect(code, contains('Nested 2'));
      });

      test('emits Row inside Column', () {
        final node = App.column(
          children: [
            App.row(
              children: [
                App.text(text: 'Left'),
                App.text(text: 'Right'),
              ],
            ),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Row'));
        expect(code, contains('Left'));
        expect(code, contains('Right'));
      });

      test('emits deeply nested layout', () {
        final node = App.column(
          children: [
            App.row(
              children: [
                App.column(
                  children: [
                    App.text(text: 'Deep'),
                  ],
                ),
              ],
            ),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Row'));
        expect(code, contains('Deep'));
      });

      test('emits complex mixed layout', () {
        final node = App.column(
          children: [
            App.text(text: 'Title'),
            App.spacer(flex: 1),
            App.row(
              mainAxisAlignment: MainAlignment.spaceBetween,
              children: [
                App.button(label: 'Cancel', onPressed: 'onCancel'),
                App.button(label: 'OK', onPressed: 'onOk'),
              ],
            ),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Title'));
        expect(code, contains('Spacer'));
        expect(code, contains('Row'));
        expect(code, contains('spaceBetween'));
        expect(code, contains('Cancel'));
        expect(code, contains('OK'));
      });
    });

    group('Edge cases', () {
      test('handles empty Column', () {
        final node = App.column(children: []);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('children: []'));
      });

      test('handles empty Row', () {
        final node = App.row(children: []);

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('children: []'));
      });

      test('handles text with special characters', () {
        final node = App.text(text: 'Hello "World" & \'Friends\'');

        final code = emitToString(node);

        expect(code, contains('AppText'));
      });

      test('handles text with newlines', () {
        final node = App.text(text: 'Line 1\nLine 2');

        final code = emitToString(node);

        expect(code, contains('AppText'));
      });

      test('handles many children (100+)', () {
        final children = List.generate(
          150,
          (i) => App.text(text: 'Item $i'),
        );

        final node = App.column(children: children);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Item 0'));
        expect(code, contains('Item 149'));
      });

      test('handles deeply nested layout (10 levels)', () {
        App createNested(int depth) {
          if (depth == 0) {
            return App.text(text: 'Leaf');
          }
          return App.column(
            children: [createNested(depth - 1)],
          );
        }

        final node = createNested(10);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Leaf'));
      });
    });

    group('All variants', () {
      test('emits all TextVariant values', () {
        for (final variant in TextVariant.values) {
          final node = App.text(
            text: 'Test',
            variant: variant,
          );

          final code = emitToString(node);

          expect(code, contains('TextVariant.${variant.name}'));
        }
      });

      test('emits all ButtonVariant values except filled (default)', () {
        // Note: emitter skips variant when it's 'filled' (the default)
        final variants = ['filled', 'outlined', 'text', 'elevated', 'tonal'];
        for (final variant in variants) {
          if (variant == 'filled') continue; // Skip default
          final node = App.button(
            label: 'Test',
            variant: variant,
          );

          final code = emitToString(node);

          expect(code, contains('ButtonVariant.$variant'));
        }
      });

      test('emits keyboard types as TextInputType', () {
        // Note: Emitter maps KeyboardType enum to Flutter's TextInputType
        final expectedMappings = {
          KeyboardType.email: 'TextInputType.emailAddress',
          KeyboardType.phone: 'TextInputType.phone',
          KeyboardType.number: 'TextInputType.number',
          KeyboardType.url: 'TextInputType.url',
          KeyboardType.text: 'TextInputType.text',
          KeyboardType.multiline: 'TextInputType.multiline',
        };

        for (final entry in expectedMappings.entries) {
          final node = App.textField(
            label: 'Test',
            keyboardType: entry.key,
          );

          final code = emitToString(node);

          expect(code, contains(entry.value));
        }
      });

      test('emits spacer nodes', () {
        // Note: Spacer emitter only emits flex, not SpacerSize enum
        final node = App.spacer(flex: 1);

        final code = emitToString(node);

        expect(code, contains('Spacer'));
      });
    });
  });
}
