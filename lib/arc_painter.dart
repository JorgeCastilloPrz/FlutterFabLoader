import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color color;

  ArcPainter(
      {this.progress,
      this.backgroundColor = Colors.grey,
      this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint
      ..color = backgroundColor
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        new Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    Rect rect = new Offset(0.0, 0.0) & size;
//    paint..shader = new LinearGradient(colors: [Colors.white, color]
//    ,begin: Alignment.topRight, end: Alignment.bottomLeft).createShader(rect);

    canvas.drawArc(new Offset(0.0, 0.0) & new Size(size.width, size.width),
        -90.0 * 0.0174533, progress * 0.0174533, false, paint..color = color);
  }

  @override
  bool shouldRepaint(ArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
