import 'package:syntax/syntax.dart';

/// Login screen definition
///
/// This demonstrates Syntax's screen generation feature.
/// Run `syntax build` to generate lib/screens/login_screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      AstNode.text(
        text: 'Welcome Back',
        variant: TextVariant.headlineMedium,
      ),
      AstNode.spacer(flex: 1),
      AstNode.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      AstNode.textField(
        label: 'Password',
        obscureText: true,
      ),
      AstNode.spacer(flex: 1),
      AstNode.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
