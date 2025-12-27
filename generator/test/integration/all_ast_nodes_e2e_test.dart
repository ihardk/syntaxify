import 'package:code_builder/code_builder.dart';
import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/emitters/layout_emitter.dart';
import 'package:test/test.dart';

/// Comprehensive E2E test using ALL AST node types.
///
/// This test verifies the complete pipeline:
/// AST Node → LayoutEmitter → code_builder Expression → Formatted Dart code
void main() {
  late LayoutEmitter emitter;

  setUp(() {
    emitter = LayoutEmitter();
  });

  String emit(App node) {
    final expr = emitter.emit(node);
    final emitter_ = DartEmitter(useNullSafetySyntax: true);
    return expr.accept(emitter_).toString();
  }

  group('All AST Nodes E2E Test', () {
    test('builds screen with ALL structural nodes', () {
      // Test all 9 structural nodes
      final layout = App.column(children: [
        App.row(children: [
          App.text(text: 'Row Item 1'),
          App.text(text: 'Row Item 2'),
        ]),
        App.container(
          width: 200,
          height: 100,
          color: ColorSemantic.surface,
          child: App.text(text: 'Container'),
        ),
        App.card(
          children: [App.text(text: 'Card Content')],
          elevation: 4,
        ),
        App.listView(
          children: [
            App.text(text: 'List Item 1'),
            App.text(text: 'List Item 2'),
          ],
          shrinkWrap: true,
        ),
        App.stack(children: [
          App.container(width: 100, height: 100),
          App.center(child: App.text(text: 'Centered')),
        ]),
        App.gridView(
          crossAxisCount: 2,
          children: [
            App.text(text: 'Grid 1'),
            App.text(text: 'Grid 2'),
          ],
        ),
        App.padding(
          padding: '16',
          child: App.text(text: 'Padded'),
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
      final layout = App.column(children: [
        App.text(text: 'Hello World', variant: 'headlineMedium'),
        App.icon(name: 'star', size: IconSize.md),
        App.spacer(size: SpacerSize.lg),
        App.image(src: 'assets/logo.png', width: 100, height: 100),
        App.divider(thickness: 2),
        App.circularProgressIndicator(strokeWidth: 4),
        App.sizedBox(width: 50, height: 50),
        App.expanded(
          child: App.text(text: 'Expanded Content'),
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
      final layout = App.column(children: [
        App.button(
          label: 'Click Me',
          onPressed: 'handleClick',
        ),
        App.textField(
          label: 'Email',
          hint: 'Enter email',
        ),
        App.checkbox(
          binding: 'isChecked',
          label: 'Accept terms',
        ),
        App.toggle(
          binding: 'isEnabled',
          label: 'Enable',
        ),
        App.iconButton(
          icon: 'settings',
          onPressed: 'handleSettings',
        ),
        App.dropdown(
          binding: 'selectedItem',
          items: ['Option 1', 'Option 2'],
        ),
        App.radio(
          binding: 'selectedOption',
          value: 'option1',
          label: 'Option 1',
        ),
        App.slider(
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
      expect(code, contains('AppToggle('));
      expect(code, contains('IconButton('));
      expect(code, contains('DropdownButton('));
      expect(code, contains('Radio('));
      expect(code, contains('AppSlider('));
    });

    test('builds screen with custom nodes', () {
      // Test custom node for plugin extensibility
      final layout = App.column(children: [
        App.custom(
          CustomNode(
            type: 'SuperCard',
            props: {
              'title': 'Custom Component',
              'color': 'blue',
            },
            children: [
              App.text(text: 'Custom child content'),
            ],
          ),
        ),
        App.custom(
          CustomNode(
            type: 'Carousel',
            props: {
              'autoPlay': true,
              'interval': 3000,
            },
            children: [
              App.image(src: 'slide1.jpg'),
              App.image(src: 'slide2.jpg'),
            ],
          ),
        ),
      ]);

      final code = emit(layout);

      // Verify custom nodes are emitted
      expect(code, contains('Column('));
      expect(code, contains('SuperCard'));
      expect(code, contains('Carousel'));
    });

    test('builds complex nested layout with mixed nodes', () {
      // Complex real-world screen
      final layout = App.column(
        mainAxisAlignment: MainAlignment.start,
        children: [
          // Header section
          App.container(
            color: ColorSemantic.primary,
            padding: '16',
            child: App.row(
              mainAxisAlignment: MainAlignment.spaceBetween,
              children: [
                App.text(text: 'Settings', variant: 'headlineMedium'),
                App.iconButton(icon: 'close', onPressed: 'handleClose'),
              ],
            ),
          ),
          App.spacer(size: SpacerSize.lg),

          // Settings form
          App.padding(
            padding: '16',
            child: App.column(children: [
              App.toggle(
                binding: 'notifications',
                label: 'Enable Notifications',
              ),
              App.divider(),
              App.toggle(
                binding: 'darkMode',
                label: 'Dark Mode',
              ),
              App.divider(),
              App.slider(
                binding: 'volume',
                min: 0,
                max: 100,
                label: 'Volume',
              ),
              App.spacer(size: SpacerSize.xl),
              App.button(
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
      expect(code, contains('AppToggle('));
      expect(code, contains('AppSlider('));
      expect(code, contains('AppButton('));
      expect(code, contains('Divider('));
    });

    test('LayoutValidator validates all node types without errors', () {
      final validator = LayoutValidator();

      // Create nodes of each type and validate - all 26 node types
      final nodes = [
        // Structural (9 nodes)
        App.column(children: [App.text(text: 'Test')]),
        App.row(children: [App.text(text: 'Test')]),
        App.container(child: App.text(text: 'Test')),
        App.card(children: [App.text(text: 'Test')]),
        App.listView(children: [App.text(text: 'Test')]),
        App.stack(children: [App.text(text: 'Test')]),
        App.gridView(crossAxisCount: 2, children: [App.text(text: 'Test')]),
        App.padding(padding: '16', child: App.text(text: 'Test')),
        App.center(child: App.text(text: 'Test')),

        // Primitive (8 nodes)
        App.text(text: 'Test'),
        App.icon(name: 'star'),
        App.spacer(size: SpacerSize.md),
        App.image(src: 'test.png'),
        App.divider(),
        App.circularProgressIndicator(),
        App.sizedBox(width: 10),
        App.expanded(child: App.text(text: 'Test')),

        // Interactive (8 nodes)
        App.button(label: 'Test'),
        App.textField(label: 'Test'),
        App.checkbox(binding: 'test'),
        App.toggle(binding: 'test'),
        App.iconButton(icon: 'test'),
        App.dropdown(binding: 'test', items: ['a', 'b']),
        App.radio(binding: 'test', value: 'a'),
        App.slider(binding: 'test'),

        // Custom (1 node)
        App.custom(
          CustomNode(
            type: 'CustomComponent',
            props: {'prop': 'value'},
            children: [App.text(text: 'Test')],
          ),
        ),
      ];

      for (final node in nodes) {
        final errors = validator.validate(node);
        expect(errors.where((e) => e.severity == ErrorSeverity.error), isEmpty,
            reason: 'Node should validate without errors');
      }
    });
  });
}
