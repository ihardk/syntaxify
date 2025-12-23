import 'package:example/syntaxify/design_system/design_system.dart'
    hide TextVariant;
import 'package:syntaxify/syntaxify.dart';

/// Registration screen definition
final registerScreen = ScreenDefinition(
  id: 'register',
  appBar: const App.appBar(title: 'Create Account'),
  layout: App.column(
    children: [
      App.text(
        text: 'Join Us Today',
        variant: 'headlineMedium',
      ),
      App.text(
        text: 'Create your account to get started',
        variant: 'bodyMedium',
      ),
      App.spacer(size: SpacerSize.lg),
      App.textField(
        label: 'Full Name',
        hint: 'Enter your full name',
      ),
      App.textField(
        label: 'Email',
        hint: 'Enter your email',
        keyboardType: KeyboardType.email,
      ),
      App.textField(
        label: 'Password',
        hint: 'Create a password',
        obscureText: true,
      ),
      App.textField(
        label: 'Confirm Password',
        hint: 'Confirm your password',
        obscureText: true,
      ),
      App.spacer(size: SpacerSize.lg),
      App.button(
        label: 'Create Account',
        variant: ButtonVariant.primary.name,
        onPressed: 'handleRegister',
      ),
      App.spacer(size: SpacerSize.md),
      App.button(
        label: 'Already have an account? Sign In',
        variant: ButtonVariant.secondary.name,
        onPressed: 'navigateToLogin',
      ),
    ],
  ),
);
