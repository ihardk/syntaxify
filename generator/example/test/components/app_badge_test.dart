import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppBadge', () {
    testWidgets('wraps child widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 5,
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('displays count variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 10,
                variant: BadgeVariant.count,
                child: Icon(Icons.mail),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('displays dot variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge.dot(
                child: Icon(Icons.message),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('handles zero count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 0,
                child: Icon(Icons.inbox),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('handles large count (99+)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 150,
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('respects showBadge parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 5,
                showBadge: false,
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 3,
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: const Scaffold(
              body: AppBadge(
                count: 7,
                child: Icon(Icons.favorite),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
    });
  });
}
