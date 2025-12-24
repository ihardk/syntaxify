// GENERATED CODE
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

  bool _rememberMe = false;

  bool _isDarkMode = false;

  double _volume = 0.0;

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
      appBar: AppBar(title: AppText(text: 'Login')),
      body: Column(
        children: [
          AppText(text: 'Welcome', variant: TextVariant.headlineMedium),
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
          Row(
            children: [
              AppCheckbox(
                value: _rememberMe,
                onChanged: (value) =>
                    setState(() => _rememberMe = value ?? false),
              ),
              SizedBox(width: 8),
              Text('Remember me'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Mode'),
              AppToggle(
                value: _isDarkMode,
                onChanged: (value) => setState(() => _isDarkMode = value),
              ),
            ],
          ),
          AppSlider(
            value: _volume,
            onChanged: (value) => setState(() => _volume = value),
            min: 0.0,
            max: 100.0,
          ),
          AppButton(
            label: 'Login',
            onPressed: widget.handleLogin,
            variant: ButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}
