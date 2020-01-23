import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        color: Colors.white,
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    @required this.color,
  }) : _paint = Paint()..color = color;
  final Color color;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    const arrowXRatio = 0.05;
    const arrowYRatio = 0.08;
    const widthRatio = 0.01;

    final path = Path()
      ..moveTo(center.dx, 0)
      ..relativeLineTo(-radius * arrowXRatio, radius * arrowYRatio)
      ..relativeLineTo(radius * arrowXRatio - radius * widthRatio, 0)
      ..relativeLineTo(0, size.height)
      ..relativeLineTo(radius * widthRatio * 2, 0)
      ..relativeLineTo(0, -size.height)
      ..relativeLineTo(radius * arrowXRatio - radius * widthRatio, 0);

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => oldDelegate.color != color;
}
