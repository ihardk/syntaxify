// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Forge

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(children: [
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Spacer(),
        TextField(decoration: InputDecoration(labelText: 'Username')),
        TextField(decoration: InputDecoration(labelText: 'Password')),
        Spacer(),
        ElevatedButton(
          onPressed: null,
          child: Text('Sign In'),
        ),
      ]),
    );
  }
}
