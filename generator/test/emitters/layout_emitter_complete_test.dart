import 'package:test/test.dart';
import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast_node.dart';

void main() {
  group('LayoutEmitter - Complete Coverage', () {
    late LayoutEmitter emitter;
    late DartEmitter dartEmitter;

    setUp(() {
      emitter = LayoutEmitter();
      dartEmitter = DartEmitter(useNullSafetySyntax: true);
    });

    String emitToString(AstNode node) {
      final expression = emitter.emit(node);
      return expression.accept(dartEmitter).toString();
    }

    group('Column emission', () {
      test('emits basic Column', () {
        final node = AstNode.column(children: []);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('children:'));
      });

      test('emits Column with children', () {
        final node = AstNode.column(
          children: [
            AstNode.text(text: 'Hello'),
            AstNode.text(text: 'World'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('AppText'));
        expect(code, contains('Hello'));
        expect(code, contains('World'));
      });

      test('emits Column with mainAxisAlignment', () {
        final node = AstNode.column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('mainAxisAlignment: MainAxisAlignment.center'));
      });

      test('emits Column with crossAxisAlignment', () {
        final node = AstNode.column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.start'));
      });

      test('emits Column with both alignments', () {
        final node = AstNode.column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('mainAxisAlignment: MainAxisAlignment.spaceBetween'));
        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.end'));
      });
    });

    group('Row emission', () {
      test('emits basic Row', () {
        final node = AstNode.row(children: []);

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('children:'));
      });

      test('emits Row with children', () {
        final node = AstNode.row(
          children: [
            AstNode.text(text: 'Left'),
            AstNode.text(text: 'Right'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('Left'));
        expect(code, contains('Right'));
      });

      test('emits Row with mainAxisAlignment', () {
        final node = AstNode.row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('mainAxisAlignment: MainAxisAlignment.spaceEvenly'));
      });

      test('emits Row with crossAxisAlignment', () {
        final node = AstNode.row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [],
        );

        final code = emitToString(node);

        expect(code, contains('crossAxisAlignment: CrossAxisAlignment.baseline'));
      });
    });

    group('Text emission', () {
      test('emits basic AppText', () {
        final node = AstNode.text(text: 'Hello World');

        final code = emitToString(node);

        expect(code, contains('AppText'));
        expect(code, contains('text:'));
        expect(code, contains('Hello World'));
      });

      test('emits AppText with variant', () {
        final node = AstNode.text(
          text: 'Title',
          variant: TextVariant.headlineMedium,
        );

        final code = emitToString(node);

        expect(code, contains('variant: TextVariant.headlineMedium'));
      });

      test('emits AppText with align', () {
        final node = AstNode.text(
          text: 'Centered',
          align: TextAlign.center,
        );

        final code = emitToString(node);

        expect(code, contains('align: TextAlign.center'));
      });

      test('emits AppText with maxLines', () {
        final node = AstNode.text(
          text: 'Limited',
          maxLines: 2,
        );

        final code = emitToString(node);

        expect(code, contains('maxLines: 2'));
      });

      test('emits AppText with overflow', () {
        final node = AstNode.text(
          text: 'Overflow',
          overflow: TextOverflow.ellipsis,
        );

        final code = emitToString(node);

        expect(code, contains('overflow: TextOverflow.ellipsis'));
      });

      test('emits AppText with all parameters', () {
        final node = AstNode.text(
          text: 'Full',
          variant: TextVariant.bodyLarge,
          align: TextAlign.justify,
          maxLines: 3,
          overflow: TextOverflow.fade,
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
        final node = AstNode.button(label: 'Click Me');

        final code = emitToString(node);

        expect(code, contains('AppButton'));
        expect(code, contains('label:'));
        expect(code, contains('Click Me'));
      });

      test('emits AppButton with onPressed callback', () {
        final node = AstNode.button(
          label: 'Submit',
          onPressed: 'handleSubmit',
        );

        final code = emitToString(node);

        expect(code, contains('onPressed: handleSubmit'));
      });

      test('emits AppButton with variant', () {
        final node = AstNode.button(
          label: 'Secondary',
          variant: ButtonVariant.secondary,
        );

        final code = emitToString(node);

        expect(code, contains('variant: ButtonVariant.secondary'));
      });

      test('emits AppButton with all parameters', () {
        final node = AstNode.button(
          label: 'Action',
          onPressed: 'handleAction',
          variant: ButtonVariant.primary,
        );

        final code = emitToString(node);

        expect(code, contains('label:'));
        expect(code, contains('onPressed: handleAction'));
        expect(code, contains('variant: ButtonVariant.primary'));
      });
    });

    group('TextField emission', () {
      test('emits basic AppInput', () {
        final node = AstNode.textField(label: 'Email');

        final code = emitToString(node);

        expect(code, contains('AppInput'));
        expect(code, contains('label:'));
        expect(code, contains('Email'));
      });

      test('emits AppInput with placeholder', () {
        final node = AstNode.textField(
          label: 'Email',
          placeholder: 'you@example.com',
        );

        final code = emitToString(node);

        expect(code, contains('placeholder:'));
        expect(code, contains('you@example.com'));
      });

      test('emits AppInput with obscureText', () {
        final node = AstNode.textField(
          label: 'Password',
          obscureText: true,
        );

        final code = emitToString(node);

        expect(code, contains('obscureText: true'));
      });

      test('emits AppInput with keyboardType', () {
        final node = AstNode.textField(
          label: 'Email',
          keyboardType: KeyboardType.email,
        );

        final code = emitToString(node);

        expect(code, contains('keyboardType: KeyboardType.email'));
      });

      test('emits AppInput with onChanged callback', () {
        final node = AstNode.textField(
          label: 'Name',
          onChanged: 'handleNameChanged',
        );

        final code = emitToString(node);

        expect(code, contains('onChanged: handleNameChanged'));
      });

      test('emits AppInput with all parameters', () {
        final node = AstNode.textField(
          label: 'Phone',
          placeholder: '+1234567890',
          obscureText: false,
          keyboardType: KeyboardType.phone,
          onChanged: 'handlePhoneChanged',
        );

        final code = emitToString(node);

        expect(code, contains('label:'));
        expect(code, contains('placeholder:'));
        expect(code, contains('keyboardType: KeyboardType.phone'));
        expect(code, contains('onChanged: handlePhoneChanged'));
      });
    });

    group('AppBar emission', () {
      test('emits basic AppBar', () {
        final node = AstNode.appBar(title: 'Home');

        final code = emitToString(node);

        expect(code, contains('AppBar'));
        expect(code, contains('title:'));
        expect(code, contains('Home'));
      });

      test('emits AppBar with actions', () {
        final node = AstNode.appBar(
          title: 'Profile',
          actions: [
            AppBarAction(icon: 'settings', onPressed: 'handleSettings'),
            AppBarAction(icon: 'logout', onPressed: 'handleLogout'),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('actions:'));
      });
    });

    group('Image emission', () {
      test('emits basic Image', () {
        final node = AstNode.image(path: 'assets/logo.png');

        final code = emitToString(node);

        expect(code, contains('Image'));
        expect(code, contains('assets/logo.png'));
      });

      test('emits Image with width', () {
        final node = AstNode.image(
          path: 'assets/logo.png',
          width: 200,
        );

        final code = emitToString(node);

        expect(code, contains('width: 200'));
      });

      test('emits Image with height', () {
        final node = AstNode.image(
          path: 'assets/logo.png',
          height: 150,
        );

        final code = emitToString(node);

        expect(code, contains('height: 150'));
      });

      test('emits Image with fit', () {
        final node = AstNode.image(
          path: 'assets/logo.png',
          fit: BoxFit.cover,
        );

        final code = emitToString(node);

        expect(code, contains('fit: BoxFit.cover'));
      });

      test('emits Image with all parameters', () {
        final node = AstNode.image(
          path: 'assets/background.jpg',
          width: 400,
          height: 300,
          fit: BoxFit.contain,
        );

        final code = emitToString(node);

        expect(code, contains('assets/background.jpg'));
        expect(code, contains('width: 400'));
        expect(code, contains('height: 300'));
        expect(code, contains('fit: BoxFit.contain'));
      });
    });

    group('Spacer emission', () {
      test('emits SizedBox with height', () {
        final node = AstNode.spacer(height: 24);

        final code = emitToString(node);

        expect(code, contains('SizedBox'));
        expect(code, contains('height: 24'));
      });

      test('emits SizedBox with width', () {
        final node = AstNode.spacer(width: 16);

        final code = emitToString(node);

        expect(code, contains('width: 16'));
      });

      test('emits SizedBox with both dimensions', () {
        final node = AstNode.spacer(height: 32, width: 48);

        final code = emitToString(node);

        expect(code, contains('height: 32'));
        expect(code, contains('width: 48'));
      });
    });

    group('Nested layouts', () {
      test('emits nested Column inside Column', () {
        final node = AstNode.column(
          children: [
            AstNode.text(text: 'Header'),
            AstNode.column(
              children: [
                AstNode.text(text: 'Nested 1'),
                AstNode.text(text: 'Nested 2'),
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
        final node = AstNode.column(
          children: [
            AstNode.row(
              children: [
                AstNode.text(text: 'Left'),
                AstNode.text(text: 'Right'),
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
        final node = AstNode.column(
          children: [
            AstNode.row(
              children: [
                AstNode.column(
                  children: [
                    AstNode.text(text: 'Deep'),
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
        final node = AstNode.column(
          children: [
            AstNode.text(text: 'Title'),
            AstNode.spacer(height: 16),
            AstNode.row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AstNode.button(label: 'Cancel', onPressed: 'onCancel'),
                AstNode.button(label: 'OK', onPressed: 'onOk'),
              ],
            ),
          ],
        );

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Title'));
        expect(code, contains('SizedBox'));
        expect(code, contains('Row'));
        expect(code, contains('spaceBetween'));
        expect(code, contains('Cancel'));
        expect(code, contains('OK'));
      });
    });

    group('Edge cases', () {
      test('handles empty Column', () {
        final node = AstNode.column(children: []);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('children: []'));
      });

      test('handles empty Row', () {
        final node = AstNode.row(children: []);

        final code = emitToString(node);

        expect(code, contains('Row'));
        expect(code, contains('children: []'));
      });

      test('handles text with special characters', () {
        final node = AstNode.text(text: 'Hello "World" & \'Friends\'');

        final code = emitToString(node);

        expect(code, contains('AppText'));
      });

      test('handles text with newlines', () {
        final node = AstNode.text(text: 'Line 1\nLine 2');

        final code = emitToString(node);

        expect(code, contains('AppText'));
      });

      test('handles many children (100+)', () {
        final children = List.generate(
          150,
          (i) => AstNode.text(text: 'Item $i'),
        );

        final node = AstNode.column(children: children);

        final code = emitToString(node);

        expect(code, contains('Column'));
        expect(code, contains('Item 0'));
        expect(code, contains('Item 149'));
      });

      test('handles deeply nested layout (10 levels)', () {
        AstNode createNested(int depth) {
          if (depth == 0) {
            return AstNode.text(text: 'Leaf');
          }
          return AstNode.column(
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
          final node = AstNode.text(
            text: 'Test',
            variant: variant,
          );

          final code = emitToString(node);

          expect(code, contains('TextVariant.${variant.name}'));
        }
      });

      test('emits all ButtonVariant values', () {
        for (final variant in ButtonVariant.values) {
          final node = AstNode.button(
            label: 'Test',
            variant: variant,
          );

          final code = emitToString(node);

          expect(code, contains('ButtonVariant.${variant.name}'));
        }
      });

      test('emits all KeyboardType values', () {
        for (final type in KeyboardType.values) {
          final node = AstNode.textField(
            label: 'Test',
            keyboardType: type,
          );

          final code = emitToString(node);

          expect(code, contains('KeyboardType.${type.name}'));
        }
      });

      test('emits all BoxFit values', () {
        for (final fit in BoxFit.values) {
          final node = AstNode.image(
            path: 'test.png',
            fit: fit,
          );

          final code = emitToString(node);

          expect(code, contains('BoxFit.${fit.name}'));
        }
      });
    });
  });
}
