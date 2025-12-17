import 'package:code_builder/code_builder.dart';
import 'package:forge/src/parser/registry_parser.dart';

class IconRegistryGenerator {
  IconRegistryGenerator();

  Library build(RegistryDefinition definition) {
    return Library((b) => b
      ..directives.add(Directive.import('package:flutter/material.dart'))
      ..body.add(
        Class((c) => c
          ..name = 'AppIcons'
          ..docs.add('/// Generated Icon Registry from ${definition.className}')
          ..fields.add(
            Field((f) => f
              ..name = '_registry'
              ..static = true
              ..modifier = FieldModifier.constant
              ..type = refer('Map<String, IconData>')
              ..assignment = literalMap(
                definition.mappings.map(
                  (key, value) => MapEntry(
                    literalString(key),
                    refer(value), // e.g. refer('Icons.home')
                  ),
                ),
              ).code),
          )
          ..methods.add(
            Method((m) => m
              ..name = 'get'
              ..static = true
              ..returns = refer('IconData?')
              ..requiredParameters.add(
                Parameter((p) => p
                  ..name = 'name'
                  ..type = refer('String?')),
              )
              ..body = refer('_registry').index(refer('name')).code
              ..lambda = true),
          )),
      ));
  }
}
