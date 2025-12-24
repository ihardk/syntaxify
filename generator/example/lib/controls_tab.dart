import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';

class ControlsTab extends StatefulWidget {
  const ControlsTab({super.key});

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  // Checkbox state
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkbox3 = false;

  // Toggle state
  bool _switch1 = false;
  bool _switch2 = true;

  // Slider state
  double _slider1 = 0.5;
  double _slider2 = 20.0;

  // Radio state
  String _radioValue = 'option1';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppText(
            text: 'Control Components',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 8),
          const AppText(
            text:
                'Interactive elements that adapt to the selected design style.',
            variant: TextVariant.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Checkboxes
          _buildSectionHeader('Checkboxes'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _buildBoxDecoration(context),
            child: Column(
              children: [
                Row(
                  children: [
                    // Simple Checkbox
                    AppCheckbox(
                      value: _checkbox1,
                      onChanged: (v) => setState(() => _checkbox1 = v ?? false),
                    ),
                    const SizedBox(width: 8),
                    const Text('Simple Checkbox'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Checked by default
                    AppCheckbox(
                      value: _checkbox2,
                      onChanged: (v) => setState(() => _checkbox2 = v ?? false),
                    ),
                    const SizedBox(width: 8),
                    const Text('Checked State'),
                  ],
                ),
                const SizedBox(height: 12),
                // Indeterminate simulation (disabled for now as API takes bool?)
                // Actually our AppCheckbox takes bool? value, so it supports null (tristate) if needed
                // But let's stick to true/false for demo
                Row(
                  children: [
                    AppCheckbox(
                      value: _checkbox3,
                      onChanged: (v) => setState(() => _checkbox3 = v ?? false),
                    ),
                    const SizedBox(width: 8),
                    const Text('Another Option'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Switches
          _buildSectionHeader('Switches'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _buildBoxDecoration(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Notifications'),
                    AppSwitch(
                      value: _switch1,
                      onChanged: (v) => setState(() => _switch1 = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode (Demo)'),
                    AppSwitch(
                      value: _switch2,
                      onChanged: (v) => setState(() => _switch2 = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Sliders
          _buildSectionHeader('Sliders'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _buildBoxDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Continuous Value: ${_slider1.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                AppSlider(
                  value: _slider1,
                  onChanged: (v) => setState(() => _slider1 = v),
                ),
                const SizedBox(height: 24),
                Text('Discrete Steps (0-100): ${_slider2.round()}'),
                const SizedBox(height: 8),
                AppSlider(
                  value: _slider2,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: _slider2.round().toString(),
                  onChanged: (v) => setState(() => _slider2 = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Radio Buttons
          _buildSectionHeader('Radio Buttons'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _buildBoxDecoration(context),
            child: Column(
              children: [
                _buildRadioOption('Option 1', 'option1'),
                const SizedBox(height: 8),
                _buildRadioOption('Option 2', 'option2'),
                const SizedBox(height: 8),
                _buildRadioOption('Option 3', 'option3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppText(text: title, variant: TextVariant.titleMedium),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      border:
          Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      children: [
        AppRadio<String>(
          value: value,
          groupValue: _radioValue,
          onChanged: (v) => setState(() => _radioValue = v!),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => setState(() => _radioValue = value),
          child: Text(label),
        ),
      ],
    );
  }
}
