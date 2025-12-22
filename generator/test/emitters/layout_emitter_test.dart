import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:syntaxify/src/models/ast/nodes.dart';
import 'package:test/test.dart';

void main() {
  final emitter = DartEmitter(useNullSafetySyntax: true);
  final formatter =
      DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
  const layoutEmitter = LayoutEmitter();

  String emit(LayoutNode node) {
    final expression = layoutEmitter.emit(node);
    // Wrap in a statement so DartFormatter can handle it
    final statement = expression.assignFinal('w').statement;
    return formatter.format('${statement.accept(emitter)}');
  }

  group('LayoutEmitter', () {
    test('emits Text widget', () {
      final node = LayoutNode.text(
        text: 'Hello World',
        variant: TextVariant.headlineMedium,
      );

      final code = emit(node);
      expect(code, contains("'Hello World'"));
      // Emitter uses AppText with TextVariant
      expect(code, contains('AppText'));
      expect(code, contains('TextVariant.headlineMedium'));
    });

    test('emits Button widget (Filled)', () {
      final node = LayoutNode.button(
        label: 'Submit',
        variant: 'filled',
        onPressed: 'submitData',
      );

      final code = emit(node);
      // Updated expectation for AppButton
      expect(code, contains('AppButton('));
      expect(code, contains("'Submit'"));
      // variant: ButtonVariant.filled is default, so it's not emitted
      expect(code, contains("onPressed: submitData"));
    });

    test('emits TextField widget', () {
      final node = LayoutNode.textField(
        label: 'Username',
        hint: 'Enter here',
        obscureText: true,
      );

      final code = emit(node);
      // Updated expectation for AppInput
      expect(code, contains('AppInput('));
      expect(code, contains("label: 'Username'"));
      expect(code, contains("hint: 'Enter here'"));
      expect(code, contains("obscureText: true"));
    });
  });

  // ============================================================
  // NEW STRUCTURAL NODE TESTS
  // ============================================================

  group('LayoutEmitter - Structural Nodes', () {
    test('emits Container with all properties', () {
      final node = LayoutNode.container(
        width: 200,
        height: 100,
        padding: '16',
        margin: '8',
        color: ColorSemantic.primary,
        borderRadius: 12,
        child: LayoutNode.text(text: 'Inside container'),
      );

      final code = emit(node);
      expect(code, contains('Container('));
      expect(code, contains('width: 200'));
      expect(code, contains('height: 100'));
      expect(code, contains('EdgeInsets.all(16'));
      expect(code, contains('EdgeInsets.all(8'));
      expect(code, contains('AppColors.primary'));
      expect(code, contains('BorderRadius.circular(12'));
      expect(code, contains('child:'));
    });

    test('emits Card with children and elevation', () {
      final node = LayoutNode.card(
        children: [
          LayoutNode.text(text: 'Card Title'),
          LayoutNode.text(text: 'Card Body'),
        ],
        padding: '16',
        elevation: 4,
      );

      final code = emit(node);
      expect(code, contains('Card('));
      expect(code, contains('elevation: 4'));
      expect(code, contains('Padding('));
      expect(code, contains('Column('));
      expect(code, contains("'Card Title'"));
      expect(code, contains("'Card Body'"));
    });

    test('emits ListView with scrollDirection and shrinkWrap', () {
      final node = LayoutNode.listView(
        children: [
          LayoutNode.text(text: 'Item 1'),
          LayoutNode.text(text: 'Item 2'),
        ],
        scrollDirection: SyntaxAxis.horizontal,
        shrinkWrap: true,
      );

      final code = emit(node);
      expect(code, contains('ListView('));
      expect(code, contains('scrollDirection: Axis.horizontal'));
      expect(code, contains('shrinkWrap: true'));
      expect(code, contains('children:'));
    });

    test('emits Stack with fit and alignment', () {
      final node = LayoutNode.stack(
        children: [
          LayoutNode.text(text: 'Background'),
          LayoutNode.text(text: 'Foreground'),
        ],
        fit: StackFit.expand,
        alignment: AlignmentEnum.center,
      );

      final code = emit(node);
      expect(code, contains('Stack('));
      expect(code, contains('fit: StackFit.expand'));
      expect(code, contains('alignment: Alignment.center'));
      expect(code, contains('children:'));
    });

    test('emits GridView with crossAxisCount and spacing', () {
      final node = LayoutNode.gridView(
        children: [
          LayoutNode.text(text: 'Grid Item 1'),
          LayoutNode.text(text: 'Grid Item 2'),
          LayoutNode.text(text: 'Grid Item 3'),
          LayoutNode.text(text: 'Grid Item 4'),
        ],
        crossAxisCount: 2,
        spacing: '8',
        crossAxisSpacing: '8',
        childAspectRatio: 1.5,
        shrinkWrap: true,
      );

      final code = emit(node);
      expect(code, contains('GridView.count('));
      expect(code, contains('crossAxisCount: 2'));
      expect(code, contains('mainAxisSpacing: 8'));
      expect(code, contains('crossAxisSpacing: 8'));
      expect(code, contains('childAspectRatio: 1.5'));
      expect(code, contains('shrinkWrap: true'));
    });

    test('emits Padding with child', () {
      final node = LayoutNode.padding(
        padding: '16,8',
        child: LayoutNode.text(text: 'Padded text'),
      );

      final code = emit(node);
      expect(code, contains('Padding('));
      expect(code, contains('EdgeInsets.symmetric('));
      expect(code, contains('horizontal: 16'));
      expect(code, contains('vertical: 8'));
      expect(code, contains('child:'));
    });

    test('emits Center with child', () {
      final node = LayoutNode.center(
        child: LayoutNode.text(text: 'Centered text'),
      );

      final code = emit(node);
      expect(code, contains('Center('));
      expect(code, contains('child:'));
      expect(code, contains("'Centered text'"));
    });
  });

  // ============================================================
  // NEW PRIMITIVE NODE TESTS
  // ============================================================

  group('LayoutEmitter - Primitive Nodes', () {
    test('emits Image with network URL', () {
      final node = LayoutNode.image(
        src: 'https://example.com/image.png',
        width: 100,
        height: 100,
        fit: ImageFit.cover,
      );

      final code = emit(node);
      expect(code, contains('Image.network('));
      expect(code, contains("'https://example.com/image.png'"));
      expect(code, contains('width: 100'));
      expect(code, contains('height: 100'));
      expect(code, contains('fit: BoxFit.cover'));
    });

    test('emits Image with asset path', () {
      final node = LayoutNode.image(
        src: 'assets/images/logo.png',
        width: 50,
      );

      final code = emit(node);
      expect(code, contains('Image.asset('));
      expect(code, contains("'assets/images/logo.png'"));
      expect(code, contains('width: 50'));
    });

    test('emits Divider with properties', () {
      final node = LayoutNode.divider(
        thickness: 2,
        indent: 16,
        endIndent: 16,
      );

      final code = emit(node);
      expect(code, contains('Divider('));
      expect(code, contains('thickness: 2'));
      expect(code, contains('indent: 16'));
      expect(code, contains('endIndent: 16'));
    });

    test('emits CircularProgressIndicator with value', () {
      final node = LayoutNode.circularProgressIndicator(
        value: 0.75,
        strokeWidth: 4,
      );

      final code = emit(node);
      expect(code, contains('CircularProgressIndicator('));
      expect(code, contains('value: 0.75'));
      expect(code, contains('strokeWidth: 4'));
    });

    test('emits SizedBox with dimensions', () {
      final node = LayoutNode.sizedBox(
        width: 100,
        height: 50,
        child: LayoutNode.text(text: 'Inside SizedBox'),
      );

      final code = emit(node);
      expect(code, contains('SizedBox('));
      expect(code, contains('width: 100'));
      expect(code, contains('height: 50'));
      expect(code, contains('child:'));
    });

    test('emits Expanded with flex', () {
      final node = LayoutNode.expanded(
        flex: 2,
        child: LayoutNode.text(text: 'Expanded child'),
      );

      final code = emit(node);
      expect(code, contains('Expanded('));
      expect(code, contains('flex: 2'));
      expect(code, contains('child:'));
    });
  });

  // ============================================================
  // NEW INTERACTIVE NODE TESTS
  // ============================================================

  group('LayoutEmitter - Interactive Nodes', () {
    test('emits Checkbox with binding and label', () {
      final node = LayoutNode.checkbox(
        binding: 'isChecked',
        label: 'Agree to terms',
        onChanged: 'onCheckboxChanged',
        tristate: true,
      );

      final code = emit(node);
      expect(code, contains('AppCheckbox('));
      expect(code, contains('value: isChecked'));
      expect(code, contains('onChanged: onCheckboxChanged'));
      expect(code, contains("'Agree to terms'"));
    });

    test('emits Switch with binding and label', () {
      final node = LayoutNode.switchWidget(
        binding: 'isEnabled',
        label: 'Enable notifications',
        onChanged: 'onSwitchChanged',
      );

      final code = emit(node);
      expect(code, contains('AppSwitch('));
      expect(code, contains('value: isEnabled'));
      expect(code, contains('onChanged: onSwitchChanged'));
      expect(code, contains("'Enable notifications'"));
    });

    test('emits IconButton with icon and callback', () {
      final node = LayoutNode.iconButton(
        icon: 'settings',
        onPressed: 'onSettingsPressed',
        size: 24,
        color: ColorSemantic.primary,
      );

      final code = emit(node);
      expect(code, contains('IconButton('));
      expect(code, contains('Icon(AppIcons.settings)'));
      expect(code, contains('onPressed: onSettingsPressed'));
      expect(code, contains('iconSize: 24'));
      expect(code, contains('color: AppColors.primary'));
    });

    test('emits Dropdown with items and binding', () {
      final node = LayoutNode.dropdown(
        binding: 'selectedOption',
        items: ['Option 1', 'Option 2', 'Option 3'],
        label: 'Select an option',
        onChanged: 'onDropdownChanged',
      );

      final code = emit(node);
      expect(code, contains('DropdownButtonFormField('));
      expect(code, contains('value: selectedOption'));
      expect(code, contains('items:'));
      expect(code, contains('DropdownMenuItem('));
      expect(code, contains("'Option 1'"));
      expect(code, contains("'Option 2'"));
      expect(code, contains("'Option 3'"));
      expect(code, contains('InputDecoration('));
      expect(code, contains("labelText: 'Select an option'"));
    });

    test('emits Radio with binding and value', () {
      final node = LayoutNode.radio(
        binding: 'selectedGender',
        value: 'male',
        label: 'Male',
        onChanged: 'onRadioChanged',
      );

      final code = emit(node);
      expect(code, contains('AppRadio('));
      expect(code, contains("value: 'male'"));
      expect(code, contains('groupValue: selectedGender'));
      expect(code, contains('onChanged: onRadioChanged'));
      expect(code, contains("'Male'"));
    });

    test('emits Slider with min, max, and divisions', () {
      final node = LayoutNode.slider(
        binding: 'volume',
        min: 0,
        max: 100,
        divisions: 10,
        label: 'Volume',
        onChanged: 'onSliderChanged',
      );

      final code = emit(node);
      expect(code, contains('AppSlider('));
      expect(code, contains('value: volume'));
      expect(code, contains('min: 0'));
      expect(code, contains('max: 100'));
      expect(code, contains('divisions: 10'));
      expect(code, contains("label: 'Volume'"));
      expect(code, contains('onChanged: onSliderChanged'));
    });
  });
}
