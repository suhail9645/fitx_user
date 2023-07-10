import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 27, 25, 25)
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.9984125);
    path0.lineTo(size.width * 0.0057143, size.height * 0.9983042);
    path0.lineTo(size.width, size.height * 0.5415755);
    path0.lineTo(size.width, size.height * 0.9984125);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
