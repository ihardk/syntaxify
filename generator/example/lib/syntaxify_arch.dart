/// Syntaxify Core Philosophy - The Renderer Pattern
///
/// This file demonstrates the underlying architecture of Syntaxify:
/// Separating WHAT (component definition) from HOW (visual rendering).
///
/// This is the philosophy that powers all of Syntaxify's generated components.
///⚠️ IMPORTANT: This is a PHILOSOPHY DEMONSTRATION
///
/// In real Syntaxify usage (see ../meta/ folder), you use annotations:
/// ```dart
/// @SyntaxComponent(description: 'A button')
/// class ButtonMeta {
///   @Required() final String label;
///   @Optional() final String? variant;
/// }
/// ```
///
/// Then run `syntaxify build` to generate AppButton, AppText, AppInput.
///
/// This file shows the CONCEPT that powers those generated components.
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ============================================================================
// PHILOSOPHY: Separate WHAT from HOW
// ============================================================================
//
// Traditional Flutter:
//   - You write ElevatedButton for Material
//   - You write CupertinoButton for iOS
//   - You write custom Container for your design
//   - Result: 3 different implementations, hard to maintain
//
// Syntaxify Approach:
//   - Define WHAT: "I want a button with this label and callback"
//   - Define HOW: "Render it using Material/Cupertino/Neo style"
//   - Result: One definition, multiple renderings
//
// ============================================================================

/// Design styles available
enum DesignStyle { material, cupertino, neo }

// ============================================================================
// PART 1: The "WHAT" - Component Specification
// ============================================================================

/// A UI node represents WHAT we want to display
/// It contains NO information about HOW to render it
class UINode {
  final String type;
  final dynamic spec;

  const UINode({required this.type, required this.spec});
}

/// Button specification - defines WHAT a button is
class MetaButtonSpec {
  final String label;
  final VoidCallback? onPressed;

  const MetaButtonSpec({required this.label, this.onPressed});
}

/// Input specification - defines WHAT an input is
class MetaInputSpec {
  final String placeholder;
  final ValueChanged<String>? onChanged;

  const MetaInputSpec({required this.placeholder, this.onChanged});
}

/// Badge specification - defines WHAT a badge is
class MetaBadgeSpec {
  final String label;

  const MetaBadgeSpec({required this.label});
}

/// Card specification - defines WHAT a card is
class MetaCardSpec {
  final Widget child;

  const MetaCardSpec({required this.child});
}

// ============================================================================
// PART 2: The "HOW" - Rendering Engine
// ============================================================================

/// The rendering engine decides HOW to render a UINode
/// based on the current DesignStyle
class UIEngine {
  /// Build a widget from a UINode using the specified style
  static Widget build(UINode node, DesignStyle style) {
    switch (node.type) {
      case 'button':
        return _renderButton(node.spec as MetaButtonSpec, style);
      case 'input':
        return _renderInput(node.spec as MetaInputSpec, style);
      case 'badge':
        return _renderBadge(node.spec as MetaBadgeSpec, style);
      case 'card':
        return _renderCard(node.spec as MetaCardSpec, style);
      default:
        return const Text('Unknown component');
    }
  }

  // ------------------------------------------------------------------------
  // Button Renderers - Same spec, different implementations
  // ------------------------------------------------------------------------

  static Widget _renderButton(MetaButtonSpec spec, DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return ElevatedButton(
          onPressed: spec.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(spec.label),
        );

      case DesignStyle.cupertino:
        return CupertinoButton.filled(
          onPressed: spec.onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(spec.label),
        );

      case DesignStyle.neo:
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE0E5EC), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(4, 4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: spec.onPressed,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Center(
                  child: Text(
                    spec.label,
                    style: const TextStyle(
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }

  // ------------------------------------------------------------------------
  // Input Renderers
  // ------------------------------------------------------------------------

  static Widget _renderInput(MetaInputSpec spec, DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return TextField(
          onChanged: spec.onChanged,
          decoration: InputDecoration(
            hintText: spec.placeholder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        );

      case DesignStyle.cupertino:
        return CupertinoTextField(
          onChanged: spec.onChanged,
          placeholder: spec.placeholder,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.circular(8),
          ),
        );

      case DesignStyle.neo:
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE0E5EC),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-2, -2),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            onChanged: spec.onChanged,
            decoration: InputDecoration(
              hintText: spec.placeholder,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        );
    }
  }

  // ------------------------------------------------------------------------
  // Badge Renderers
  // ------------------------------------------------------------------------

  static Widget _renderBadge(MetaBadgeSpec spec, DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            spec.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

      case DesignStyle.cupertino:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            spec.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

      case DesignStyle.neo:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE0E5EC), Color(0xFFFFFFFF)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-2, -2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Text(
            spec.label,
            style: const TextStyle(
              color: Color(0xFF4A5568),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
    }
  }

  // ------------------------------------------------------------------------
  // Card Renderers
  // ------------------------------------------------------------------------

  static Widget _renderCard(MetaCardSpec spec, DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(padding: const EdgeInsets.all(16), child: spec.child),
        );

      case DesignStyle.cupertino:
        return Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: CupertinoColors.separator, width: 0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: spec.child,
        );

      case DesignStyle.neo:
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE0E5EC), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(6, 6),
                blurRadius: 12,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-6, -6),
                blurRadius: 12,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: spec.child,
        );
    }
  }
}

// ============================================================================
// PART 3: Example Usage
// ============================================================================

/// This demonstrates the philosophy in action
///
/// Run this with:
/// ```dart
/// import 'meta_arch.dart';
///
/// void main() {
///   runApp(const MaterialApp(home: PhilosophyDemo()));
/// }
/// ```
class PhilosophyDemo extends StatefulWidget {
  const PhilosophyDemo({super.key});

  @override
  State<PhilosophyDemo> createState() => _PhilosophyDemoState();
}

class _PhilosophyDemoState extends State<PhilosophyDemo> {
  DesignStyle currentStyle = DesignStyle.material;
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    // Define WHAT we want (the UI structure)
    final buttonNode = UINode(
      type: 'button',
      spec: MetaButtonSpec(
        label: "CLICK ME",
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Button Pressed! Input: $inputText")),
          );
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Syntaxify Philosophy Demo")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Style Switcher
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black12),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: DesignStyle.values.map((style) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Radio<DesignStyle>(
                            value: style,
                            groupValue: currentStyle,
                            onChanged: (v) => setState(() => currentStyle = v!),
                          ),
                          Text(
                            style.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 50),

              // The same components, different renderings
              UIEngine.build(buttonNode, currentStyle),
              const SizedBox(height: 20),
              UIEngine.build(
                const UINode(
                  type: 'badge',
                  spec: MetaBadgeSpec(label: "NEW ARRIVAL"),
                ),
                currentStyle,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: UIEngine.build(
                  UINode(
                    type: 'input',
                    spec: MetaInputSpec(
                      placeholder: "Type something...",
                      onChanged: (value) => setState(() => inputText = value),
                    ),
                  ),
                  currentStyle,
                ),
              ),
              const SizedBox(height: 10),
              Text("You typed: $inputText"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: UIEngine.build(
                  const UINode(
                    type: 'card',
                    spec: MetaCardSpec(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Philosophy Card",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "This card changes its appearance based on the selected style. "
                            "Same definition, different rendering!",
                          ),
                        ],
                      ),
                    ),
                  ),
                  currentStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// KEY TAKEAWAYS
// ============================================================================
//
// 1. SEPARATION OF CONCERNS
//    - UINode = WHAT (component definition)
//    - UIEngine = HOW (rendering logic)
//
// 2. SINGLE SOURCE OF TRUTH
//    - Define your UI structure once
//    - Render it in multiple ways
//
// 3. EASY THEME SWITCHING
//    - Change one variable (currentStyle)
//    - Entire app updates
//
// 4. MAINTAINABILITY
//    - Update rendering logic in one place
//    - All components benefit
//
// 5. THIS IS WHAT SYNTAX DOES
//    - Syntaxify generates this pattern for you
//    - You define components in meta/
//    - Syntaxify generates the renderers
//    - You use AppButton, AppText, AppInput
//    - They work with Material, Cupertino, Neo
//
// ============================================================================
