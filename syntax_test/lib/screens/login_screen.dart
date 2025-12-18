// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntax

import 'package:flutter/material.dart';
import 'package:syntax_test/syntax/index.dart';
import 'package:syntax_test/syntax/design_system/design_system.dart';

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
      AppButton(
        label: 'Sign In',
        onPressed: handleLogin,
      ),
    ]));
  }
}
