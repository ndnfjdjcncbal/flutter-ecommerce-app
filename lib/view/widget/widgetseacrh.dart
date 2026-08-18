import 'dart:ui';

import 'package:flutter/material.dart';

class BorderedRangeThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final double borderWidth;
  final Color borderColor;
  final Color fillColor;

  const BorderedRangeThumbShape({
    this.thumbRadius = 8,
    this.borderWidth = 1,
    this.borderColor = Colors.purple,
    this.fillColor = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        bool? isEnabled,
        bool? isOnTop,
        TextDirection? textDirection,
        required SliderThemeData sliderTheme,
        Thumb? thumb,
        bool? isPressed,
      }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius - (borderWidth / 2), borderPaint);
  }
}