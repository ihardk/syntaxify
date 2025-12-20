import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/generators/screen_generator.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/ast/screen_definition.dart';
import 'package:test/test.dart';

void main() {
  group('ScreenGenerator', () {
    final generator = ScreenGenerator();

    test('generates a simple screen with AppBar and Body', () {
      final screen = ScreenDefinition(
        id: 'login',
        appBar: AppBarNode(title: 'Login'),
        layout: LayoutNode.column(
          children: [
            LayoutNode.text(text: 'Welcome'),
            LayoutNode.button(label: 'Sign In', variant: ButtonVariant.filled),
          ],
        ),
      );

      final code = generator.generate(screen);

      // Verify Imports
      expect(code, contains("import 'package:flutter/material.dart';"));
      // Expect relative imports
      expect(code, contains("import '../index.dart';"));
      expect(code, contains("import '../design_system/design_system.dart';"));

      // Verify Class Definition
      expect(code, contains('class LoginScreen extends StatelessWidget'));

      // Verify Fields (VoidCallback for button action 'submit') - TODO: Parse actions from AST
      // For now, let's just ensure basic structure correct with new AppButton

      // Verify Build Method
      expect(code, contains('Widget build(BuildContext context)'));

      // Verify Scaffold
      expect(code, contains('return Scaffold('));

      // Verify AppBar
      expect(code, contains('appBar: AppBar('));
      expect(code, contains("title: Text('Login')"));

      // Verify Body
      expect(code, contains('body: Column('));
      expect(code, contains("children: ["));
      expect(code, contains("Text('Welcome')"));
      // Verify AppButton emission
      expect(code, contains("AppButton("));
      expect(code, contains("label: 'Sign In'"));
    });

    test('generates screen without AppBar', () {
      final screen = ScreenDefinition(
        id: 'splash',
        layout: LayoutNode.text(text: 'Loading...'),
      );

      final code = generator.generate(screen);

      expect(code, contains('class SplashScreen extends StatelessWidget'));
      expect(code, contains('return Scaffold('));
      expect(code, isNot(contains('appBar:')));
      expect(code, contains("body: Text('Loading...')"));
    });
  });
}
