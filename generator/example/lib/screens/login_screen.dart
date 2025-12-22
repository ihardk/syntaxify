// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';
import 'package:example/syntaxify/design_system/design_system.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.handleLogin});

  final VoidCallback? handleLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppText(text: 'Welcome Back', variant: TextVariant.headlineMedium),
          Spacer(flex: 1),
          AppInput(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          AppInput(
            label: 'Password',
            controller: _passwordController,
            obscureText: true,
          ),
          Spacer(flex: 1),
          AppButton(
            label: 'Sign In',
            onPressed: widget.handleLogin,
            variant: ButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}
