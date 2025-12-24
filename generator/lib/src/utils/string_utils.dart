/// String utility functions for case conversion.
///
/// Provides shared methods for converting strings between different
/// naming conventions used in code generation.
class StringUtils {
  const StringUtils._();

  /// Converts a string to PascalCase (e.g., 'my_class' → 'MyClass').
  static String toPascalCase(String input) {
    if (input.isEmpty) return '';
    return input
        .split('_')
        .map((s) => s.isNotEmpty
            ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
            : '')
        .join('');
  }

  /// Converts a string to camelCase (e.g., 'my_variable' → 'myVariable').
  static String toCamelCase(String input) {
    if (input.isEmpty) return '';
    // Remove non-alphanumeric and convert to camelCase
    final parts = input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ').split(' ');
    if (parts.isEmpty) return 'input';
    return parts.first.toLowerCase() +
        parts
            .skip(1)
            .map((s) => s.isNotEmpty
                ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
                : '')
            .join('');
  }

  /// Converts a string to snake_case (e.g., 'MyClass' → 'my_class').
  static String toSnakeCase(String input) {
    if (input.isEmpty) return '';
    return input
        .replaceAllMapped(
          RegExp('([A-Z])'),
          (match) => '_${match.group(1)!.toLowerCase()}',
        )
        .replaceFirst('_', '');
  }

  /// Converts a string to kebab-case (e.g., 'MyClass' → 'my-class').
  static String toKebabCase(String input) {
    return toSnakeCase(input).replaceAll('_', '-');
  }
}
