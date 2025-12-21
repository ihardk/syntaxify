import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that checks for empty button labels.
///
/// Shows an error when LayoutNode.button() has an empty label string.
class EmptyButtonLabelLint extends DartLintRule {
  const EmptyButtonLabelLint() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_button_label',
    problemMessage: 'Button label cannot be empty',
    correctionMessage: 'Provide a non-empty label like "Submit" or "Cancel"',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if this is a LayoutNode.button() call
      if (!_isLayoutNodeMethod(node, 'button')) return;

      // Find the label argument
      final labelArg = _findNamedArgument(node, 'label');
      if (labelArg == null) return;

      // Check if it's an empty string
      if (labelArg is StringLiteral && labelArg.stringValue?.trim().isEmpty == true) {
        reporter.atNode(labelArg, code);
      }
    });
  }
}

/// Lint rule that checks for invalid Dart identifiers in callbacks.
///
/// Shows an error when callback names (onPressed, onChanged, etc.)
/// contain invalid characters like hyphens or spaces.
class InvalidCallbackNameLint extends DartLintRule {
  const InvalidCallbackNameLint() : super(code: _code);

  static const _code = LintCode(
    name: 'invalid_callback_name',
    problemMessage: 'Callback name must be a valid Dart identifier',
    correctionMessage: 'Use camelCase names like "handleSubmit" instead of names with hyphens or spaces',
    errorSeverity: ErrorSeverity.ERROR,
  );

  static final _identifierPattern = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

  static const _dartKeywords = {
    'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch',
    'class', 'const', 'continue', 'covariant', 'default', 'deferred', 'do',
    'dynamic', 'else', 'enum', 'export', 'extends', 'extension', 'external',
    'factory', 'false', 'final', 'finally', 'for', 'Function', 'get', 'hide',
    'if', 'implements', 'import', 'in', 'interface', 'is', 'late', 'library',
    'mixin', 'new', 'null', 'on', 'operator', 'part', 'required', 'rethrow',
    'return', 'set', 'show', 'static', 'super', 'switch', 'sync', 'this',
    'throw', 'true', 'try', 'typedef', 'var', 'void', 'while', 'with', 'yield',
  };

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check LayoutNode.button() and LayoutNode.textField()
      if (_isLayoutNodeMethod(node, 'button')) {
        _checkCallbackArg(node, 'onPressed', reporter);
      } else if (_isLayoutNodeMethod(node, 'textField')) {
        _checkCallbackArg(node, 'onChanged', reporter);
        _checkCallbackArg(node, 'onSubmitted', reporter);
        _checkCallbackArg(node, 'binding', reporter);
      } else if (_isLayoutNodeMethod(node, 'appBar')) {
        _checkCallbackArg(node, 'leadingAction', reporter);
      }
    });
  }

  void _checkCallbackArg(
    MethodInvocation node,
    String argName,
    ErrorReporter reporter,
  ) {
    final arg = _findNamedArgument(node, argName);
    if (arg == null) return;

    if (arg is StringLiteral) {
      final value = arg.stringValue;
      if (value != null && value.isNotEmpty && !_isValidIdentifier(value)) {
        reporter.atNode(arg, code);
      }
    }
  }

  bool _isValidIdentifier(String name) {
    if (!_identifierPattern.hasMatch(name)) return false;
    return !_dartKeywords.contains(name);
  }
}

/// Lint rule that checks for empty text content.
///
/// Shows an error when LayoutNode.text() has an empty text string.
class EmptyTextContentLint extends DartLintRule {
  const EmptyTextContentLint() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_text_content',
    problemMessage: 'Text content cannot be empty',
    correctionMessage: 'Provide non-empty text content or use a Spacer instead',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isLayoutNodeMethod(node, 'text')) return;

      final textArg = _findNamedArgument(node, 'text');
      if (textArg == null) return;

      if (textArg is StringLiteral && textArg.stringValue?.trim().isEmpty == true) {
        reporter.atNode(textArg, code);
      }
    });
  }
}

/// Lint rule that checks for empty containers (Column/Row with no children).
///
/// Shows a warning when LayoutNode.column() or LayoutNode.row() has no children.
class EmptyContainerLint extends DartLintRule {
  const EmptyContainerLint() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_container',
    problemMessage: 'Container has no children',
    correctionMessage: 'Add child widgets like LayoutNode.text() or LayoutNode.button()',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isLayoutNodeMethod(node, 'column') &&
          !_isLayoutNodeMethod(node, 'row')) {
        return;
      }

      final childrenArg = _findNamedArgument(node, 'children');
      if (childrenArg == null) return;

      // Check if it's an empty list
      if (childrenArg is ListLiteral && childrenArg.elements.isEmpty) {
        reporter.atNode(childrenArg, code);
      }
    });
  }
}

// Helper functions

/// Checks if a method invocation is a LayoutNode factory method.
bool _isLayoutNodeMethod(MethodInvocation node, String methodName) {
  if (node.methodName.name != methodName) return false;

  final target = node.target;
  if (target is SimpleIdentifier && target.name == 'LayoutNode') {
    return true;
  }

  return false;
}

/// Lint rule that checks for negative numbers where positive values are expected.
///
/// Shows an error when properties like maxLines, maxLength, or flex have negative values.
class NegativeNumberLint extends DartLintRule {
  const NegativeNumberLint() : super(code: _code);

  static const _code = LintCode(
    name: 'negative_number_value',
    problemMessage: 'Value must be a positive number',
    correctionMessage: 'Use a positive integer value',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check text nodes for maxLines
      if (_isLayoutNodeMethod(node, 'text')) {
        _checkPositiveArg(node, 'maxLines', reporter);
      }
      // Check textField for maxLines and maxLength
      else if (_isLayoutNodeMethod(node, 'textField')) {
        _checkPositiveArg(node, 'maxLines', reporter);
        _checkPositiveArg(node, 'maxLength', reporter);
      }
      // Check spacer for flex
      else if (_isLayoutNodeMethod(node, 'spacer')) {
        _checkPositiveArg(node, 'flex', reporter);
      }
    });
  }

  void _checkPositiveArg(
    MethodInvocation node,
    String argName,
    ErrorReporter reporter,
  ) {
    final arg = _findNamedArgument(node, argName);
    if (arg == null) return;

    if (arg is IntegerLiteral) {
      final value = arg.value;
      if (value != null && value <= 0) {
        reporter.atNode(arg, code);
      }
    }
  }
}

/// Lint rule that checks for conflicting properties.
///
/// Shows an info message when properties conflict (e.g., maxLines=1 with overflow=visible).
class ConflictingPropertiesLint extends DartLintRule {
  const ConflictingPropertiesLint() : super(code: _code);

  static const _code = LintCode(
    name: 'conflicting_properties',
    problemMessage: 'These properties may conflict and cause unexpected behavior',
    correctionMessage: 'Consider using TextOverflow.ellipsis instead of visible',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isLayoutNodeMethod(node, 'text')) return;

      final maxLinesArg = _findNamedArgument(node, 'maxLines');
      final overflowArg = _findNamedArgument(node, 'overflow');

      if (maxLinesArg == null || overflowArg == null) return;

      // Check if maxLines=1 with overflow=visible
      if (maxLinesArg is IntegerLiteral && maxLinesArg.value == 1) {
        if (overflowArg is PrefixedIdentifier &&
            overflowArg.identifier.name == 'visible') {
          reporter.atNode(overflowArg, code);
        }
      }
    });
  }
}

/// Lint rule that checks for empty icon names.
///
/// Shows an error when icon name is empty in LayoutNode.icon() or button icons.
class EmptyIconNameLint extends DartLintRule {
  const EmptyIconNameLint() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_icon_name',
    problemMessage: 'Icon name cannot be empty',
    correctionMessage: 'Provide a valid icon name like "home" or "settings"',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check icon nodes
      if (_isLayoutNodeMethod(node, 'icon')) {
        final nameArg = _findNamedArgument(node, 'name');
        if (nameArg is StringLiteral && nameArg.stringValue?.trim().isEmpty == true) {
          reporter.atNode(nameArg, code);
        }
      }
      // Check button icon property
      else if (_isLayoutNodeMethod(node, 'button')) {
        final iconArg = _findNamedArgument(node, 'icon');
        if (iconArg is StringLiteral && iconArg.stringValue?.trim().isEmpty == true) {
          reporter.atNode(iconArg, code);
        }
      }
    });
  }
}

/// Lint rule that checks for textFields missing both label and hint.
///
/// Shows a warning when textField has neither label nor hint.
class MissingTextFieldLabelLint extends DartLintRule {
  const MissingTextFieldLabelLint() : super(code: _code);

  static const _code = LintCode(
    name: 'missing_textfield_label',
    problemMessage: 'TextField should have either a label or hint',
    correctionMessage: 'Provide a label or hint to guide the user',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isLayoutNodeMethod(node, 'textField')) return;

      final labelArg = _findNamedArgument(node, 'label');
      final hintArg = _findNamedArgument(node, 'hint');

      // Check if both are missing or empty
      final hasLabel = labelArg is StringLiteral &&
          labelArg.stringValue?.trim().isNotEmpty == true;
      final hasHint = hintArg is StringLiteral &&
          hintArg.stringValue?.trim().isNotEmpty == true;

      if (!hasLabel && !hintArg) {
        // Neither label nor hint provided
        reporter.atNode(node.methodName, code);
      } else if (!hasLabel && !hasHint) {
        // Both provided but empty
        reporter.atNode(node.methodName, code);
      }
    });
  }
}

/// Lint rule that checks for empty AppBar titles.
///
/// Shows a warning when AppBar has no title.
class EmptyAppBarTitleLint extends DartLintRule {
  const EmptyAppBarTitleLint() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_appbar_title',
    problemMessage: 'AppBar should have a title',
    correctionMessage: 'Provide a descriptive title for the app bar',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isLayoutNodeMethod(node, 'appBar')) return;

      final titleArg = _findNamedArgument(node, 'title');

      if (titleArg == null) {
        reporter.atNode(node.methodName, code);
      } else if (titleArg is StringLiteral &&
                 titleArg.stringValue?.trim().isEmpty == true) {
        reporter.atNode(titleArg, code);
      }
    });
  }
}

// Helper functions

/// Checks if a method invocation is a LayoutNode factory method.
bool _isLayoutNodeMethod(MethodInvocation node, String methodName) {
  if (node.methodName.name != methodName) return false;

  final target = node.target;
  if (target is SimpleIdentifier && target.name == 'LayoutNode') {
    return true;
  }

  return false;
}

/// Finds a named argument in a method invocation.
Expression? _findNamedArgument(MethodInvocation node, String name) {
  for (final arg in node.argumentList.arguments) {
    if (arg is NamedExpression && arg.name.label.name == name) {
      return arg.expression;
    }
  }
  return null;
}
