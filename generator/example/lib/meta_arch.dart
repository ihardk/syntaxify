import 'package:flutter/material.dart';

// =============================================================================
// LAYER 1: DATA (Tokens & Enums)
// =============================================================================

enum DesignStyle { material, cupertino, neo }

/// Design Tokens: The DNA of the button component.
/// Pure data. No widgets.
class ButtonTokens {
  final double radius;
  final double borderWidth;
  final Color bgColor;
  final Color textColor;
  final Offset shadowOffset;
  final double elevation;

  const ButtonTokens({
    required this.radius,
    required this.borderWidth,
    required this.bgColor,
    required this.textColor,
    required this.shadowOffset,
    this.elevation = 0,
  });
}

class BadgeTokens {
  final double radius;
  final Color bgColor;
  final Color textColor;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const BadgeTokens({
    required this.radius,
    required this.bgColor,
    required this.textColor,
    required this.padding,
    required this.textStyle,
  });
}

class CardTokens {
  final double radius;
  final double borderWidth;
  final Color bgColor;
  final Color borderColor;
  final Offset shadowOffset;
  final double elevation;
  final EdgeInsets padding;

  const CardTokens({
    required this.radius,
    required this.borderWidth,
    required this.bgColor,
    this.borderColor = Colors.black,
    required this.shadowOffset,
    this.elevation = 0,
    required this.padding,
  });
}

class InputTokens {
  final double radius;
  final double borderWidth;
  final Color filledColor;
  final Color borderColor;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const InputTokens({
    required this.radius,
    required this.borderWidth,
    required this.filledColor,
    required this.borderColor,
    required this.padding,
    required this.textStyle,
  });
}

// =============================================================================
// LAYER 2: REGISTRY (The "Theme" Source)
// =============================================================================

class TokenLibrary {
  static ButtonTokens button(DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        // Standard rounded, shadowed, blue button
        return const ButtonTokens(
          radius: 8,
          borderWidth: 0,
          bgColor: Colors.blue,
          textColor: Colors.white,
          shadowOffset: Offset(0, 2),
          elevation: 2,
        );

      case DesignStyle.cupertino:
        // Flat, fully rounded, lighter
        return const ButtonTokens(
          radius: 100, // Pill shape
          borderWidth: 0,
          bgColor: Color(0xFF007AFF),
          textColor: Colors.white,
          shadowOffset: Offset.zero,
        );

      case DesignStyle.neo:
        // Hard edges, thick borders, aggressive shadow
        return const ButtonTokens(
          radius: 0,
          borderWidth: 3,
          bgColor: Color(0xFFFFD700), // Gold
          textColor: Colors.black,
          shadowOffset: Offset(5, 5),
        );
    }
  }

  static BadgeTokens badge(DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return const BadgeTokens(
            radius: 4,
            bgColor: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            textStyle: TextStyle(fontSize: 12));
      case DesignStyle.cupertino:
        return const BadgeTokens(
            radius: 100,
            bgColor: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            textStyle: TextStyle(fontSize: 12));
      case DesignStyle.neo:
        return const BadgeTokens(
            radius: 0,
            bgColor: Colors.black,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
    }
  }

  static CardTokens card(DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return const CardTokens(
            radius: 12,
            borderWidth: 0,
            bgColor: Colors.white,
            shadowOffset: Offset(0, 2),
            elevation: 4,
            padding: EdgeInsets.all(16));
      case DesignStyle.cupertino:
        return const CardTokens(
            radius: 16,
            borderWidth: 0,
            bgColor: Colors.white,
            shadowOffset: Offset.zero,
            elevation: 0,
            padding: EdgeInsets.all(16));
      case DesignStyle.neo:
        return const CardTokens(
            radius: 0,
            borderWidth: 3,
            bgColor: Colors.white,
            shadowOffset: Offset(6, 6),
            elevation: 0,
            padding: EdgeInsets.all(20));
    }
  }

  static InputTokens input(DesignStyle style) {
    switch (style) {
      case DesignStyle.material:
        return const InputTokens(
            radius: 4,
            borderWidth: 1,
            filledColor: Colors.white,
            borderColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            textStyle: TextStyle(fontSize: 16));
      case DesignStyle.cupertino:
        return const InputTokens(
            radius: 8,
            borderWidth: 0,
            filledColor: Color(0xFFE5E5EA),
            borderColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            textStyle: TextStyle(fontSize: 16));
      case DesignStyle.neo:
        return const InputTokens(
            radius: 0,
            borderWidth: 3,
            filledColor: Colors.white,
            borderColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    }
  }
}

// =============================================================================
// LAYER 3: SPEC (The API)
// =============================================================================

class MetaButtonSpec {
  final String label;
  final VoidCallback? onPressed;

  const MetaButtonSpec({
    required this.label,
    this.onPressed,
  });
}

class MetaBadgeSpec {
  final String label;
  const MetaBadgeSpec({required this.label});
}

class MetaCardSpec {
  final Widget child;
  const MetaCardSpec({required this.child});
}

class MetaInputSpec {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  const MetaInputSpec({required this.placeholder, this.onChanged});
}

class UINode {
  final String type;
  final dynamic spec;

  const UINode({required this.type, required this.spec});
}

// =============================================================================
// LAYER 4: RENDERER (The generic widget)
// =============================================================================

class ButtonRenderer extends StatelessWidget {
  final ButtonTokens tokens;
  final MetaButtonSpec spec;

  const ButtonRenderer({
    super.key,
    required this.tokens,
    required this.spec,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: spec.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: tokens.bgColor,
          borderRadius: BorderRadius.circular(tokens.radius),
          border: tokens.borderWidth > 0
              ? Border.all(color: Colors.black, width: tokens.borderWidth)
              : null,
          boxShadow: [
            if (tokens.shadowOffset != Offset.zero)
              BoxShadow(
                color: Colors.black,
                offset: tokens.shadowOffset,
              ),
            if (tokens.elevation > 0 && tokens.shadowOffset == Offset.zero)
              BoxShadow(
                color: Colors.black26,
                blurRadius: tokens.elevation * 2,
                offset: Offset(0, tokens.elevation),
              )
          ],
        ),
        child: Text(
          spec.label,
          style: TextStyle(
            color: tokens.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class BadgeRenderer extends StatelessWidget {
  final BadgeTokens tokens;
  final MetaBadgeSpec spec;
  const BadgeRenderer({super.key, required this.tokens, required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: tokens.padding,
      decoration: BoxDecoration(
        color: tokens.bgColor,
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Text(spec.label,
          style: tokens.textStyle.copyWith(color: tokens.textColor)),
    );
  }
}

class CardRenderer extends StatelessWidget {
  final CardTokens tokens;
  final MetaCardSpec spec;
  const CardRenderer({super.key, required this.tokens, required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: tokens.padding,
      decoration: BoxDecoration(
        color: tokens.bgColor,
        borderRadius: BorderRadius.circular(tokens.radius),
        border: tokens.borderWidth > 0
            ? Border.all(color: tokens.borderColor, width: tokens.borderWidth)
            : null,
        boxShadow: [
          if (tokens.shadowOffset != Offset.zero)
            BoxShadow(color: Colors.black, offset: tokens.shadowOffset),
          if (tokens.elevation > 0 && tokens.shadowOffset == Offset.zero)
            BoxShadow(
                color: Colors.black12,
                blurRadius: tokens.elevation * 2,
                offset: Offset(0, tokens.elevation))
        ],
      ),
      child: spec.child,
    );
  }
}

class InputRenderer extends StatelessWidget {
  final InputTokens tokens;
  final MetaInputSpec spec;
  const InputRenderer({super.key, required this.tokens, required this.spec});

  @override
  Widget build(BuildContext context) {
    // We map generic tokens to Flutter's specific InputBorder system
    final borderSide = tokens.borderWidth > 0
        ? BorderSide(color: tokens.borderColor, width: tokens.borderWidth)
        : BorderSide.none;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(tokens.radius),
      borderSide: borderSide,
    );

    return TextField(
      onChanged: spec.onChanged,
      style: tokens.textStyle.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: spec.placeholder,
        hintStyle: tokens.textStyle.copyWith(color: Colors.grey),
        filled: true,
        fillColor: tokens.filledColor,
        contentPadding: tokens.padding,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: borderSide.copyWith(
              color: tokens.borderColor == Colors.transparent
                  ? Colors.grey.withOpacity(0.5)
                  : tokens.borderColor),
        ),
      ),
    );
  }
}

// =============================================================================
// LAYER 5: ENGINE (The Glue)
// =============================================================================

class UIEngine {
  static Widget build(UINode node, DesignStyle style) {
    switch (node.type) {
      case 'button':
        final spec = node.spec as MetaButtonSpec;
        final tokens = TokenLibrary.button(style);
        return ButtonRenderer(tokens: tokens, spec: spec);

      case 'badge':
        final spec = node.spec as MetaBadgeSpec;
        final tokens = TokenLibrary.badge(style);
        return BadgeRenderer(tokens: tokens, spec: spec);

      case 'card':
        final spec = node.spec as MetaCardSpec;
        final tokens = TokenLibrary.card(style);
        return CardRenderer(tokens: tokens, spec: spec);

      case 'input':
        final spec = node.spec as MetaInputSpec;
        final tokens = TokenLibrary.input(style);
        return InputRenderer(tokens: tokens, spec: spec);

      default:
        return Text("Unknown node type: ${node.type}");
    }
  }
}
