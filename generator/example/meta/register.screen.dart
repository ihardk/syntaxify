import 'package:syntaxify/syntaxify.dart';

/// Registration screen definition
final registerScreen = ScreenDefinition(
  id: 'register',
  appBar: AstNode.appBar(title: 'Create Account'),
  layout: AstNode.column(
    children: [
      AstNode.text(
        text: 'Join Us Today',
        variant: TextVariant.headlineMedium,
      ),
      AstNode.text(
        text: 'Create your account to get started',
        variant: TextVariant.bodyMedium,
      ),
      AstNode.spacer(size: SpacerSize.lg),
      AstNode.textField(
        label: 'Full Name',
        hint: 'Enter your full name',
      ),
      AstNode.textField(
        label: 'Email',
        hint: 'Enter your email',
        keyboardType: KeyboardType.email,
      ),
      AstNode.textField(
        label: 'Password',
        hint: 'Create a password',
        obscureText: true,
      ),
      AstNode.textField(
        label: 'Confirm Password',
        hint: 'Confirm your password',
        obscureText: true,
      ),
      AstNode.spacer(size: SpacerSize.lg),
      AstNode.button(
        label: 'Create Account',
        variant: ButtonVariant.filled,
        onPressed: 'handleRegister',
      ),
      AstNode.spacer(size: SpacerSize.md),
      AstNode.button(
        label: 'Already have an account? Sign In',
        variant: ButtonVariant.text,
        onPressed: 'navigateToLogin',
      ),
    ],
  ),
);
