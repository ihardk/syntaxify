import 'package:example/syntaxify/design_system/design_system.dart';
import 'package:syntaxify/syntaxify.dart';

/// Registration screen definition
final registerScreen = ScreenDefinition(
  id: 'register',
  appBar: const LayoutNode.appBar(title: 'Create Account'),
  layout: LayoutNode.column(
    children: [
      LayoutNode.text(
        text: 'Join Us Today',
        variant: TextVariant.headlineMedium,
      ),
      LayoutNode.text(
        text: 'Create your account to get started',
        variant: TextVariant.bodyMedium,
      ),
      LayoutNode.spacer(size: SpacerSize.lg),
      LayoutNode.textField(
        label: 'Full Name',
        hint: 'Enter your full name',
      ),
      LayoutNode.textField(
        label: 'Email',
        hint: 'Enter your email',
        keyboardType: KeyboardType.email,
      ),
      LayoutNode.textField(
        label: 'Password',
        hint: 'Create a password',
        obscureText: true,
      ),
      LayoutNode.textField(
        label: 'Confirm Password',
        hint: 'Confirm your password',
        obscureText: true,
      ),
      LayoutNode.spacer(size: SpacerSize.lg),
      LayoutNode.button(
        label: 'Create Account',
        variant: ButtonVariant.primary.name,
        onPressed: 'handleRegister',
      ),
      LayoutNode.spacer(size: SpacerSize.md),
      LayoutNode.button(
        label: 'Already have an account? Sign In',
        variant: ButtonVariant.secondary.name,
        onPressed: 'navigateToLogin',
      ),
    ],
  ),
);
