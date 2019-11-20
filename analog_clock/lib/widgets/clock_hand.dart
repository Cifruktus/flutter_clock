import 'package:analog_clock/util/util.dart';
import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(),
    );
  }
}

class _Painter extends CustomPainter {
  final _paint = Paint();
  final _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    logger.info('size: $size');
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    _path
      ..moveTo(center.dx, 0)
      ..lineTo(center.dx - radius / 10, radius / 10)
      ..lineTo(center.dx - radius / 40, radius / 10)
      ..lineTo(center.dx - radius / 40, center.dy)
      ..lineTo(center.dx + radius / 40, center.dy)
      ..lineTo(center.dx + radius / 40, radius / 10)
      ..lineTo(center.dx + radius / 10, radius / 10);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
