/// Abstract interface for code formatting.
///
/// Allows swapping formatters or disabling formatting in tests.
abstract class CodeFormatter {
  /// Format Dart source code.
  String format(String code);
}
