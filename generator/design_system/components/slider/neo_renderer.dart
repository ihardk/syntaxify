part of '../../design_system.dart';

mixin NeoSliderRenderer on DesignStyle {
  @override
  SliderTokens get sliderTokens => const SliderTokens(
        activeTrackColor: Color(0xFFFFD700), // Gold
        inactiveTrackColor: Colors.white,
        thumbColor: Colors.white,
        overlayColor: Color(0x1A000000), // black with 10% alpha
        trackHeight: 8.0,
        thumbRadius: 10.0,
        thumbShadow: BoxShadow(offset: Offset(2, 2), color: Colors.black),
      );

  @override
  Widget renderSlider({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    String? label,
  }) {
    final tokens = sliderTokens;

    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: tokens.activeTrackColor,
        inactiveTrackColor: tokens.inactiveTrackColor,
        thumbColor: tokens.thumbColor,
        trackHeight: tokens.trackHeight,
        thumbShape: _NeoThumbShape(tokens: tokens),
        trackShape: _NeoTrackShape(tokens: tokens),
        overlayColor: tokens.overlayColor,
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );
  }
}

class _NeoThumbShape extends SliderComponentShape {
  const _NeoThumbShape({required this.tokens});

  final SliderTokens tokens;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    final size = tokens.thumbRadius * 2;
    return Size(size, size);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final size = tokens.thumbRadius * 2;
    final rect = Rect.fromCenter(center: center, width: size, height: size);

    // Shadow (if provided)
    if (tokens.thumbShadow != null) {
      final shadow = tokens.thumbShadow!;
      canvas.drawRect(
        rect.shift(shadow.offset),
        Paint()..color = shadow.color,
      );
    }

    // Fill
    canvas.drawRect(rect, Paint()..color = sliderTheme.thumbColor!);

    // Border
    canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
  }
}

class _NeoTrackShape extends SliderTrackShape {
  const _NeoTrackShape({required this.tokens});

  final SliderTokens tokens;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final trackHeight = tokens.trackHeight;
    final trackLeft = offset.dx + 10;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 20;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final trackRect = getPreferredRect(
        parentBox: parentBox, offset: offset, sliderTheme: sliderTheme);
    final canvas = context.canvas;

    // Track background
    canvas.drawRect(
        trackRect, Paint()..color = sliderTheme.inactiveTrackColor!);
    // Active portion
    final activeRect = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);
    canvas.drawRect(activeRect, Paint()..color = sliderTheme.activeTrackColor!);
    // Border
    canvas.drawRect(
        trackRect,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
  }
}
