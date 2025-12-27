import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syntaxify/src/design_system/design_system.dart';

void main() {
  group('AppAvatar', () {
    testWidgets('renders with initials', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'AB',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders circle variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'CD',
                variant: AvatarVariant.circle,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('renders square variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar.square(
                initials: 'EF',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('accepts custom size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'GH',
                size: 60.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('accepts custom background color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'IJ',
                backgroundColor: Colors.purple,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('renders with image URL', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(
                imageSrc: 'https://example.com/avatar.jpg',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('renders default icon when no initials or image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const MaterialStyle(),
            child: const Scaffold(
              body: AppAvatar(),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('works with CupertinoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const CupertinoStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'KL',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('works with NeoStyle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppTheme(
            style: const NeoStyle(),
            child: const Scaffold(
              body: AppAvatar(
                initials: 'MN',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });
  });
}
