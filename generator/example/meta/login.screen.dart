import 'package:forge/forge.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: AppBarNode(
    title: 'Login',
  ),
  layout: AstNode.column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AstNode.text(
        text: 'Welcome Back',
        variant: TextVariant.headlineMedium,
      ),
      AstNode.spacer(flex: 1),
      AstNode.textField(
        label: 'Username',
        hint: 'user@example.com',
        keyboardType: KeyboardType.email,
      ),
      AstNode.textField(
        label: 'Password',
        obscureText: true,
      ),
      AstNode.spacer(flex: 2),
      AstNode.button(
        label: 'Sign In',
        variant: ButtonVariant.filled,
        onPressed: 'onSignIn',
      ),
      AstNode.button(
        label: 'Forgot Password?',
        variant: ButtonVariant.text,
        onPressed: 'onForgot',
      ),
    ],
  ),
);
