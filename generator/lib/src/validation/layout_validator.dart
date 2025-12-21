import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/models/validation_error.dart';

/// Validates layout nodes for correctness before code generation.
///
/// This validator catches common errors early:
/// - Empty values (labels, text)
/// - Invalid Dart identifiers (callback names)
/// - Empty containers
/// - Conflicting properties
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
      structural: (n) => _validateStructural(n.node, path),
      primitive: (n) => _validatePrimitive(n.node, path),
      interactive: (n) => _validateInteractive(n.node, path),
      custom: (n) => _validateCustom(n.node, path),
      appBar: (n) => _validateAppBar(n, path),
    );
  }

  /// Validates a custom node.
  List<ValidationError> _validateCustom(CustomNode node, String path) {
    // Custom nodes are validated by plugins (future).
    // For now, we just ensure basic integrity if needed.
    return [];
  }

  // --- Sub-Validators ---

  List<ValidationError> _validateStructural(StructuralNode node, String path) {
    return node.map(
      column: (n) => _validateColumn(n, path),
      row: (n) => _validateRow(n, path),
      container: (n) => _validateContainer(n, path),
      card: (n) => _validateCard(n, path),
      listView: (n) => _validateListView(n, path),
    );
  }

  List<ValidationError> _validatePrimitive(PrimitiveNode node, String path) {
    return node.map(
      text: (n) => _validateText(n, path),
      icon: (n) => _validateIcon(n, path),
      spacer: (n) => _validateSpacer(n, path),
      image: (n) => _validateImage(n, path),
      divider: (n) => _validateDivider(n, path),
      circularProgressIndicator: (n) =>
          _validateCircularProgressIndicator(n, path),
      sizedBox: (n) => _validateSizedBox(n, path),
      expanded: (n) => _validateExpanded(n, path),
    );
  }

  List<ValidationError> _validateInteractive(
      InteractiveNode node, String path) {
    return node.map(
      button: (n) => _validateButton(n, path),
      textField: (n) => _validateTextField(n, path),
      checkbox: (n) => _validateCheckbox(n, path),
      switchNode: (n) => _validateSwitch(n, path),
    );
  }

  // --- Specific Validators ---

  /// Validates a button node.
  List<ValidationError> _validateButton(ButtonNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.button';
    final props = node.props;

    // Rule: Label cannot be empty or whitespace
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
    if (props?.iconPosition != null &&
        (props?.icon == null || props!.icon!.trim().isEmpty)) {
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
        suggestion: 'Add at least one child widget to the column',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (var i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath[$i]');
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
        suggestion: 'Add at least one child widget to the row',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (var i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a text node.
  List<ValidationError> _validateText(TextNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.text';

    // Rule: Text content cannot be empty or whitespace (unless intentional, but validator catches it)
    if (node.text.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Text content cannot be empty',
        nodePath: nodePath,
        fieldName: 'text',
        suggestion: 'Provide some text to display',
      ));
    }

    // Rule: maxLines must be non-negative
    if (node.maxLines != null && node.maxLines! < 1) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLines must be a positive number',
        nodePath: nodePath,
        fieldName: 'maxLines',
        suggestion: 'Set maxLines to 1 or higher',
      ));
    }

    // Rule: Conflicting properties (clip overflow with specific maxLines)
    // Example rule: If maxLines is 1, overflow should usually be ellipsis or fade, not clip?
    // The test says "validates text with conflicting overflow and maxLines" -> maxLines: 1 + clip
    if (node.maxLines == 1 && node.overflow == TextOverflow.clip) {
      errors.add(ValidationError(
        type: ValidationErrorType.conflictingProperties,
        message:
            'TextOverflow.clip with maxLines: 1 might cut off text abruptly',
        nodePath: nodePath,
        fieldName: 'overflow',
        suggestion: 'Consider using TextOverflow.ellipsis',
        severity: ErrorSeverity.info,
      ));
    }

    return errors;
  }

  /// Validates a text field node.
  List<ValidationError> _validateTextField(TextFieldNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.textField';
    final props = node.props;

    // Rule: TextField must have a label or hint
    final hasLabel = node.label != null && node.label!.trim().isNotEmpty;
    final hasHint = props?.hint != null && props!.hint!.trim().isNotEmpty;

    if (!hasLabel && !hasHint) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'TextField must have a label or hint',
        nodePath: nodePath,
        fieldName: 'label',
        suggestion: 'Provide a label or hint text',
      ));
    }

    // Rule: onChanged must be valid identifier
    if (node.onChanged != null && !_isValidDartIdentifier(node.onChanged!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'onChanged callback must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onChanged',
        suggestion:
            'Use camelCase names like "handleTextChange" instead of "${node.onChanged}"',
      ));
    }

    // Rule: onSubmitted must be valid identifier
    if (node.onSubmitted != null &&
        !_isValidDartIdentifier(node.onSubmitted!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'onSubmitted callback must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onSubmitted',
        suggestion:
            'Use camelCase names like "handleSubmit" instead of "${node.onSubmitted}"',
      ));
    }

    // Rule: binding must be valid identifier if provided
    // (Assuming binding is a property that maps to a controller/variable)
    // Note: binding is not on InteractiveNode base, it's specific to TextField?
    // Let's check TextFieldInteractiveNode definition. It's likely in `node`.
    // Wait, TextFieldInteractiveNode usually has `label`, `onChanged` etc directly?
    // Or in `props`? `InteractiveNode.textField` has specific fields.
    // The previous error was accessing `node.binding`? No, the test used `LayoutNode.textField(binding: ...)`.
    // I need to check `TextFieldInteractiveNode` definition for `binding`.
    // Note: I don't see `binding` in the `validation_error.dart` I wrote earlier
    // but the test uses it. Assuming `TextFieldInteractiveNode` has it.
    // If not, I can't validate it. But let's assume it does or misses it.
    // Checking `TextFieldProps` in `node_props.dart` earlier... I didn't see `binding`.
    // `TextFieldProps` had: hint, helperText, prefixIcon...
    // Maybe `binding` is a top-level field on `TextFieldInteractiveNode`?
    // I will skip binding validation if I can't find the field, or check if it's there.

    // Rule: binding must be valid identifier
    if (node.binding != null && !_isValidDartIdentifier(node.binding!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'binding must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'binding',
      ));
    }

    // Rule: maxLength must be positive
    if (props?.maxLength != null && props!.maxLength! < 1) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLength must be a positive integer',
        nodePath: nodePath,
        fieldName: 'maxLength',
      ));
    }

    // Rule: maxLines must be positive
    if (props?.maxLines != null && props!.maxLines! < 1) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'maxLines must be a positive number',
        nodePath: nodePath,
        fieldName: 'maxLines',
      ));
    }

    return errors;
  }

  /// Validates an icon node.
  List<ValidationError> _validateIcon(IconNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.icon';

    // Rule: Icon name cannot be empty or whitespace only
    if (node.name.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Icon name cannot be empty',
        nodePath: nodePath,
        fieldName: 'name',
        suggestion: 'Provide a Material icon name (e.g., "add", "home")',
      ));
    }

    return errors;
  }

  /// Validates a spacer node.
  List<ValidationError> _validateSpacer(SpacerNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.spacer';

    // Rule: Flex must be non-negative
    if (node.flex != null && node.flex! < 1) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Spacer flex must be a positive number',
        nodePath: nodePath,
        fieldName: 'flex',
        suggestion: 'Set flex to 1 or higher',
      ));
    }

    return errors;
  }

  /// Validates an app bar node.
  List<ValidationError> _validateAppBar(AppBarNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.appBar';

    // Rule: Title should not be empty (if strict mode? Test expects it)
    if (node.title != null && node.title!.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'AppBar should have a title',
        nodePath: nodePath,
        fieldName: 'title',
        suggestion: 'Provide a title or remove the property',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: onLeadingPressed needs leadingIcon
    if (node.onLeadingPressed != null && node.leadingIcon == null) {
      errors.add(ValidationError(
        type: ValidationErrorType.missingDependency,
        message: 'onLeadingPressed requires leadingIcon',
        nodePath: nodePath,
        fieldName: 'onLeadingPressed',
        suggestion: 'Provide a leadingIcon or remove onLeadingPressed',
      ));
    }

    // Rule: onLeadingPressed valid identifier
    if (node.onLeadingPressed != null &&
        !_isValidDartIdentifier(node.onLeadingPressed!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'onLeadingPressed must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onLeadingPressed',
      ));
    }

    return errors;
  }

  /// Validates a container node.
  List<ValidationError> _validateContainer(ContainerNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.container';

    // Rule: Container should have either a child or sizing (warning)
    if (node.child == null &&
        node.width == null &&
        node.height == null &&
        node.padding == null &&
        node.margin == null) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Container has no content or sizing',
        nodePath: nodePath,
        fieldName: 'child',
        suggestion:
            'Add a child widget or specify width/height/padding/margin',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: Width must be non-negative
    if (node.width != null && node.width! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Container width must be non-negative',
        nodePath: nodePath,
        fieldName: 'width',
        suggestion: 'Set width to 0 or higher',
      ));
    }

    // Rule: Height must be non-negative
    if (node.height != null && node.height! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Container height must be non-negative',
        nodePath: nodePath,
        fieldName: 'height',
        suggestion: 'Set height to 0 or higher',
      ));
    }

    // Rule: Border radius must be non-negative
    if (node.borderRadius != null && node.borderRadius! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Container borderRadius must be non-negative',
        nodePath: nodePath,
        fieldName: 'borderRadius',
        suggestion: 'Set borderRadius to 0 or higher',
      ));
    }

    // Rule: Having both color and semantic might be confusing (warning)
    if (node.color != null && node.semantic != null) {
      errors.add(ValidationError(
        type: ValidationErrorType.conflictingProperties,
        message: 'Container has both color and semantic specified',
        nodePath: nodePath,
        fieldName: 'color',
        suggestion:
            'Use either color for explicit colors or semantic for theme-based colors',
        severity: ErrorSeverity.info,
      ));
    }

    // Recursively validate child
    if (node.child != null) {
      final childErrors = validate(node.child!, '$nodePath.child');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a card node.
  List<ValidationError> _validateCard(CardNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.card';

    // Rule: Card should have at least one child (warning)
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'Card has no children',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add at least one child widget to the card',
        severity: ErrorSeverity.warning,
      ));
    }

    // Rule: Elevation must be non-negative
    if (node.elevation != null && node.elevation! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Card elevation must be non-negative',
        nodePath: nodePath,
        fieldName: 'elevation',
        suggestion: 'Set elevation to 0 or higher',
      ));
    }

    // Recursively validate children
    for (var i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates a list view node.
  List<ValidationError> _validateListView(ListViewNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.listView';

    // Rule: ListView should have at least one child (warning)
    if (node.children.isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyChildren,
        message: 'ListView has no children',
        nodePath: nodePath,
        fieldName: 'children',
        suggestion: 'Add at least one child widget to the list view',
        severity: ErrorSeverity.warning,
      ));
    }

    // Recursively validate children
    for (var i = 0; i < node.children.length; i++) {
      final childErrors = validate(node.children[i], '$nodePath[$i]');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates an image node.
  List<ValidationError> _validateImage(ImageNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.image';

    // Rule: Image src cannot be empty or whitespace
    if (node.src.trim().isEmpty) {
      errors.add(ValidationError(
        type: ValidationErrorType.emptyValue,
        message: 'Image src cannot be empty',
        nodePath: nodePath,
        fieldName: 'src',
        suggestion:
            'Provide an asset path, network URL, or registry name',
      ));
    }

    // Rule: Width must be non-negative
    if (node.width != null && node.width! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Image width must be non-negative',
        nodePath: nodePath,
        fieldName: 'width',
        suggestion: 'Set width to 0 or higher',
      ));
    }

    // Rule: Height must be non-negative
    if (node.height != null && node.height! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Image height must be non-negative',
        nodePath: nodePath,
        fieldName: 'height',
        suggestion: 'Set height to 0 or higher',
      ));
    }

    return errors;
  }

  /// Validates a divider node.
  List<ValidationError> _validateDivider(DividerNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.divider';

    // Rule: Thickness must be non-negative
    if (node.thickness != null && node.thickness! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Divider thickness must be non-negative',
        nodePath: nodePath,
        fieldName: 'thickness',
        suggestion: 'Set thickness to 0 or higher',
      ));
    }

    // Rule: Indent must be non-negative
    if (node.indent != null && node.indent! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Divider indent must be non-negative',
        nodePath: nodePath,
        fieldName: 'indent',
        suggestion: 'Set indent to 0 or higher',
      ));
    }

    // Rule: End indent must be non-negative
    if (node.endIndent != null && node.endIndent! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Divider endIndent must be non-negative',
        nodePath: nodePath,
        fieldName: 'endIndent',
        suggestion: 'Set endIndent to 0 or higher',
      ));
    }

    return errors;
  }

  /// Validates a circular progress indicator node.
  List<ValidationError> _validateCircularProgressIndicator(
      CircularProgressIndicatorNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.circularProgressIndicator';

    // Rule: Value must be between 0 and 1 if provided
    if (node.value != null && (node.value! < 0 || node.value! > 1)) {
      errors.add(ValidationError(
        type: ValidationErrorType.outOfRange,
        message: 'CircularProgressIndicator value must be between 0 and 1',
        nodePath: nodePath,
        fieldName: 'value',
        suggestion: 'Set value to a number between 0.0 and 1.0',
      ));
    }

    // Rule: Stroke width must be positive
    if (node.strokeWidth != null && node.strokeWidth! <= 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'CircularProgressIndicator strokeWidth must be positive',
        nodePath: nodePath,
        fieldName: 'strokeWidth',
        suggestion: 'Set strokeWidth to a value greater than 0',
      ));
    }

    return errors;
  }

  /// Validates a sized box node.
  List<ValidationError> _validateSizedBox(SizedBoxNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.sizedBox';

    // Rule: Width must be non-negative
    if (node.width != null && node.width! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'SizedBox width must be non-negative',
        nodePath: nodePath,
        fieldName: 'width',
        suggestion: 'Set width to 0 or higher',
      ));
    }

    // Rule: Height must be non-negative
    if (node.height != null && node.height! < 0) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'SizedBox height must be non-negative',
        nodePath: nodePath,
        fieldName: 'height',
        suggestion: 'Set height to 0 or higher',
      ));
    }

    // Recursively validate child
    if (node.child != null) {
      final childErrors = validate(node.child!, '$nodePath.child');
      errors.addAll(childErrors);
    }

    return errors;
  }

  /// Validates an expanded node.
  List<ValidationError> _validateExpanded(ExpandedNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.expanded';

    // Rule: Flex must be positive
    if (node.flex != null && node.flex! < 1) {
      errors.add(ValidationError(
        type: ValidationErrorType.negativeNumber,
        message: 'Expanded flex must be a positive number',
        nodePath: nodePath,
        fieldName: 'flex',
        suggestion: 'Set flex to 1 or higher',
      ));
    }

    // Recursively validate child
    final childErrors = validate(node.child, '$nodePath.child');
    errors.addAll(childErrors);

    return errors;
  }

  /// Validates a checkbox node.
  List<ValidationError> _validateCheckbox(CheckboxNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.checkbox';

    // Rule: binding must be valid identifier
    if (!_isValidDartIdentifier(node.binding)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'Checkbox binding must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'binding',
        suggestion:
            'Use camelCase names like "isChecked" instead of "${node.binding}"',
      ));
    }

    // Rule: onChanged must be valid identifier if provided
    if (node.onChanged != null && !_isValidDartIdentifier(node.onChanged!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'Checkbox onChanged must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onChanged',
        suggestion:
            'Use camelCase names like "handleCheckboxChange" instead of "${node.onChanged}"',
      ));
    }

    return errors;
  }

  /// Validates a switch node.
  List<ValidationError> _validateSwitch(SwitchNode node, String path) {
    final errors = <ValidationError>[];
    final nodePath = '$path.switch';

    // Rule: binding must be valid identifier
    if (!_isValidDartIdentifier(node.binding)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'Switch binding must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'binding',
        suggestion:
            'Use camelCase names like "isEnabled" instead of "${node.binding}"',
      ));
    }

    // Rule: onChanged must be valid identifier if provided
    if (node.onChanged != null && !_isValidDartIdentifier(node.onChanged!)) {
      errors.add(ValidationError(
        type: ValidationErrorType.invalidIdentifier,
        message: 'Switch onChanged must be a valid Dart identifier',
        nodePath: nodePath,
        fieldName: 'onChanged',
        suggestion:
            'Use camelCase names like "handleSwitchChange" instead of "${node.onChanged}"',
      ));
    }

    return errors;
  }

  /// Checks if a string is a valid Dart identifier.
  bool _isValidDartIdentifier(String s) {
    if (s.isEmpty) return false;
    // Reserved keywords check (basic set)
    const keywords = {
      'class',
      'if',
      'else',
      'for',
      'do',
      'while',
      'switch',
      'case',
      'default',
      'break',
      'continue',
      'return',
      'true',
      'false',
      'null',
      'this',
      'super',
      'new',
      'const',
      'final',
      'var',
      'void',
      'int',
      'double',
      'num',
      'bool',
      'String',
      'List',
      'Map',
      'Set',
      'dynamic',
      'async',
      'await',
      'yield',
      'in',
      'is',
      'as',
      'import',
      'export',
      'part',
      'library',
      'show',
      'hide',
      'typedef',
      'function',
      'try',
      'catch',
      'finally',
      'throw',
      'rethrow',
      'assert',
      'enum',
      'extends',
      'with',
      'implements',
      'abstract',
      'external',
      'static',
      'operator',
      'get',
      'set',
      'factory',
      'mixin',
      'covariant',
      'deferred',
      'interface'
    };
    if (keywords.contains(s)) return false;

    // Regex for Dart identifiers
    final identifierRegex = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
    return identifierRegex.hasMatch(s);
  }
}
