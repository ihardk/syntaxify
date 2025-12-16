import 'package:flutter/material.dart';
import 'meta_arch.dart';

void main() {
  runApp(const MaterialApp(home: MetaDemo()));
}

class MetaDemo extends StatefulWidget {
  const MetaDemo({super.key});

  @override
  State<MetaDemo> createState() => _MetaDemoState();
}

class _MetaDemoState extends State<MetaDemo> {
  // 1. STATE: The only thing that changes is this enum.
  DesignStyle currentStyle = DesignStyle.material;
  String _inputText = "";

  // 2. META DEFINITION: The UI is defined once as data.
  // Note: We move this to a getter or build method to access 'setState' and current state
  // or we can keep it static if we passed a controller, but for this 'meta' concept,
  // re-creating the node with the new callback is the 'React-like' way.

  @override
  Widget build(BuildContext context) {
    // Dynamic Node Creation based on state (React-style)
    final buttonNode = UINode(
      type: 'button',
      spec: MetaButtonSpec(
        label: "CLICK ME",
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Button Pressed! Input: $_inputText")));
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Meta UI Phase 0")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CONTROL PANEL
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black12)
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
                          Text(style.name.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 50),

              // THE META RENDER
              // Notice: No "if style == material" logic here.
              // Just "Build this node using this style".

              // 1. Button
              UIEngine.build(buttonNode, currentStyle),

              const SizedBox(height: 20),

              // 2. Badge
              UIEngine.build(
                const UINode(
                  type: 'badge',
                  spec: MetaBadgeSpec(label: "NEW ARRIVAL"),
                ),
                currentStyle,
              ),

              const SizedBox(height: 20),

              // 3. Input with Interactivity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: UIEngine.build(
                  UINode(
                    type: 'input',
                    spec: MetaInputSpec(
                        placeholder: "Type something...",
                        onChanged: (value) {
                          setState(() => _inputText = value);
                        }),
                  ),
                  currentStyle,
                ),
              ),

              const SizedBox(height: 10),
              Text("You typed: $_inputText"),

              const SizedBox(height: 20),

              // 4. Card (Composition)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: UIEngine.build(
                  const UINode(
                    type: 'card',
                    spec: MetaCardSpec(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Meta Card Title",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(
                              "This content is wrapped inside a meta-card. The border, shadow, and padding change based on the style."),
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
