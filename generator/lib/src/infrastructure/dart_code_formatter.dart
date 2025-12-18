import 'package:dart_style/dart_style.dart';

import 'package:syntax/src/core/interfaces/code_formatter.dart';

/// Dart code formatter using dart_style package.
class DartCodeFormatter implements CodeFormatter {
  final _formatter = DartFormatter();

  @override
  String format(String code) {
    try {
      return _formatter.format(code);
    } catch (e) {
      // Return unformatted code if formatting fails
      return code;
    }
  }
}

/// No-op formatter for testing.
///
/// Returns code unchanged - useful for testing output
/// without formatting overhead.
class NoOpFormatter implements CodeFormatter {
  @override
  String format(String code) => code;
}
