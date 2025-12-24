library;

import 'package:flutter/material.dart';
import 'package:syntaxify/syntaxify.dart';

@SyntaxComponent(description: 'A design-system-aware checkbox component')
class SuperCardMeta {
  bool value;
  SuperCardMeta({this.value = true});
}
