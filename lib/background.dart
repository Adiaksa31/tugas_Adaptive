import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();

    var w = size.width;
    var h = size.height;

    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // path.addRect(rect);

    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    var colors = [
      Color.fromARGB(255, 0, 183, 255),
      Color.fromARGB(255, 0, 183, 255),
      Color.fromARGB(255, 0, 183, 255),
    ];
    var stops = [0 / 2, .8 / 2, 1.8 / 2];

    Rect rectShape = new Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
        colors: colors,
        stops: stops,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);

    paint = new Paint()..shader = gradient.createShader(rectShape);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
