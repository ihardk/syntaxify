import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:syntaxify/src/emitters/strategies/node_emit_strategy.dart';

/// Emitter strategy for interactive input nodes.
///
/// Handles: Button, TextField, Checkbox, Toggle, IconButton, Dropdown,
/// Radio, Slider.
class InteractiveEmitStrategy implements NodeEmitStrategy {
  @override
  Expression emit(dynamic node, EmitContext context) {
    if (node is InteractiveNode) {
      return node.map(
        button: (n) => _emitButton(n, context),
        textField: (n) => _emitTextField(n, context),
        checkbox: (n) => _emitCheckbox(n, context),
        toggleNode: (n) => _emitSwitch(n, context),
        iconButton: (n) => _emitIconButton(n, context),
        dropdown: (n) => _emitDropdown(n, context),
        radio: (n) => _emitRadio(n, context),
        slider: (n) => _emitSlider(n, context),
      );
    }
    throw ArgumentError('Expected InteractiveNode, got ${node.runtimeType}');
  }

  Expression _emitButton(ButtonNode node, EmitContext context) {
    final props = node.props;
    return refer('AppButton').newInstance([], {
      'label': literalString(node.label),
      'onPressed': node.onPressed != null
          ? refer(context.variableMap[node.onPressed!] ?? node.onPressed!)
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

  Expression _emitTextField(TextFieldNode node, EmitContext context) {
    final props = node.props;
    // Map KeyboardType enum to Flutter's TextInputType
    String? keyboardType;
    if (props?.keyboardType != null) {
      switch (props!.keyboardType!) {
        case KeyboardType.text:
          keyboardType = 'text';
          break;
        case KeyboardType.number:
          keyboardType = 'number';
          break;
        case KeyboardType.email:
          keyboardType = 'emailAddress';
          break;
        case KeyboardType.phone:
          keyboardType = 'phone';
          break;
        case KeyboardType.url:
          keyboardType = 'url';
          break;
        case KeyboardType.multiline:
          keyboardType = 'multiline';
          break;
      }
    }

    // Get controller from map
    final label = node.label ?? 'input';
    final controllerFieldName = context.controllerMap[label];

    return refer('AppInput').newInstance([], {
      if (node.label != null) 'label': literalString(node.label!),
      if (controllerFieldName != null)
        'controller': refer(controllerFieldName)
      else if (node.label != null)
        'controller': refer('_${_toCamelCase(node.label!)}Controller'),
      if (props?.hint != null) 'hint': literalString(props!.hint!),
      if (props?.obscureText == true) 'obscureText': literalTrue,
      if (keyboardType != null)
        'keyboardType': refer('TextInputType.$keyboardType'),
      if (props?.maxLines != null) 'maxLines': literalNum(props!.maxLines!),
      if (props?.prefixIcon != null)
        'prefixIcon': refer('Icons.${props!.prefixIcon!}'),
      if (props?.suffixIcon != null)
        'suffixIcon': refer('Icons.${props!.suffixIcon!}'),
    });
  }

  Expression _emitCheckbox(CheckboxNode node, EmitContext context) {
    final checkbox = refer('AppCheckbox').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(context.variableMap[node.onChanged!] ?? node.onChanged!)
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

  Expression _emitSwitch(ToggleNode node, EmitContext context) {
    final toggle = refer('AppSwitch').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(context.variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
    });

    if (node.label != null) {
      return refer('Row').newInstance([], {
        'mainAxisAlignment': refer('MainAxisAlignment.spaceBetween'),
        'children': literalList([
          refer('Text').newInstance([literalString(node.label!)]),
          toggle,
        ]),
      });
    }
    return toggle;
  }

  Expression _emitIconButton(IconButtonNode node, EmitContext context) {
    return refer('IconButton').newInstance([], {
      'icon':
          refer('Icon').newInstance([refer('AppIcons').property(node.icon)]),
      'onPressed': node.onPressed != null
          ? refer(context.variableMap[node.onPressed!] ?? node.onPressed!)
          : literalNull,
      if (node.size != null) 'iconSize': literalNum(node.size!),
      if (node.color != null) 'color': _emitColorSemantic(node.color!),
    });
  }

  Expression _emitDropdown(DropdownNode node, EmitContext context) {
    final items = literalList(
      node.items
          .map((item) => refer('DropdownMenuItem').newInstance([], {
                'value': literalString(item),
                'child': refer('Text').newInstance([literalString(item)]),
              }))
          .toList(),
    );

    return refer('DropdownButton').newInstance([], {
      'value': refer('_${node.binding}'),
      'items': items,
      'onChanged': node.onChanged != null
          ? refer(context.variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
      if (node.label != null)
        'hint': refer('Text').newInstance([literalString(node.label!)]),
    });
  }

  Expression _emitRadio(RadioNode node, EmitContext context) {
    final radio = refer('Radio').newInstance([], {
      'value': literalString(node.value),
      'groupValue': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(context.variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
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

  Expression _emitSlider(SliderNode node, EmitContext context) {
    final slider = refer('AppSlider').newInstance([], {
      'value': refer('_${node.binding}'),
      'onChanged': node.onChanged != null
          ? refer(context.variableMap[node.onChanged!] ?? node.onChanged!)
          : refer('(value) => setState(() => _${node.binding} = value)'),
      if (node.min != null) 'min': literalNum(node.min!),
      if (node.max != null) 'max': literalNum(node.max!),
      if (node.divisions != null) 'divisions': literalNum(node.divisions!),
    });

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

  Expression _emitColorSemantic(ColorSemantic semantic) {
    return refer('AppColors').property(semantic.name);
  }

  String _toCamelCase(String input) {
    return input
        .split(RegExp(r'[\s_-]+'))
        .asMap()
        .map((i, word) => MapEntry(
            i,
            i == 0
                ? word.toLowerCase()
                : word[0].toUpperCase() + word.substring(1).toLowerCase()))
        .values
        .join();
  }
}
