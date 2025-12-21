import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error.freezed.dart';

/// Represents a validation error in a layout node.
///
/// Used by the LayoutValidator to report issues with layout definitions
/// before code generation, allowing early detection of errors.
@freezed
sealed class ValidationError with _$ValidationError {
  const factory ValidationError({
    /// The type of validation error
    required ValidationErrorType type,

    /// Human-readable error message
    required String message,

    /// Path to the problematic node (e.g., "column.children[0].button")
    String? nodePath,

    /// Field name that caused the error
    String? fieldName,

    /// Suggested fix for the error
    String? suggestion,

    /// Error severity level
    @Default(ErrorSeverity.error) ErrorSeverity severity,
  }) = _ValidationError;
}

/// Types of validation errors that can occur in layout nodes.
enum ValidationErrorType {
  /// Empty string value where content is expected (e.g., empty button label)
  emptyValue,

  /// Invalid Dart identifier name (e.g., contains hyphens or spaces)
  invalidIdentifier,

  /// Container node with no children (e.g., empty Column)
  emptyChildren,

  /// Mutually exclusive properties both set
  conflictingProperties,

  /// Enum value doesn't exist in the enum type
  invalidEnumValue,

  /// Negative value where positive number is expected
  negativeNumber,

  /// Value is outside the allowed range
  outOfRange,
}

/// Severity levels for validation errors.
enum ErrorSeverity {
  /// Error must be fixed - generated code won't be valid
  error,

  /// Warning should be fixed - might cause runtime issues
  warning,

  /// Info message - consider fixing for best practices
  info,
}
