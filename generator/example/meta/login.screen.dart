import 'package:syntaxify/syntaxify.dart';

/// Login screen definition
///
/// This demonstrates Syntaxify's screen generation feature.
/// Run `syntaxify build` to generate lib/screens/login_screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: LayoutNode.column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      LayoutNode.text(
        text: 'Welcome Back',
        variant: TextVariant.headlineMedium,
      ),
      LayoutNode.spacer(flex: 1),
      LayoutNode.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      LayoutNode.textField(
        label: 'Password',
        obscureText: true,
      ),
      LayoutNode.spacer(flex: 1),
      LayoutNode.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
