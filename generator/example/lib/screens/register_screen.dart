// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';
import 'package:example/syntaxify/design_system/design_system.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, this.handleRegister, this.navigateToLogin});

  final VoidCallback? handleRegister;

  final VoidCallback? navigateToLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Column(
        children: [
          AppText(text: 'Join Us Today', variant: TextVariant.headlineMedium),
          AppText(
            text: 'Create your account to get started',
            variant: TextVariant.bodyMedium,
          ),
          Spacer(),
          AppInput(label: 'Full Name', hint: 'Enter your full name'),
          AppInput(
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          AppInput(
            label: 'Password',
            hint: 'Create a password',
            obscureText: true,
          ),
          AppInput(
            label: 'Confirm Password',
            hint: 'Confirm your password',
            obscureText: true,
          ),
          Spacer(),
          AppButton(label: 'Create Account', onPressed: handleRegister),
          Spacer(),
          AppButton(
            label: 'Already have an account? Sign In',
            onPressed: navigateToLogin,
            variant: ButtonVariant.text,
          ),
        ],
      ),
    );
  }
}
