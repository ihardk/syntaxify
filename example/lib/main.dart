/// Syntax Demo App
///
/// This app demonstrates the Syntax code generator's renderer pattern.
///
/// TRADITIONAL FLUTTER:
/// - Write ElevatedButton for Material
/// - Write CupertinoButton for iOS
/// - Write custom Container for your design
/// - Result: 3 different implementations
///
/// WITH SYNTAX:
/// - Define once: AppButton(label: 'Click', onPressed: ...)
/// - Renders as Material/Cupertino/Neo based on AppTheme
/// - Result: One definition, multiple renderings
///
/// See lib/syntax_arch.dart for the underlying philosophy.

import 'package:flutter/material.dart';
import 'package:example/syntax/index.dart';
import 'package:example/syntax/design_system/design_system.dart';

void main() {
  runApp(const SyntaxDemo());
}

class SyntaxDemo extends StatefulWidget {
  const SyntaxDemo({super.key});

  @override
  State<SyntaxDemo> createState() => _SyntaxDemoState();
}

class _SyntaxDemoState extends State<SyntaxDemo> {
  // SYNTAX: Single style variable controls entire app appearance
  // TRADITIONAL: Would need to rebuild widgets or use complex theming
  DesignStyle _currentStyle = MaterialStyle();
  String _inputText = '';

  void _switchStyle(DesignStyle style) {
    setState(() => _currentStyle = style);
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      style: _currentStyle,
      child: MaterialApp(
        title: 'Syntax Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text('Syntax Demo - Renderer Pattern'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Style Switcher
                  _buildStyleSwitcher(),

                  const SizedBox(height: 40),

                  // Components Demo
                  _buildComponentsDemo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyleSwitcher() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎨 Design Style',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Same components, different renderings:',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStyleChip('Material', MaterialStyle()),
              _buildStyleChip('Cupertino', CupertinoStyle()),
              _buildStyleChip('Neo', NeoStyle()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyleChip(String label, DesignStyle style) {
    final isSelected = _currentStyle.runtimeType == style.runtimeType;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _switchStyle(style),
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildComponentsDemo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SYNTAX: AppText with variant
          // TRADITIONAL: Text with Theme.of(context).textTheme.headlineMedium
          AppText(
            text: 'Welcome to Syntax',
            variant: TextVariant.headlineMedium,
          ),

          const SizedBox(height: 8),

          AppText(
            text: 'Generated components with the renderer pattern',
            variant: TextVariant.bodyMedium,
          ),

          const SizedBox(height: 32),

          // SYNTAX: AppInput with built-in styling
          // TRADITIONAL: TextField with InputDecoration, controllers, etc.
          AppInput(
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => setState(() => _inputText = value),
          ),

          const SizedBox(height: 16),

          AppInput(
            label: 'Password',
            hint: 'Enter your password',
            obscureText: true,
          ),

          const SizedBox(height: 24),

          // SYNTAX: AppButton with variants
          // TRADITIONAL: ElevatedButton/CupertinoButton/Custom Container
          // Same component, different rendering based on AppTheme!
          AppButton(
            label: 'Primary Button',
            variant: ButtonVariant.primary,
            onPressed: () => _showMessage('Primary button pressed!'),
          ),

          const SizedBox(height: 12),

          AppButton(
            label: 'Secondary Button',
            variant: ButtonVariant.outlined,
            onPressed: () => _showMessage('Secondary button pressed!'),
          ),

          const SizedBox(height: 12),

          AppButton(
            label: 'Text Button',
            variant: ButtonVariant.text,
            onPressed: () => _showMessage('Text button pressed!'),
          ),

          if (_inputText.isNotEmpty) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppText(
                text: 'You typed: $_inputText',
                variant: TextVariant.labelSmall,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
