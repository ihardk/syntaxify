import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/parser/registry_parser.dart';

class ImageRegistryGenerator {
  ImageRegistryGenerator();

  Library build(RegistryDefinition definition) {
    return Library((b) => b
      ..directives.add(Directive.import('package:flutter/material.dart'))
      ..body.add(
        Class((c) => c
          ..name = 'AppImages'
          ..docs.add('/// Generated Image Registry from ${definition.className}')
          ..fields.addAll(
            definition.mappings.entries.map(
              (entry) => Field((f) => f
                ..name = entry.key
                ..static = true
                ..modifier = FieldModifier.constant
                ..type = refer('String')
                ..assignment = literalString(entry.value).code),
            ),
          )),
      ));
  }
}
