// GENERATED CODE
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';
import 'package:example/syntaxify/design_system/design_system.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.handleRegister, this.navigateToLogin});

  final VoidCallback? handleRegister;

  final VoidCallback? navigateToLogin;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _fullNameController;

  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(text: 'Create Account')),
      body: Column(
        children: [
          AppText(text: 'Join Us Today', variant: TextVariant.headlineMedium),
          AppText(
            text: 'Create your account to get started',
            variant: TextVariant.bodyMedium,
          ),
          Spacer(),
          AppInput(
            label: 'Full Name',
            controller: _fullNameController,
            hint: 'Enter your full name',
          ),
          AppInput(
            label: 'Email',
            controller: _emailController,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          AppInput(
            label: 'Password',
            controller: _passwordController,
            hint: 'Create a password',
            obscureText: true,
          ),
          AppInput(
            label: 'Confirm Password',
            controller: _confirmPasswordController,
            hint: 'Confirm your password',
            obscureText: true,
          ),
          Spacer(),
          AppButton(
            label: 'Create Account',
            onPressed: widget.handleRegister,
            variant: ButtonVariant.primary,
          ),
          Spacer(),
          AppButton(
            label: 'Already have an account? Sign In',
            onPressed: widget.navigateToLogin,
            variant: ButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
