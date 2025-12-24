import 'package:syntaxify/syntaxify.dart';

// Create meta/login.screen.dart
final loginScreen = ScreenDefinition(
  id: 'login',
  appBar: App.appBar(title: 'Login'),
  layout: App.column(
    children: [
      App.text(text: 'Welcome', variant: 'headlineMedium'),
      App.textField(label: 'Email', keyboardType: KeyboardType.email),
      App.textField(label: 'Password', obscureText: true),

      // New Interactive Components
      App.checkbox(label: 'Remember me', binding: 'rememberMe'),
      App.toggle(label: 'Dark Mode', binding: 'isDarkMode'),
      App.slider(min: 0, max: 100, binding: 'volume'),

      App.button(label: 'Login', onPressed: 'handleLogin'),
    ],
  ),
);
