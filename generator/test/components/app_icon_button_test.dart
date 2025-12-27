import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppIconButton', () {
    testWidgets('renders filled variant correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton.filled(
                icon: 'home',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('renders outlined variant correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton.outlined(
                icon: 'settings',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('renders standard variant correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'menu',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('handles disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'delete',
                isDisabled: true,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('handles null onPressed (disabled)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'lock',
                onPressed: null,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('accepts custom size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'star',
                size: 32.0,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('accepts custom color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'favorite',
                color: Colors.red,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('renders with tooltip', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'help',
                tooltip: 'Help',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'home',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: Scaffold(
              body: AppIconButton(
                icon: 'home',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppIconButton), findsOneWidget);
    });
  });
}
