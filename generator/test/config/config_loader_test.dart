import 'dart:io';
import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';

void main() {
  group('ConfigLoader', () {
    late ConfigLoader loader;
    late Directory tempDir;

    setUp(() {
      loader = const ConfigLoader();
      tempDir = Directory.systemTemp.createTempSync('syntaxify_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('returns default config when no file exists', () {
      final config = loader.load(cwd: tempDir.path);

      expect(config.metaDir, equals('meta'));
      expect(config.outputDir, equals('lib/syntaxify'));
      expect(config.designSystemDir, equals('lib/syntaxify/design_system'));
      expect(config.tokensDir, equals('lib/syntaxify/design_system'));
      expect(config.generateScreens, isTrue);
      expect(config.generateComponents, isTrue);
    });

    test('parses valid syntaxify.yaml', () {
      final configFile = File('${tempDir.path}/syntaxify.yaml');
      configFile.writeAsStringSync('''
meta: custom_meta
output: lib/generated
design_system: lib/design
tokens: lib/tokens
generate:
  screens: false
  components: true
''');

      final config = loader.load(cwd: tempDir.path);

      expect(config.metaDir, equals('custom_meta'));
      expect(config.outputDir, equals('lib/generated'));
      expect(config.designSystemDir, equals('lib/design'));
      expect(config.tokensDir, equals('lib/tokens'));
      expect(config.generateScreens, isFalse);
      expect(config.generateComponents, isTrue);
    });

    test('uses defaults for missing fields', () {
      final configFile = File('${tempDir.path}/syntaxify.yaml');
      configFile.writeAsStringSync('''
meta: my_meta
''');

      final config = loader.load(cwd: tempDir.path);

      expect(config.metaDir, equals('my_meta'));
      expect(config.outputDir, equals('lib/syntaxify')); // default
      expect(config.generateScreens, isTrue); // default
    });

    test('handles empty file gracefully', () {
      final configFile = File('${tempDir.path}/syntaxify.yaml');
      configFile.writeAsStringSync('');

      final config = loader.load(cwd: tempDir.path);

      expect(config.metaDir, equals('meta')); // default
    });

    test('handles malformed YAML gracefully', () {
      final configFile = File('${tempDir.path}/syntaxify.yaml');
      configFile.writeAsStringSync('invalid: [yaml: content');

      // Should not throw, returns defaults
      final config = loader.load(cwd: tempDir.path);
      expect(config.metaDir, equals('meta'));
    });

    group('merge', () {
      test('CLI args override file config', () {
        final fileConfig = SyntaxifyConfig(
          metaDir: 'file_meta',
          outputDir: 'file_output',
        );

        final merged = loader.merge(
          fileConfig,
          metaDir: 'cli_meta',
        );

        expect(merged.metaDir, equals('cli_meta')); // CLI wins
        expect(merged.outputDir, equals('file_output')); // file preserved
      });

      test('null CLI args preserve file values', () {
        final fileConfig = SyntaxifyConfig(
          metaDir: 'file_meta',
          outputDir: 'file_output',
        );

        final merged = loader.merge(fileConfig);

        expect(merged.metaDir, equals('file_meta'));
        expect(merged.outputDir, equals('file_output'));
      });
    });
  });
}
