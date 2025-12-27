import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppBottomNav', () {
    final items = [
      const BottomNavItem(icon: 'home', label: 'Home'),
      const BottomNavItem(icon: 'search', label: 'Search'),
      const BottomNavItem(icon: 'person', label: 'Profile'),
    ];

    testWidgets('renders navigation items correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: items,
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('renders standard variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: items,
                currentIndex: 0,
                onTap: (_) {},
                variant: BottomNavVariant.standard,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('renders floating variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav.floating(
                items: items,
                currentIndex: 1,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('handles showLabels parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: items,
                currentIndex: 0,
                onTap: (_) {},
                showLabels: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('renders items with badges', (tester) async {
      final itemsWithBadges = [
        const BottomNavItem(icon: 'home', label: 'Home'),
        const BottomNavItem(icon: 'notifications', label: 'Notifications', badge: '5'),
        const BottomNavItem(icon: 'person', label: 'Profile'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: itemsWithBadges,
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: items,
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: Scaffold(
              bottomNavigationBar: AppBottomNav(
                items: items,
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppBottomNav), findsOneWidget);
    });
  });

  group('BottomNavItem', () {
    test('equality works correctly', () {
      const item1 = BottomNavItem(icon: 'home', label: 'Home');
      const item2 = BottomNavItem(icon: 'home', label: 'Home');
      const item3 = BottomNavItem(icon: 'search', label: 'Search');

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });

    test('hashCode works correctly', () {
      const item1 = BottomNavItem(icon: 'home', label: 'Home');
      const item2 = BottomNavItem(icon: 'home', label: 'Home');

      expect(item1.hashCode, equals(item2.hashCode));
    });
  });
}
