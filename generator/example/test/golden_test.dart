import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/generated/index.dart';

/// Golden tests for AppButton across all style × variant combinations.
///
/// These tests capture visual snapshots for regression testing.
/// Run with: flutter test --update-goldens
void main() {
  group('AppButton Golden Tests', () {
    // Test helper to wrap widget for golden test
    Widget wrapForGolden(Widget child, {DesignStyle? style}) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppTheme(
          style: style ?? const MaterialStyle(),
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    // ============================================
    // MATERIAL STYLE GOLDENS (3 variants)
    // ============================================

    group('MaterialStyle', () {
      testWidgets('primary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Primary Button'),
            style: const MaterialStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/material_primary.png'),
        );
      });

      testWidgets('secondary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.secondary(label: 'Secondary Button'),
            style: const MaterialStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/material_secondary.png'),
        );
      });

      testWidgets('outlined variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.outlined(label: 'Outlined Button'),
            style: const MaterialStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/material_outlined.png'),
        );
      });
    });

    // ============================================
    // CUPERTINO STYLE GOLDENS (3 variants)
    // ============================================

    group('CupertinoStyle', () {
      testWidgets('primary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Primary Button'),
            style: const CupertinoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/cupertino_primary.png'),
        );
      });

      testWidgets('secondary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.secondary(label: 'Secondary Button'),
            style: const CupertinoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/cupertino_secondary.png'),
        );
      });

      testWidgets('outlined variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.outlined(label: 'Outlined Button'),
            style: const CupertinoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/cupertino_outlined.png'),
        );
      });
    });

    // ============================================
    // NEO STYLE GOLDENS (3 variants)
    // ============================================

    group('NeoStyle', () {
      testWidgets('primary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Primary Button'),
            style: const NeoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/neo_primary.png'),
        );
      });

      testWidgets('secondary variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.secondary(label: 'Secondary Button'),
            style: const NeoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/neo_secondary.png'),
        );
      });

      testWidgets('outlined variant', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.outlined(label: 'Outlined Button'),
            style: const NeoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/neo_outlined.png'),
        );
      });
    });

    // ============================================
    // STATE GOLDENS
    // ============================================

    group('States', () {
      testWidgets('loading state (Material)', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Loading', isLoading: true),
            style: const MaterialStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/material_loading.png'),
        );
      });

      testWidgets('disabled state (Material)', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Disabled', isDisabled: true),
            style: const MaterialStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/material_disabled.png'),
        );
      });

      testWidgets('loading state (Neo)', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Loading', isLoading: true),
            style: const NeoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/neo_loading.png'),
        );
      });

      testWidgets('disabled state (Neo)', (tester) async {
        await tester.pumpWidget(
          wrapForGolden(
            const AppButton.primary(label: 'Disabled', isDisabled: true),
            style: const NeoStyle(),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/neo_disabled.png'),
        );
      });
    });
  });
}
