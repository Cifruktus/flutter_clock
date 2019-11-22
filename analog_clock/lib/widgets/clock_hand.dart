import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        color: Theme.of(context).textTheme.body1.color,
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
  final _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    const arrowYRatio = 0.1;
    const arrowXRatio = 0.1;
    const widthRatio = 0.025;
    _path
      ..moveTo(center.dx, 0)
      ..lineTo(center.dx - radius * arrowXRatio, radius * arrowYRatio)
      ..lineTo(center.dx - radius * widthRatio, radius * arrowYRatio)
      ..lineTo(center.dx - radius * widthRatio, center.dy)
      ..lineTo(center.dx + radius * widthRatio, center.dy)
      ..lineTo(center.dx + radius * widthRatio, radius * arrowYRatio)
      ..lineTo(center.dx + radius * arrowXRatio, radius * arrowYRatio);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => oldDelegate.color != color;
}
