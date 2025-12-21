// ============================================
// SYNTAXIFY DEMO APP
// ============================================
// This demo shows what comes from Syntaxify vs native Flutter
//
// LEGEND:
// 🎨 SYNTAXIFY - Design system features (AppTheme, styles)
// 🎯 SYNTAXIFY - Button components (AppButton)
// 📝 SYNTAXIFY - Text components (AppText)
// ⌨️  SYNTAXIFY - Input components (AppInput)
// 🌟 SYNTAXIFY - Generated screens from .screen.dart files
// [No emoji] - Native Flutter widgets
// ============================================

// Native Flutter imports
import 'package:flutter/material.dart';

// Syntaxify imports - generated components and design system
import 'package:example/syntaxify/index.dart';

// Generated screen from meta/login.screen.dart
import 'package:example/screens/login_screen.dart';

// Tabs
import 'package:example/overview_tab.dart';

void main() {
  runApp(const MyApp()); // Native Flutter
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DesignStyle _currentStyle = MaterialStyle();
  String _currentStyleName = 'Material';

  void _switchStyle(DesignStyle style, String name) {
    setState(() {
      _currentStyle = style;
      _currentStyleName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      // 🎨 SYNTAXIFY: Design system wrapper
      style: _currentStyle, // Switch between Material/Cupertino/Neo
      child: MaterialApp(
        // Native Flutter
        title: 'Syntaxify Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: SyntaxifyDemoScreen(
          currentStyleName: _currentStyleName,
          onStyleChanged: _switchStyle,
        ),
      ),
    );
  }
}

class SyntaxifyDemoScreen extends StatefulWidget {
  final String currentStyleName;
  final Function(DesignStyle, String) onStyleChanged;

  const SyntaxifyDemoScreen({
    super.key,
    required this.currentStyleName,
    required this.onStyleChanged,
  });

  @override
  State<SyntaxifyDemoScreen> createState() => _SyntaxifyDemoScreenState();
}

class _SyntaxifyDemoScreenState extends State<SyntaxifyDemoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syntaxify Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Overview'),
            Tab(icon: Icon(Icons.smart_button), text: 'Buttons'),
            Tab(icon: Icon(Icons.text_fields), text: 'Inputs'),
            Tab(icon: Icon(Icons.screen_share), text: 'Screens'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTab(
            currentStyleName: widget.currentStyleName,
            onStyleChanged: widget.onStyleChanged,
          ),
          const ButtonsTab(),
          const InputsTab(),
          const ScreensTab(),
        ],
      ),
    );
  }
}

// BUTTONS TAB
// ============================================
class ButtonsTab extends StatefulWidget {
  const ButtonsTab({super.key});

  @override
  State<ButtonsTab> createState() => _ButtonsTabState();
}

class _ButtonsTabState extends State<ButtonsTab> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            text: 'Button Components',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 8),
          AppText(
            text: 'Syntaxify buttons adapt to the selected design style.',
            variant: TextVariant.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Button Variants
          AppText(
            text: 'Variants',
            variant: TextVariant.titleMedium,
          ), // 📝 SYNTAXIFY
          const SizedBox(height: 16), // Native Flutter
          // 🎯 SYNTAXIFY: Primary button - renders as ElevatedButton (Material),
          // CupertinoButton.filled (Cupertino), or custom Neo style
          AppButton.primary(
            label: 'Primary Button',
            onPressed: () => _showSnackBar(context, 'Primary button pressed'),
          ),
          const SizedBox(height: 12), // Native Flutter
          // 🎯 SYNTAXIFY: Secondary button variant
          AppButton.secondary(
            label: 'Secondary Button',
            onPressed: () => _showSnackBar(context, 'Secondary button pressed'),
          ),
          const SizedBox(height: 12), // Native Flutter
          // 🎯 SYNTAXIFY: Outlined button variant
          AppButton.outlined(
            label: 'Outlined Button',
            onPressed: () => _showSnackBar(context, 'Outlined button pressed'),
          ),
          const SizedBox(height: 12), // Native Flutter
          // 🎯 SYNTAXIFY: Disabled state
          AppButton.primary(
            label: 'Disabled Button',
            onPressed: null,
            isDisabled: true,
          ),
          const SizedBox(height: 32),

          // Interactive Demo
          AppText(text: 'Interactive Demo', variant: TextVariant.titleMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                AppText(
                  text: 'Counter: $_counter',
                  variant: TextVariant.headlineMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton.outlined(
                      label: 'Reset',
                      onPressed: () => setState(() => _counter = 0),
                    ),
                    const SizedBox(width: 16),
                    AppButton.primary(
                      label: 'Increment',
                      onPressed: () => setState(() => _counter++),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Typography Scale - Same component, different variants!
          AppText(text: 'Typography Scale', variant: TextVariant.titleMedium),
          const SizedBox(height: 16),

          // 📝 SYNTAXIFY: All use AppText, just different variants
          // Each adapts to the current design style (Material/Cupertino/Neo)
          AppText(text: 'Display Large', variant: TextVariant.displayLarge),
          const SizedBox(height: 8),
          AppText(text: 'Headline Medium', variant: TextVariant.headlineMedium),
          const SizedBox(height: 8),
          AppText(text: 'Title Medium', variant: TextVariant.titleMedium),
          const SizedBox(height: 8),
          AppText(text: 'Body Large', variant: TextVariant.bodyLarge),
          const SizedBox(height: 8),
          AppText(text: 'Body Medium', variant: TextVariant.bodyMedium),
          const SizedBox(height: 8),
          AppText(text: 'Label Small', variant: TextVariant.labelSmall),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}

// ============================================
// INPUTS TAB
// ============================================
class InputsTab extends StatefulWidget {
  const InputsTab({super.key});

  @override
  State<InputsTab> createState() => _InputsTabState();
}

class _InputsTabState extends State<InputsTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            text: 'Input Components',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 8),
          AppText(
            text:
                'Text input fields with different keyboard types and configurations.',
            variant: TextVariant.bodyLarge,
          ),
          const SizedBox(height: 32),

          AppText(
            text: 'Standard Inputs',
            variant: TextVariant.titleMedium,
          ), // 📝 SYNTAXIFY
          const SizedBox(height: 16), // Native Flutter
          // ⌨️ SYNTAXIFY: AppInput with email keyboard type
          // Renders as TextField (Material) or CupertinoTextField (Cupertino)
          AppInput(
            label: 'Email',
            controller: _emailController, // Native Flutter controller
            keyboardType: TextInputType.emailAddress, // Native Flutter enum
            hint: 'Enter your email',
          ),
          const SizedBox(height: 16), // Native Flutter
          // ⌨️ SYNTAXIFY: Password input with obscureText
          AppInput(
            label: 'Password',
            controller: _passwordController,
            obscureText: true, // Hides text input
            hint: 'Enter your password',
          ),
          const SizedBox(height: 16), // Native Flutter
          // ⌨️ SYNTAXIFY: Phone input with phone keyboard
          AppInput(
            label: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            hint: '+1 (555) 123-4567',
          ),
          const SizedBox(height: 32),

          // Form Demo
          AppText(text: 'Form Example', variant: TextVariant.titleMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText(text: 'Contact Form', variant: TextVariant.titleMedium),
                const SizedBox(height: 16),
                AppInput(label: 'Name', hint: 'John Doe'),
                const SizedBox(height: 12),
                AppInput(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  hint: 'john@example.com',
                ),
                const SizedBox(height: 12),
                AppInput(label: 'Message', hint: 'Type your message here...'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.outlined(
                        label: 'Clear',
                        onPressed: () {
                          _emailController.clear();
                          _passwordController.clear();
                          _phoneController.clear();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton.primary(
                        label: 'Submit',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Form submitted!')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// SCREENS TAB
// ============================================
class ScreensTab extends StatelessWidget {
  const ScreensTab({super.key});

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(text: 'Screen Generation', variant: TextVariant.displayLarge),
          const SizedBox(height: 8),
          AppText(
            text: 'The Power of .screen.dart Files',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 16),
          AppText(
            text:
                'Create entire Flutter screens with just a simple definition file. No boilerplate, no repetition - just describe your UI structure.',
            variant: TextVariant.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Highlighted Process
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.15),
                  Colors.purple.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.blue, size: 32),
                    const SizedBox(width: 12),
                    AppText(
                      text: 'How It Works',
                      variant: TextVariant.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildStep('1', 'Create login.screen.dart in meta/ folder'),
                _buildStep('2', 'Run: dart run syntaxify build'),
                _buildStep('3', 'Get lib/screens/login_screen.dart'),
                _buildStep('4', 'Edit freely - it\'s yours now!'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          AppText(text: 'Live Example', variant: TextVariant.headlineMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.amber.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.file_present, color: Colors.amber[800], size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'meta/login.screen.dart',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Generated → lib/screens/login_screen.dart',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Center(
            // Native Flutter
            child: AppButton.primary(
              // 🎯 SYNTAXIFY component
              label: 'View Generated Login Screen',
              onPressed: () {
                Navigator.of(context).push(
                  // Native Flutter navigation
                  MaterialPageRoute(
                    // Native Flutter
                    builder: (context) => LoginScreen(
                      // 🌟 GENERATED from login.screen.dart!
                      handleLogin: () {
                        Navigator.of(context).pop(); // Native Flutter
                        ScaffoldMessenger.of(context).showSnackBar(
                          // Native Flutter
                          const SnackBar(
                            content: Text(
                              'Login button pressed from generated screen!',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          // Code Preview
          AppText(
            text: 'What\'s Inside login.screen.dart?',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 8),
          AppText(
            text:
                'Just a simple, declarative structure - Syntaxify handles the rest!',
            variant: TextVariant.bodyMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Text('''final loginScreen = ScreenDefinition(
  id: 'login',
  layout: LayoutNode.column(children: [
    LayoutNode.text(text: 'Welcome Back'),
    LayoutNode.textField(
      label: 'Email',
      keyboardType: KeyboardType.emailAddress
    ),
    LayoutNode.textField(
      label: 'Password',
      obscureText: true
    ),
    LayoutNode.button(
      label: 'Sign In',
      onPressed: 'handleLogin'
    ),
  ]),
);''', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
