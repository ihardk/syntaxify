import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppAppBar', () {
    testWidgets('renders title correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'Test App',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
      expect(find.text('Test App'), findsOneWidget);
    });

    testWidgets('renders primary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'Primary',
                variant: AppBarVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('renders transparent variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar.transparent(
                title: 'Transparent',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'With Leading',
                leading: 'menu',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('renders with action icons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'With Actions',
                actions: ['search', 'settings'],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('centers title when centerTitle is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'Centered',
                centerTitle: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('implements PreferredSizeWidget', (tester) async {
      const appBar = AppAppBar(title: 'Test');
      expect(appBar.preferredSize, equals(const Size.fromHeight(56)));
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'Cupertino',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: Scaffold(
              appBar: const AppAppBar(
                title: 'Neo',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAppBar), findsOneWidget);
    });
  });
}
