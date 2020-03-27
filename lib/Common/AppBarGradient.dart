import 'package:flutter/material.dart';

class GradientCheatingBorder extends Border {
  const GradientCheatingBorder({
    this.gradient,
    BorderSide top = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
    BorderSide left = BorderSide.none,
  }) : super(top: top, right: right, bottom: bottom, left: left);

  const GradientCheatingBorder.fromBorderSide(BorderSide side, {this.gradient})
      : super.fromBorderSide(side);

  factory GradientCheatingBorder.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    Gradient gradient,
  }) {
    final BorderSide side =
        BorderSide(color: color, width: width, style: style);
    return GradientCheatingBorder.fromBorderSide(side, gradient: gradient);
  }

  final Gradient gradient;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius borderRadius,
  }) {
    if (gradient != null) {
      canvas.drawRect(
        rect,
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.fill,
      );
    }

    super.paint(
      canvas,
      rect,
      textDirection: textDirection,
      shape: shape,
      borderRadius: borderRadius,
    );
  }
}
