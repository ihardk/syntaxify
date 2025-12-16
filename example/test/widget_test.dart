import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('MetaDemo renders and switches styles',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MetaDemo()));

    expect(find.text('CLICK ME'), findsOneWidget); // Button
    expect(find.text('NEW ARRIVAL'), findsOneWidget); // Badge
    expect(find.text('Type something...'), findsOneWidget); // Input
    expect(find.text('Meta Card Title'), findsOneWidget); // Card header

    // Verify interactivity
    await tester.enterText(find.byType(TextField), 'Hello Meta');
    await tester.pump();
    expect(find.text('You typed: Hello Meta'), findsOneWidget);

    // Verify Material style radio is present
    expect(find.text('MATERIAL'), findsOneWidget);

    // Tap the Neo radio button
    await tester.tap(find.text('NEO'));
    await tester.pump();

    // Verify button is still there (logic holds)
    expect(find.text('CLICK ME'), findsOneWidget);
  });
}
