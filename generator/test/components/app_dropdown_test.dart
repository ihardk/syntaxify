import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppDropdown', () {
    final stringItems = [
      const DropdownItem(value: 'a', label: 'Option A'),
      const DropdownItem(value: 'b', label: 'Option B'),
      const DropdownItem(value: 'c', label: 'Option C'),
    ];

    testWidgets('renders with String type', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('renders standard variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
                variant: DropdownVariant.standard,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('renders outlined variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>.outlined(
                value: 'b',
                items: stringItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('renders underlined variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>.underlined(
                value: 'c',
                items: stringItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('handles int type correctly', (tester) async {
      final intItems = [
        const DropdownItem(value: 1, label: 'One'),
        const DropdownItem(value: 2, label: 'Two'),
        const DropdownItem(value: 3, label: 'Three'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<int>(
                value: 1,
                items: intItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<int>), findsOneWidget);
    });

    testWidgets('shows label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
                label: 'Select Option',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('shows hint when no value selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: null,
                items: stringItems,
                onChanged: (_) {},
                hint: 'Please select',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('displays error text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
                errorText: 'Invalid selection',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('handles disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
                enabled: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: Scaffold(
              body: AppDropdown<String>(
                value: 'a',
                items: stringItems,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppDropdown<String>), findsOneWidget);
    });
  });

  group('DropdownItem', () {
    test('equality works correctly', () {
      const item1 = DropdownItem(value: 'a', label: 'Option A');
      const item2 = DropdownItem(value: 'a', label: 'Option A');
      const item3 = DropdownItem(value: 'b', label: 'Option B');

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });

    test('hashCode works correctly', () {
      const item1 = DropdownItem(value: 'a', label: 'Option A');
      const item2 = DropdownItem(value: 'a', label: 'Option A');

      expect(item1.hashCode, equals(item2.hashCode));
    });
  });
}
