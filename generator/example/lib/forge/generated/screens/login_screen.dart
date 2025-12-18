// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Forge

import 'package:flutter/material.dart' hide AppTheme;
import '../../../forge/index.dart';
import '../../../forge/design_system/design_system.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.onSignIn,
    this.onForgot,
  });

  final VoidCallback? onSignIn;

  final VoidCallback? onForgot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(children: [
        Spacer(flex: 1),
        AppInput(
          label: 'Username',
          hint: 'user@example.com',
          controller: TextEditingController(),
        ),
        AppInput(
          label: 'Password',
          obscureText: true,
        ),
        Spacer(flex: 2),
        AppButton(
          label: 'Sign In',
          onPressed: onSignIn,
        ),
        AppButton(
          label: 'Forgot Password?',
          onPressed: onForgot,
          variant: ButtonVariant.primary,
        ),
      ]),
    );
  }
}
