import 'dart:io';

import 'package:test/test.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:forge/src/parser/meta_parser.dart';

void main() {
  group('MetaParser Enum Parsing', () {
    late MetaParser parser;
    late Logger logger;
    late Directory tempDir;

    setUp(() {
      logger = Logger(level: Level.quiet);
      parser = MetaParser(logger: logger);
      tempDir = Directory.systemTemp.createTempSync('enum_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('parses enums from meta file', () async {
      final file = File('${tempDir.path}/button.meta.dart');
      await file.writeAsString('''
import 'package:forge/forge.dart';

@ForgeComponent
class ButtonMeta {
  final String label;
  final ButtonVariant variant;
}

enum ButtonVariant {
  primary,
  secondary,
  text,
}

enum ButtonSize {
  small,
  medium,
  large,
}
''');

      final result = await parser.parseDirectory(tempDir);

      expect(result.hasErrors, isFalse);
      expect(result.nodes.length, equals(1));

      // Verify Enums
      expect(result.enums.length, equals(2));

      final variantEnum =
          result.enums.firstWhere((e) => e.name == 'ButtonVariant');
      expect(variantEnum.values, containsAll(['primary', 'secondary', 'text']));

      final sizeEnum = result.enums.firstWhere((e) => e.name == 'ButtonSize');
      expect(sizeEnum.values, containsAll(['small', 'medium', 'large']));
    });
  });
}
