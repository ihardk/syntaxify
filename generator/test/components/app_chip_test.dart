import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppChip', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppChip(label: 'Test Chip'),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
      expect(find.text('Test Chip'), findsOneWidget);
    });

    testWidgets('renders filled variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppChip(
                label: 'Filled',
                variant: ChipVariant.filled,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('renders outlined variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppChip.outlined(
                label: 'Outlined',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppChip(
                label: 'With Icon',
                icon: 'star',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('handles delete callback', (tester) async {
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppChip(
                label: 'Deletable',
                onDeleted: () {
                  deleted = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('handles selected state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppChip(
                label: 'Selected',
                selected: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: const Scaffold(
              body: AppChip(label: 'Cupertino'),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: const Scaffold(
              body: AppChip(label: 'Neo'),
            ),
          ),
        ),
      );

      expect(find.byType(AppChip), findsOneWidget);
    });
  });
}
