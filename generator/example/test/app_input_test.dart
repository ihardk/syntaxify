import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/syntaxify/index.dart';
import '../meta/app_icons.dart' as meta;

void main() {
  group('AppInput Component Tests', () {
    // Helper to wrap with theme
    Widget wrapWithTheme(Widget child, {DesignStyle? style}) {
      return MaterialApp(
        home: AppTheme(
          style: style ?? const MaterialStyle(),
          child: Scaffold(body: Center(child: child)),
        ),
      );
    }

    // ============================================
    // INTERNAL WIDGET RENDERING (Mixins)
    // ============================================

    testWidgets('MaterialStyle renders TextField with InputDecoration',
        (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppInput(label: 'MatInput', controller: TextEditingController()),
        style: const MaterialStyle(),
      ));

      expect(find.byType(TextField), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.labelText, 'MatInput');
    });

    testWidgets('CupertinoStyle renders CupertinoTextField', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppInput(
            label: 'CupInput',
            hint: 'Hint',
            controller: TextEditingController()),
        style: const CupertinoStyle(),
      ));

      expect(find.byType(CupertinoTextField), findsOneWidget);
      // Cupertino uses specific placeholder widget, finding by text is safer
      expect(find.text('CupInput'), findsOneWidget);
      expect(find.text('Hint'), findsOneWidget);
    });

    testWidgets('NeoStyle renders Container and Uppercase Label',
        (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppInput(label: 'NeoInput', controller: TextEditingController()),
        style: const NeoStyle(),
      ));

      // Neo uppercases labels
      expect(find.text('NEOINPUT'), findsOneWidget);
      // Logic check: Decoration should have box shadow
      expect(find.byType(Container), findsWidgets);
    });

    // ============================================
    // PROPERTY PROPAGATION
    // ============================================

    testWidgets('Controller is propagated', (tester) async {
      final controller = TextEditingController(text: 'Initial');
      await tester.pumpWidget(wrapWithTheme(
        AppInput(controller: controller),
      ));

      expect(find.text('Initial'), findsOneWidget);

      // Update controller
      controller.text = 'Updated';
      await tester.pump();
      expect(find.text('Updated'), findsOneWidget);
    });

    testWidgets('ObscureText is propagated', (tester) async {
      // Default false
      await tester.pumpWidget(wrapWithTheme(
          AppInput(obscureText: false, controller: TextEditingController())));
      var textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, false);

      // True
      await tester.pumpWidget(wrapWithTheme(
          AppInput(obscureText: true, controller: TextEditingController())));
      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('ErrorText is propagated', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppInput(
            errorText: 'Invalid Value', controller: TextEditingController()),
      ));

      expect(find.text('Invalid Value'), findsOneWidget);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.errorText, 'Invalid Value');
    });

    // ============================================
    // INTERACTION
    // ============================================

    testWidgets('OnChanged callback fires', (tester) async {
      String? value;
      await tester.pumpWidget(wrapWithTheme(
        AppInput(
            onChanged: (v) => value = v, controller: TextEditingController()),
      ));

      await tester.enterText(find.byType(TextField), 'Hello');
      expect(value, 'Hello');
    });

    testWidgets('OnSubmitted callback fires', (tester) async {
      String? value;
      await tester.pumpWidget(wrapWithTheme(
        AppInput(
            onSubmitted: (v) => value = v, controller: TextEditingController()),
      ));

      await tester.enterText(find.byType(TextField), 'SubmitMe');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(value, 'SubmitMe');
    });

    // ============================================
    // ICON REGISTRY
    // ============================================

    // Note: 'search' and 'user' should be in defaults.

    testWidgets('Icons render when defined by AppIcon', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        AppInput(
          label: 'IconInput',
          prefixIconName: meta.AppIcon.search,
          suffixIconName: meta.AppIcon.user,
          controller: TextEditingController(),
        ),
      ));

      // We expect 2 icons
      expect(find.byType(Icon), findsNWidgets(2));
      expect(find.byIcon(Icons.search), findsOneWidget);
      // 'user' maps to Icons.person in default AppIcons
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
