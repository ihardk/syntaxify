import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

/// Integration tests for design system components across all styles.
///
/// Verifies that all components render correctly with Material, Cupertino, and Neo styles.
/// Tests integration between components, tokens, and renderers.
void main() {
  group('Design System Integration Tests', () {
    group('AppIconButton Integration', () {
      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                body: AppIconButton(
                  icon: 'add',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppIconButton), findsOneWidget);
        expect(find.byType(IconButton), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: Scaffold(
                body: AppIconButton(
                  icon: 'add',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppIconButton), findsOneWidget);
        expect(find.byType(CupertinoButton), findsOneWidget);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: Scaffold(
                body: AppIconButton(
                  icon: 'add',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppIconButton), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('AppDropdown Integration', () {
      final items = [
        const DropdownItem(value: 'a', label: 'Option A'),
        const DropdownItem(value: 'b', label: 'Option B'),
      ];

      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                body: AppDropdown<String>(
                  value: 'a',
                  items: items,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppDropdown<String>), findsOneWidget);
        expect(find.byType(DropdownButton<String>), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: Scaffold(
                body: AppDropdown<String>(
                  value: 'a',
                  items: items,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppDropdown<String>), findsOneWidget);
        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: Scaffold(
                body: AppDropdown<String>(
                  value: 'a',
                  items: items,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppDropdown<String>), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('AppTabBar Integration', () {
      final tabs = [
        const TabBarItem(label: 'Tab 1'),
        const TabBarItem(label: 'Tab 2'),
      ];

      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                body: DefaultTabController(
                  length: 2,
                  child: AppTabBar(tabs: tabs),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppTabBar), findsOneWidget);
        expect(find.byType(TabBar), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: Scaffold(
                body: AppTabBar(
                  tabs: tabs,
                  currentIndex: 0,
                  onTap: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppTabBar), findsOneWidget);
        expect(find.byType(CupertinoSlidingSegmentedControl<int>), findsOneWidget);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: Scaffold(
                body: AppTabBar(
                  tabs: tabs,
                  currentIndex: 0,
                  onTap: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppTabBar), findsOneWidget);
        expect(find.byType(Row), findsWidgets);
      });
    });

    group('AppBottomNav Integration', () {
      final items = [
        const BottomNavItem(icon: 'home', label: 'Home'),
        const BottomNavItem(icon: 'search', label: 'Search'),
      ];

      testWidgets('renders with MaterialStyle', (tester) async {
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
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
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
        expect(find.byType(CupertinoTabBar), findsOneWidget);
      });

      testWidgets('renders with NeoStyle', (tester) async {
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
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('AppAppBar Integration', () {
      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                appBar: const AppAppBar(title: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAppBar), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: Scaffold(
                appBar: const AppAppBar(title: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAppBar), findsOneWidget);
        expect(find.byType(CupertinoNavigationBar), findsOneWidget);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: Scaffold(
                appBar: const AppAppBar(title: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAppBar), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('AppChip Integration', () {
      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: const Scaffold(
                body: AppChip(label: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppChip), findsOneWidget);
        expect(find.byType(Chip), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: const Scaffold(
                body: AppChip(label: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppChip), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: const Scaffold(
                body: AppChip(label: 'Test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppChip), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('AppBadge Integration', () {
      testWidgets('renders with MaterialStyle', (tester) async {
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
        expect(find.byType(Badge), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
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
        expect(find.byType(Stack), findsOneWidget);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
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
        expect(find.byType(Stack), findsOneWidget);
      });
    });

    group('AppAvatar Integration', () {
      testWidgets('renders with MaterialStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: const Scaffold(
                body: AppAvatar(initials: 'AB'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAvatar), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);
      });

      testWidgets('renders with CupertinoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const CupertinoStyle(),
              child: const Scaffold(
                body: AppAvatar(initials: 'AB'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAvatar), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('renders with NeoStyle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const NeoStyle(),
              child: const Scaffold(
                body: AppAvatar(initials: 'AB'),
              ),
            ),
          ),
        );

        expect(find.byType(AppAvatar), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('Cross-Component Integration', () {
      testWidgets('AppBottomNav with AppBadge integration', (tester) async {
        final items = [
          const BottomNavItem(icon: 'home', label: 'Home'),
          const BottomNavItem(icon: 'notifications', label: 'Alerts', badge: '5'),
          const BottomNavItem(icon: 'person', label: 'Profile'),
        ];

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
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });

      testWidgets('AppAppBar with AppIconButton actions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                appBar: const AppAppBar(
                  title: 'Test',
                  leading: 'menu',
                  actions: ['search', 'settings'],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppAppBar), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('AppChip with AppAvatar integration', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: const Scaffold(
                body: Row(
                  children: [
                    AppAvatar(initials: 'JD', size: 32),
                    SizedBox(width: 8),
                    AppChip(label: 'John Doe'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppAvatar), findsOneWidget);
        expect(find.byType(AppChip), findsOneWidget);
      });

      testWidgets('AppBadge with AppIconButton integration', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppTheme(
              style: const MaterialStyle(),
              child: Scaffold(
                body: AppBadge(
                  count: 3,
                  child: AppIconButton(
                    icon: 'notifications',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppBadge), findsOneWidget);
        expect(find.byType(AppIconButton), findsOneWidget);
      });
    });

    group('Token Integration', () {
      testWidgets('IconButtonTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.iconButtonTokens(IconButtonVariant.standard);

        expect(tokens.size, isNotNull);
        expect(tokens.iconSize, isNotNull);
        expect(tokens.color, isNotNull);
      });

      testWidgets('DropdownTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.dropdownTokens(DropdownVariant.outlined);

        expect(tokens.borderColor, isNotNull);
        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.textStyle, isNotNull);
      });

      testWidgets('TabBarTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.tabBarTokens(TabBarVariant.underlined);

        expect(tokens.selectedColor, isNotNull);
        expect(tokens.unselectedColor, isNotNull);
        expect(tokens.indicatorColor, isNotNull);
      });

      testWidgets('BottomNavTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.bottomNavTokens(BottomNavVariant.standard);

        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.selectedColor, isNotNull);
        expect(tokens.unselectedColor, isNotNull);
      });

      testWidgets('AppBarTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.appBarTokens(AppBarVariant.primary);

        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.foregroundColor, isNotNull);
        expect(tokens.elevation, isNotNull);
      });

      testWidgets('ChipTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.chipTokens(ChipVariant.filled);

        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.textStyle, isNotNull);
        expect(tokens.padding, isNotNull);
      });

      testWidgets('BadgeTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.badgeTokens(BadgeVariant.count);

        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.textStyle, isNotNull);
        expect(tokens.size, isNotNull);
      });

      testWidgets('AvatarTokens derived from foundation', (tester) async {
        const style = MaterialStyle();
        final tokens = style.avatarTokens(AvatarVariant.circle);

        expect(tokens.backgroundColor, isNotNull);
        expect(tokens.textStyle, isNotNull);
        expect(tokens.size, isNotNull);
      });
    });

    group('Style Switching', () {
      testWidgets('AppIconButton responds to style changes', (tester) async {
        final style = ValueNotifier<DesignStyle>(const MaterialStyle());

        await tester.pumpWidget(
          ValueListenableBuilder<DesignStyle>(
            valueListenable: style,
            builder: (context, currentStyle, _) {
              return MaterialApp(
                home: AppTheme(
                  style: currentStyle,
                  child: Scaffold(
                    body: AppIconButton(
                      icon: 'add',
                      onPressed: () {},
                    ),
                  ),
                ),
              );
            },
          ),
        );

        expect(find.byType(IconButton), findsOneWidget);

        // Switch to Cupertino
        style.value = const CupertinoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(CupertinoButton), findsOneWidget);

        // Switch to Neo
        style.value = const NeoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(AppIconButton), findsOneWidget);
      });

      testWidgets('AppDropdown responds to style changes', (tester) async {
        final style = ValueNotifier<DesignStyle>(const MaterialStyle());
        final items = [
          const DropdownItem(value: 'a', label: 'Option A'),
          const DropdownItem(value: 'b', label: 'Option B'),
        ];

        await tester.pumpWidget(
          ValueListenableBuilder<DesignStyle>(
            valueListenable: style,
            builder: (context, currentStyle, _) {
              return MaterialApp(
                home: AppTheme(
                  style: currentStyle,
                  child: Scaffold(
                    body: AppDropdown<String>(
                      value: 'a',
                      items: items,
                      onChanged: (_) {},
                    ),
                  ),
                ),
              );
            },
          ),
        );

        expect(find.byType(DropdownButton<String>), findsOneWidget);

        // Switch to Cupertino
        style.value = const CupertinoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(GestureDetector), findsWidgets);

        // Switch to Neo
        style.value = const NeoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(AppDropdown<String>), findsOneWidget);
      });

      testWidgets('AppAvatar responds to style changes', (tester) async {
        final style = ValueNotifier<DesignStyle>(const MaterialStyle());

        await tester.pumpWidget(
          ValueListenableBuilder<DesignStyle>(
            valueListenable: style,
            builder: (context, currentStyle, _) {
              return MaterialApp(
                home: AppTheme(
                  style: currentStyle,
                  child: const Scaffold(
                    body: AppAvatar(initials: 'AB'),
                  ),
                ),
              );
            },
          ),
        );

        expect(find.byType(CircleAvatar), findsOneWidget);

        // Switch to Cupertino
        style.value = const CupertinoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(Container), findsWidgets);

        // Switch to Neo
        style.value = const NeoStyle();
        await tester.pumpAndSettle();

        expect(find.byType(AppAvatar), findsOneWidget);
      });
    });
  });
}
