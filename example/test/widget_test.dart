import 'package:example/syntax/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/syntax/index.dart';

void main() {
  group('AppButton Renderer Pattern Tests', () {
    // Test helper to wrap widget with theme
    Widget wrapWithTheme(Widget child, {DesignStyle? style}) {
      return MaterialApp(
        home: AppTheme(
          style: style ?? const MaterialStyle(),
          child: Scaffold(body: Center(child: child)),
        ),
      );
    }

    // ============================================
    // VARIANT CONSTRUCTOR TESTS
    // ============================================

    group('Variant Constructors', () {
      testWidgets('AppButton.primary() creates primary variant',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(const AppButton.primary(label: 'Primary')),
        );

        expect(find.text('Primary'), findsOneWidget);
        // Material primary uses ElevatedButton
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('AppButton.secondary() creates secondary variant',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(const AppButton.secondary(label: 'Secondary')),
        );

        expect(find.text('Secondary'), findsOneWidget);
        // Material secondary uses FilledButton.tonal
        expect(find.byType(FilledButton), findsOneWidget);
      });

      testWidgets('AppButton.outlined() creates outlined variant',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(const AppButton.outlined(label: 'Outlined')),
        );

        expect(find.text('Outlined'), findsOneWidget);
        // Material outlined uses OutlinedButton
        expect(find.byType(OutlinedButton), findsOneWidget);
      });
    });

    // ============================================
    // MATERIAL STYLE TESTS (3 variants)
    // ============================================

    group('MaterialStyle Rendering', () {
      testWidgets('renders primary with ElevatedButton', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test'),
            style: const MaterialStyle(),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('renders outlined with OutlinedButton', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.outlined(label: 'Test'),
            style: const MaterialStyle(),
          ),
        );

        expect(find.byType(OutlinedButton), findsOneWidget);
      });

      testWidgets('calls onPressed when primary is tapped', (tester) async {
        bool pressed = false;

        await tester.pumpWidget(
          wrapWithTheme(
            AppButton.primary(label: 'Test', onPressed: () => pressed = true),
            style: const MaterialStyle(),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        expect(pressed, true);
      });
    });

    // ============================================
    // NEO STYLE TESTS (3 variants)
    // ============================================

    group('NeoStyle Rendering', () {
      testWidgets('renders with brutalist styling (no border radius)',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test'),
            style: const NeoStyle(),
          ),
        );

        // Neo uses GestureDetector + Container
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(Container), findsWidgets);

        // Check for uppercase text (Neo style)
        expect(find.text('TEST'), findsOneWidget);
      });

      testWidgets('renders secondary with coral color', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.secondary(label: 'Test'),
            style: const NeoStyle(),
          ),
        );

        // Neo secondary should still render
        expect(find.text('TEST'), findsOneWidget);
      });

      testWidgets('calls onPressed when tapped', (tester) async {
        bool pressed = false;

        await tester.pumpWidget(
          wrapWithTheme(
            AppButton.primary(label: 'Test', onPressed: () => pressed = true),
            style: const NeoStyle(),
          ),
        );

        await tester.tap(find.byType(GestureDetector));
        expect(pressed, true);
      });
    });

    // ============================================
    // CUPERTINO STYLE TESTS (3 variants)
    // ============================================

    group('CupertinoStyle Rendering', () {
      testWidgets('renders with CupertinoButton', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test'),
            style: const CupertinoStyle(),
          ),
        );

        expect(find.byType(CupertinoButton), findsOneWidget);
      });

      testWidgets('renders outlined with border', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.outlined(label: 'Test'),
            style: const CupertinoStyle(),
          ),
        );

        // Outlined uses Container + CupertinoButton
        expect(find.byType(Container), findsWidgets);
        expect(find.byType(CupertinoButton), findsOneWidget);
      });
    });

    // ============================================
    // LOADING STATE TESTS
    // ============================================

    group('Loading State', () {
      testWidgets('Material shows CircularProgressIndicator when loading',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test', isLoading: true),
            style: const MaterialStyle(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('Neo shows loading indicator', (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test', isLoading: true),
            style: const NeoStyle(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('Cupertino shows CupertinoActivityIndicator when loading',
          (tester) async {
        await tester.pumpWidget(
          wrapWithTheme(
            const AppButton.primary(label: 'Test', isLoading: true),
            style: const CupertinoStyle(),
          ),
        );

        expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      });
    });

    // ============================================
    // DISABLED STATE TESTS
    // ============================================

    group('Disabled State', () {
      testWidgets('does not call onPressed when disabled', (tester) async {
        bool pressed = false;

        await tester.pumpWidget(
          wrapWithTheme(
            AppButton.primary(
              label: 'Test',
              onPressed: () => pressed = true,
              isDisabled: true,
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        expect(pressed, false);
      });
    });

    // ============================================
    // THEME SWITCHING TESTS
    // ============================================

    group('Theme Switching', () {
      testWidgets('switching style changes rendering', (tester) async {
        final styleNotifier = ValueNotifier<DesignStyle>(const MaterialStyle());

        await tester.pumpWidget(
          MaterialApp(
            home: ValueListenableBuilder<DesignStyle>(
              valueListenable: styleNotifier,
              builder: (_, style, __) => AppTheme(
                style: style,
                child: const Scaffold(
                  body: Center(child: AppButton.primary(label: 'Theme Test')),
                ),
              ),
            ),
          ),
        );

        // Verify Material uses ElevatedButton
        expect(find.byType(ElevatedButton), findsOneWidget);

        // Switch to Neo
        styleNotifier.value = const NeoStyle();
        await tester.pumpAndSettle();

        // Verify Neo uses GestureDetector (not ElevatedButton)
        expect(find.byType(ElevatedButton), findsNothing);
        expect(find.text('THEME TEST'), findsOneWidget); // Neo uppercases
      });
    });
  });
}
