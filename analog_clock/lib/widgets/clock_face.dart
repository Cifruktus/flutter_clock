import 'dart:math';

import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({
    Key key,
    @required this.type,
  }) : super(key: key);

  final ClockType type;

  double get _opacity {
    switch (type) {
      case ClockType.hour:
        return 0.3;
      case ClockType.minute:
        return 0.4;
      case ClockType.second:
        return 0.48;
    }
    assert(false, 'invalid type: $type');
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ClockModel>(context);
    return Opacity(
      opacity: _opacity,
      child: CustomPaint(
        painter: _Painter(
          type: type,
          color: Colors.white,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFFE37200)
              : const Color(0xFF778C98),
          is24HourFormat: model.is24HourFormat as bool,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    @required this.type,
    @required this.color,
    @required this.backgroundColor,
    @required this.is24HourFormat,
  })  : _num = _getNum(
          type: type,
          is24HourFormat: is24HourFormat,
        ),
        _textPainters = _getTextPainters(
          type: type,
          color: color,
          is24HourFormat: is24HourFormat,
        ),
        _paint = Paint()
          ..style = PaintingStyle.stroke
          ..color = color,
        _backgroundPaint = Paint()..color = backgroundColor;

  final Color color;
  final Color backgroundColor;
  final bool is24HourFormat;
  final Paint _paint;
  final Paint _backgroundPaint;
  final _path = Path();
  final int _num;
  final List<TextPainter> _textPainters;
  final ClockType type;

  static int _getNum({
    @required ClockType type,
    @required bool is24HourFormat,
  }) {
    switch (type) {
      case ClockType.second:
      case ClockType.minute:
        return 60;
      case ClockType.hour:
        return is24HourFormat ? 24 : 12;
    }
    assert(false, 'Unexpected type: $type');
    return 0;
  }

  static int _getSkipNum(ClockType type) {
    switch (type) {
      case ClockType.second:
        // ignore: avoid_returning_null
        return null;
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
    @required bool is24HourFormat,
  }) {
    return List<TextPainter>.generate(
        _getNum(
          type: type,
          is24HourFormat: is24HourFormat,
        ), (i) {
      final getSkipNum = _getSkipNum(type);
      if (getSkipNum == null || i % getSkipNum != 0) {
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
    const gageRatioMin = 0.9;
    const gageRatioMax = 0.95;
    const textRatio = 0.8;

    canvas.drawCircle(center, radius, _backgroundPaint);
    for (final i in List.generate(_num, (i) => i)) {
      final radian = 2 * pi * i / _num - pi / 2;
      _path
        ..moveTo(
          radius * cos(radian) * gageRatioMax + center.dx,
          radius * sin(radian) * gageRatioMax + center.dy,
        )
        ..lineTo(
          radius * cos(radian) * gageRatioMin + center.dx,
          radius * sin(radian) * gageRatioMin + center.dy,
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
  bool shouldRepaint(_Painter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.is24HourFormat != is24HourFormat;
}
