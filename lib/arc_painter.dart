import 'package:flutter/material.dart';
import 'dart:math';

class ArcPainter extends CustomPainter {
  ArcPainter({
    this.backgroundColor,
    this.valueColor,
    this.headValue,
    this.tailValue,
    this.stepValue,
    this.rotationValue,
    this.strokeWidth,
  }) : arcStart = _startAngle + tailValue * 3 / 2 * pi + rotationValue * pi * 1.7 - stepValue * 0.8 * pi,
        arcSweep = max(headValue * 3 / 2 * pi - tailValue * 3 / 2 * pi, _epsilon);

  final Color backgroundColor;
  final Color valueColor;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    paint.strokeCap = StrokeCap.square;

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(ArcPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor
        || oldPainter.valueColor != valueColor
        || oldPainter.headValue != headValue
        || oldPainter.tailValue != tailValue
        || oldPainter.stepValue != stepValue
        || oldPainter.rotationValue != rotationValue
        || oldPainter.strokeWidth != strokeWidth;
  }
}
