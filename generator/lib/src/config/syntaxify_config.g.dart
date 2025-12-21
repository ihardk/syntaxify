// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syntaxify_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyntaxifyConfig _$SyntaxifyConfigFromJson(Map<String, dynamic> json) =>
    _SyntaxifyConfig(
      metaDir: json['metaDir'] as String? ?? 'meta',
      outputDir: json['outputDir'] as String? ?? 'lib/syntaxify',
      designSystemDir:
          json['designSystemDir'] as String? ?? 'lib/syntaxify/design_system',
      tokensDir: json['tokensDir'] as String? ?? 'lib/syntaxify/design_system',
      generateScreens: json['generateScreens'] as bool? ?? true,
      generateComponents: json['generateComponents'] as bool? ?? true,
    );

Map<String, dynamic> _$SyntaxifyConfigToJson(_SyntaxifyConfig instance) =>
    <String, dynamic>{
      'metaDir': instance.metaDir,
      'outputDir': instance.outputDir,
      'designSystemDir': instance.designSystemDir,
      'tokensDir': instance.tokensDir,
      'generateScreens': instance.generateScreens,
      'generateComponents': instance.generateComponents,
    };
