import 'package:syntax/syntax.dart';

final loginScreen = ScreenDefinition(
  id: 'login',
  layout: AstNode.column(
    children: [
      AstNode.text(text: 'Welcome Back'),
      AstNode.textField(label: 'Email', keyboardType: KeyboardType.email),
      AstNode.button(label: 'Sign In', onPressed: 'handleLogin'),
    ],
  ),
);
