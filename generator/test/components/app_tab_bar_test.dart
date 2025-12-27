import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppTabBar', () {
    final tabs = [
      const TabBarItem(label: 'Home', icon: 'home'),
      const TabBarItem(label: 'Search', icon: 'search'),
      const TabBarItem(label: 'Profile', icon: 'person'),
    ];

    testWidgets('renders tabs correctly', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: tabs,
                currentIndex: selectedIndex,
                onTabChange: (index) {
                  selectedIndex = index;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders primary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: tabs,
                currentIndex: 0,
                onTabChange: (_) {},
                variant: TabBarVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
    });

    testWidgets('renders secondary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppTabBar.secondary(
                tabs: tabs,
                currentIndex: 1,
                onTabChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
    });

    testWidgets('renders without icons', (tester) async {
      final tabsNoIcons = [
        const TabBarItem(label: 'Tab 1'),
        const TabBarItem(label: 'Tab 2'),
        const TabBarItem(label: 'Tab 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: tabsNoIcons,
                currentIndex: 0,
                onTabChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
      expect(find.text('Tab 1'), findsOneWidget);
    });

    testWidgets('handles scrollable tabs', (tester) async {
      final manyTabs = List.generate(
        10,
        (i) => TabBarItem(label: 'Tab $i', icon: 'star'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: manyTabs,
                currentIndex: 0,
                onTabChange: (_) {},
                isScrollable: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: tabs,
                currentIndex: 0,
                onTabChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: Scaffold(
              body: AppTabBar(
                tabs: tabs,
                currentIndex: 0,
                onTabChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppTabBar), findsOneWidget);
    });
  });

  group('TabBarItem', () {
    test('equality works correctly', () {
      const item1 = TabBarItem(label: 'Home', icon: 'home');
      const item2 = TabBarItem(label: 'Home', icon: 'home');
      const item3 = TabBarItem(label: 'Search', icon: 'search');

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });

    test('hashCode works correctly', () {
      const item1 = TabBarItem(label: 'Home', icon: 'home');
      const item2 = TabBarItem(label: 'Home', icon: 'home');

      expect(item1.hashCode, equals(item2.hashCode));
    });
  });
}
