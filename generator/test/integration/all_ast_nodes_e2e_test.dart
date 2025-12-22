import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:test/test.dart';

/// Comprehensive E2E test using ALL AST node types.
///
/// This test verifies the complete pipeline:
/// AST Node → LayoutEmitter → code_builder Expression → Formatted Dart code
void main() {
  late LayoutEmitter emitter;
  late DartFormatter formatter;

  setUp(() {
    emitter = const LayoutEmitter();
    formatter =
        DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
  });

  String emit(LayoutNode node) {
    final expr = emitter.emit(node);
    final emitter_ = DartEmitter(useNullSafetySyntax: true);
    return expr.accept(emitter_).toString();
  }

  group('All AST Nodes E2E Test', () {
    test('builds screen with ALL structural nodes', () {
      // Test all 9 structural nodes
      final layout = LayoutNode.column(children: [
        LayoutNode.row(children: [
          LayoutNode.text(text: 'Row Item 1'),
          LayoutNode.text(text: 'Row Item 2'),
        ]),
        LayoutNode.container(
          width: 200,
          height: 100,
          color: ColorSemantic.surface,
          child: LayoutNode.text(text: 'Container'),
        ),
        LayoutNode.card(
          children: [LayoutNode.text(text: 'Card Content')],
          elevation: 4,
        ),
        LayoutNode.listView(
          children: [
            LayoutNode.text(text: 'List Item 1'),
            LayoutNode.text(text: 'List Item 2'),
          ],
          shrinkWrap: true,
        ),
        LayoutNode.stack(children: [
          LayoutNode.container(width: 100, height: 100),
          LayoutNode.center(child: LayoutNode.text(text: 'Centered')),
        ]),
        LayoutNode.gridView(
          crossAxisCount: 2,
          children: [
            LayoutNode.text(text: 'Grid 1'),
            LayoutNode.text(text: 'Grid 2'),
          ],
        ),
        LayoutNode.padding(
          padding: '16',
          child: LayoutNode.text(text: 'Padded'),
        ),
      ]);

      final code = emit(layout);

      // Verify all structural nodes present
      expect(code, contains('Column('));
      expect(code, contains('Row('));
      expect(code, contains('Container('));
      expect(code, contains('Card('));
      expect(code, contains('ListView('));
      expect(code, contains('Stack('));
      expect(code, contains('GridView.count('));
      expect(code, contains('Padding('));
      expect(code, contains('Center('));
    });

    test('builds screen with ALL primitive nodes', () {
      // Test all 8 primitive nodes
      final layout = LayoutNode.column(children: [
        LayoutNode.text(
            text: 'Hello World', variant: TextVariant.headlineMedium),
        LayoutNode.icon(name: 'star', size: IconSize.md),
        LayoutNode.spacer(size: SpacerSize.lg),
        LayoutNode.image(src: 'assets/logo.png', width: 100, height: 100),
        LayoutNode.divider(thickness: 2),
        LayoutNode.circularProgressIndicator(strokeWidth: 4),
        LayoutNode.sizedBox(width: 50, height: 50),
        LayoutNode.expanded(
          child: LayoutNode.text(text: 'Expanded Content'),
        ),
      ]);

      final code = emit(layout);

      // Verify all primitive nodes present
      expect(code, contains('AppText('));
      expect(code, contains('Icon('));
      expect(code,
          contains('SizedBox(')); // Spacer becomes SizedBox for sized spacers
      expect(code, contains('Image.asset('));
      expect(code, contains('Divider('));
      expect(code, contains('CircularProgressIndicator('));
      expect(code, contains('Expanded('));
    });

    test('builds screen with ALL interactive nodes', () {
      // Test all 8 interactive nodes
      final layout = LayoutNode.column(children: [
        LayoutNode.button(
          label: 'Click Me',
          onPressed: 'handleClick',
        ),
        LayoutNode.textField(
          label: 'Email',
          hint: 'Enter email',
        ),
        LayoutNode.checkbox(
          binding: 'isChecked',
          label: 'Accept terms',
        ),
        LayoutNode.switchWidget(
          binding: 'isEnabled',
          label: 'Enable',
        ),
        LayoutNode.iconButton(
          icon: 'settings',
          onPressed: 'handleSettings',
        ),
        LayoutNode.dropdown(
          binding: 'selectedItem',
          items: ['Option 1', 'Option 2'],
        ),
        LayoutNode.radio(
          binding: 'selectedOption',
          value: 'option1',
          label: 'Option 1',
        ),
        LayoutNode.slider(
          binding: 'sliderValue',
          min: 0,
          max: 100,
        ),
      ]);

      final code = emit(layout);

      // Verify all interactive nodes present (using App wrappers)
      expect(code, contains('AppButton('));
      expect(code, contains('AppInput('));
      expect(code, contains('AppCheckbox('));
      expect(code, contains('AppSwitch('));
      expect(code, contains('IconButton('));
      expect(code, contains('DropdownButtonFormField('));
      expect(code, contains('AppRadio('));
      expect(code, contains('AppSlider('));
    });

    test('builds complex nested layout with mixed nodes', () {
      // Complex real-world screen
      final layout = LayoutNode.column(
        mainAxisAlignment: SyntaxMainAxisAlignment.start,
        children: [
          // Header section
          LayoutNode.container(
            color: ColorSemantic.primary,
            padding: '16',
            child: LayoutNode.row(
              mainAxisAlignment: SyntaxMainAxisAlignment.spaceBetween,
              children: [
                LayoutNode.text(
                    text: 'Settings', variant: TextVariant.headlineMedium),
                LayoutNode.iconButton(icon: 'close', onPressed: 'handleClose'),
              ],
            ),
          ),
          LayoutNode.spacer(size: SpacerSize.lg),

          // Settings form
          LayoutNode.padding(
            padding: '16',
            child: LayoutNode.column(children: [
              LayoutNode.switchWidget(
                binding: 'notifications',
                label: 'Enable Notifications',
              ),
              LayoutNode.divider(),
              LayoutNode.switchWidget(
                binding: 'darkMode',
                label: 'Dark Mode',
              ),
              LayoutNode.divider(),
              LayoutNode.slider(
                binding: 'volume',
                min: 0,
                max: 100,
                label: 'Volume',
              ),
              LayoutNode.spacer(size: SpacerSize.xl),
              LayoutNode.button(
                label: 'Save Settings',
                onPressed: 'handleSave',
              ),
            ]),
          ),
        ],
      );

      final code = emit(layout);

      // Verify complex nesting works
      expect(code, contains('Column('));
      expect(code, contains('Container('));
      expect(code, contains('Row('));
      expect(code, contains('AppSwitch('));
      expect(code, contains('AppSlider('));
      expect(code, contains('AppButton('));
      expect(code, contains('Divider('));
    });

    test('LayoutValidator validates all node types without errors', () {
      final validator = LayoutValidator();

      // Create nodes of each type and validate
      final nodes = [
        // Structural
        LayoutNode.column(children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.row(children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.container(child: LayoutNode.text(text: 'Test')),
        LayoutNode.card(children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.listView(children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.stack(children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.gridView(
            crossAxisCount: 2, children: [LayoutNode.text(text: 'Test')]),
        LayoutNode.padding(padding: '16', child: LayoutNode.text(text: 'Test')),
        LayoutNode.center(child: LayoutNode.text(text: 'Test')),

        // Primitive
        LayoutNode.text(text: 'Test'),
        LayoutNode.icon(name: 'star'),
        LayoutNode.spacer(size: SpacerSize.md),
        LayoutNode.image(src: 'test.png'),
        LayoutNode.divider(),
        LayoutNode.circularProgressIndicator(),
        LayoutNode.sizedBox(width: 10),
        LayoutNode.expanded(child: LayoutNode.text(text: 'Test')),

        // Interactive
        LayoutNode.button(label: 'Test'),
        LayoutNode.textField(label: 'Test'),
        LayoutNode.checkbox(binding: 'test'),
        LayoutNode.switchWidget(binding: 'test'),
        LayoutNode.iconButton(icon: 'test'),
        LayoutNode.dropdown(binding: 'test', items: ['a', 'b']),
        LayoutNode.radio(binding: 'test', value: 'a'),
        LayoutNode.slider(binding: 'test'),
      ];

      for (final node in nodes) {
        final errors = validator.validate(node);
        expect(errors.where((e) => e.severity == ErrorSeverity.error), isEmpty,
            reason: 'Node should validate without errors');
      }
    });
  });
}
