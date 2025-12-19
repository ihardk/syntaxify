// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';
import 'package:example/syntaxify/design_system/design_system.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.handleLogin,
  });

  final VoidCallback? handleLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      AppText(
        text: 'Welcome Back',
        variant: TextVariant.bodyMedium,
      ),
      AppInput(
        label: 'Email',
        keyboardType: TextInputType.emailAddress,
      ),
      AppInput(
        label: 'Password',
        obscureText: true,
      ),
      AppButton(
        label: 'Sign In',
        onPressed: handleLogin,
      ),
    ]));
  }
}
