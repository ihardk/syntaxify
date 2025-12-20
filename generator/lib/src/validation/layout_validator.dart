import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/validation_error.dart';

/// Validates layout nodes for correctness before code generation.
///
/// This validator catches common errors early:
/// - Empty values (labels, text)
/// - Invalid Dart identifiers (callback names)
/// - Empty containers
/// - Conflicting properties
///
/// Example usage:
/// ```dart
/// final validator = LayoutValidator();
/// final errors = validator.validate(layoutNode);
/// if (errors.isNotEmpty) {
///   // Handle validation errors
///   for (final error in errors) {
///     print('${error.severity.name}: ${error.message}');
///   }
/// }
/// ```
class LayoutValidator {
  const LayoutValidator();

  /// Validates a layout node and all its children.
  ///
  /// Returns a list of validation errors. An empty list means the node is valid.
  ///
  /// [node] - The layout node to validate
  /// [path] - The path to this node (used for error reporting)
  List<ValidationError> validate(LayoutNode node, [String path = 'root']) {
    return node.map(
      column: (n) => _validateColumn(n, path),
      row: (n) => _validateRow(n, path),
      button: (n) => _validateButton(n, path),
      text: (n) => _validateText(n, path),
      textField: (n) => _validateTextField(n, path),
      icon: (n) => _validateIcon(n, path),
      spacer: (n) => _validateSpacer(n, path),
      appBar: (n) => _validateAppBar(n, path),
    );
  }

  /// Validates a button node.
  List<ValidationError> _validateButton(ButtonNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.button';

    // Rule: Label cannot be empty
    if (node.label.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Button label cannot be empty',
        nodePath: nodePath,
        fieldName: 'label',
        suggestion: 'Provide a non-empty label like "Submit" or "Cancel"',
      ));
    }

    // Rule: onPressed must be valid Dart identifier if provided
    if (node.onPressed != null && node.onPressed!.isNotEmpty) {
      if (!_isValidDartIdentifier(node.onPressed!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'onPressed must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'onPressed',
          suggestion:
              'Use camelCase names like "handleSubmit" instead of "${node.onPressed}"',
        ));
      }
    }

    // Rule: Icon name should be provided if iconPosition is set
    if (node.iconPosition != null && (node.icon == null || node.icon!.isEmpty)) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Icon name must be provided when iconPosition is set',
        nodePath: nodePath,
        fieldName: 'icon',
        suggestion: 'Provide an icon name or remove the iconPosition property',
        severity: ErrorSeverity.warning,
      ));
    }

    return errors;
  }

  /// Validates a column node.
  List<ValidationError> _validateColumn(ColumnNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.column';

    // Rule: Column should have at least one child (warning)
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Column has no children',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add child widgets like LayoutNode.text() or LayoutNode.button()',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (int i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath.children[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a row node.
  List<ValidationError> _validateRow(RowNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.row';

    // Rule: Row should have at least one child (warning)
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Row has no children',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add child widgets like LayoutNode.text() or LayoutNode.button()',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (int i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath.children[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a text node.
  List<ValidationError> _validateText(TextNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.text';

    // Rule: Text content cannot be empty
    if (node.text.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Text content cannot be empty',
        nodePath: nodePath,
        fieldName: 'text',
        suggestion: 'Provide non-empty text content or use a Spacer instead',
      ));
    }

    // Rule: maxLines should be positive if provided
    if (node.maxLines != null && node.maxLines! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLines must be a positive number',
        nodePath: nodePath,
        fieldName: 'maxLines',
        suggestion: 'Use a positive integer like 1, 2, or 3',
      ));
    }

    // Rule: maxLines = 1 with overflow = visible might cause issues (info)
    if (node.maxLines == 1 && node.overflow == TextOverflow.visible) {
      errors.add(ValidationError(
        type: ValidationErrorType.conflictingProperties,
        message: 'maxLines=1 with overflow=visible may cause layout issues',
        nodePath: nodePath,
        suggestion: 'Consider using TextOverflow.ellipsis instead',
        severity: ErrorSeverity.info,
      ));
    }

    return errors;
  }

  /// Validates a text field node.
  List<ValidationError> _validateTextField(TextFieldNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.textField';

    // Rule: At least label or hint should be provided (warning)
    if ((node.label == null || node.label!.trim().isEmpty) &&
        (node.hint == null || node.hint!.trim().isEmpty)) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'TextField should have either a label or hint',
        nodePath: nodePath,
        suggestion: 'Provide a label or hint to guide the user',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: onChanged must be valid Dart identifier if provided
    if (node.onChanged != null && node.onChanged!.isNotEmpty) {
      if (!_isValidDartIdentifier(node.onChanged!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'onChanged must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'onChanged',
          suggestion:
              'Use camelCase names like "handleTextChanged" instead of "${node.onChanged}"',
        ));
      }
    }

    // Rule: onSubmitted must be valid Dart identifier if provided
    if (node.onSubmitted != null && node.onSubmitted!.isNotEmpty) {
      if (!_isValidDartIdentifier(node.onSubmitted!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'onSubmitted must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'onSubmitted',
          suggestion:
              'Use camelCase names like "handleSubmit" instead of "${node.onSubmitted}"',
        ));
      }
    }

    // Rule: maxLines should be positive if provided
    if (node.maxLines != null && node.maxLines! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLines must be a positive number',
        nodePath: nodePath,
        fieldName: 'maxLines',
        suggestion: 'Use a positive integer or remove maxLines',
      ));
    }

    // Rule: maxLength should be positive if provided
    if (node.maxLength != null && node.maxLength! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLength must be a positive number',
        nodePath: nodePath,
        fieldName: 'maxLength',
        suggestion: 'Use a positive integer or remove maxLength',
      ));
    }

    // Rule: binding must be valid Dart identifier if provided
    if (node.binding != null && node.binding!.isNotEmpty) {
      if (!_isValidDartIdentifier(node.binding!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'binding must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'binding',
          suggestion:
              'Use camelCase names like "emailController" instead of "${node.binding}"',
        ));
      }
    }

    return errors;
  }

  /// Validates an icon node.
  List<ValidationError> _validateIcon(IconNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.icon';

    // Rule: Icon name cannot be empty
    if (node.name.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Icon name cannot be empty',
        nodePath: nodePath,
        fieldName: 'name',
        suggestion: 'Provide a valid icon name like "home" or "settings"',
      ));
    }

    // Rule: Icon name should be valid identifier (warning)
    if (!_isValidIconName(node.name)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'Icon name should be a valid identifier',
        nodePath: nodePath,
        fieldName: 'name',
        suggestion: 'Use snake_case like "arrow_forward" or camelCase like "arrowForward"',
        severity: ErrorSeverity.warning,
      ));
    }

    return errors;
  }

  /// Validates a spacer node.
  List<ValidationError> _validateSpacer(SpacerNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.spacer';

    // Rule: flex should be positive if provided
    if (node.flex != null && node.flex! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'flex must be a positive number',
        nodePath: nodePath,
        fieldName: 'flex',
        suggestion: 'Use a positive integer like 1 or 2',
      ));
    }

    return errors;
  }

  /// Validates an app bar node.
  List<ValidationError> _validateAppBar(AppBarNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.appBar';

    // Rule: AppBar should have a title (warning)
    if (node.title == null || node.title!.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'AppBar should have a title',
        nodePath: nodePath,
        fieldName: 'title',
        suggestion: 'Provide a descriptive title for the app bar',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: leadingAction must be valid Dart identifier if provided
    if (node.leadingAction != null && node.leadingAction!.isNotEmpty) {
      if (!_isValidDartIdentifier(node.leadingAction!)) {
        errors.add(ValidationError(
          type: ValidationErrorType.invalidIdentifier,
          message: 'leadingAction must be a valid Dart identifier',
          nodePath: nodePath,
          fieldName: 'leadingAction',
          suggestion:
              'Use camelCase names like "handleBack" instead of "${node.leadingAction}"',
        ));
      }
    }

    // Validate actions
    if (node.actions != null) {
      for (int i = 0; i < node.actions!.length; i++) {
        final action = node.actions![i];
        final actionPath = '$nodePath.actions[$i]';

        // Rule: Action icon cannot be empty
        if (action.icon.trim().isEmpty) {
          errors.add(ValidationError(
            type: ValidationErrorType.emptyValue,
            message: 'AppBar action icon cannot be empty',
            nodePath: actionPath,
            fieldName: 'icon',
            suggestion: 'Provide an icon name like "search" or "settings"',
          ));
        }

        // Rule: Action onPressed must be valid Dart identifier
        if (action.onPressed.isEmpty || !_isValidDartIdentifier(action.onPressed)) {
          errors.add(ValidationError(
            type: ValidationErrorType.invalidIdentifier,
            message: 'AppBar action onPressed must be a valid Dart identifier',
            nodePath: actionPath,
            fieldName: 'onPressed',
            suggestion:
                'Use camelCase names like "handleSearch" instead of "${action.onPressed}"',
          ));
        }
      }
    }

    return errors;
  }

  /// Checks if a string is a valid Dart identifier.
  ///
  /// Valid identifiers:
  /// - Start with a letter or underscore
  /// - Contain only letters, digits, and underscores
  /// - Are not Dart keywords
  bool _isValidDartIdentifier(String name) {
    if (name.isEmpty) return false;

    // Check basic pattern: must start with letter or underscore,
    // followed by letters, digits, or underscores
    final identifierPattern = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
    if (!identifierPattern.hasMatch(name)) {
      return false;
    }

    // Check against Dart keywords
    const dartKeywords = {
      'abstract',
      'as',
      'assert',
      'async',
      'await',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'covariant',
      'default',
      'deferred',
      'do',
      'dynamic',
      'else',
      'enum',
      'export',
      'extends',
      'extension',
      'external',
      'factory',
      'false',
      'final',
      'finally',
      'for',
      'Function',
      'get',
      'hide',
      'if',
      'implements',
      'import',
      'in',
      'interface',
      'is',
      'late',
      'library',
      'mixin',
      'new',
      'null',
      'on',
      'operator',
      'part',
      'required',
      'rethrow',
      'return',
      'set',
      'show',
      'static',
      'super',
      'switch',
      'sync',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'var',
      'void',
      'while',
      'with',
      'yield',
    };

    return !dartKeywords.contains(name);
  }

  /// Checks if a string is a valid icon name.
  ///
  /// Icon names should be valid identifiers (snake_case or camelCase).
  bool _isValidIconName(String name) {
    if (name.isEmpty) return false;

    // Allow snake_case or camelCase
    final pattern = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');
    return pattern.hasMatch(name);
  }
}
