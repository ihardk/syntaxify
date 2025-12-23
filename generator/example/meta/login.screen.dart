import 'package:syntaxify/syntaxify.dart';

/// Login screen definition
///
/// This demonstrates Syntaxify's screen generation feature.
/// Run `syntaxify build` to generate lib/screens/login_screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  layout: App.column(
    mainAxisAlignment: MainAlignment.center,
    crossAxisAlignment: CrossAlignment.stretch,
    children: [
      App.text(
        text: 'Welcome Back',
        variant: TextVariant.headlineMedium,
      ),
      App.spacer(flex: 1),
      App.textField(
        label: 'Email',
        keyboardType: KeyboardType.email,
      ),
      App.textField(
        label: 'Password',
        obscureText: true,
      ),
      App.spacer(flex: 1),
      App.button(
        label: 'Sign In',
        onPressed: 'handleLogin',
      ),
    ],
  ),
);
