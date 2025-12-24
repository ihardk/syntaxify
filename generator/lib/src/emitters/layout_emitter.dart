import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/generators/generator_registry.dart';

/// Emits Flutter widget code from AST layout nodes.
///
/// The [LayoutEmitter] is the core transformation engine that converts
/// Syntaxify's declarative AST nodes into Flutter widget expressions using
/// `package:code_builder`.
///
/// ## Supported Node Types
///
/// - **Structural**: Column, Row, Container, Card, ListView, Stack, etc.
/// - **Primitive**: Text, Icon, Image, Divider, Spacer, etc.
/// - **Interactive**: Button, TextField, Checkbox, Switch, Slider, etc.
/// - **Custom**: Plugin-provided nodes via [GeneratorRegistry]
///
/// ## Design System Integration
///
/// Interactive nodes emit App wrapper components (`AppCheckbox`, `AppSwitch`,
/// etc.) that delegate rendering to the active design style (Material,
/// Cupertino, or Neo).
///
/// ## Usage
///
/// ```dart
/// final emitter = LayoutEmitter();
/// final expression = emitter.emit(app);
/// final dartCode = expression.accept(DartEmitter()).toString();
/// ```
class LayoutEmitter {
  const LayoutEmitter({
    this.registry,
    this.controllerMap = const {},
    this.variableMap = const {},
  });

  /// Optional generator registry for custom node handling.
  final GeneratorRegistry? registry;

  /// Map of input labels to controller field names for StatefulWidget screens.
  final Map<String, String> controllerMap;

  /// Map of variable names to their scoped reference (e.g. 'handleLogin' -> 'widget.handleLogin').
  final Map<String, String> variableMap;

  /// Converts a [App] into a [Spec] (Expression).
  Expression emit(App node) {
    return node.map(
      structural: (n) => _emitStructural(n.node),
      primitive: (n) => _emitPrimitive(n.node),
      interactive: (n) => _emitInteractive(n.node),
      custom: (n) => _emitCustom(n.node),
      appBar: (n) => _emitAppBar(n),
    );
  }

  // --- Sub-Emitters ---

  Expression _emitStructural(StructuralNode node) {
    return node.map(
      column: _emitColumn,
      row: _emitRow,
      container: _emitContainer,
      card: _emitCard,
      listView: _emitListView,
      stack: _emitStack,
      gridView: _emitGridView,
      padding: _emitPadding,
      center: _emitCenter,
    );
  }

  Expression _emitPrimitive(PrimitiveNode node) {
    return node.map(
      text: _emitText,
      icon: _emitIcon,
      spacer: _emitSpacer,
      image: _emitImage,
      divider: _emitDivider,
      circularProgressIndicator: _emitCircularProgressIndicator,
      sizedBox: _emitSizedBox,
      expanded: _emitExpanded,
    );
  }

  Expression _emitInteractive(InteractiveNode node) {
    return node.map(
      button: _emitButton,
      textField: _emitTextField,
      checkbox: _emitCheckbox,
      switchNode: _emitSwitch,
      iconButton: _emitIconButton,
      dropdown: _emitDropdown,
      radio: _emitRadio,
      slider: _emitSlider,
    );
  }

  Expression _emitCustom(CustomNode node) {
    final handler = registry?.getCustomEmitter(node.type);
    if (handler != null) {
      return handler.emit(node);
    }
    // Placeholder if no handler found
    return refer('Placeholder').newInstance([], {
      'child':
          literalString('Custom Component (Missing Handler): ${node.type}'),
    });
  }

  // --- Specific Emitters ---

  Expression _emitColumn(ColumnNode node) {
    // Generate children list
    List<Expression> children = node.children.map(emit).toList();

    // Add spacing between children if spacing is specified
    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        // Add vertical spacing after each child except the last one
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox').newInstance([], {
              'height': literalNum(spacingValue),
            }),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('Column').newInstance([], {
      'children': literalList(children),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitRow(RowNode node) {
    // Generate children list
    List<Expression> children = node.children.map(emit).toList();

    // Add spacing between children if spacing is specified
    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        // Add horizontal spacing after each child except the last one
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox').newInstance([], {
              'width': literalNum(spacingValue),
            }),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('Row').newInstance([], {
      'children': literalList(children),
      if (node.mainAxisAlignment != null)
        'mainAxisAlignment':
            refer('MainAxisAlignment.${node.mainAxisAlignment!.name}'),
      if (node.crossAxisAlignment != null)
        'crossAxisAlignment':
            refer('CrossAxisAlignment.${node.crossAxisAlignment!.name}'),
    });
  }

  Expression _emitText(TextNode node) {
    return refer('AppText').newInstance([], {
      'text': literalString(node.text),
      if (node.variant != null) 'variant': refer('TextVariant.${node.variant}'),
      if (node.align != null) 'align': refer('TextAlign.${node.align!.name}'),
      if (node.maxLines != null) 'maxLines': literalNum(node.maxLines!),
      if (node.overflow != null)
        'overflow': refer('TextOverflow.${node.overflow!.name}'),
    });
  }

  Expression _emitButton(ButtonNode node) {
    final props = node.props;
    return refer('AppButton').newInstance([], {
      'label': literalString(node.label),
      'onPressed': node.onPressed != null
          ? refer(variableMap[node.onPressed!] ?? node.onPressed!)
          : literalNull,
      if (props?.variant != null)
        'variant': refer('ButtonVariant.${props!.variant}'),
      if (props?.size != null) 'size': refer('ButtonSize.${props!.size!.name}'),
      if (props?.icon != null) 'icon': refer('Icons.${props!.icon!}'),
      if (props?.isDisabled == true) 'isDisabled': literalTrue,
      if (props?.fullWidth == true) 'fullWidth': literalTrue,
      if (props?.isLoading == true) 'isLoading': literalTrue,
    });
  }

  Expression _emitTextField(TextFieldNode node) {
    final props = node.props;
    // Map KeyboardType enum to Flutter's TextInputType
    String? keyboardTypeValue;
    if (props?.keyboardType != null) {
      switch (props!.keyboardType!) {
        case KeyboardType.email:
          keyboardTypeValue = 'emailAddress';
          break;
        case KeyboardType.number:
          keyboardTypeValue = 'number';
          break;
        case KeyboardType.phone:
          keyboardTypeValue = 'phone';
          break;
        case KeyboardType.url:
          keyboardTypeValue = 'url';
          break;
        case KeyboardType.multiline:
          keyboardTypeValue = 'multiline';
          break;
        case KeyboardType.text:
          keyboardTypeValue = 'text';
          break;
      }
    }

    // Check if we have a controller for this input
    final label = node.label ?? '';
    final controllerFieldName = controllerMap[label];

    return refer('AppInput').newInstance([], {
      'label': literalString(label),
      // Inject controller reference if available from the StatefulWidget's State
      if (controllerFieldName != null) 'controller': refer(controllerFieldName),
      if (props?.hint != null) 'hint': literalString(props!.hint!),
      if (props?.obscureText == true) 'obscureText': literalTrue,
      if (keyboardTypeValue != null)
        'keyboardType': refer('TextInputType.$keyboardTypeValue'),
      if (node.onChanged != null)
        'onChanged': refer(variableMap[node.onChanged!] ?? node.onChanged!),
      if (node.onSubmitted != null)
        'onSubmitted':
            refer(variableMap[node.onSubmitted!] ?? node.onSubmitted!),
      if (node.onChanged != null)
        'onChanged': refer(variableMap[node.onChanged!] ?? node.onChanged!),
      if (node.onSubmitted != null)
        'onSubmitted':
            refer(variableMap[node.onSubmitted!] ?? node.onSubmitted!),
    });
  }

  Expression _emitIcon(IconNode node) {
    return refer('Icon').newInstance([
      refer('Icons.${node.name}'),
    ], {
      if (node.size != null) 'size': literalNum(24),
    });
  }

  Expression _emitSpacer(SpacerNode node) {
    // If flex is specified or size is SpacerSize.flex, use Spacer widget
    if (node.flex != null || node.size == SpacerSize.flex) {
      return refer('Spacer').newInstance([], {
        if (node.flex != null) 'flex': literalNum(node.flex!),
      });
    }

    // Otherwise, use SizedBox with semantic spacing
    final height = _getSpacingValue(node.size);
    return refer('SizedBox').newInstance([], {
      'height': literalNum(height),
    });
  }

  // Helper to convert SpacerSize to pixel values
  double _getSpacingValue(SpacerSize? size) {
    switch (size) {
      case SpacerSize.xs:
        return 4.0;
      case SpacerSize.sm:
        return 8.0;
      case SpacerSize.md:
      case null:
        return 16.0; // Default
      case SpacerSize.lg:
        return 24.0;
      case SpacerSize.xl:
        return 32.0;
      case SpacerSize.flex:
        return 16.0; // Fallback, shouldn't reach here
    }
  }

  Expression _emitAppBar(AppBarNode node) {
    // AppBar is typically a PreferredSizeWidget, but for AST purposes it maps to AppBar
    return refer('AppBar').newInstance([], {
      if (node.title != null)
        'title': refer('AppText')
            .newInstance([], {'text': literalString(node.title!)})
    });
  }

  // --- New Structural Node Emitters ---

  Expression _emitContainer(ContainerNode node) {
    // Determine if we need BoxDecoration (for color + borderRadius combination)
    final hasColor = node.color != null;
    final hasBorderRadius = node.borderRadius != null;
    final needsDecoration = hasColor || hasBorderRadius;

    final containerArgs = <String, Expression>{
      if (node.child != null) 'child': emit(node.child!),
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.padding != null) 'padding': _parseEdgeInsets(node.padding!),
      if (node.margin != null) 'margin': _parseEdgeInsets(node.margin!),
    };

    // Add color/decoration
    if (needsDecoration) {
      final decorationArgs = <String, Expression>{};
      if (hasColor) {
        decorationArgs['color'] = _emitColorSemantic(node.color!);
      }
      if (hasBorderRadius) {
        decorationArgs['borderRadius'] = refer('BorderRadius')
            .property('circular')
            .call([literalNum(node.borderRadius!)]);
      }
      containerArgs['decoration'] =
          refer('BoxDecoration').newInstance([], decorationArgs);
    }

    return refer('Container').newInstance([], containerArgs);
  }

  Expression _emitCard(CardNode node) {
    final columnChild = refer('Column').newInstance([], {
      'children': literalList(node.children.map(emit).toList()),
    });

    return refer('Card').newInstance([], {
      'child': node.padding != null
          ? refer('Padding').newInstance([], {
              'padding': _parseEdgeInsets(node.padding!),
              'child': columnChild,
            })
          : columnChild,
      if (node.elevation != null) 'elevation': literalNum(node.elevation!),
    });
  }

  Expression _emitListView(ListViewNode node) {
    // Generate children list
    List<Expression> children = node.children.map(emit).toList();

    // Add spacing between children if spacing is specified
    if (node.spacing != null) {
      final spacingValue = double.tryParse(node.spacing!) ?? 16.0;
      final isHorizontal = node.scrollDirection == SyntaxAxis.horizontal;

      final spacedChildren = <Expression>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        // Add spacing after each child except the last one
        if (i < children.length - 1) {
          spacedChildren.add(
            refer('SizedBox').newInstance([], {
              if (isHorizontal)
                'width': literalNum(spacingValue)
              else
                'height': literalNum(spacingValue),
            }),
          );
        }
      }
      children = spacedChildren;
    }

    return refer('ListView').newInstance([], {
      'children': literalList(children),
      if (node.scrollDirection != null &&
          node.scrollDirection != SyntaxAxis.vertical)
        'scrollDirection': refer('Axis.${node.scrollDirection!.name}'),
      if (node.shrinkWrap == true) 'shrinkWrap': literalTrue,
    });
  }

  // --- New Primitive Node Emitters ---

  Expression _emitImage(ImageNode node) {
    // Determine image source type
    final isNetworkUrl =
        node.src.startsWith('http://') || node.src.startsWith('https://');
    final isDirectPath = node.src.contains('/');
    final isRegistryName = !isDirectPath && !isNetworkUrl;

    // Build Image widget arguments
    final imageArgs = <String, Expression>{
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.fit != null) 'fit': refer('BoxFit.${node.fit!.name}'),
    };

    if (isRegistryName) {
      // Registry image - generate runtime check for network vs asset
      final pathRef = refer('AppImages').property(node.src);

      // Create condition: AppImages.x.startsWith('http://') || AppImages.x.startsWith('https://')
      final isNetworkCondition = pathRef
          .property('startsWith')
          .call([literalString('http://')]).or(
              pathRef.property('startsWith').call([literalString('https://')]));

      // Generate: condition ? Image.network(...) : Image.asset(...)
      return isNetworkCondition.conditional(
        refer('Image').property('network').call([pathRef], imageArgs),
        refer('Image').property('asset').call([pathRef], imageArgs),
      );
    } else if (isNetworkUrl) {
      // Direct network URL
      return refer('Image')
          .property('network')
          .call([literalString(node.src)], imageArgs);
    } else {
      // Direct asset path
      return refer('Image')
          .property('asset')
          .call([literalString(node.src)], imageArgs);
    }
  }

  Expression _emitDivider(DividerNode node) {
    return refer('Divider').newInstance([], {
      if (node.thickness != null) 'thickness': literalNum(node.thickness!),
      if (node.indent != null) 'indent': literalNum(node.indent!),
      if (node.endIndent != null) 'endIndent': literalNum(node.endIndent!),
    });
  }

  Expression _emitCircularProgressIndicator(
      CircularProgressIndicatorNode node) {
    return refer('CircularProgressIndicator').newInstance([], {
      if (node.value != null) 'value': literalNum(node.value!),
      if (node.strokeWidth != null)
        'strokeWidth': literalNum(node.strokeWidth!),
    });
  }

  // --- New Interactive Node Emitters ---

  Expression _emitCheckbox(CheckboxNode node) {
    // If has label, wrap in Row for label + checkbox layout
    final checkbox = refer('AppCheckbox').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(variableMap[node.onChanged!] ?? node.onChanged!)
          : refer(
              '(value) => setState(() => _${node.binding} = value ?? false)'),
    });

    if (node.label != null) {
      return refer('Row').newInstance([], {
        'children': literalList([
          checkbox,
          refer('SizedBox').newInstance([], {'width': literalNum(8)}),
          refer('Text').newInstance([literalString(node.label!)]),
        ]),
      });
    }
    return checkbox;
  }

  Expression _emitSwitch(SwitchNode node) {
    // If has label, wrap in Row for label + switch layout
    final switchWidget = refer('AppSwitch').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
    });

    if (node.label != null) {
      return refer('Row').newInstance([], {
        'mainAxisAlignment': refer('MainAxisAlignment.spaceBetween'),
        'children': literalList([
          refer('Text').newInstance([literalString(node.label!)]),
          switchWidget,
        ]),
      });
    }
    return switchWidget;
  }

  Expression _emitSizedBox(SizedBoxNode node) {
    return refer('SizedBox').newInstance([], {
      if (node.width != null) 'width': literalNum(node.width!),
      if (node.height != null) 'height': literalNum(node.height!),
      if (node.child != null) 'child': emit(node.child!),
    });
  }

  Expression _emitExpanded(ExpandedNode node) {
    return refer('Expanded').newInstance([], {
      'child': emit(node.child),
      if (node.flex != null) 'flex': literalNum(node.flex!),
    });
  }

  Expression _emitIconButton(IconButtonNode node) {
    return refer('IconButton').newInstance([], {
      'icon':
          refer('Icon').newInstance([refer('AppIcons').property(node.icon)]),
      'onPressed': node.onPressed != null
          ? refer(variableMap[node.onPressed!] ?? node.onPressed!)
          : literalNull,
      if (node.size != null) 'iconSize': literalNum(node.size!),
      if (node.color != null) 'color': _emitColorSemantic(node.color!),
    });
  }

  Expression _emitStack(StackNode node) {
    return refer('Stack').newInstance([], {
      'children': literalList(node.children.map(emit).toList()),
      if (node.fit != null) 'fit': refer('StackFit.${node.fit!.name}'),
      if (node.alignment != null) 'alignment': _emitAlignment(node.alignment!),
    });
  }

  Expression _emitGridView(GridViewNode node) {
    // Generate children list
    List<Expression> children = node.children.map(emit).toList();

    // Calculate spacing values
    final mainAxisSpacing =
        node.spacing != null ? (double.tryParse(node.spacing!) ?? 16.0) : 16.0;
    final crossAxisSpacing = node.crossAxisSpacing != null
        ? (double.tryParse(node.crossAxisSpacing!) ?? 16.0)
        : 16.0;

    return refer('GridView').property('count').call([], {
      'crossAxisCount': literalNum(node.crossAxisCount),
      'children': literalList(children),
      'mainAxisSpacing': literalNum(mainAxisSpacing),
      'crossAxisSpacing': literalNum(crossAxisSpacing),
      if (node.childAspectRatio != null)
        'childAspectRatio': literalNum(node.childAspectRatio!),
      if (node.shrinkWrap == true) 'shrinkWrap': literalTrue,
    });
  }

  Expression _emitPadding(PaddingNode node) {
    return refer('Padding').newInstance([], {
      'padding': _parseEdgeInsets(node.padding),
      'child': emit(node.child),
    });
  }

  Expression _emitCenter(CenterNode node) {
    return refer('Center').newInstance([], {
      'child': emit(node.child),
    });
  }

  Expression _emitDropdown(DropdownNode node) {
    // Generate dropdown items
    final items = literalList(
      node.items
          .map((item) => refer('DropdownMenuItem').newInstance([], {
                'value': literalString(item),
                'child': refer('Text').newInstance([literalString(item)]),
              }))
          .toList(),
    );

    return refer('DropdownButtonFormField').newInstance([], {
      'value': refer(node.binding),
      'items': items,
      'onChanged': node.onChanged != null
          ? refer(variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) {}'),
      if (node.label != null)
        'decoration': refer('InputDecoration').newInstance([], {
          'labelText': literalString(node.label!),
        }),
    });
  }

  Expression _emitRadio(RadioNode node) {
    // If has label, wrap in Row for label + radio layout
    final radio = refer('AppRadio').newInstance([], {
      'value': literalString(node.value),
      'groupValue': refer(node.binding),
      'onChanged': node.onChanged != null
          ? refer(variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) {}'),
    });

    if (node.label != null) {
      return refer('Row').newInstance([], {
        'children': literalList([
          radio,
          refer('SizedBox').newInstance([], {'width': literalNum(8)}),
          refer('Text').newInstance([literalString(node.label!)]),
        ]),
      });
    }
    return radio;
  }

  Expression _emitSlider(SliderNode node) {
    final slider = refer('AppSlider').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
      if (node.min != null) 'min': literalNum(node.min!),
      if (node.max != null) 'max': literalNum(node.max!),
      if (node.divisions != null) 'divisions': literalNum(node.divisions!),
      if (node.label != null) 'label': literalString(node.label!),
    });

    // If label provided, wrap in Column for label + slider layout
    if (node.label != null) {
      return refer('Column').newInstance([], {
        'crossAxisAlignment': refer('CrossAxisAlignment.start'),
        'children': literalList([
          refer('Text').newInstance([literalString(node.label!)]),
          slider,
        ]),
      });
    }
    return slider;
  }

  // --- Helper Methods ---

  /// Emits a ColorSemantic enum as an AppColors reference.
  ///
  /// Maps semantic color names to the generated AppColors class.
  Expression _emitColorSemantic(ColorSemantic semantic) {
    return refer('AppColors').property(semantic.name);
  }

  /// Emits an AlignmentEnum as a Flutter Alignment reference.
  Expression _emitAlignment(AlignmentEnum alignment) {
    final alignmentMap = {
      AlignmentEnum.topLeft: 'topLeft',
      AlignmentEnum.topCenter: 'topCenter',
      AlignmentEnum.topRight: 'topRight',
      AlignmentEnum.centerLeft: 'centerLeft',
      AlignmentEnum.center: 'center',
      AlignmentEnum.centerRight: 'centerRight',
      AlignmentEnum.bottomLeft: 'bottomLeft',
      AlignmentEnum.bottomCenter: 'bottomCenter',
      AlignmentEnum.bottomRight: 'bottomRight',
    };
    return refer('Alignment').property(alignmentMap[alignment]!);
  }

  /// Parses an EdgeInsets string into the appropriate EdgeInsets constructor call.
  ///
  /// Supported formats:
  /// - Single value: "16" -> EdgeInsets.all(16)
  /// - Two values: "16,8" -> EdgeInsets.symmetric(horizontal: 16, vertical: 8)
  /// - Four values: "16,8,16,8" -> EdgeInsets.fromLTRB(16, 8, 16, 8)
  Expression _parseEdgeInsets(String value) {
    final parts = value.split(',').map((s) => s.trim()).toList();

    if (parts.length == 1) {
      // Single value: EdgeInsets.all(value)
      final num = double.tryParse(parts[0]) ?? 0.0;
      return refer('EdgeInsets').property('all').call([literalNum(num)]);
    } else if (parts.length == 2) {
      // Two values: EdgeInsets.symmetric(horizontal: h, vertical: v)
      final horizontal = double.tryParse(parts[0]) ?? 0.0;
      final vertical = double.tryParse(parts[1]) ?? 0.0;
      return refer('EdgeInsets').property('symmetric').call([], {
        'horizontal': literalNum(horizontal),
        'vertical': literalNum(vertical),
      });
    } else if (parts.length == 4) {
      // Four values: EdgeInsets.fromLTRB(left, top, right, bottom)
      final left = double.tryParse(parts[0]) ?? 0.0;
      final top = double.tryParse(parts[1]) ?? 0.0;
      final right = double.tryParse(parts[2]) ?? 0.0;
      final bottom = double.tryParse(parts[3]) ?? 0.0;
      return refer('EdgeInsets').property('fromLTRB').call([
        literalNum(left),
        literalNum(top),
        literalNum(right),
        literalNum(bottom),
      ]);
    } else {
      // Invalid format, default to all(16)
      return refer('EdgeInsets').property('all').call([literalNum(16.0)]);
    }
  }
}
