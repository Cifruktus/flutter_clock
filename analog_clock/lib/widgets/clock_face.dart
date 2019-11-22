import 'dart:math';

import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({
    Key key,
    @required this.type,
  }) : super(key: key);

  final ClockType type;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        type: type,
        color: Theme.of(context).textTheme.body1.color,
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    @required this.type,
    @required this.color,
  })  : _num = _getNum(type),
        _textPainters = _getTextPainters(
          type: type,
          color: color,
        ),
        _paint = Paint()
          ..style = PaintingStyle.stroke
          ..color = color;

  final Color color;
  final Paint _paint;
  final _path = Path();
  final int _num;
  final List<TextPainter> _textPainters;
  final ClockType type;

  static int _getNum(ClockType type) {
    switch (type) {
      case ClockType.second:
      case ClockType.minute:
        return 60;
      case ClockType.hour:
        return 24;
    }
    assert(false, 'Unexpected type: $type');
    return 0;
  }

  static int _getSkipNum(ClockType type) {
    switch (type) {
      case ClockType.second:
      case ClockType.minute:
        return 10;
      case ClockType.hour:
        return 3;
    }
    assert(false, 'Unexpected type: $type');
    return 0;
  }

  static List<TextPainter> _getTextPainters({
    @required ClockType type,
    @required Color color,
  }) {
    return List<TextPainter>.generate(_getNum(type), (i) {
      if (i % _getSkipNum(type) != 0) {
        return null;
      }
      return TextPainter(
        text: TextSpan(
            text: '$i',
            style: TextStyle(
              fontSize: 13,
              color: color,
            )),
        textDirection: TextDirection.ltr,
      )..layout();
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    const gageRatio = 0.9;
    const textRatio = 0.8;

    canvas.drawCircle(center, radius, _paint);
    for (final i in List.generate(_num, (i) => i)) {
      final radian = 2 * pi * i / _num - pi / 2;
      _path
        ..moveTo(
          radius * cos(radian) + center.dx,
          radius * sin(radian) + center.dy,
        )
        ..lineTo(
          radius * cos(radian) * gageRatio + center.dx,
          radius * sin(radian) * gageRatio + center.dy,
        );
      canvas.drawPath(_path, _paint);

      final textPainter = _textPainters[i];
      if (textPainter != null) {
        textPainter.paint(
          canvas,
          Offset(
            radius * cos(radian) * textRatio +
                center.dx -
                textPainter.width / 2,
            radius * sin(radian) * textRatio +
                center.dy -
                textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => oldDelegate.color != color;
}
