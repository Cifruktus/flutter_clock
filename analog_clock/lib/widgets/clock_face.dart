import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(),
    );
  }
}

class _Painter extends CustomPainter {
  final _paint = Paint()..style = PaintingStyle.stroke;
  final _path = Path();
  static const _num = 60;

  final _textPainters = List<TextPainter>.generate(_num, (i) {
    if (i % 10 != 0) {
      return null;
    }
    return TextPainter(
      text: TextSpan(
          text: '${i}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          )),
      textDirection: TextDirection.ltr,
    )..layout();
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);

    canvas.drawCircle(center, radius, _paint);
    for (final i in List.generate(_num, (i) => i)) {
      final radian = 2 * pi * i / _num - pi / 2;
      _path
        ..moveTo(
          radius * cos(radian) + center.dx,
          radius * sin(radian) + center.dy,
        )
        ..lineTo(
          radius * cos(radian) * 0.9 + center.dx,
          radius * sin(radian) * 0.9 + center.dy,
        );
      canvas.drawPath(_path, _paint);

      final textPainter = _textPainters[i];
      if (textPainter != null) {
        textPainter.paint(
          canvas,
          Offset(
            radius * cos(radian) * 0.8 + center.dx - textPainter.width / 2,
            radius * sin(radian) * 0.8 + center.dy - textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
